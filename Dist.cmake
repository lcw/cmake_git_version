IF (UNIX)
  FILE(WRITE ${CMAKE_BINARY_DIR}/Dist.cmake
"MESSAGE(STATUS \"Package Dist running...\")
INCLUDE(CPackSourceConfig.cmake)
EXECUTE_PROCESS(COMMAND cpack -G TGZ --config CPackSourceConfig.cmake
  TIMEOUT 3600
  WORKING_DIRECTORY \${CMAKE_BINARY_DIR})
")
  #
  # Add custom target
  #
  ADD_CUSTOM_TARGET(dist
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/Dist.cmake
    )
ENDIF(UNIX)
