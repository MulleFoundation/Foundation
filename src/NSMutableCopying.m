//
//  NSMutableCopying.h
//  MulleObjC
//
//  Copyright (c) 2016 Nat! - Mulle kybernetiK.
//  Copyright (c) 2016 Codeon GmbH.
//  All rights reserved.
//
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  Neither the name of Mulle kybernetiK nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//
#import "import-private.h"

#import "NSMutableCopying.h"




@implementation NSObject( NSMutableCopying)

static mulle_objc_walkcommand_t
   _MulleObjCPropertyRetainInstanceVariable( struct _mulle_objc_property *property,
                                             struct _mulle_objc_infraclass *cls,
                                             void *info)
{
   id                        self = info;
   uint32_t                  mode;
   id                        *p_ivar;
   int                       offset;
   mulle_objc_ivarid_t       ivarid;
   struct _mulle_objc_ivar   *ivar;

   mode = property->bits & (_mulle_objc_property_retain|_mulle_objc_property_copy);
   if( ! mode)
      return( mulle_objc_walk_ok);

   ivarid = _mulle_objc_property_get_ivarid( property);
   if( ! ivarid)  // gotta be dynamic then
   {
      assert( property->bits & _mulle_objc_property_dynamic);
      return( mulle_objc_walk_ok);
   }

   ivar    = mulle_objc_infraclass_search_ivar( cls, ivarid);
   offset  = _mulle_objc_ivar_get_offset( ivar);
   p_ivar  = (id *) &((char *) self)[ offset];
   // MEMO: if the value is copy, then the value is copied already anyway by
   //       the original object and we can just -retain in all cases
   [*p_ivar retain];

   return( mulle_objc_walk_ok);
}


void   _MulleObjCInstanceRetainProperties( id self, Class infraCls)
{
   // MEMO: rename to mulleCopyOfInstanceRetainsProperties ?
   _mulle_objc_infraclass_walk_properties( infraCls,
                                           _mulle_objc_infraclass_get_inheritance( infraCls),
                                           _MulleObjCPropertyRetainInstanceVariable,
                                           self);
}


id   _MulleObjCInstanceDuplicate( id self, Class infraCls, NSUInteger extraBytes)
{
   id   clone;

   clone    = _MulleObjCClassAllocateInstance( infraCls, extraBytes);
   memcpy( clone, self, extraBytes + _mulle_objc_infraclass_get_instancesize( infraCls));
   return( clone);
}


id   _MulleObjCInstanceCopy( id self, NSUInteger extraBytes, BOOL retainProperties)
{
   id      clone;
   Class   infraCls;

   infraCls = [self class];
   clone    = _MulleObjCInstanceDuplicate( self, infraCls, extraBytes);
   if( retainProperties)
      _MulleObjCInstanceRetainProperties( infraCls, clone);
   return( clone);
}


- (instancetype) mutableInstance
{
   id   obj;

   obj = [(id <NSMutableCopying>) self mutableCopy];
   obj = [obj autorelease];
   return( obj);
}

@end



@implementation MulleDynamicObject( NSMutableCopying)
/*
 *
 */
static inline void  copy_generic_value( struct mulle__pointermap *map,
                                        struct mulle_pointerpair *pair,
                                        struct _mulle_objc_infraclass *infra,
                                        struct mulle_allocator *allocator)
{
   char                            *signature;
   MulleObjCGenericType            type;
   mulle_objc_methodid_t           methodid;
   struct _mulle_objc_descriptor   *desc;
   struct _mulle_objc_property     *property;
   struct _mulle_objc_universe     *universe;

   methodid = (mulle_objc_methodid_t) (uintptr_t) pair->key;
   property = _MulleObjCClassPointerSearchDynamicProperty( &infra, methodid);
   if( property)
   {
      type      = _MulleObjCGenericTypeOfProperty( property);
   }
   else
   {
      universe  = _mulle_objc_infraclass_get_universe( infra);
      desc      = mulle_objc_universe_lookup_descriptor_nofail( universe, methodid);
      signature = _mulle_objc_descriptor_get_signature( desc);
      type      = _MulleObjCGenericTypeOfSignature( signature);
   }

