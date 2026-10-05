### 0.23.5


* `Foundation.h` umbrella header now imports `MulleWebFoundation` directly instead of conditionally pulling in `MulleObjCExpatFoundation`, `MulleObjCInetOSFoundation` and `MulleObjCHTTPFoundation`
* **BREAKING** the ``HAVE_LIB_MULLE_OBJC_EXPAT_FOUNDATION`,` ``HAVE_LIB_MULLE_OBJC_INET_OS_FOUNDATION`` and ``HAVE_LIB_MULLE_OBJC_HTTP_FOUNDATION`` feature macros are no longer defined by `import.h`
* updated the API/documentation TOC to reflect the new single web dependency



feature: amalgamate Foundation dependencies into MulleWebFoundation

* MulleWebFoundation now replaces the former MulleObjCExpatFoundation, MulleObjCInetOSFoundation and MulleObjCHTTPFoundation dependencies
* the generated imports expose ``<MulleWebFoundation/MulleWebFoundation.h>`` and ``HAVE_LIB_MULLE_WEB_FOUNDATION`,` while ``HAVE_LIB_MULLE_OBJC_EXPAT_FOUNDATION`,` ``HAVE_LIB_MULLE_OBJC_INET_OS_FOUNDATION`` and ``HAVE_LIB_MULLE_OBJC_HTTP_FOUNDATION`` are gone (**BREAKING** for code that tests those macros)
* the `mulle-objc-list` dependency is renamed to `mulle-objc-tools`

### 0.23.4




* all public headers and source files now include a BSD license and copyright header
* new API documentation index with table of contents

### 0.23.3





* fixes NSMutableDictionary mutableCopy, no longer tries to be too smart for its own good
