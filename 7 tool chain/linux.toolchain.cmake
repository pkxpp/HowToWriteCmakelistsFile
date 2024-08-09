MESSAGE("------------------------------------------1" ${ANDROID_NDK})
if( NOT ANDROID_NDK )
  MESSAGE("111")
else()
  MESSAGE("222")
endif()
# the name of the target operating system
set(CMAKE_SYSTEM_NAME Linux)

set(CMAKE_TRY_COMPILE_PLATFORM_VARIABLES ANDROID_NDK)
# which C and C++ compiler to use
set(CMAKE_C_COMPILER /home/alex/eldk-mips/usr/bin/mips_4KC-gcc)
set(CMAKE_CXX_COMPILER
    /home/alex/eldk-mips/usr/bin/mips_4KC-g++)

# location of the target environment
set(CMAKE_FIND_ROOT_PATH /home/alex/eldk-mips/mips_4KC
                          /home/alex/eldk-mips-extra-install )

# adjust the default behavior of the FIND_XXX() commands:
# search for headers and libraries in the target environment,
# search for programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
MESSAGE("------------------------------------------2")