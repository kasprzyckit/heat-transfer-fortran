cmake_minimum_required(VERSION 3.5)
project (HeatTransfer)
enable_language (Fortran)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
endif()


if(CMAKE_Fortran_COMPILER_ID MATCHES "GNU")
    set(dialect "-ffree-form -std=f2008 -fimplicit-none -cpp -Wall -pedantic")
    set(bounds "-fbounds-check")
    set(realeaseopts "-O3  -pthread -funroll-all-loops")
    set(debugopts "-O0 -g3 -fbacktrace -fcheck=all -fdump-fortran-optimized")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "Intel")
    set(dialect "-std08  -module . -implicitnone -fpp -Wall -pedantic")
    set(bounds " -check bounds")
    set(realeaseopts "-funroll-all-loops -O3")
    set(debugopts "-O0 -g -traceback -check all -debug extended -debug-parameters all")
endif()

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${dialect}")
set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} ${bounds} ${debugopts}")
set(CMAKE_Fortran_RELEASE_FLAGS "${CMAKE_Fortran_RELEASE_FLAGS} ${realeaseopts}")

set(SRC "${PROJECT_SOURCE_DIR}/src")
set(fdm_SRC
  ${SRC}/gauss.F90
  ${SRC}/fdm.F90
  )
set(fdm_MAIN heat_transfer_error.F90)

# --------------------------------------------------------------------
# Executables
# --------------------------------------------------------------------

function(define_precision kind)
  add_executable("${PROJECT_NAME}_${kind}" ${fdm_MAIN} ${fdm_SRC})
  set_target_properties("${PROJECT_NAME}_${kind}" PROPERTIES COMPILE_FLAGS "-D\"_KIND=${kind}\"")
endfunction()

define_precision(4)
define_precision(8)
define_precision(16)

# --------------------------------------------------------------------
# Tests
# --------------------------------------------------------------------

enable_testing()

set(CTEST_OUTPUT_ON_FAILURE)
add_test(NAME gauss_test
  WORKING_DIRECTORY ${SRC}
  COMMAND funit gauss)