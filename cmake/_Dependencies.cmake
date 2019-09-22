#
# cmake/_Dependencies.cmake is generated by `mulle-sde`. Edits will be lost.
# Disable generation of this file with:
#   mulle-sde environment  --global set MULLE_SOURCETREE_TO_CMAKE_DEPENDENCIES_FILE DISABLE
if( MULLE_TRACE_INCLUDE)
   message( STATUS "# Include \"${CMAKE_CURRENT_LIST_FILE}\"" )
endif()

#
# Generated from sourcetree: objc-compat;no-all-load,no-import,no-link;
# Disable with: `mulle-sourcetree mark objc-compat no-link`
#
if( NOT OBJC_COMPAT_HEADER)
   find_file( OBJC_COMPAT_HEADER NAMES objc-compat/objc-compat.h objc-compat.h)
   message( STATUS "OBJC_COMPAT_HEADER is ${OBJC_COMPAT_HEADER}")

   #
   # Add to list of header files.
   # Disable with: `mulle-sourcetree mark objc-compat no-cmakeadd`
   #
   set( HEADER_ONLY_LIBRARIES
      ${OBJC_COMPAT_HEADER}
      ${HEADER_ONLY_LIBRARIES}
      CACHE INTERNAL "need to cache this"
   )
   if( OBJC_COMPAT_HEADER)
      #
      # Inherit ObjC loader and link dependency info.
      # Disable with: `mulle-sourcetree mark objc-compat no-cmakeinherit`
      #
      get_filename_component( _TMP_OBJC_COMPAT_ROOT "${OBJC_COMPAT_HEADER}" DIRECTORY)
      get_filename_component( _TMP_OBJC_COMPAT_NAME "${_TMP_OBJC_COMPAT_ROOT}" NAME)
      get_filename_component( _TMP_OBJC_COMPAT_ROOT "${_TMP_OBJC_COMPAT_ROOT}" DIRECTORY)
      get_filename_component( _TMP_OBJC_COMPAT_ROOT "${_TMP_OBJC_COMPAT_ROOT}" DIRECTORY)
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark objc-compat no-cmakedependency`
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
      message( FATAL_ERROR "OBJC_COMPAT_HEADER was not found")
   endif()
endif()



#
# Generated from sourcetree: MulleFoundation;;
# Disable with: `mulle-sourcetree mark MulleFoundation no-link`
#
if( NOT MULLE_FOUNDATION_LIBRARY)
   find_library( MULLE_FOUNDATION_LIBRARY NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}MulleFoundation${CMAKE_STATIC_LIBRARY_SUFFIX} MulleFoundation NO_CMAKE_SYSTEM_PATH)
   message( STATUS "MULLE_FOUNDATION_LIBRARY is ${MULLE_FOUNDATION_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_FOUNDATION_LIBRARY)
      #
      # Add to MULLE_FOUNDATION_LIBRARY list.
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmakeadd`
      #
      set( ALL_LOAD_DEPENDENCY_LIBRARIES
         ${ALL_LOAD_DEPENDENCY_LIBRARIES}
         ${MULLE_FOUNDATION_LIBRARY}
         CACHE INTERNAL "need to cache this"
      )
      #
      # Inherit ObjC loader and link dependency info.
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmakeinherit`
      #
      # // temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_FOUNDATION_ROOT "${MULLE_FOUNDATION_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_FOUNDATION_ROOT "${_TMP_MULLE_FOUNDATION_ROOT}" DIRECTORY)
      #
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmakedependency`
      #
      foreach( _TMP_MULLE_FOUNDATION_NAME "MulleFoundation")
         set( _TMP_MULLE_FOUNDATION_DIR "${_TMP_MULLE_FOUNDATION_ROOT}/include/${_TMP_MULLE_FOUNDATION_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_MULLE_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            unset( MULLE_FOUNDATION_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_FOUNDATION_DIR}")
            # we only want top level INHERIT_OBJC_LOADERS, so disable them
            if( NOT NO_INHERIT_OBJC_LOADERS)
               set( NO_INHERIT_OBJC_LOADERS OFF)
            endif()
            list( APPEND _TMP_INHERIT_OBJC_LOADERS ${NO_INHERIT_OBJC_LOADERS})
            set( NO_INHERIT_OBJC_LOADERS ON)
            #
            include( "${_TMP_MULLE_FOUNDATION_DIR}/DependenciesAndLibraries.cmake")
            #
            list( GET _TMP_INHERIT_OBJC_LOADERS -1 NO_INHERIT_OBJC_LOADERS)
            list( REMOVE_AT _TMP_INHERIT_OBJC_LOADERS -1)
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
      # Search for "objc-loader.inc" in include directory.
      # Disable with: `mulle-sourcetree mark MulleFoundation no-cmakeloader`
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
      message( FATAL_ERROR "MULLE_FOUNDATION_LIBRARY was not found")
   endif()
