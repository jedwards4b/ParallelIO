cmake_minimum_required (VERSION 2.8.12)
include (CheckFunctionExists)
project (PIOC C)

#==============================================================================
#  DEFINE THE TARGET
#==============================================================================

if (CMAKE_BUILD_TYPE)
    define_property(
        SOURCE
        PROPERTY COMPILE_FLAGS
        INHERITED
        BRIEF_DOCS "brief-doc"
        FULL_DOCS  "full-doc"
    )
    string(TOUPPER ${CMAKE_BUILD_TYPE} _build_type)
    set_directory_properties(PROPERTIES COMPILE_FLAGS "${CMAKE_CXX_FLAGS_${_build_type}}")
    set(CMAKE_CXX_FLAGS_${_build_type} "")
endif()

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set (src topology.c pio_file.c pioc_support.c pio_lists.c
  pioc.c pioc_sc.c pio_spmd.c pio_rearrange.c pio_nc4.c pioc_async.c
  pio_nc.c pio_put_nc.c pio_get_nc.c pio_getput_int.c pio_msg.c
  pio_darray.c pio_darray_int.c pio_get_vard.c pio_put_vard.c pio_error.c parallel_sort.c)
if (NETCDF_INTEGRATION)
  set (src ${src} ../ncint/nc_get_vard.c ../ncint/ncintdispatch.c ../ncint/ncint_pio.c ../ncint/nc_put_vard.c)
endif ()
add_library (piocobj OBJECT ${src})
# Always use -fPIC
set_property(TARGET piocobj PROPERTY POSITION_INDEPENDENT_CODE ON)

