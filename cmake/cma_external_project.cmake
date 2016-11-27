# -*- Mode:cmake -*-

####################################################################################################
#                                                                                                  #
# Copyright (C) 2016 University of Hull                                                            #
#                                                                                                  #
####################################################################################################

include(ExternalProject)

# .rst:
# cma_externalproject_add(NAME [<option>...])
#
# wrapper for externalproject_add. arguments are forwarded to externalproject_add and a
# 'git status' target is created for each external project. all 'git status' targets, for external
# projects processed with 'cma_externalproject_add' are a dependency to the global 'git-status'
# target. the git status for all external projects can then be checked in ${CMAKE_BINARY_DIR}:
#
#   % cmake --build . --target git-status
#
function(cma_externalproject_add NAME)
  externalproject_add(${NAME} ${ARGN})

  if(NOT TARGET git-status)
    add_custom_target(git-status)
  endif()
  
  add_custom_target(${NAME}-git-status
                    COMMAND           git status --porcelain
		    WORKING_DIRECTORY ${NAME}-prefix/src/${NAME}
		    COMMENT           "Checking 'git status' for ${NAME}")

  add_dependencies(git-status ${NAME}-git-status)
endfunction()
