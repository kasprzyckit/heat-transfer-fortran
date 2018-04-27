cmake_minimum_required(VERSION 3.5)
project (HeatTransfer)
enable_language (Fortran)


# Default to Release build
if(NOT CMAKE_BUILD_TYPE)
  message(STATUS "No build type selected, default to Release")
  set(CMAKE_BUILD_TYPE "Release")
#  set(CMAKE_BUILD_TYPE "Debug")
endif()

# FFLAGS depend on the compiler
get_filename_component (Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME)

if(CMAKE_Fortran_COMPILER_ID MATCHES "GNU")
    set(dialect "-ffree-form -std=f2008 -fimplicit-none -fpp -Wall -pedantic -cpp")
    set(bounds "-fbounds-check")
    set(realeaseopts "-O3  -pthread -funroll-all-loops")
    set(debugopts "-O0 -g3 -fbacktrace -fcheck=all -fdump-fortran-optimized")
#    -DIINFO -DIDEBUG -DIPRINT")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "Intel")
    set(dialect "-std08  -module . -implicitnone -fpp -Wall -pedantic")
    set(bounds " -check bounds")
    set(realeaseopts "-funroll-all-loops -O3")
    set(debugopts "-O0 -g -traceback -check all -debug extended -debug-parameters all")
#    -DIINFO -DIDEBUG -DIPRINT")
endif()

set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} ${bounds}")
set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} ${debugopts}")
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${dialect}")
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_RELEASE_FLAGS} ${realeaseopts}")

include_directories("${PROJECT_SOURCE_DIR}/src")

set(SRC src)
set(ads_SRC
  ${SRC}/gauss.F90
  )

# --------------------------------------------------------------------
# Libraries
# --------------------------------------------------------------------

# Target library definition
add_library(ads STATIC ${ads_SRC})
target_link_libraries(ads ${ads_LIBS})


# --------------------------------------------------------------------
# Problems
# --------------------------------------------------------------------
option(SKIP_PROBLEMS "skip compiling example problems" OFF)

function(define_problem name)
  add_executable(${name} ${ARGN})
  target_link_libraries(${name} ads)
endfunction()

if (NOT SKIP_PROBLEMS)

  define_problem(heat_transfer
    problems/heat_transfer.F90)
    
endif()