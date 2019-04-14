function(setup_git_branch)
    execute_process(
        COMMAND git rev-parse --abbrev-ref HEAD
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_BRANCH
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set(GIT_BRANCH ${GIT_BRANCH} PARENT_SCOPE)
endfunction()

function(setup_git_commit_hash)
    execute_process(
        COMMAND git log -1 --format=%h
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_COMMIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set(GIT_COMMIT_HASH ${GIT_COMMIT_HASH} PARENT_SCOPE)
endfunction()

function(print_include_directories)
    get_property(dirs DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY INCLUDE_DIRECTORIES)
    message(STATUS "all include directories:")
    foreach(dir ${dirs})
        message(STATUS "-   ${dir}")
    endforeach()
endfunction()

function(print_all_linked_libraries target)
    get_target_property(libs ${target} LINK_LIBRARIES)
    message(STATUS "all linked libraries: (against ${target})")
    foreach (lib ${libs})
        message(STATUS "-   ${lib}")
    endforeach()
endfunction()

function(print_all_variables)
    get_cmake_property(vars VARIABLES)
    list(SORT vars)
    message(STATUS "all variables:")
    foreach (var ${vars})
        message(STATUS "-   ${var}=${${var}}")
    endforeach()
endfunction()

