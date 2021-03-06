INCLUDE(CheckCXXSourceCompiles)

FUNCTION(CheckWineGcc BITNESS WINEGCC_EXECUTABLE RESULT)
	FILE(WRITE "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/winegcc_test.cxx" "
	#include <iostream>
	#define USE_WS_PREFIX
	#include <windows.h>
	int main(int argc, const char* argv[]) {
		return 0;
	}
	")
	EXECUTE_PROCESS(COMMAND ${WINEGCC_EXECUTABLE} "-m${BITNESS}"
		"${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/winegcc_test.cxx"
		"-o" "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/winegcc_test"
		OUTPUT_QUIET ERROR_QUIET
		RESULT_VARIABLE WINEGCC_RESULT
	)
	FILE(REMOVE "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/winegcc_test.cxx"
		"${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/winegcc_test"
		"${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/winegcc_test.exe.so"
	)
	IF(WINEGCC_RESULT EQUAL 0)
		SET(${RESULT} True PARENT_SCOPE)
	ELSE()
		SET(${RESULT} False PARENT_SCOPE)
	ENDIF()
ENDFUNCTION()
