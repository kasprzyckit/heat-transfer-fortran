cmake_minimum_required(VERSION 3.5)
project (HeatTransfer)
enable_language (Fortran)

# FFLAGS depend on the compiler
get_filename_component (Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME)

if(CMAKE_Fortran_COMPILER_ID MATCHES "GNU")
    set(dialect "-ffree-form -std=f2008 -fimplicit-none -fpp -Wall -pedantic -cpp")
    set(realeaseopts "-O3  -pthread -funroll-all-loops")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "Intel")
    set(dialect "-std08  -module . -implicitnone -fpp -Wall -pedantic -cpp")
    set(realeaseopts "-funroll-all-loops -O3")
endif()

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${dialect}")
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_RELEASE_FLAGS} ${realeaseopts}")

include_directories("${PROJECT_SOURCE_DIR}/src")

set(SRC src)
set(fdm_SRC
  ${SRC}/gauss.F90
  )
set(fdm_MAIN heat_transfer.F90)

# --------------------------------------------------------------------
# Libraries & executables
# --------------------------------------------------------------------


function(define_precision kind)
  add_executable("${PROJECT_NAME}_${kind}" ${fdm_MAIN} ${fdm_SRC})
  set_target_properties("${PROJECT_NAME}_${kind}" PROPERTIES COMPILE_FLAGS "-D\"_KIND=${kind}\"")
endfunction()

define_precision(4)
define_precision(8)
define_precision(16)