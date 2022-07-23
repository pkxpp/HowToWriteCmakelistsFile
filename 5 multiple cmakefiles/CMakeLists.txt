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