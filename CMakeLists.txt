# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2016 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

project(HUGH_META VERSION 0.1.18 LANGUAGES NONE)

if(NOT HUGH_INSTALL_PREFIX)
  set(HUGH_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/install)

  if(DEFINED ENV{HUGH_INSTALL_PREFIX})
    get_filename_component(dir $ENV{HUGH_INSTALL_PREFIX} ABSOLUTE BASE_DIR ${CMAKE_BINARY_DIR})
    set(HUGH_INSTALL_PREFIX ${dir} CACHE INTERNAL "HUGH Installation Root")
  endif()

  set(ENV{HUGH_INSTALL_PREFIX} ${HUGH_INSTALL_PREFIX})
endif()

set(HUGH_GITHUB http://github.com/regnirpsj)
option(HUGH_MAINTAINER_MODE "Enable maintainer mode" OFF)
if (HUGH_MAINTAINER_MODE)
  set(HUGH_GITHUB git@github.com:regnirpsj)
endif()

set(HUGH_BUILD_COMMAND   ${CMAKE_COMMAND} --build .)
set(HUGH_TEST_COMMAND    ${CMAKE_COMMAND} --build . --target test_all)
set(HUGH_INSTALL_COMMAND ${CMAKE_COMMAND} --build . --target install)

if(WIN32)
  set(HUGH_BUILD_COMMAND ${HUGH_BUILD_COMMAND} -- /nologo /v:m)
  set(HUGH_TEST_COMMAND  ${HUGH_TEST_COMMAND} -- /nologo /v:m)
endif()

set(HUGH_COMMON_CMAKE_ARGS)
list(APPEND HUGH_COMMON_CMAKE_ARGS -DCMAKE_INSTALL_MESSAGE=NEVER)
list(APPEND HUGH_COMMON_CMAKE_ARGS -DHUGH_INSTALL_PREFIX=${HUGH_INSTALL_PREFIX})

if(NOT CMAKE_BUILD_TYPE)
  list(APPEND HUGH_COMMON_CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release)
else()
  list(APPEND HUGH_COMMON_CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})
endif()

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS})

include(cmake/cma_external_project.cmake)

cma_externalproject_add(hugh-build-system
                        GIT_REPOSITORY      "${HUGH_GITHUB}/hugh-build-system.git"
		        GIT_TAG             "master"
		        CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
   			BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
			TEST_COMMAND        ${HUGH_TEST_COMMAND}
			INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
			TEST_BEFORE_INSTALL 1)

cma_externalproject_add(hugh-data
                        GIT_REPOSITORY      "${HUGH_GITHUB}/hugh-data.git"
			GIT_TAG             "master"
			CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
			BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
			TEST_COMMAND        ""
			INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
			TEST_BEFORE_INSTALL 0
			DEPENDS             hugh-build-system)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_SUPPORT_DOC_USR=1 -DHUGH_SUPPORT_DOC_DEV=1)

cma_externalproject_add(hugh-support
                        GIT_REPOSITORY      "${HUGH_GITHUB}/hugh-support.git"
			GIT_TAG             "master"
			CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
			BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
			TEST_COMMAND        ${HUGH_TEST_COMMAND}
			INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
			TEST_BEFORE_INSTALL 1
			DEPENDS             hugh-build-system)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_EVENTS_DOC_USR=1 -DHUGH_EVENTS_DOC_DEV=1)

cma_externalproject_add(hugh-events
                        GIT_REPOSITORY      "${HUGH_GITHUB}/hugh-events.git"
			GIT_TAG             "master"
			CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
			BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
			TEST_COMMAND        ${HUGH_TEST_COMMAND}
			INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
			TEST_BEFORE_INSTALL 1
			DEPENDS             hugh-build-system hugh-support)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_FIELDS_DOC_USR=1 -DHUGH_FIELDS_DOC_DEV=1)

cma_externalproject_add(hugh-fields
                        GIT_REPOSITORY      "${HUGH_GITHUB}/hugh-fields.git"
			GIT_TAG             "master"
			CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
			BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
			TEST_COMMAND        ${HUGH_TEST_COMMAND}
			INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
			TEST_BEFORE_INSTALL 1
			DEPENDS             hugh-build-system hugh-support)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_PLATFORM_DOC_USR=1 -DHUGH_PLATFORM_DOC_DEV=1)

cma_externalproject_add(hugh-platform
                        GIT_REPOSITORY      "${HUGH_GITHUB}/hugh-platform.git"
			GIT_TAG             "master"
			CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
			BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
			TEST_COMMAND        ${HUGH_TEST_COMMAND}
			INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
			TEST_BEFORE_INSTALL 1
			DEPENDS             hugh-build-system hugh-fields hugh-support)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_SCENE_DOC_USR=1 -DHUGH_SCENE_DOC_DEV=1)

cma_externalproject_add(hugh-scene
                        GIT_REPOSITORY      "${HUGH_GITHUB}/hugh-scene.git"
			GIT_TAG             "master"
			CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
			BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
			TEST_COMMAND        ${HUGH_TEST_COMMAND}
			INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
			TEST_BEFORE_INSTALL 1
			DEPENDS             hugh-build-system hugh-data hugh-fields hugh-support)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_RENDER_DOC_USR=1 -DHUGH_RENDER_DOC_DEV=1)

cma_externalproject_add(hugh-render
                        GIT_REPOSITORY      "${HUGH_GITHUB}/hugh-render.git"
			GIT_TAG             "master"
			CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
			BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
			TEST_COMMAND        ${HUGH_TEST_COMMAND}
			INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
			TEST_BEFORE_INSTALL 1
			DEPENDS             hugh-build-system hugh-data hugh-scene hugh-support)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_RENDER_HW_DOC_USR=1 -DHUGH_RENDER_HW_DOC_DEV=1)

cma_externalproject_add(hugh-render-hw
                        GIT_REPOSITORY      "${HUGH_GITHUB}/hugh-render-hw.git"
                        GIT_TAG             "master"
                        CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
                        BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
                        TEST_COMMAND        ${HUGH_TEST_COMMAND}
                        INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
                        TEST_BEFORE_INSTALL 1
                        DEPENDS             hugh-build-system hugh-data hugh-fields hugh-render hugh-scene hugh-support)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_RENDER_SW_DOC_USR=1 -DHUGH_RENDER_SW_DOC_DEV=1)

cma_externalproject_add(hugh-render-sw
                        GIT_REPOSITORY      "${HUGH_GITHUB}/hugh-render-sw.git"
			GIT_TAG             "master"
			CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
			BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
			TEST_COMMAND        ${HUGH_TEST_COMMAND}
			INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
			TEST_BEFORE_INSTALL 1
			DEPENDS             hugh-build-system hugh-data hugh-render hugh-scene hugh-support)

set(HUGH_CMAKE_ARGS ${HUGH_COMMON_CMAKE_ARGS} -DHUGH_GUI_EXAMPLES_DOC_USR=1 -DHUGH_GUI_EXAMPLES_DOC_DEV=1)

cma_externalproject_add(hugh-gui-examples
                        GIT_REPOSITORY      "${HUGH_GITHUB}/hugh-gui-examples.git"
			GIT_TAG             "master"
			CMAKE_ARGS          ${HUGH_CMAKE_ARGS}
			BUILD_COMMAND       ${HUGH_BUILD_COMMAND}
			TEST_COMMAND        ${HUGH_TEST_COMMAND}
			INSTALL_COMMAND     ${HUGH_INSTALL_COMMAND}
			TEST_BEFORE_INSTALL 1
			DEPENDS             hugh-build-system hugh-data hugh-support)
