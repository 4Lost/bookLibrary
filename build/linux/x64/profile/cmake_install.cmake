# Install script for directory: /home/elias/Nextcloud/Data/Programms/library/book_library/linux

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Profile")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/run/current-system/sw/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/")
  
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/book_library" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/book_library")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/book_library"
         RPATH "$ORIGIN/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/book_library")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle" TYPE EXECUTABLE FILES "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/intermediates_do_not_run/book_library")
  if(EXISTS "$ENV{DESTDIR}/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/book_library" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/book_library")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/book_library"
         OLD_RPATH "/home/elias/Nextcloud/Data/Programms/library/book_library/linux/flutter/ephemeral:/nix/store/vbw9c3pvwli5iidik8dddgz423wr1h18-gtk+3-3.24.43/lib:/nix/store/idrnfiw9r87giqiqwr36xkch4dsr0rdz-pango-1.54.0/lib:/nix/store/dqxy0zqcyhapa6yv3kb4kmj2sfzkgjn2-harfbuzz-10.0.1/lib:/nix/store/j6wpl172pz2323fia7cbjx9lznsc47ri-at-spi2-core-2.54.0/lib:/nix/store/arrgysrp5ks44qidsf8byjj11pnkaf65-cairo-1.18.2/lib:/nix/store/mafw0r1djqvl36by8qhz02kmaggh24v8-gdk-pixbuf-2.42.12/lib:/nix/store/jq1ydifw3ip1vx94dl8w8bgvr07l6s3x-glib-2.82.1/lib:"
         NEW_RPATH "$ORIGIN/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/run/current-system/sw/bin/strip" "$ENV{DESTDIR}/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/book_library")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/data/icudtl.dat")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/data" TYPE FILE FILES "/home/elias/Nextcloud/Data/Programms/library/book_library/linux/flutter/ephemeral/icudtl.dat")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/lib/libflutter_linux_gtk.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/lib" TYPE FILE FILES "/home/elias/Nextcloud/Data/Programms/library/book_library/linux/flutter/ephemeral/libflutter_linux_gtk.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/lib/")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/lib" TYPE DIRECTORY FILES "/home/elias/Nextcloud/Data/Programms/library/book_library/build/native_assets/linux/")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/data/flutter_assets")
  
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/data/flutter_assets")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/data" TYPE DIRECTORY FILES "/home/elias/Nextcloud/Data/Programms/library/book_library/build//flutter_assets")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/lib/libapp.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/bundle/lib" TYPE FILE FILES "/home/elias/Nextcloud/Data/Programms/library/book_library/build/lib/libapp.so")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/flutter/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_COMPONENT MATCHES "^[a-zA-Z0-9_.+-]+$")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
  else()
    string(MD5 CMAKE_INST_COMP_HASH "${CMAKE_INSTALL_COMPONENT}")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INST_COMP_HASH}.txt")
    unset(CMAKE_INST_COMP_HASH)
  endif()
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
  file(WRITE "/home/elias/Nextcloud/Data/Programms/library/book_library/build/linux/x64/profile/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
