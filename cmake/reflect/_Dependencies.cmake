# This file will be regenerated by `mulle-sourcetree-to-cmake` via
# `mulle-sde reflect` and any edits will be lost.
#
# This file will be included by cmake/share/Files.cmake
#
# Disable generation of this file with:
#
# mulle-sde environment set MULLE_SOURCETREE_TO_CMAKE_DEPENDENCIES_FILE DISABLE
#
if( MULLE_TRACE_INCLUDE)
   message( STATUS "# Include \"${CMAKE_CURRENT_LIST_FILE}\"" )
endif()

#
# Generated from sourcetree: 1d5ee5ef-0008-4953-906c-010b0f2438dc;objc-compat;no-all-load,no-cmake-searchpath,no-import,no-link;
# Disable with : `mulle-sourcetree mark objc-compat no-header`
# Disable for this platform: `mulle-sourcetree mark objc-compat no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark objc-compat no-cmake-sdk-<name>`
#
if( NOT OBJC_COMPAT_HEADER)
   find_file( OBJC_COMPAT_HEADER NAMES objc-compat.h objc-compat/objc-compat.h)
   message( STATUS "OBJC_COMPAT_HEADER is ${OBJC_COMPAT_HEADER}")

   #
   # Add OBJC_COMPAT_HEADER to HEADER_ONLY_LIBRARIES list.
   # Disable with: `mulle-sourcetree mark objc-compat no-cmake-add`
   #
   set( HEADER_ONLY_LIBRARIES
      ${OBJC_COMPAT_HEADER}
      ${HEADER_ONLY_LIBRARIES}
      CACHE INTERNAL "need to cache this"
   )
   if( OBJC_COMPAT_HEADER)
      #
      # Inherit ObjC loader and link dependency info.
      # Disable with: `mulle-sourcetree mark objc-compat no-cmake-inherit`
      #
      get_filename_component( _TMP_OBJC_COMPAT_ROOT "${OBJC_COMPAT_HEADER}" DIRECTORY)
      get_filename_component( _TMP_OBJC_COMPAT_NAME "${_TMP_OBJC_COMPAT_ROOT}" NAME)
      get_filename_component( _TMP_OBJC_COMPAT_ROOT "${_TMP_OBJC_COMPAT_ROOT}" DIRECTORY)
      get_filename_component( _TMP_OBJC_COMPAT_ROOT "${_TMP_OBJC_COMPAT_ROOT}" DIRECTORY)
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark objc-compat no-cmake-dependency`
      #
      foreach( _TMP_OBJC_COMPAT_NAME IN LISTS _TMP_OBJC_COMPAT_NAME)
         set( _TMP_OBJC_COMPAT_DIR "${_TMP_OBJC_COMPAT_ROOT}/include/${_TMP_OBJC_COMPAT_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_OBJC_COMPAT_DIR}/DependenciesAndLibraries.cmake")
            unset( OBJC_COMPAT_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_OBJC_COMPAT_DIR}")
            # we only want top level INHERIT_OBJC_LOADERS, so disable them
            if( NOT NO_INHERIT_OBJC_LOADERS)
               set( NO_INHERIT_OBJC_LOADERS OFF)
            endif()
            list( APPEND _TMP_INHERIT_OBJC_LOADERS ${NO_INHERIT_OBJC_LOADERS})
            set( NO_INHERIT_OBJC_LOADERS ON)
            #
            include( "${_TMP_OBJC_COMPAT_DIR}/DependenciesAndLibraries.cmake")
            #
            list( GET _TMP_INHERIT_OBJC_LOADERS -1 NO_INHERIT_OBJC_LOADERS)
            list( REMOVE_AT _TMP_INHERIT_OBJC_LOADERS -1)
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_OBJC_COMPAT_DIR}")
            set( INHERITED_DEFINITIONS
               ${INHERITED_DEFINITIONS}
               ${OBJC_COMPAT_DEFINITIONS}
               CACHE INTERNAL "need to cache this"
            )
            break()
         else()
            message( STATUS "${_TMP_OBJC_COMPAT_DIR}/DependenciesAndLibraries.cmake not found")
         endif()
      endforeach()
   else()
      # Disable with: `mulle-sourcetree mark objc-compat no-require`
      message( FATAL_ERROR "OBJC_COMPAT_HEADER was not found")
   endif()
endif()



#
# Generated from sourcetree: 445683ED-0F8E-41AA-993A-DF3A42E5813A;MulleFoundation;no-singlephase;
# Disable with : `mulle-sourcetree mark MulleFoundation no-link`
# Disable for this platform: `mulle-sourcetree mark MulleFoundation no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark MulleFoundation no-cmake-sdk-<name>`
#
if( NOT MULLE_FOUNDATION_LIBRARY)
   find_library( MULLE_FOUNDATION_LIBRARY NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}MulleFoundation${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX} ${CMAKE_STATIC_LIBRARY_PREFIX}MulleFoundation${CMAKE_STATIC_LIBRARY_SUFFIX} MulleFoundation NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH)
   message( STATUS "MULLE_FOUNDATION_LIBRARY is ${MULLE_FOUNDATION_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_FOUNDATION_LIBRARY)
      #
      # Add MULLE_FOUNDATION_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmake-add`
      #
      set( ALL_LOAD_DEPENDENCY_LIBRARIES
         ${ALL_LOAD_DEPENDENCY_LIBRARIES}
         ${MULLE_FOUNDATION_LIBRARY}
         CACHE INTERNAL "need to cache this"
      )
      #
      # Inherit information from dependency.
      # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmake-inherit`
      #
      # temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_FOUNDATION_ROOT "${MULLE_FOUNDATION_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_FOUNDATION_ROOT "${_TMP_MULLE_FOUNDATION_ROOT}" DIRECTORY)
      #
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmake-dependency`
      #
      foreach( _TMP_MULLE_FOUNDATION_NAME "MulleFoundation")
         set( _TMP_MULLE_FOUNDATION_DIR "${_TMP_MULLE_FOUNDATION_ROOT}/include/${_TMP_MULLE_FOUNDATION_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_MULLE_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            unset( MULLE_FOUNDATION_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_FOUNDATION_DIR}")
            #
            include( "${_TMP_MULLE_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            #
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_FOUNDATION_DIR}")
            set( INHERITED_DEFINITIONS
               ${INHERITED_DEFINITIONS}
               ${MULLE_FOUNDATION_DEFINITIONS}
               CACHE INTERNAL "need to cache this"
            )
            break()
         else()
            message( STATUS "${_TMP_MULLE_FOUNDATION_DIR}/DependenciesAndLibraries.cmake not found")
         endif()
      endforeach()
      #
      # Search for "MulleObjCLoader+<name>.h" in include directory.
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmake-loader`
      #
      if( NOT NO_INHERIT_OBJC_LOADERS)
         foreach( _TMP_MULLE_FOUNDATION_NAME "MulleFoundation")
            set( _TMP_MULLE_FOUNDATION_FILE "${_TMP_MULLE_FOUNDATION_ROOT}/include/${_TMP_MULLE_FOUNDATION_NAME}/MulleObjCLoader+${_TMP_MULLE_FOUNDATION_NAME}.h")
            if( EXISTS "${_TMP_MULLE_FOUNDATION_FILE}")
               set( INHERITED_OBJC_LOADERS
                  ${INHERITED_OBJC_LOADERS}
                  ${_TMP_MULLE_FOUNDATION_FILE}
                  CACHE INTERNAL "need to cache this"
               )
               break()
            endif()
         endforeach()
      endif()
   else()
      # Disable with: `mulle-sourcetree mark MulleFoundation no-require-link`
      message( FATAL_ERROR "MULLE_FOUNDATION_LIBRARY was not found")
   endif()
