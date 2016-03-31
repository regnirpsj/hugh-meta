# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2016 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

project(HUGH_META VERSION 0.1.9)

set(HUGH_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/install)

if(DEFINED ENV{HUGH_INSTALL_PREFIX})
  set(HUGH_INSTALL_PREFIX $ENV{HUGH_INSTALL_PREFIX} CACHE INTERNAL "")
endif()

set(ENV{HUGH_INSTALL_PREFIX} ${HUGH_INSTALL_PREFIX})

set(HUGH_BUILD_COMMAND   ${CMAKE_COMMAND} --build .)
set(HUGH_TEST_COMMAND    ${CMAKE_COMMAND} --build . --target test_all)
set(HUGH_INSTALL_COMMAND ${CMAKE_COMMAND} --build . --target install)

include(ExternalProject)

set(HUGH_CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${HUGH_INSTALL_PREFIX})

externalproject_add(hugh-build-system
                    GIT_REPOSITORY      "http://github.com/regnirpsj/hugh-build-system.git"
		    GIT_TAG             "master"
		    CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
		    BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
		    TEST_COMMAND        ${HUGH_TEST_COMMAND}
		    INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
		    TEST_BEFORE_INSTALL 1)

set(HUGH_CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release -DHUGH_INSTALL_PREFIX=${HUGH_INSTALL_PREFIX})

externalproject_add(hugh-support
                    GIT_REPOSITORY      "http://github.com/regnirpsj/hugh-support.git"
		    GIT_TAG             "master"
		    CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
		    BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
		    TEST_COMMAND        ${HUGH_TEST_COMMAND}
		    INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
		    TEST_BEFORE_INSTALL 1
		    DEPENDS             hugh-build-system)

externalproject_add(hugh-fields
                    GIT_REPOSITORY      "http://github.com/regnirpsj/hugh-fields.git"
		    GIT_TAG             "master"
		    CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
		    BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
		    TEST_COMMAND        ${HUGH_TEST_COMMAND}
		    INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
		    TEST_BEFORE_INSTALL 1
		    DEPENDS             hugh-build-system hugh-support)

externalproject_add(hugh-platform
                    GIT_REPOSITORY      "http://github.com/regnirpsj/hugh-platform.git"
		    GIT_TAG             "master"
		    CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
		    BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
		    TEST_COMMAND        ${HUGH_TEST_COMMAND}
		    INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
		    TEST_BEFORE_INSTALL 1
		    DEPENDS             hugh-build-system hugh-support hugh-fields)

externalproject_add(hugh-scene
                    GIT_REPOSITORY      "http://github.com/regnirpsj/hugh-scene.git"
		    GIT_TAG             "master"
		    CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
		    BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
		    TEST_COMMAND        ${HUGH_TEST_COMMAND}
		    INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
		    TEST_BEFORE_INSTALL 1
		    DEPENDS             hugh-build-system hugh-support hugh-fields)
