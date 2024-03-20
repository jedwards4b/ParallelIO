include (LibMPI)
include (add_pio_executable)
include_directories("${CMAKE_SOURCE_DIR}/tests/cunit")
include_directories("${CMAKE_SOURCE_DIR}/src/clib")
include_directories("${CMAKE_BINARY_DIR}")
include_directories("${NetCDF_C_INCLUDE_DIR}")
if (WITH_PNETCDF)
  include_directories("${PnetCDF_C_INCLUDE_DIR}")
endif()

# Compiler-specific compiler options
if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c99")
elseif ("${CMAKE_C_COMPILER_ID}" STREQUAL "PGI")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -c99")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -c99")
elseif ("${CMAKE_C_COMPILER_ID}" STREQUAL "Intel")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c99")
elseif ("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c99")
endif()
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O0")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0")

#==============================================================================
#  PREPARE FOR TESTING
#==============================================================================

# Don't run these tests if we are using MPI SERIAL.
if (NOT PIO_USE_MPISERIAL)
  add_pio_executable (test_async_mpi  "test_async_mpi.c")
  add_dependencies (tests test_async_mpi)
  
  add_pio_executable (test_intercomm2 "test_intercomm2.c;test_common.c")
  add_dependencies (tests test_intercomm2)
  add_pio_executable (test_async_simple  "test_async_simple.c;test_common.c")
  add_dependencies (tests test_async_simple)
  add_pio_executable (test_async_3proc  "test_async_3proc.c;test_common.c")
  add_dependencies (tests test_async_3proc)
  add_pio_executable (test_async_4proc  "test_async_4proc.c;test_common.c")
  add_dependencies (tests test_async_4proc)
  add_pio_executable (test_iosystem2_simple  "test_iosystem2_simple.c;test_common.c")
  add_dependencies (tests test_iosystem2_simple)
  add_pio_executable (test_iosystem2_simple2  "test_iosystem2_simple2.c;test_common.c")
  add_dependencies (tests test_iosystem2_simple2)
  add_pio_executable (test_iosystem2  "test_iosystem2.c;test_common.c")
  add_dependencies (tests test_iosystem2)
  add_pio_executable (test_iosystem3_simple  "test_iosystem3_simple.c;test_common.c")
  add_dependencies (tests test_iosystem3_simple)
  add_pio_executable (test_iosystem3_simple2  "test_iosystem3_simple2.c;test_common.c")
  add_dependencies (tests test_iosystem3_simple2)
  add_pio_executable (test_iosystem3  "test_iosystem3.c;test_common.c")
  add_dependencies (tests test_iosystem3)
  add_pio_executable (test_pioc  "test_pioc.c;test_common.c;test_shared.c")
  add_pio_executable (test_pioc_unlim  "test_pioc_unlim.c;test_common.c;test_shared.c")
  add_pio_executable (test_pioc_putget  "test_pioc_putget.c;test_common.c;test_shared.c")
  add_pio_executable (test_pioc_fill  "test_pioc_fill.c;test_common.c;test_shared.c")
  add_pio_executable (test_darray  "test_darray.c;test_common.c")
  add_pio_executable (test_darray_lossycompress  "test_darray_lossycompress.c;test_common.c")
  add_pio_executable (test_darray_append  "test_darray_append.c;test_common.c")
  add_pio_executable (test_darray_frame  "test_darray_frame.c;test_common.c")
  add_pio_executable (test_darray_multi  "test_darray_multi.c;test_common.c")
  add_pio_executable (test_darray_multivar  "test_darray_multivar.c;test_common.c")
  add_pio_executable (test_darray_multivar2  "test_darray_multivar2.c;test_common.c")
  add_pio_executable (test_darray_multivar3  "test_darray_multivar3.c;test_common.c")
  add_pio_executable (test_darray_1d  "test_darray_1d.c;test_common.c")
  add_pio_executable (test_darray_3d  "test_darray_3d.c;test_common.c")
  add_pio_executable (test_decomp_uneven  "test_decomp_uneven.c;test_common.c")
  add_pio_executable (test_decomps  "test_decomps.c;test_common.c")
  add_pio_executable (test_rearr  "test_rearr.c;test_common.c")
  add_pio_executable (test_darray_fill  "test_darray_fill.c;test_common.c")
  add_pio_executable (test_decomp_frame  "test_decomp_frame.c;test_common.c")
  add_pio_executable (test_perf2  "test_perf2.c;test_common.c")
    add_pio_executable (test_darray_async_simple  "test_darray_async_simple.c;test_common.c")
    add_pio_executable (test_darray_async  "test_darray_async.c;test_common.c")
    add_pio_executable (test_darray_async_many  "test_darray_async_many.c;test_common.c")
    add_pio_executable (test_darray_2sync  "test_darray_2sync.c;test_common.c")
    add_pio_executable (test_async_multicomp  "test_async_multicomp.c;test_common.c")
    add_pio_executable (test_async_multi2  "test_async_multi2.c;test_common.c")
    add_pio_executable (test_async_manyproc  "test_async_manyproc.c;test_common.c")
    add_pio_executable (test_async_1d  test_async_1d.c)
    add_pio_executable (test_simple  "test_simple.c;test_common.c")
    add_pio_executable (test_async_perf  "test_async_perf.c;test_common.c")
