#import "import.h"

#include <stdint.h>

/*
 *  (c) 2018 nat
 *
 *  version:  major, minor, patch
 */
#define FOUNDATION_VERSION  ((0UL << 20) | (22 << 8) | 1)


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


FOUNDATION_GLOBAL
uint32_t   Foundation_get_version( void);

/*
   Add other library headers here like so, for exposure to library
   consumers.

   # include "foo.h"
*/


#ifdef __has_include
# if __has_include( "_Foundation-versioncheck.h")
#  include "_Foundation-versioncheck.h"
# endif
#endif
