SET( TARGET_SRC
    osgviewerQt.cpp
)

SET(TARGET_ADDED_LIBRARIES osgWidget osgQt)

SET( EXAMPLE_NAME osgviewerQt )

SETUP_EXAMPLE( ${EXAMPLE_NAME} )

IF ( Qt5Gui_FOUND )
    qt5_use_modules( example_${EXAMPLE_NAME} Gui )
ENDIF( Qt5Gui_FOUND )
