
[TOC]

һ�����������������̣������exe/dll/lib��

# ����

��Ӽ���*ADD_EXECUTABLE*����
```
#1.cmake verson��ָ��cmake�汾
cmake_minimum_required(VERSION 3.2)

#2.project name��ָ����Ŀ�����ƣ�һ�����Ŀ���ļ������ƶ�Ӧ
PROJECT(chapter2)

#3.head file path��ͷ�ļ�Ŀ¼
INCLUDE_DIRECTORIES(
include
)

#4.source directory��Դ�ļ�Ŀ¼
AUX_SOURCE_DIRECTORY(src DIR_SRCS)

#5.set environment variable�����û��������������õ���Դ�ļ�ȫ����Ҫ�ŵ������������ܹ�ͨ��������ִ�е�ʱ�����ָ������⣬����"symbol lookup error xxxxx , undefined symbol"
SET(TEST_MATH
${DIR_SRCS}
2.01.nullptr.cpp
)

#6.add executable file�����Ҫ����Ŀ�ִ���ļ�
ADD_EXECUTABLE(nullptr 2.01.nullptr.cpp)
ADD_EXECUTABLE(constexpr 2.02.constexpr.cpp)

#7.add link library����ӿ�ִ���ļ�����Ҫ�Ŀ⣬���������õ���libm.so����������lib+name+.so��������Ӹÿ������
#TARGET_LINK_LIBRARIES(${PROJECT_NAME} m)
```

# �ο�
[1][Cmake֮CMakeLists.txt](https://blog.csdn.net/u013896064/article/details/82874152)
[2][Cmake֪ʶ----��дCMakeLists.txt�ļ�����C/C++����](https://www.cnblogs.com/cv-pr/p/6206921.html)
