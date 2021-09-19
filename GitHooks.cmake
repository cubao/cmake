# default to install precommit hook
if(NOT DEFINED INSTALL_GIT_PRECOMMIT_HOOK)
    message(STATUS "'INSTALL_GIT_PRECOMMIT_HOOK' not defined, set to dedault: ON")
    set(INSTALL_GIT_PRECOMMIT_HOOK ON)
endif()
if (NOT INSTALL_GIT_PRECOMMIT_HOOK)
    message(STATUS "it seems you explicitly disabled clang-formatting git pre-commit hook")
else()
    message(STATUS "git pre-commit hook clang-formatting works by default")
endif()
if(NOT GIT_FOUND)
    find_package(Git QUIET)
endif()
if(NOT CLANG_FORMAT)
    find_program(CLANG_FORMAT clang-format)
endif()

if(INSTALL_GIT_PRECOMMIT_HOOK AND GIT_FOUND AND CLANG_FORMAT AND EXISTS ${PROJECT_SOURCE_DIR}/.git/hooks AND NOT EXISTS ${PROJECT_SOURCE_DIR}/.git/hooks/pre-commit)
    configure_file(${CMAKE_CURRENT_LIST_DIR}/pre-commit.in ${PROJECT_SOURCE_DIR}/.git/hooks/pre-commit)
endif()

# setup version.h.in
if(NOT EXISTS ${PROJECT_SOURCE_DIR}/version.h.in)
    configure_file(${CMAKE_CURRENT_LIST_DIR}/version.h.in ${PROJECT_SOURCE_DIR}/version.h.in COPYONLY)
endif()

# setup .clang-format
if(NOT EXISTS ${PROJECT_SOURCE_DIR}/.clang-format)
    message(STATUS "installing .clang-format for C++ project... (standard: cpp11)")
    configure_file(${CMAKE_CURRENT_LIST_DIR}/_clang-format ${PROJECT_SOURCE_DIR}/.clang-format COPYONLY)
endif()

# setup .gitignore
if(NOT EXISTS ${PROJECT_SOURCE_DIR}/.gitignore)
    message(STATUS "installing .gitignore for C++ project...")
    configure_file(${CMAKE_CURRENT_LIST_DIR}/_gitignore ${PROJECT_SOURCE_DIR}/.gitignore COPYONLY)
endif()
