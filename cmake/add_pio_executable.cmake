# Utility for linking PIO tests and examples.
# Intended for internal use only
function(add_pio_executable EXE SRC) 
  add_executable(${EXE} EXCLUDE_FROM_ALL "${SRC}") 
  include_directories(${PIO_INCLUDE_DIRS} "${CMAKE_BINARY_DIR}" "${CMAKE_SOURCE_DIR}/src/clib" "${CMAKE_BINARY_DIR}/src/gptl/" "${CMAKE_BINARY_DIR}/src/flib/" "${CMAKE_BINARY_DIR}/src/clib/" "${NetCDF_C_INCLUDE_DIR}"  "${PnetCDF_C_INCLUDE_DIR}")
  if (PIO_ENABLE_FORTRAN)
    target_link_libraries (${EXE} PRIVATE piofSTATIC )
  endif()
  target_link_libraries (${EXE} PRIVATE piocSTATIC )
  target_link_libraries (${EXE} PUBLIC "${NetCDF_C_LIBRARY}")
  if (WITH_PNETCDF)
    target_link_libraries (${EXE} PUBLIC "${PnetCDF_C_LIBRARY}")
  endif()
  if (PIO_ENABLE_TIMING)
    target_link_libraries (${EXE} PRIVATE gptlSTATIC)
  endif()

endfunction()
