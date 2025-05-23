//
//  main.m
//  archiver-test
//
//  Created by Nat! on 19.04.16.
//  Copyright © 2016 Mulle kybernetiK. All rights reserved.
//


#import <MulleObjCStandardFoundation/MulleObjCStandardFoundation.h>


int   main( int argc, const char * argv[])
{
   id         array;
   NSNumber   *nr;
   NSString   *key;
   id         copied;

   // simple basic test for leakage

   nr     = [NSNumber numberWithInt:1848];
   key    = [NSString stringWithUTF8String:"bar"];
   array  = [NSArray arrayWithObjects:nr, key, nil];
   copied = [array mutableInstance];
   return( [copied count] == 2 ? 0 : -1);
}
