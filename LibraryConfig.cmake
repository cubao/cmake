# Select library type
set(_PN ${PROJECT_NAME})
option(BUILD_SHARED_LIBS "Build ${_PN} as a shared library." ON)
if(BUILD_SHARED_LIBS)
    set(LIBRARY_TYPE SHARED)
else()
    set(LIBRARY_TYPE STATIC)
endif()

# Set a default build type if none was specified
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to 'Release'.")
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
    # Set the possible values of build type for cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Target
add_library(${LIBRARY_NAME} ${LIBRARY_TYPE} ${SOURCES} ${HEADERS})

# Install library
install(TARGETS ${LIBRARY_NAME}
    EXPORT ${PROJECT_EXPORT}
    RUNTIME DESTINATION "${INSTALL_BIN_DIR}" COMPONENT bin
    LIBRARY DESTINATION "${INSTALL_LIB_DIR}" COMPONENT shlib
    ARCHIVE DESTINATION "${INSTALL_LIB_DIR}" COMPONENT stlib
    COMPONENT dev)

# Config & install lib version
configure_file(version.h.in "${CMAKE_CURRENT_BINARY_DIR}/version.h" @ONLY)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/version.h" DESTINATION "${INSTALL_INCLUDE_DIR}/${LIBRARY_FOLDER}")

# Install header files, if set HEADER_ROOT, preserve directory structure, otherwise flatten it
foreach(file ${HEADERS})
    if(HEADER_ROOT)
        get_filename_component(dir ${file} DIRECTORY)
        string(REGEX REPLACE "${HEADER_ROOT}" "" dir ${dir})
        install(FILES ${file} DESTINATION "${INSTALL_INCLUDE_DIR}/${LIBRARY_FOLDER}${dir}")
    else()
        install(FILES ${file} DESTINATION "${INSTALL_INCLUDE_DIR}/${LIBRARY_FOLDER}")
    endif()
endforeach()
