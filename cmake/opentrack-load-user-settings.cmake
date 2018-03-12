if(WIN32)
    set(__sdk_username "$ENV{USERNAME}")
else()
    set(__sdk_username "$ENV{USER}")
endif()

if(".${__sdk_username}" STREQUAL ".")
    set(__sdk_username "(I-have-no-name)")
endif()

if(WIN32)
    set(__sdk_os "windows")
else()
    string(REGEX MATCH "^Linux (.+)-Microsoft\$" __sdk_os_match "${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_VERSION}")
    if(__sdk_os_match)
        set(__sdk_os "Windows-WSL")
    else()
        set(__sdk_os "${CMAKE_SYSTEM_NAME}")
    endif()
endif()

include(CMakeDetermineCCompiler)
include(CMakeDetermineCXXCompiler)

set(__sdk_paths_filename "${CMAKE_SOURCE_DIR}/sdk-paths-${__sdk_username}@${CMAKE_CXX_COMPILER_ID}-${__sdk_os}.cmake")

if(EXISTS "${__sdk_paths_filename}")
    include("${__sdk_paths_filename}")
endif()
