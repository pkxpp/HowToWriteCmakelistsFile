
[TOC]

增加编译标志，比如/std:c++17

# 代码

给每个工程设置一个环境变量，包含这个工程需要得cpp文件
```
#1.cmake verson，指定cmake版本
cmake_minimum_required(VERSION 3.2)

#2.project name，指定项目的名称，一般和项目的文件夹名称对应
PROJECT(chapter2)

#3.head file path，头文件目录
INCLUDE_DIRECTORIES(
include
)

#4.source directory，源文件目录
AUX_SOURCE_DIRECTORY(src DIR_SRCS)

#5.set environment variable，设置环境变量，编译用到的源文件全部都要放到这里，否则编译能够通过，但是执行的时候会出现各种问题，比如"symbol lookup error xxxxx , undefined symbol"
SET(PRO_Nullptr
${DIR_SRCS}
2.01.nullptr.cpp
)

SET(PRO_Constexpr
${DIR_SRCS}
2.02.constexpr.cpp
)

#6.add executable file，添加要编译的可执行文件
ADD_EXECUTABLE(nullptr ${PRO_Nullptr})
ADD_EXECUTABLE(constexpr ${PRO_Constexpr})

#7.add link library，添加可执行文件所需要的库，比如我们用到了libm.so（命名规则：lib+name+.so），就添加该库的名称
#TARGET_LINK_LIBRARIES(${PROJECT_NAME} m)
```

# 参考
[1][Cmake之CMakeLists.txt](https://blog.csdn.net/u013896064/article/details/82874152)
