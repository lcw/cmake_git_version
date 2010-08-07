CMAKE_MINIMUM_REQUIRED(VERSION 2.8 FATAL_ERROR)
PROJECT(VERSIONHEADER C)
FIND_PACKAGE(Git)
FILE(WRITE ${CMAKE_BINARY_DIR}/main.c
"\#include \"version.h\"\nint main(void){return 0;}\n"
)
FILE(WRITE ${CMAKE_BINARY_DIR}/version.h.in
"\#define VERSION \"@VERSION@\"\n"
)
FILE(WRITE ${CMAKE_BINARY_DIR}/version.cmake
"EXECUTE_PROCESS(
     COMMAND ${GIT_EXECUTABLE} describe --tags --dirty
     OUTPUT_VARIABLE VERSION
     OUTPUT_STRIP_TRAILING_WHITESPACE
 )
 CONFIGURE_FILE(\${SRC} \${DST} @ONLY)
")
INCLUDE_DIRECTORIES(${CMAKE_BINARY_DIR})
ADD_EXECUTABLE(main main.c)
ADD_CUSTOM_TARGET(
    version
    ${CMAKE_COMMAND} -D SRC=${CMAKE_BINARY_DIR}/version.h.in
                     -D DST=${CMAKE_BINARY_DIR}/version.h
                     -P ${CMAKE_BINARY_DIR}/version.cmake
)
ADD_DEPENDENCIES(main version)
