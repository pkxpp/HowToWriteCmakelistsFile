
@[toc]
���CMakeLists�ļ�Ƕ��

# Ŀ¼
Ŀ¼�ṹ

```
��  CMakeLists.txt
��  main.cpp
��  tutorial4.md
��
����hello
��      CMakeLists.txt
��      hello.cpp
��      hello.h
��
����world
        CMakeLists.txt
        world.cpp
        world.h
```

# ����

## �����CMakeLists.txt
```
#1.cmake verson��ָ��cmake�汾
cmake_minimum_required(VERSION 3.2)

#2.project name��ָ����Ŀ�����ƣ�һ�����Ŀ���ļ������ƶ�Ӧ
PROJECT(chapter4)

#3.head file path��ͷ�ļ�Ŀ¼
INCLUDE_DIRECTORIES(
./
./hello
./world
)

#4.source directory��Դ�ļ�Ŀ¼
AUX_SOURCE_DIRECTORY(. DIR_SRCS)

#5.set environment variable�����û��������������õ���Դ�ļ�ȫ����Ҫ�ŵ������������ܹ�ͨ��������ִ�е�ʱ�����ָ������⣬����"symbol lookup error xxxxx , undefined symbol"
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

#7.add executable file�����Ҫ����Ŀ�ִ���ļ�
ADD_EXECUTABLE(helloworld ${DIR_SRCS})

#8.add link library����ӿ�ִ���ļ�����Ҫ�Ŀ⣬���������õ���libm.so����������lib+name+.so��������Ӹÿ������
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

# �ο�
[1][��Ŀ¼���̵�CmakeLists.txt��д���Զ���Ӷ�Ŀ¼�µ��ļ���](https://www.linuxidc.com/Linux/2019-01/156197.htm)
