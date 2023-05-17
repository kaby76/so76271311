# Generated from trgen 0.20.22

cmake_minimum_required (VERSION 3.14)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

set(CMAKE_CXX_STANDARD 17)
set(ANTLR_EXECUTABLE "C:/Users/Kenne/.m2/antlr4-4.12.0-complete.jar")
set(Java_JAVA_EXECUTABLE "java")
set(ANTLR4_TAG 4.12.0)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
#SET(GCC_COVERAGE_COMPILE_FLAGS "-g -pg")
#SET(GCC_COVERAGE_LINK_FLAGS    "-g -pg")
SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /MT")
#SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}")
#SET(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}")

add_definitions(-DANTLR4CPP_STATIC)

include(ExternalAntlr4Cpp)
include_directories(${ANTLR4_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/)
find_package(ANTLR REQUIRED)

antlr_target(
    abbLexer
    abbLexer.g4
    LEXER
    )
antlr_target(
    abbParser
    abbParser.g4
    PARSER
    DEPENDS_ANTLR abbLexer
    COMPILE_FLAGS -lib ${ANTLR_abbLexer_OUTPUT_DIR}
    )

include_directories(${ANTLR_abbLexer_OUTPUT_DIR})
include_directories(${ANTLR_abbParser_OUTPUT_DIR})

add_executable(Test
    Test.cpp
    ErrorListener.cpp
    ErrorListener.h
${ANTLR_abbLexer_CXX_OUTPUTS}
    ${ANTLR_abbParser_CXX_OUTPUTS}
    )


target_compile_options(Test PUBLIC /MT)

target_link_libraries(Test antlr4_static Threads::Threads)
