
[TOC]

��vsһ�����������exe��dll��lib�ȿ�����һ��ָ��Ŀ¼

# Ŀ¼
Ŀ¼�ṹ���£����հ�exe������productĿ¼��

��  CMakeLists.txt
��  tutorial6.md
��
����build
����include
��      a.h
��
����product
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
���У���Ҫ��nullptr.exe�������ϲ�Ŀ¼��product��
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


# ���post build����
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

## ADD_CUSTOM_COMMAND
�ؼ������������
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
ͨ��cmake������֮����vs��post event������ʾ�����£�
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

**�������**
* ��ʽ
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
* ÿһ��ȫ��д�ľ��Ǹ����������� ����Сд��ĸ������Ҫ�����Լ���Ŀ��д�Ķ�Ӧ��������
* TARGET����д���ǵ�ǰ������
* PRE_BUILD | PRE_LINK | POST_BUILD ���¼����ͣ�vs����POST_BUILD�õĶ࣬�������exe��dll��lib�ļ�������ָ��Ŀ¼
* COMMAND �����������
������������ǿ���exe·��
```
COMMAND ${CMAKE_COMMAND} -E 
            copy_if_different  
            "$<$<CONFIG:Release>:${PROJECT_BINARY_DIR}/Debug/${PROJECT_NAME}.exe>"
            "$<$<CONFIG:Debug>:${PROJECT_BINARY_DIR}/Debug/${PROJECT_NAME}.exe>"
            "${CMAKE_BINARY_DIR}/$<$<CONFIG:Release>:Release>$<$<CONFIG:Debug>:Debug>/"
```
(1)��Ϊ��cmake�������ǰ���и�${CMAKE_COMMAND}��������֮�����cmake.exe��·��
(2)�����õ�����������д����û��ȥ�����ſ��ö����С�Debug��Release�������ж�

# ������

## error MSB3073: ���setlocal
setlocal�������û������ģ�����һЩ˵��Ҫ����Ա����vs�ģ������ˡ�Ŀǰ�������������copy�Ǳ�������������϶���·����̫��

# �ο�
[1][Cmake֮CMakeLists.txt](https://blog.csdn.net/u013896064/article/details/82874152)
[2][Cmake֪ʶ----��дCMakeLists.txt�ļ�����C/C++����](https://www.cnblogs.com/cv-pr/p/6206921.html)
[3][Cmake֮CMakeLists.txt](https://blog.csdn.net/u013896064/article/details/82874152)
[4][CMakeLists.txt �﷨������ʵ������](https://blog.csdn.net/afei__/article/details/81201039)
[5][cmake��prebuild/postbuild����](https://blog.csdn.net/z0n1l2/article/details/86267985)
[6][��CMake��cmake��add_custom_command��add_custom_targetָ��](https://blog.csdn.net/qq_38410730/article/details/102797448)