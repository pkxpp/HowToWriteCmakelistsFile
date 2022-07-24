
[TOC]

像vs一样，编译完把exe、dll、lib等拷贝到一个指定目录

# 目录
目录结构如下，最终把exe拷贝到product目录中

│  CMakeLists.txt
│  tutorial6.md
│
├─build
├─include
│      a.h
│
├─product
└─src
    │  a.cpp
    │
    ├─2.01.nullptr
    │      2.01.nullptr.cpp
    │      CMakeLists.txt
    │
    └─2.02.constexpr
            2.02.constexpr.cpp
            CMakeLists.txt

# 代码


## 最外面的CMakeLists.txt
类似于解决方案
```
#1.cmake verson，指定cmake版本
cmake_minimum_required(VERSION 3.2)

#2.project name，指定项目的名称，一般和项目的文件夹名称对应
PROJECT(chapter5)

#3.head file path，头文件目录
INCLUDE_DIRECTORIES(
include
)

#4.source directory，源文件目录
# AUX_SOURCE_DIRECTORY(src DIR_SRCS)

# 定义子目录src，用以递归的调用src中的MakeLists.txt
add_subdirectory(src/2.01.nullptr)
add_subdirectory(src/2.02.constexpr)
```

## 2.01.nullptr/CMakeLists.txt
其中，需要把nullptr.exe拷贝到上层目录的product中
```
#1.cmake verson，指定cmake版本
cmake_minimum_required(VERSION 3.2)

#2.project name，指定项目的名称，一般和项目的文件夹名称对应
PROJECT(nullptr)

#3.head file path，头文件目录
INCLUDE_DIRECTORIES(
../include
)

#4.source directory，源文件目录
AUX_SOURCE_DIRECTORY(../src DIR_SRCS)

#5.set environment variable，设置环境变量，编译用到的源文件全部都要放到这里，否则编译能够通过，但是执行的时候会出现各种问题，比如"symbol lookup error xxxxx , undefined symbol"
SET(PRO_Nullptr
${DIR_SRCS}
2.01.nullptr.cpp
)

#6.add executable file，添加要编译的可执行文件
ADD_EXECUTABLE(nullptr ${PRO_Nullptr})

#7.add link library，添加可执行文件所需要的库，比如我们用到了libm.so（命名规则：lib+name+.so），就添加该库的名称
#TARGET_LINK_LIBRARIES(${PROJECT_NAME} m)


# 添加post build命令
ADD_CUSTOM_COMMAND(
        TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E 
            copy_if_different  
            "$<$<CONFIG:Release>:${PROJECT_BINARY_DIR}/Debug/${PROJECT_NAME}.exe>"
            "$<$<CONFIG:Debug>:${PROJECT_BINARY_DIR}/Debug/${PROJECT_NAME}.exe>"
            "${CMAKE_BINARY_DIR}/$<$<CONFIG:Release>:Release>$<$<CONFIG:Debug>:Debug>/"
    )
```

## 2.02.constexpr/CMakeLists.txt

```
#1.cmake verson，指定cmake版本
cmake_minimum_required(VERSION 3.2)

#2.project name，指定项目的名称，一般和项目的文件夹名称对应
PROJECT(2.02.constexpr)

#3.head file path，头文件目录
INCLUDE_DIRECTORIES(
../include
)

#4.source directory，源文件目录
AUX_SOURCE_DIRECTORY(../src DIR_SRCS)

#5.set environment variable，设置环境变量，编译用到的源文件全部都要放到这里，否则编译能够通过，但是执行的时候会出现各种问题，比如"symbol lookup error xxxxx , undefined symbol"
SET(PRO_Constexpr
${DIR_SRCS}
2.02.constexpr.cpp
)

#6.add executable file，添加要编译的可执行文件
ADD_EXECUTABLE(constexpr ${PRO_Constexpr})

#7.add link library，添加可执行文件所需要的库，比如我们用到了libm.so（命名规则：lib+name+.so），就添加该库的名称
#TARGET_LINK_LIBRARIES(${PROJECT_NAME} m)
```

