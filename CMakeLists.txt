cmake_minimum_required(VERSION 3.16)

project(DayRater VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Sql Graphs)

qt_standard_project_setup(REQUIRES 6.5)

set(app_icon_resource_windows "${CMAKE_CURRENT_SOURCE_DIR}/resources.qrc")

qt_add_executable(appDayRater
    main.cpp
    ${app_icon_resource_windows}
)

qt_add_qml_module(appDayRater
    URI DayRater
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES resources.qrc
        QML_FILES TimeSelector.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appDayRater PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appDayRater
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appDayRater
    PRIVATE Qt6::Quick Qt6::Sql Qt6::Graphs
)

include(GNUInstallDirs)
install(TARGETS appDayRater
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
