cmake_minimum_required( VERSION 3.1)

project( Foundation C)


### mulle-sde environment

# add cmake module paths to search path
list( INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/cmake/share")
list( INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/cmake/reflect")
list( INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/cmake")

include( Environment)

include( Files)

### Library

if( HEADERS_PHASE)
   install( FILES ${INSTALL_PUBLIC_HEADERS}  DESTINATION "include/Foundation")
   install( FILES ${INSTALL_PRIVATE_HEADERS} DESTINATION "include/Foundation/private")
   install( FILES ${CMAKE_INCLUDES}          DESTINATION "include/Foundation/cmake")

   # short cut out
   if( NOT COMPILE_PHASE AND NOT LINK_PHASE)
      return()
   endif()
endif()

if( LINK_PHASE)
   include( Dependencies OPTIONAL)
endif()

unset( STARTUP_LIBRARY_NAME)


if( STANDALONE)
   set( LIBRARY_NAME "_Foundation")
   set( STANDALONE_LIBRARY_NAME "Foundation")
endif()

include( Library)
include( InstallLibrary)
include( FinalOutput OPTIONAL)
