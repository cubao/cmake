if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()
message("Build type: " ${CMAKE_BUILD_TYPE})

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -O3 -Wall -pthread -Wno-reorder -march=native")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -O3 -march=native")

if(NOT DEFINED CONAN_BUILD_INFO_CMAKE)
    include_directories(${CMAKE_INSTALL_PREFIX}/include)
    link_directories(${CMAKE_INSTALL_PREFIX}/lib)
    list(APPEND CMAKE_PREFIX_PATH
        "${CMAKE_INSTALL_PREFIX}/lib/cmake"
        "${CMAKE_INSTALL_PREFIX}/share")
endif()