endif()


#
# Generated from sourcetree: mulle-objc-compat;no-all-load,no-import;
# Disable with: `mulle-sourcetree mark mulle-objc-compat no-link`
#
if( NOT MULLE_OBJC_COMPAT_LIBRARY)
   find_library( MULLE_OBJC_COMPAT_LIBRARY NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}mulle-objc-compat${CMAKE_STATIC_LIBRARY_SUFFIX} mulle-objc-compat NO_CMAKE_SYSTEM_PATH)
   message( STATUS "MULLE_OBJC_COMPAT_LIBRARY is ${MULLE_OBJC_COMPAT_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_OBJC_COMPAT_LIBRARY)
      #
      # Add to MULLE_OBJC_COMPAT_LIBRARY list.
      # Disable with: `mulle-sourcetree mark mulle-objc-compat no-cmakeadd`
      #
      set( DEPENDENCY_LIBRARIES
         ${DEPENDENCY_LIBRARIES}
         ${MULLE_OBJC_COMPAT_LIBRARY}
         CACHE INTERNAL "need to cache this"
      )
      #
      # Inherit ObjC loader and link dependency info.
      # Disable with: `mulle-sourcetree mark mulle-objc-compat no-cmakeinherit`
      #
      # // temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_OBJC_COMPAT_ROOT "${MULLE_OBJC_COMPAT_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_OBJC_COMPAT_ROOT "${_TMP_MULLE_OBJC_COMPAT_ROOT}" DIRECTORY)
      #
      #
      # Search for "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark mulle-objc-compat no-cmakedependency`
      #
      foreach( _TMP_MULLE_OBJC_COMPAT_NAME "mulle-objc-compat")
         set( _TMP_MULLE_OBJC_COMPAT_DIR "${_TMP_MULLE_OBJC_COMPAT_ROOT}/include/${_TMP_MULLE_OBJC_COMPAT_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( EXISTS "${_TMP_MULLE_OBJC_COMPAT_DIR}/DependenciesAndLibraries.cmake")
            unset( MULLE_OBJC_COMPAT_DEFINITIONS)
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_OBJC_COMPAT_DIR}")
            # we only want top level INHERIT_OBJC_LOADERS, so disable them
            if( NOT NO_INHERIT_OBJC_LOADERS)
               set( NO_INHERIT_OBJC_LOADERS OFF)
            endif()
            list( APPEND _TMP_INHERIT_OBJC_LOADERS ${NO_INHERIT_OBJC_LOADERS})
            set( NO_INHERIT_OBJC_LOADERS ON)
            #
            include( "${_TMP_MULLE_OBJC_COMPAT_DIR}/DependenciesAndLibraries.cmake")
            #
            list( GET _TMP_INHERIT_OBJC_LOADERS -1 NO_INHERIT_OBJC_LOADERS)
            list( REMOVE_AT _TMP_INHERIT_OBJC_LOADERS -1)
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
   else()
      message( FATAL_ERROR "MULLE_OBJC_COMPAT_LIBRARY was not found")
   endif()
endif()