# Include the clib source directory
target_include_directories (piocobj
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Include the ncint source directory
target_include_directories (piocobj
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/../ncint)

# System and compiler CPP directives
target_compile_definitions (piocobj
  PUBLIC ${CMAKE_SYSTEM_DIRECTIVE})
target_compile_definitions (piocobj
  PUBLIC ${CMAKE_C_COMPILER_DIRECTIVE})


add_library (piocSTATIC STATIC $<TARGET_OBJECTS:piocobj>)
if (BUILD_SHARED_LIBS)
  add_library (piocSHARED SHARED $<TARGET_OBJECTS:piocobj>)
  set_target_properties(piocSHARED PROPERTIES OUTPUT_NAME pioc)
endif()
set_target_properties(piocSTATIC PROPERTIES OUTPUT_NAME pioc)

set_source_files_properties(
    pioc_async.c
    PROPERTIES
    COMPILE_FLAGS -O0
)


# set up include-directories
include_directories(
  "${CMAKE_BINARY_DIR}"
  "${PROJECT_SOURCE_DIR}"   # to find foo/foo.h
  "${PROJECT_BINARY_DIR}")  # to find foo/config.h


# Compiler-specific compiler options
if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
  string(APPEND CMAKE_C_FLAGS  " -std=gnu99 " )
elseif ("${CMAKE_C_COMPILER_ID}" STREQUAL "PGI")
  string(APPEND CMAKE_C_FLAGS  " -c99 ")
elseif ("${CMAKE_C_COMPILER_ID}" STREQUAL "Intel")
  string(APPEND CMAKE_C_FLAGS  " -std=c99 -debug minimal ")
elseif ("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
  string(APPEND CMAKE_C_FLAGS  " -std=c99 ")
endif()

#==============================================================================
#  DEFINE THE INSTALL
#==============================================================================

# Library
install (TARGETS piocSTATIC DESTINATION lib)
if (BUILD_SHARED_LIBS)
  install (TARGETS piocSHARED DESTINATION lib)
endif()
# Include/Header Files
install (FILES pio.h uthash.h DESTINATION include)

#==============================================================================
#  DEFINE THE DEPENDENCIES
#==============================================================================
# MPI test done at top level
if (MPISERIAL_C_FOUND)
    target_compile_definitions (piocobj
      PRIVATE MPI_SERIAL)
    target_include_directories (piocobj
      PUBLIC ${MPISERIAL_C_INCLUDE_DIRS})
    target_link_libraries (piocobj
      PUBLIC ${MPISERIAL_C_LIBRARIES})
    set (WITH_PNETCDF FALSE)
endif ()



#===== GPTL =====
if (PIO_ENABLE_TIMING)
  if (GPTL_C_FOUND)
    message (STATUS "Found GPTL C: ${GPTL_C_LIBRARIES}")
    target_include_directories (piocobj
      PUBLIC ${GPTL_C_INCLUDE_DIRS})
    target_link_libraries (piocobj
      PUBLIC ${GPTL_C_LIBRARIES})
  else ()
    message (STATUS "Using internal GPTL C library for timing")
    target_include_directories (piocobj PUBLIC "${PROJECT_SOURCE_DIR}/../gptl")
    
    target_link_libraries (piocobj
      PUBLIC gptl)
  endif ()
  target_compile_definitions (piocobj
    PUBLIC TIMING)
endif ()

#===== NetCDF-C =====
if (NetCDF_C_FOUND)
  target_include_directories (piocobj
    PUBLIC ${NetCDF_C_INCLUDE_DIRS})
  target_link_libraries (piocobj
    PUBLIC ${NetCDF_C_LIBRARIES})
  if (${NetCDF_C_LOGGING_ENABLED})
    # netcdf.h needs this to be defined to use netCDF logging.
    target_compile_definitions (piocobj
      PUBLIC LOGGING)
  endif()
endif ()

#===== PnetCDF-C =====
if (PnetCDF_C_FOUND)
  target_include_directories (piocobj
    PUBLIC ${PnetCDF_C_INCLUDE_DIRS})
  target_link_libraries (piocobj
    PUBLIC ${PnetCDF_C_LIBRARIES})

  # Check library for varn functions
  set (CMAKE_REQUIRED_LIBRARIES ${PnetCDF_C_LIBRARY})
endif ()

#===== Add EXTRAs =====
target_include_directories (piocobj
  PUBLIC ${PIO_C_EXTRA_INCLUDE_DIRS})
target_link_libraries (piocobj
  PUBLIC ${PIO_C_EXTRA_LIBRARIES})
target_compile_options (piocobj
  PRIVATE ${PIO_C_EXTRA_COMPILE_OPTIONS})
target_compile_definitions (piocobj
  PUBLIC ${PIO_C_EXTRA_COMPILE_DEFINITIONS})
if (PIO_C_EXTRA_LINK_FLAGS)
  set_target_properties(piocobj PROPERTIES
    LINK_FLAGS ${PIO_C_EXTRA_LINK_FLAGS})
endif ()

#===== Check for necessities =====
if (NOT PnetCDF_C_FOUND AND NOT NetCDF_C_FOUND)
  message (FATAL_ERROR "Must have PnetCDF and/or NetCDF C libraries")
endif ()

#===== MPI =====
if (PIO_USE_MPISERIAL)
  if (MPISERIAL_C_FOUND)
    target_compile_definitions (piocobj
      PRIVATE _MPISERIAL)
    target_include_directories (piocobj
      PUBLIC ${MPISERIAL_C_INCLUDE_DIRS})
    target_link_libraries (piocobj
      PUBLIC ${MPISERIAL_C_LIBRARIES})

    set (WITH_PNETCDF FALSE)
    set (MPI_C_INCLUDE_PATH ${MPISERIAL_C_INCLUDE_DIRS})
  endif ()
endif ()

include(CheckTypeSize)
check_type_size("size_t" SIZEOF_SIZE_T)
CHECK_TYPE_SIZE("long long" SIZEOF_LONG_LONG)
if (NOT ${SIZEOF_SIZE_T} EQUAL ${SIZEOF_LONG_LONG})
  message (FATAL_ERROR "size_t and long long must be the same size!")
endif ()

set(CFLAGS "${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_${CMAKE_BUILD_TYPE}}" PARENT_SCOPE)
get_target_property(cppdefs piocobj COMPILE_DEFINITIONS)
get_target_property(includes piocobj INCLUDE_DIRECTORIES)
foreach(x IN LISTS cppdefs)
  string(APPEND CPPFLAGS " -D${x}")
endforeach()
foreach(x IN LISTS includes)
  if (x)
    string(APPEND CPPFLAGS " -I${x}")
  endif()
endforeach()
set(CPPFLAGS ${CPPFLAGS} PARENT_SCOPE)