endif ()
add_pio_executable (test_spmd  "test_spmd.c;test_common.c")
add_dependencies (tests test_spmd)
add_dependencies (tests test_rearr)
add_dependencies (tests test_pioc)
add_dependencies (tests test_pioc_unlim)
add_dependencies (tests test_pioc_putget)
add_dependencies (tests test_pioc_fill)
add_dependencies (tests test_darray)
add_dependencies (tests test_darray_lossycompress)
add_dependencies (tests test_darray_append)
add_dependencies (tests test_darray_frame)
add_dependencies (tests test_darray_multi)
add_dependencies (tests test_darray_multivar)
add_dependencies (tests test_darray_multivar2)
add_dependencies (tests test_darray_multivar3)
add_dependencies (tests test_darray_1d)
add_dependencies (tests test_darray_3d)
add_dependencies (tests test_decomp_uneven)
add_dependencies (tests test_decomps)
add_dependencies (tests test_darray_fill)
add_dependencies (tests test_decomp_frame)
#  add_dependencies (tests test_perf2)
add_dependencies (tests test_darray_async_simple)
add_dependencies (tests test_darray_async)
add_dependencies (tests test_darray_async_many)
add_dependencies (tests test_darray_2sync)
add_dependencies (tests test_async_multicomp)
add_dependencies (tests test_async_multi2)
add_dependencies (tests test_async_manyproc)
add_dependencies (tests test_async_1d)
add_dependencies (tests test_simple)
add_dependencies (tests test_async_perf)

# Test Timeout in seconds.
if (PIO_VALGRIND_CHECK)
  set (DEFAULT_TEST_TIMEOUT 800)
else ()
  set (DEFAULT_TEST_TIMEOUT 600)
endif ()

# All tests need a certain number of tasks, but they should be able to
# run successfully with more than they need. Test this by providing an
# extra processor for each C test.
set (AT_LEAST_TWO_TASKS 3)
set (AT_LEAST_THREE_TASKS 4)
set (AT_LEAST_FOUR_TASKS 5)
set (AT_LEAST_EIGHT_TASKS 9)
set (EXACTLY_FOUR_TASKS 4)

if (PIO_USE_MPISERIAL)
  add_test(NAME test_pioc
    COMMAND test_pioc)
else ()
  add_mpi_test(test_async_mpi
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_async_mpi
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_spmd
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_spmd
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_rearr
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_rearr
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_intercomm2
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_intercomm2
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_async_simple
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_async_simple
    NUMPROCS ${AT_LEAST_TWO_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_async_3proc
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_async_3proc
    NUMPROCS ${AT_LEAST_THREE_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_async_4proc
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_async_4proc
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_iosystem2_simple
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_iosystem2_simple
    NUMPROCS ${AT_LEAST_TWO_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_iosystem2_simple2
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_iosystem2_simple2
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_iosystem2
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_iosystem2
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_iosystem3_simple
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_iosystem3_simple
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_iosystem3_simple2
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_iosystem3_simple2
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_iosystem3
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_iosystem3
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_pioc
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_pioc
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_pioc_unlim
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_pioc_unlim
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_pioc_putget
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_pioc_putget
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  # timeout in github testing - skip this test
  set_tests_properties(test_pioc_putget PROPERTIES LABELS "skipforspack")

  add_mpi_test(test_pioc_fill
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_pioc_fill
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_lossycompress
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_lossycompress
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_append
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_append
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_frame
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_frame
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_multi
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_multi
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_multivar
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_multivar
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  # timeout in github testing - skip this test
  set_tests_properties(test_darray_multivar PROPERTIES LABELS "skipforspack")

  add_mpi_test(test_darray_multivar2
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_multivar2
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  # add_mpi_test(test_darray_multivar3
  #   EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_multivar3
  #   NUMPROCS ${AT_LEAST_FOUR_TASKS}
  #   TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_1d
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_1d
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_3d
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_3d
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_fill
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_fill
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_2sync
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_2sync
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_async_simple
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_async_simple
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
    # add_mpi_test(test_perf2
    #   EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_perf2
    #   NUMPROCS ${AT_LEAST_FOUR_TASKS}
    #   TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_async
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_async
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_darray_async_many
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_darray_async_many
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_async_multicomp
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_async_multicomp
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_async_multi2
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_async_multi2
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_async_manyproc
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_async_manyproc
    NUMPROCS ${AT_LEAST_EIGHT_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_decomp_uneven
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_decomp_uneven
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_decomps
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_decomps
    NUMPROCS ${AT_LEAST_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  add_mpi_test(test_simple
    EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_simple
    NUMPROCS ${EXACTLY_FOUR_TASKS}
    TIMEOUT ${DEFAULT_TEST_TIMEOUT})
  # add_mpi_test(test_async_perf
  #   EXECUTABLE ${CMAKE_CURRENT_BINARY_DIR}/test_async_perf
  #   NUMPROCS ${EXACTLY_FOUR_TASKS}
  #   TIMEOUT ${DEFAULT_TEST_TIMEOUT})
endif ()
MESSAGE("CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS}")
