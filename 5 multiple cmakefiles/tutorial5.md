
[TOC]

���CMakeLists�ļ�������vsһ�����и����������Ȼ�������кܶ๤��

# Ŀ¼
Ŀ¼�ṹ

��  CMakeLists.txt
��  tutorial5.md
��
����include
��      a.h
��
����src
    ��  a.cpp
    ��
    ����2.01.nullptr
    ��      2.01.nullptr.cpp
    ��      CMakeLists.txt
    ��
    ����2.02.constexpr
            2.02.constexpr.cpp
            CMakeLists.txt

# ����


## �������CMakeLists.txt
�����ڽ������
```
#1.cmake verson��ָ��cmake�汾
cmake_minimum_required(VERSION 3.2)

#2.project name��ָ����Ŀ�����ƣ�һ�����Ŀ���ļ������ƶ�Ӧ
PROJECT(chapter5)

#3.head file path��ͷ�ļ�Ŀ¼
INCLUDE_DIRECTORIES(
include
)

#4.source directory��Դ�ļ�Ŀ¼
# AUX_SOURCE_DIRECTORY(src DIR_SRCS)

# ������Ŀ¼src�����Եݹ�ĵ���src�е�MakeLists.txt
add_subdirectory(src/2.01.nullptr)
add_subdirectory(src/2.02.constexpr)
```

## 2.01.nullptr/CMakeLists.txt

```
#1.cmake verson��ָ��cmake�汾
cmake_minimum_required(VERSION 3.2)

#2.project name��ָ����Ŀ�����ƣ�һ�����Ŀ���ļ������ƶ�Ӧ
PROJECT(nullptr)

#3.head file path��ͷ�ļ�Ŀ¼
INCLUDE_DIRECTORIES(
../include
)

#4.source directory��Դ�ļ�Ŀ¼
AUX_SOURCE_DIRECTORY(../src DIR_SRCS)

#5.set environment variable�����û��������������õ���Դ�ļ�ȫ����Ҫ�ŵ������������ܹ�ͨ��������ִ�е�ʱ�����ָ������⣬����"symbol lookup error xxxxx , undefined symbol"
SET(PRO_Nullptr
${DIR_SRCS}
2.01.nullptr.cpp
)

#6.add executable file�����Ҫ����Ŀ�ִ���ļ�
ADD_EXECUTABLE(nullptr ${PRO_Nullptr})

#7.add link library����ӿ�ִ���ļ�����Ҫ�Ŀ⣬���������õ���libm.so����������lib+name+.so��������Ӹÿ������
#TARGET_LINK_LIBRARIES(${PROJECT_NAME} m)
```

## 2.02.constexpr/CMakeLists.txt

```
#1.cmake verson��ָ��cmake�汾
cmake_minimum_required(VERSION 3.2)

#2.project name��ָ����Ŀ�����ƣ�һ�����Ŀ���ļ������ƶ�Ӧ
PROJECT(2.02.constexpr)

#3.head file path��ͷ�ļ�Ŀ¼
INCLUDE_DIRECTORIES(
../include
)

#4.source directory��Դ�ļ�Ŀ¼
AUX_SOURCE_DIRECTORY(../src DIR_SRCS)

#5.set environment variable�����û��������������õ���Դ�ļ�ȫ����Ҫ�ŵ������������ܹ�ͨ��������ִ�е�ʱ�����ָ������⣬����"symbol lookup error xxxxx , undefined symbol"
SET(PRO_Constexpr
${DIR_SRCS}
2.02.constexpr.cpp
)

#6.add executable file�����Ҫ����Ŀ�ִ���ļ�
ADD_EXECUTABLE(constexpr ${PRO_Constexpr})

#7.add link library����ӿ�ִ���ļ�����Ҫ�Ŀ⣬���������õ���libm.so����������lib+name+.so��������Ӹÿ������
#TARGET_LINK_LIBRARIES(${PROJECT_NAME} m)
```

# �ο�
[1][Cmake֮CMakeLists.txt](https://blog.csdn.net/u013896064/article/details/82874152)
[2][Cmake֪ʶ----��дCMakeLists.txt�ļ�����C/C++����](https://www.cnblogs.com/cv-pr/p/6206921.html)
[3][Cmake֮CMakeLists.txt](https://blog.csdn.net/u013896064/article/details/82874152)
[4][CMakeLists.txt �﷨������ʵ������](https://blog.csdn.net/afei__/article/details/81201039)
