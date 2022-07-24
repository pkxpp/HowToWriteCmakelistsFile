
@[toc]
多个CMakeLists文件嵌套

# 目录
目录结构

```
│  CMakeLists.txt
│  main.cpp
│  tutorial4.md
│
├─hello
│      CMakeLists.txt
│      hello.cpp
│      hello.h
│
└─world
        CMakeLists.txt
        world.cpp
        world.h
```

# 代码

## 最外层CMakeLists.txt
```
#1.cmake verson，指定cmake版本
cmake_minimum_required(VERSION 3.2)

#2.project name，指定项目的名称，一般和项目的文件夹名称对应
PROJECT(chapter4)

#3.head file path，头文件目录
INCLUDE_DIRECTORIES(
./
./hello
./world
)

#4.source directory，源文件目录
AUX_SOURCE_DIRECTORY(. DIR_SRCS)

#5.set environment variable，设置环境变量，编译用到的源文件全部都要放到这里，否则编译能够通过，但是执行的时候会出现各种问题，比如"symbol lookup error xxxxx , undefined symbol"
SET(PRO_Nullptr
${DIR_SRCS}
2.01.nullptr.cpp
)

SET(PRO_Constexpr
${DIR_SRCS}
2.02.constexpr.cpp
)

#6.Add block directories
ADD_SUBDIRECTORY(hello)
ADD_SUBDIRECTORY(world)

#7.add executable file，添加要编译的可执行文件
ADD_EXECUTABLE(helloworld ${DIR_SRCS})

#8.add link library，添加可执行文件所需要的库，比如我们用到了libm.so（命名规则：lib+name+.so），就添加该库的名称
TARGET_LINK_LIBRARIES(helloworld hello world)
```
## hello/CMakeLists.txt
```
aux_source_directory(. DIR_HELLO_SRCS)
add_library(hello ${DIR_HELLO_SRCS})
```

## world/CMakeLists.txt

```
aux_source_directory(. DIR_WORLD_SRCS)
add_library(world ${DIR_WORLD_SRCS})
```

# 参考
[1][多目录工程的CmakeLists.txt编写（自动添加多目录下的文件）](https://www.linuxidc.com/Linux/2019-01/156197.htm)
