message(STATUS "Configure example")

cmake_minimum_required(VERSION 3.16)

project(QuickVLCExample VERSION 0.1 LANGUAGES CXX)

set(CMAKE_MODULE_PATH
    ${CMAKE_SOURCE_DIR}/cmake
    ${CMAKE_SOURCE_DIR}/config
    ${CMAKE_SOURCE_DIR}/config/platform
)

# Require C++ standard minimum 17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Automatically run moc, uic and/or rcc, if required
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Verbose makefile
set(CMAKE_VERBOSE_MAKEFILE ON)

set(QML_IMPORT_PATH /srv/build_libs/quickvlc/lib)

find_package(QT NAMES Qt6 COMPONENTS Core Gui REQUIRED)
find_package(Qt6 COMPONENTS Quick QuickTest Widgets REQUIRED)
find_package(QuickVLC COMPONENTS Core Qml REQUIRED)
find_package(LIBVLC REQUIRED)

SET(EX_NAME QuickVlcExample)

qt_add_executable(${EX_NAME}
    main.cpp
)

qt_add_qml_module(${EX_NAME}
    URI example
    VERSION 1.0
    QML_FILES
        main.qml
)

target_link_libraries(${EX_NAME}
    PUBLIC
        Qt6::Core
        Qt6::Quick
        Qt6::Widgets
        QuickVLC::Core
        QuickVLC::Qml
        ${LIBVLC_LIBRARY}
        ${LIBVLCCORE_LIBRARY}
)