   //
   // descriptor is always the "value" getter
   // key is the value selector
   //
   switch( type)
   {
   case MulleObjCGenericTypeStrdup : pair->value = mulle_allocator_strdup( allocator, pair->value);
                    break;
   case MulleObjCGenericTypeValue  :
   case MulleObjCGenericTypeNumber :
   case MulleObjCGenericTypeRetain : pair->value = [(id) pair->value retain];
                    break;
   case MulleObjCGenericTypeCopy   : pair->value = [(id) pair->value copy];
   default        : break;
   }

   _mulle__pointermap_insert_pair( map, pair, allocator);
}


id   _MulleDynamicObjectCopy( MulleDynamicObject *self, NSUInteger extraBytes)
{
   MulleDynamicObject                   *clone;
   Class                                infraCls;
   size_t                               n;
   struct mulle__pointermapenumerator   rover;
   struct mulle_pointerpair             pair;
   struct mulle_allocator               *allocator;

   infraCls = [self class];
   clone    = _MulleObjCInstanceDuplicate( self, infraCls, extraBytes);

   {
      // new  __ivars though
      n         = mulle__pointermap_get_count( &self->__ivars);
      allocator = MulleObjCInstanceGetAllocator( clone);
      _mulle__pointermap_init( &clone->__ivars, n, allocator);

      //
      // send -copy (or -retain) to values
      //
      rover = mulle__pointermap_enumerate( &self->__ivars);
      while( _mulle__pointermapenumerator_next_pair( &rover, &pair))
      {
         // this is a "choke" point: best solution would be to have a
         // per infraclass property cache to speed this up
         copy_generic_value( &clone->__ivars, &pair, infraCls, allocator);
      }
      mulle__pointermapenumerator_done( &rover);
   }

   _MulleObjCInstanceRetainProperties( self, infraCls);

   return( clone);
}

@end


@implementation MulleObject( NSMutableCopying)

// as a base class, we need to support this, otherwise we get into dire
// straits for base classes
id   _MulleObjectCopy( id self, NSUInteger extraBytes)
{
   MulleObject   *copy;

   copy = _MulleDynamicObjectCopy( self, 0);

   // copy lock or make a new one ? guess a new one
   if( copy->__lock)
      copy->__lock = [NSRecursiveLock new];
   return( copy);
}

@end



@implementation NSData( NSMutableCopying)

- (id) mutableCopy
{
   return( [[NSMutableData alloc] initWithData:self]);
}

@end




@implementation NSMutableString ( NSMutableCopying)

- (id) mutableCopy
{
   return( [[NSMutableString alloc] initWithStrings:_storage
                                              count:_count]);
}

@end



@implementation NSString ( NSMutableCopying)

- (id) mutableCopy
{
   return( [[NSMutableString alloc] initWithString:self]);
}

@end



@implementation NSCharacterSet( NSMutableCopying)

- (id) mutableCopy
{
   NSMutableCharacterSet   *set;

   set = [NSMutableCharacterSet new];
   [set formUnionWithCharacterSet:self];
   return( set);
}

@end


@implementation NSArray( NSMutableCopying)

- (id) mutableCopy
{
   return( [[NSMutableArray alloc] initWithArray:self]);
}

@end


@implementation NSSet( NSMutableCopying)

- (id) mutableCopy
{
   return( [[NSMutableSet alloc] initWithSet:self
                                   copyItems:NO]);
}

@end


@implementation NSDictionary( NSMutableCopying)

- (id) mutableCopy
{
   return( [[NSMutableDictionary alloc] initWithDictionary:self]);
}

@end


@implementation NSMutableDictionary( NSMutableCopying)

//
// keep the class
//
- (id) mutableCopy
{
   return( [[MulleObjCObjectGetClass( self) alloc] initWithDictionary:self]);
}

@end
