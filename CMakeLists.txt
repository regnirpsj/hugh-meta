# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2016 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

project(HUGH_META VERSION 0.1.14 LANGUAGES NONE)

if(NOT HUGH_INSTALL_PREFIX)
  set(HUGH_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/install)

  if(DEFINED ENV{HUGH_INSTALL_PREFIX})
    set(HUGH_INSTALL_PREFIX $ENV{HUGH_INSTALL_PREFIX} CACHE INTERNAL "HUGH Installation Root")
  endif()

  set(ENV{HUGH_INSTALL_PREFIX} ${HUGH_INSTALL_PREFIX})
endif()

set(HUGH_BUILD_COMMAND   ${CMAKE_COMMAND} --build .)
set(HUGH_TEST_COMMAND    ${CMAKE_COMMAND} --build . --target test_all)
set(HUGH_INSTALL_COMMAND ${CMAKE_COMMAND} --build . --target install)

include(ExternalProject)

set(HUGH_COMMON_CMAKE_ARGS)
list(APPEND HUGH_COMMON_CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release)
list(APPEND HUGH_COMMON_CMAKE_ARGS -DCMAKE_INSTALL_MESSAGE=NEVER)
list(APPEND HUGH_COMMON_CMAKE_ARGS -DHUGH_INSTALL_PREFIX=${HUGH_INSTALL_PREFIX})

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS})

externalproject_add(hugh-build-system
                    GIT_REPOSITORY      "http://github.com/regnirpsj/hugh-build-system.git"
		    GIT_TAG             "master"
		    CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
		    BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
		    TEST_COMMAND        ${HUGH_TEST_COMMAND}
		    INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
		    TEST_BEFORE_INSTALL 1)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_SUPPORT_DOC_USR=1 -DHUGH_SUPPORT_DOC_DEV=1)

externalproject_add(hugh-support
                    GIT_REPOSITORY      "http://github.com/regnirpsj/hugh-support.git"
		    GIT_TAG             "master"
		    CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
		    BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
		    TEST_COMMAND        ${HUGH_TEST_COMMAND}
		    INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
		    TEST_BEFORE_INSTALL 1
		    DEPENDS             hugh-build-system)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_FIELDS_DOC_USR=1 -DHUGH_FIELDS_DOC_DEV=1)

externalproject_add(hugh-fields
                    GIT_REPOSITORY      "http://github.com/regnirpsj/hugh-fields.git"
		    GIT_TAG             "master"
		    CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
		    BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
		    TEST_COMMAND        ${HUGH_TEST_COMMAND}
		    INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
		    TEST_BEFORE_INSTALL 1
		    DEPENDS             hugh-build-system hugh-support)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_PLATFORM_DOC_USR=1 -DHUGH_PLATFORM_DOC_DEV=1)

externalproject_add(hugh-platform
                    GIT_REPOSITORY      "http://github.com/regnirpsj/hugh-platform.git"
		    GIT_TAG             "master"
		    CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
		    BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
		    TEST_COMMAND        ${HUGH_TEST_COMMAND}
		    INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
		    TEST_BEFORE_INSTALL 1
		    DEPENDS             hugh-build-system hugh-support hugh-fields)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_SCENE_DOC_USR=1 -DHUGH_SCENE_DOC_DEV=1)

externalproject_add(hugh-scene
                    GIT_REPOSITORY      "http://github.com/regnirpsj/hugh-scene.git"
		    GIT_TAG             "master"
		    CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
		    BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
		    TEST_COMMAND        ${HUGH_TEST_COMMAND}
		    INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
		    TEST_BEFORE_INSTALL 1
		    DEPENDS             hugh-build-system hugh-support hugh-fields)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_RENDER_SW_DOC_USR=1 -DHUGH_RENDER_SW_DOC_DEV=1)

externalproject_add(hugh-render-sw
                    GIT_REPOSITORY      "http://github.com/regnirpsj/hugh-render-sw.git"
		    GIT_TAG             "master"
		    CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
		    BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
		    TEST_COMMAND        ${HUGH_TEST_COMMAND}
		    INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
		    TEST_BEFORE_INSTALL 1
		    DEPENDS             hugh-build-system hugh-scene hugh-support)

