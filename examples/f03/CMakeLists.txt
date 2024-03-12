###-------------------------------------------------------------------------###
### CMakeList.txt for examples using pio
###-------------------------------------------------------------------------###

# Adding PIO definitions - defined in the root directory
ADD_DEFINITIONS(${PIO_DEFINITIONS})

# Include PIO include and lib directories
INCLUDE_DIRECTORIES(${PIO_INCLUDE_DIRS})
LINK_DIRECTORIES(${PIO_LIB_DIR})

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -g -O0")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O0")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0")
if(${PIO_BUILD_TIMING})
  SET(TIMING_LINK_LIB timing)
endif()
SET(SRC examplePio.F90)
ADD_EXECUTABLE(examplePio_f90 ${SRC})
message("Looking for netcdf in ${NetCDF_C_LIBRARY}")
get_filename_component(NCLIB ${NetCDF_C_LIBRARY} DIRECTORY)
find_library(NETCDF_LIB HINTS ${NCLIB} netcdf)
SET(NETCDF_LIBS netcdf)
if (WITH_PNETCDF)
  find_library(PNETCDF_LIB HINTS ${PNetCDF_C_LIBRARY} pnetcdf)
  LIST(APPEND NETCDF_LIBS pnetcdf)
endif()

TARGET_LINK_LIBRARIES(examplePio_f90 piofSTATIC piocSTATIC ${TIMING_LINK_LIB} "${NETCDF_LIBS}" )
SET(SRC exampleAsyncPio.F90)
ADD_EXECUTABLE(exampleAsyncPio_f90 ${SRC})
TARGET_LINK_LIBRARIES(exampleAsyncPio_f90 piofSTATIC piocSTATIC ${TIMING_LINK_LIB} "${NETCDF_LIBS}" ) 
target_include_directories (examplePio_f90 
  PUBLIC ${CMAKE_BINARY_DIR}
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/../../src/flib"
  PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
target_include_directories (exampleAsyncPio_f90 
  PUBLIC ${CMAKE_BINARY_DIR}
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/../src/flib"
  PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
