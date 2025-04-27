//
//  NSMutableCopying.h
//  MulleObjCContainerFoundation
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
#import "import.h"

struct NSZone;


// NSMutableCopy should imply NSCopying
//
// What does that mean ? It means that -mutableCopy should only be
// defined on a class, if that class is composed of a immutable class and
// a mutable variant: e.g. NSString <-> NSMutableArray, NSArray <-> NSMutableArray.
//
// You should not have `-mutableCopy` on an object that does
// not support -copy. And you can only support -copy if you generate immutable
// objects from it.
//
// Using -mutableCopy breaks the possibility of returning nil for empty mutable
// containers.
//
//  NSMutableArray   *array;
//
//  array = [foo mutableCopy];
//  [array addObject:@"foo"];
//  assert( [array count] >= 1);  // BOOM
//
// vs.
//  NSMutableArray   *array;
//
//  array = [NSMutableArray arrayWithArray:foo];
//  [array addObject:@"foo"];
//  assert( [array count] >= 1);  // FINE!
//
// With all this being said, this is now in Foundation, because `-mutableCopy`
// is a meme the MulleFoundation no longer relies on and is therefore part
// of the compatibility layer.
//
// Also no longer a protocolclass because putting a random NSMutableCopying
// on a subclass was too dangerous (MulleObject -mutableCopy method was
// ignored)
//
@protocol NSMutableCopying  // < NSCopying>

//
// Does not return an instancetype (e.g. NSSet returns NSMutableSet).
// If it isn't mutable, you should be using -copy or simply use constructors
// to copy.
//
- (id) mutableCopy;

@optional
// this is preferable as it returns autoreleased
- (id) mutableInstance;

@end


@interface NSObject( NSMutableCopying)

- (id) mutableInstance;

@end


FOUNDATION_GLOBAL
MULLE_C_NONNULL_FIRST
id   _MulleObjCInstanceCopy( id self, NSUInteger extraBytes, BOOL retainProperties);

FOUNDATION_GLOBAL
MULLE_C_NONNULL_FIRST_SECOND
void   _MulleObjCInstanceRetainProperties( id clone, Class infraCls);


FOUNDATION_GLOBAL
MULLE_C_NONNULL_FIRST_SECOND
id   _MulleObjCInstanceDuplicate( id object, Class infraCls, NSUInteger extraBytes);



static inline id   NSCopyObject( id object, NSUInteger extraBytes, NSZone *zone)
{
   if( ! object)
      return( nil);
   return( _MulleObjCInstanceCopy( object, extraBytes, NO));
}


//
// default is NO: and it's probably a bad idea anyway
//
FOUNDATION_GLOBAL
MULLE_C_NONNULL_FIRST
id   _MulleDynamicObjectCopy( id object, NSUInteger extraBytes);


static inline id   MulleDynamicObjectCopy( id object, NSUInteger extraBytes)
{
   if( ! object)
      return( nil);
   return( _MulleDynamicObjectCopy( object, extraBytes));
}



//
FOUNDATION_GLOBAL
MULLE_C_NONNULL_FIRST
id   _MulleObjectCopy( id object, NSUInteger extraBytes);

static inline id   MulleObjectCopy( id object, NSUInteger extraBytes)
{
   if( ! object)
      return( nil);
   return( _MulleObjectCopy( object, extraBytes));
}




@interface NSData( NSMutableCopying) < NSMutableCopying>
@end

@interface NSString( NSMutableCopying) < NSMutableCopying>
@end

@interface NSSet( NSMutableCopying) < NSMutableCopying>
@end

@interface NSArray( NSMutableCopying) < NSMutableCopying>
@end

@interface NSDictionary( NSMutableCopying) < NSMutableCopying>
@end

@interface NSCharacterSet( NSMutableCopying) < NSMutableCopying>
@end

