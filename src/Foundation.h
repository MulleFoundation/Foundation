#import "import.h"

#include <stdint.h>

/*
 *  (c) 2018 nat
 *
 *  version:  major, minor, patch
 */
#define FOUNDATION_VERSION  ((0 << 20) | (18 << 8) | 0)


static inline unsigned int   Foundation_get_version_major( void)
{
   return( FOUNDATION_VERSION >> 20);
}


static inline unsigned int   Foundation_get_version_minor( void)
{
   return( (FOUNDATION_VERSION >> 8) & 0xFFF);
}


static inline unsigned int   Foundation_get_version_patch( void)
{
   return( FOUNDATION_VERSION & 0xFF);
}


extern uint32_t   Foundation_get_version( void);

/*
   Add other library headers here like so, for exposure to library
   consumers.

   # include "foo.h"
*/