endif()


#
# Generated from sourcetree: 3D67B37E-41CA-4A09-9BF5-F3F9A87C9592;MulleObjCExpatFoundation;no-require,no-singlephase;
# Disable with : `mulle-sourcetree mark MulleObjCExpatFoundation no-link`
# Disable for this platform: `mulle-sourcetree mark MulleObjCExpatFoundation no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark MulleObjCExpatFoundation no-cmake-sdk-<name>`
#
if( NOT MULLE_OBJC_EXPAT_FOUNDATION_LIBRARY)
   find_library( MULLE_OBJC_EXPAT_FOUNDATION_LIBRARY NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}MulleObjCExpatFoundation${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX} ${CMAKE_STATIC_LIBRARY_PREFIX}MulleObjCExpatFoundation${CMAKE_STATIC_LIBRARY_SUFFIX} MulleObjCExpatFoundation NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH)
   message( STATUS "MULLE_OBJC_EXPAT_FOUNDATION_LIBRARY is ${MULLE_OBJC_EXPAT_FOUNDATION_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_OBJC_EXPAT_FOUNDATION_LIBRARY)
      #
      # Add MULLE_OBJC_EXPAT_FOUNDATION_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
      # Disable with: `mulle-sourcetree mark MulleObjCExpatFoundation no-cmake-add`
      #
      set( ALL_LOAD_DEPENDENCY_LIBRARIES
         ${ALL_LOAD_DEPENDENCY_LIBRARIES}
         ${MULLE_OBJC_EXPAT_FOUNDATION_LIBRARY}
         CACHE INTERNAL "need to cache this"
      )
      #
      # Inherit information from dependency.
      # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
      # Disable with: `mulle-sourcetree mark MulleObjCExpatFoundation no-cmake-inherit`
      #
      # temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_OBJC_EXPAT_FOUNDATION_ROOT "${MULLE_OBJC_EXPAT_FOUNDATION_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_OBJC_EXPAT_FOUNDATION_ROOT "${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_ROOT}" DIRECTORY)
      #
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark MulleObjCExpatFoundation no-cmake-dependency`
      #
      foreach( _TMP_MULLE_OBJC_EXPAT_FOUNDATION_NAME "MulleObjCExpatFoundation")
         set( _TMP_MULLE_OBJC_EXPAT_FOUNDATION_DIR "${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_ROOT}/include/${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            unset( MULLE_OBJC_EXPAT_FOUNDATION_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_DIR}")
            #
            include( "${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            #
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_DIR}")
            set( INHERITED_DEFINITIONS
               ${INHERITED_DEFINITIONS}
               ${MULLE_OBJC_EXPAT_FOUNDATION_DEFINITIONS}
               CACHE INTERNAL "need to cache this"
            )
            break()
         else()
            message( STATUS "${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_DIR}/DependenciesAndLibraries.cmake not found")
         endif()
      endforeach()
      #
      # Search for "MulleObjCLoader+<name>.h" in include directory.
      # Disable with: `mulle-sourcetree mark MulleObjCExpatFoundation no-cmake-loader`
      #
      if( NOT NO_INHERIT_OBJC_LOADERS)
         foreach( _TMP_MULLE_OBJC_EXPAT_FOUNDATION_NAME "MulleObjCExpatFoundation")
            set( _TMP_MULLE_OBJC_EXPAT_FOUNDATION_FILE "${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_ROOT}/include/${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_NAME}/MulleObjCLoader+${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_NAME}.h")
            if( EXISTS "${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_FILE}")
               set( INHERITED_OBJC_LOADERS
                  ${INHERITED_OBJC_LOADERS}
                  ${_TMP_MULLE_OBJC_EXPAT_FOUNDATION_FILE}
                  CACHE INTERNAL "need to cache this"
               )
               break()
            endif()
         endforeach()
      endif()
   else()
      # Enable with: `mulle-sourcetree mark MulleObjCExpatFoundation require`
      message( STATUS "MULLE_OBJC_EXPAT_FOUNDATION_LIBRARY is missing but it is marked as \"no-require\"")
   endif()
endif()


#
# Generated from sourcetree: E5624C70-7EEE-4478-A21F-C30A91F71EC8;MulleObjCInetOSFoundation;no-require,no-singlephase;
# Disable with : `mulle-sourcetree mark MulleObjCInetOSFoundation no-link`
# Disable for this platform: `mulle-sourcetree mark MulleObjCInetOSFoundation no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark MulleObjCInetOSFoundation no-cmake-sdk-<name>`
#
if( NOT MULLE_OBJC_INET_OS_FOUNDATION_LIBRARY)
   find_library( MULLE_OBJC_INET_OS_FOUNDATION_LIBRARY NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}MulleObjCInetOSFoundation${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX} ${CMAKE_STATIC_LIBRARY_PREFIX}MulleObjCInetOSFoundation${CMAKE_STATIC_LIBRARY_SUFFIX} MulleObjCInetOSFoundation NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH)
   message( STATUS "MULLE_OBJC_INET_OS_FOUNDATION_LIBRARY is ${MULLE_OBJC_INET_OS_FOUNDATION_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_OBJC_INET_OS_FOUNDATION_LIBRARY)
      #
      # Add MULLE_OBJC_INET_OS_FOUNDATION_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
      # Disable with: `mulle-sourcetree mark MulleObjCInetOSFoundation no-cmake-add`
      #
      set( ALL_LOAD_DEPENDENCY_LIBRARIES
         ${ALL_LOAD_DEPENDENCY_LIBRARIES}
         ${MULLE_OBJC_INET_OS_FOUNDATION_LIBRARY}
         CACHE INTERNAL "need to cache this"
      )
      #
      # Inherit information from dependency.
      # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
      # Disable with: `mulle-sourcetree mark MulleObjCInetOSFoundation no-cmake-inherit`
      #
      # temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_OBJC_INET_OS_FOUNDATION_ROOT "${MULLE_OBJC_INET_OS_FOUNDATION_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_OBJC_INET_OS_FOUNDATION_ROOT "${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_ROOT}" DIRECTORY)
      #
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark MulleObjCInetOSFoundation no-cmake-dependency`
      #
      foreach( _TMP_MULLE_OBJC_INET_OS_FOUNDATION_NAME "MulleObjCInetOSFoundation")
         set( _TMP_MULLE_OBJC_INET_OS_FOUNDATION_DIR "${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_ROOT}/include/${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            unset( MULLE_OBJC_INET_OS_FOUNDATION_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_DIR}")
            #
            include( "${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            #
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_DIR}")
            set( INHERITED_DEFINITIONS
               ${INHERITED_DEFINITIONS}
               ${MULLE_OBJC_INET_OS_FOUNDATION_DEFINITIONS}
               CACHE INTERNAL "need to cache this"
            )
            break()
         else()
            message( STATUS "${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_DIR}/DependenciesAndLibraries.cmake not found")
         endif()
      endforeach()
      #
      # Search for "MulleObjCLoader+<name>.h" in include directory.
      # Disable with: `mulle-sourcetree mark MulleObjCInetOSFoundation no-cmake-loader`
      #
      if( NOT NO_INHERIT_OBJC_LOADERS)
         foreach( _TMP_MULLE_OBJC_INET_OS_FOUNDATION_NAME "MulleObjCInetOSFoundation")
            set( _TMP_MULLE_OBJC_INET_OS_FOUNDATION_FILE "${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_ROOT}/include/${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_NAME}/MulleObjCLoader+${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_NAME}.h")
            if( EXISTS "${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_FILE}")
               set( INHERITED_OBJC_LOADERS
                  ${INHERITED_OBJC_LOADERS}
                  ${_TMP_MULLE_OBJC_INET_OS_FOUNDATION_FILE}
                  CACHE INTERNAL "need to cache this"
               )
               break()
            endif()
         endforeach()
      endif()
   else()
      # Enable with: `mulle-sourcetree mark MulleObjCInetOSFoundation require`
      message( STATUS "MULLE_OBJC_INET_OS_FOUNDATION_LIBRARY is missing but it is marked as \"no-require\"")
   endif()
endif()


#
# Generated from sourcetree: AE716CD1-2BDB-46E3-936B-8C33F16B71EF;MulleObjCHTTPFoundation;no-require,no-singlephase;
# Disable with : `mulle-sourcetree mark MulleObjCHTTPFoundation no-link`
# Disable for this platform: `mulle-sourcetree mark MulleObjCHTTPFoundation no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark MulleObjCHTTPFoundation no-cmake-sdk-<name>`
#
if( NOT MULLE_OBJC_HTTP_FOUNDATION_LIBRARY)
   find_library( MULLE_OBJC_HTTP_FOUNDATION_LIBRARY NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}MulleObjCHTTPFoundation${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX} ${CMAKE_STATIC_LIBRARY_PREFIX}MulleObjCHTTPFoundation${CMAKE_STATIC_LIBRARY_SUFFIX} MulleObjCHTTPFoundation NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH)
   message( STATUS "MULLE_OBJC_HTTP_FOUNDATION_LIBRARY is ${MULLE_OBJC_HTTP_FOUNDATION_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_OBJC_HTTP_FOUNDATION_LIBRARY)
      #
      # Add MULLE_OBJC_HTTP_FOUNDATION_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
      # Disable with: `mulle-sourcetree mark MulleObjCHTTPFoundation no-cmake-add`
      #
      set( ALL_LOAD_DEPENDENCY_LIBRARIES
         ${ALL_LOAD_DEPENDENCY_LIBRARIES}
         ${MULLE_OBJC_HTTP_FOUNDATION_LIBRARY}
         CACHE INTERNAL "need to cache this"
      )
      #
      # Inherit information from dependency.
      # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
      # Disable with: `mulle-sourcetree mark MulleObjCHTTPFoundation no-cmake-inherit`
      #
      # temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_OBJC_HTTP_FOUNDATION_ROOT "${MULLE_OBJC_HTTP_FOUNDATION_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_OBJC_HTTP_FOUNDATION_ROOT "${_TMP_MULLE_OBJC_HTTP_FOUNDATION_ROOT}" DIRECTORY)
      #
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark MulleObjCHTTPFoundation no-cmake-dependency`
      #
      foreach( _TMP_MULLE_OBJC_HTTP_FOUNDATION_NAME "MulleObjCHTTPFoundation")
         set( _TMP_MULLE_OBJC_HTTP_FOUNDATION_DIR "${_TMP_MULLE_OBJC_HTTP_FOUNDATION_ROOT}/include/${_TMP_MULLE_OBJC_HTTP_FOUNDATION_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_MULLE_OBJC_HTTP_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            unset( MULLE_OBJC_HTTP_FOUNDATION_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_OBJC_HTTP_FOUNDATION_DIR}")
            #
            include( "${_TMP_MULLE_OBJC_HTTP_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            #
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_OBJC_HTTP_FOUNDATION_DIR}")
            set( INHERITED_DEFINITIONS
               ${INHERITED_DEFINITIONS}
               ${MULLE_OBJC_HTTP_FOUNDATION_DEFINITIONS}
               CACHE INTERNAL "need to cache this"
            )
            break()
         else()
            message( STATUS "${_TMP_MULLE_OBJC_HTTP_FOUNDATION_DIR}/DependenciesAndLibraries.cmake not found")
         endif()
      endforeach()
      #
      # Search for "MulleObjCLoader+<name>.h" in include directory.
      # Disable with: `mulle-sourcetree mark MulleObjCHTTPFoundation no-cmake-loader`
      #
      if( NOT NO_INHERIT_OBJC_LOADERS)
         foreach( _TMP_MULLE_OBJC_HTTP_FOUNDATION_NAME "MulleObjCHTTPFoundation")
            set( _TMP_MULLE_OBJC_HTTP_FOUNDATION_FILE "${_TMP_MULLE_OBJC_HTTP_FOUNDATION_ROOT}/include/${_TMP_MULLE_OBJC_HTTP_FOUNDATION_NAME}/MulleObjCLoader+${_TMP_MULLE_OBJC_HTTP_FOUNDATION_NAME}.h")
            if( EXISTS "${_TMP_MULLE_OBJC_HTTP_FOUNDATION_FILE}")
               set( INHERITED_OBJC_LOADERS
                  ${INHERITED_OBJC_LOADERS}
                  ${_TMP_MULLE_OBJC_HTTP_FOUNDATION_FILE}
                  CACHE INTERNAL "need to cache this"
               )
               break()
            endif()
         endforeach()
      endif()
   else()
      # Enable with: `mulle-sourcetree mark MulleObjCHTTPFoundation require`
      message( STATUS "MULLE_OBJC_HTTP_FOUNDATION_LIBRARY is missing but it is marked as \"no-require\"")
   endif()
endif()


#
# Generated from sourcetree: BD0E4FC1-56D9-4EF4-91D0-862D520A2ADC;mulle-objc-compat;no-cmake-searchpath,no-import;
# Disable with : `mulle-sourcetree mark mulle-objc-compat no-link`
# Disable for this platform: `mulle-sourcetree mark mulle-objc-compat no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark mulle-objc-compat no-cmake-sdk-<name>`
#
if( NOT MULLE_OBJC_COMPAT_LIBRARY)
   find_library( MULLE_OBJC_COMPAT_LIBRARY NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}mulle-objc-compat${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX} ${CMAKE_STATIC_LIBRARY_PREFIX}mulle-objc-compat${CMAKE_STATIC_LIBRARY_SUFFIX} mulle-objc-compat NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH)
   message( STATUS "MULLE_OBJC_COMPAT_LIBRARY is ${MULLE_OBJC_COMPAT_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_OBJC_COMPAT_LIBRARY)
      #
      # Add MULLE_OBJC_COMPAT_LIBRARY to ALL_LOAD_DEPENDENCY_LIBRARIES list.
      # Disable with: `mulle-sourcetree mark mulle-objc-compat no-cmake-add`
      #
      set( ALL_LOAD_DEPENDENCY_LIBRARIES
         ${ALL_LOAD_DEPENDENCY_LIBRARIES}
         ${MULLE_OBJC_COMPAT_LIBRARY}
         CACHE INTERNAL "need to cache this"
      )
      #
      # Inherit information from dependency.
      # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
      # Disable with: `mulle-sourcetree mark mulle-objc-compat no-cmake-inherit`
      #
      # temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_OBJC_COMPAT_ROOT "${MULLE_OBJC_COMPAT_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_OBJC_COMPAT_ROOT "${_TMP_MULLE_OBJC_COMPAT_ROOT}" DIRECTORY)
      #
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark mulle-objc-compat no-cmake-dependency`
      #
      foreach( _TMP_MULLE_OBJC_COMPAT_NAME "mulle-objc-compat")
         set( _TMP_MULLE_OBJC_COMPAT_DIR "${_TMP_MULLE_OBJC_COMPAT_ROOT}/include/${_TMP_MULLE_OBJC_COMPAT_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_MULLE_OBJC_COMPAT_DIR}/DependenciesAndLibraries.cmake")
            unset( MULLE_OBJC_COMPAT_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_OBJC_COMPAT_DIR}")
            #
            include( "${_TMP_MULLE_OBJC_COMPAT_DIR}/DependenciesAndLibraries.cmake")
            #
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_OBJC_COMPAT_DIR}")
            set( INHERITED_DEFINITIONS
               ${INHERITED_DEFINITIONS}
               ${MULLE_OBJC_COMPAT_DEFINITIONS}
               CACHE INTERNAL "need to cache this"
            )
            break()
         else()
            message( STATUS "${_TMP_MULLE_OBJC_COMPAT_DIR}/DependenciesAndLibraries.cmake not found")
         endif()
      endforeach()
      #
      # Search for "MulleObjCLoader+<name>.h" in include directory.
      # Disable with: `mulle-sourcetree mark mulle-objc-compat no-cmake-loader`
      #
      if( NOT NO_INHERIT_OBJC_LOADERS)
         foreach( _TMP_MULLE_OBJC_COMPAT_NAME "mulle-objc-compat")
            set( _TMP_MULLE_OBJC_COMPAT_FILE "${_TMP_MULLE_OBJC_COMPAT_ROOT}/include/${_TMP_MULLE_OBJC_COMPAT_NAME}/MulleObjCLoader+${_TMP_MULLE_OBJC_COMPAT_NAME}.h")
            if( EXISTS "${_TMP_MULLE_OBJC_COMPAT_FILE}")
               set( INHERITED_OBJC_LOADERS
                  ${INHERITED_OBJC_LOADERS}
                  ${_TMP_MULLE_OBJC_COMPAT_FILE}
                  CACHE INTERNAL "need to cache this"
               )
               break()
            endif()
         endforeach()
      endif()
   else()
      # Disable with: `mulle-sourcetree mark mulle-objc-compat no-require-link`
      message( FATAL_ERROR "MULLE_OBJC_COMPAT_LIBRARY was not found")
   endif()
endif()