## ADD_CUSTOM_COMMAND
关键是这个命令了
```
ADD_CUSTOM_COMMAND(
        TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E 
            copy_if_different  
            "$<$<CONFIG:Release>:${PROJECT_BINARY_DIR}/Debug/${PROJECT_NAME}.exe>"
            "$<$<CONFIG:Debug>:${PROJECT_BINARY_DIR}/Debug/${PROJECT_NAME}.exe>"
            "${CMAKE_BINARY_DIR}/$<$<CONFIG:Release>:Release>$<$<CONFIG:Debug>:Debug>/"
    )
```
通过cmake翻译完之后，在vs的post event里面显示的如下：
```
setlocal
"D:\Program Files\CMake\bin\cmake.exe" -E copy_if_different  "F:/study/compile/cmake/how to write cmakelists/6 post build/build/src/2.01.nullptr/Debug/nullptr.exe" "F:/study/compile/cmake/how to write cmakelists/6 post build/build/Debug/"
if %errorlevel% neq 0 goto :cmEnd
:cmEnd
endlocal & call :cmErrorLevel %errorlevel% & goto :cmDone
:cmErrorLevel
exit /b %1
:cmDone
if %errorlevel% neq 0 goto :VCEnd
```

**命令详解**
* 格式
```
add_custom_command(TARGET <target>
                   PRE_BUILD | PRE_LINK | POST_BUILD
                   COMMAND command1 [ARGS] [args1...]
                   [COMMAND command2 [ARGS] [args2...] ...]
                   [BYPRODUCTS [files...]]
                   [WORKING_DIRECTORY dir]
                   [COMMENT comment]
                   [VERBATIM] [USES_TERMINAL])


```
* 每一行全大写的就是各个参数名， 后面小写字母的是需要根据自己项目填写的对应参数内容
* TARGET：填写的是当前工程名
* PRE_BUILD | PRE_LINK | POST_BUILD ：事件类型，vs里面POST_BUILD用的多，编译完把exe、dll、lib文件拷贝到指定目录
* COMMAND ：具体的命令
我这里的命令是拷贝exe路径
```
COMMAND ${CMAKE_COMMAND} -E 
            copy_if_different  
            "$<$<CONFIG:Release>:${PROJECT_BINARY_DIR}/Debug/${PROJECT_NAME}.exe>"
            "$<$<CONFIG:Debug>:${PROJECT_BINARY_DIR}/Debug/${PROJECT_NAME}.exe>"
            "${CMAKE_BINARY_DIR}/$<$<CONFIG:Release>:Release>$<$<CONFIG:Debug>:Debug>/"
```
(1)因为是cmake命令，所以前面有个${CMAKE_COMMAND}，翻译完之后就是cmake.exe的路径
(2)这里用到了条件语句的写法，没有去深究，大概看得懂就行。Debug和Release的条件判断

# 问题解决

## error MSB3073: 命令“setlocal
setlocal命令本身是没有问题的，网上一些说需要管理员启动vs的，就算了。目前遇到的问题就是copy那边命令出错，基本上都是路径不太对

# 参考
[1][Cmake之CMakeLists.txt](https://blog.csdn.net/u013896064/article/details/82874152)
[2][Cmake知识----编写CMakeLists.txt文件编译C/C++程序](https://www.cnblogs.com/cv-pr/p/6206921.html)
[3][Cmake之CMakeLists.txt](https://blog.csdn.net/u013896064/article/details/82874152)
[4][CMakeLists.txt 语法介绍与实例演练](https://blog.csdn.net/afei__/article/details/81201039)
[5][cmake中prebuild/postbuild命令](https://blog.csdn.net/z0n1l2/article/details/86267985)
[6][【CMake】cmake的add_custom_command和add_custom_target指令](https://blog.csdn.net/qq_38410730/article/details/102797448)