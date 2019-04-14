# General CMake Configuration

把本 repo 加到 C++ 项目中作为 submodule:

```bash
git submodule add git@github.com:district10/cmake.git
```

# 使用

```cmake
cmake_minimum_required(VERSION 3.5)
set(MAJOR_VERSION 1)
set(MAJOR_VERSION 0)
set(MAJOR_VERSION 0)

# option(INSTALL_GIT_PRECOMMIT_HOOK "install precommit hook" ON)
include(cmake/GitHooks.cmake)
set(CONAN_BUILD_INFO_CMAKE ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
if(NOT EXISTS ${CONAN_BUILD_INFO_CMAKE})
    message(FATAL_ERROR "**********************\nYou may need to:\n\tconan install ..\n**********************")
endif()
include(${CONAN_BUILD_INFO_CMAKE})
conan_basic_setup()

include(cmake/Utilities.cmake)
include(cmake/GeneralConfig.cmake)
# print_all_variables()

include_directories(BEFORE
    ${PROJECT_BINARY_DIR}
    ${PROJECT_SOURCE_DIR}/include
    ${CONAN_INCLUDE_DIRS}
)
print_include_directories()

configure_file(
    ${PROJECT_SOURCE_DIR}/version.h.in
    ${PROJECT_BINARY_DIR}/version.h
)

include(cmake/SetEnv.cmake)
set(HEADER_ROOT "${PROJECT_SOURCE_DIR}/include")
file(GLOB_RECURSE HEADERS include/*)
file(GLOB_RECURSE SOURCES src/*.cpp)
include(cmake/LibraryConfig.cmake)
message(STATUS "$HEADERS: ${HEADERS}")
message(STATUS "$SOURCES: ${SOURCES}")
target_link_libraries(${PROJECT_NAME}
    ${CONAN_LIBS}
)
print_all_linked_libraries(${PROJECT_NAME})

option(BUILD_TESTS "Build tests." OFF)
if(BUILD_TESTS)
    message(STATUS "adding tests...")
    file(GLOB SRCS tests/test_*.cpp)
    foreach(src ${SRCS})
        string(REGEX REPLACE "(^.*/|.cpp$)" "" exe ${src})
        add_executable(${exe} ${src})
        target_link_libraries(${exe} ${PROJECT_NAME})
    endforeach(src)
endif()
```

# Credits

-   <https://github.com/pablospe/cmake-example-library>
-   <https://github.com/hernando/CMake/blob/master/GitHooks.cmake>
