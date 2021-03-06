#snapped from: https://bitbucket.org/sinbad/ogre/src/0bba4f7cdb95/CMake/Packages/FindOpenGLES.cmake?at=default
#-------------------------------------------------------------------
# This file is part of the CMake build system for OGRE
#     (Object-oriented Graphics Rendering Engine)
# For the latest info, see http://www.ogre3d.org/
#
# The contents of this file are placed in the public domain. Feel
# free to make use of it in any way you like.
#-------------------------------------------------------------------

# - Try to find OpenGLES
# Once done this will define
#
#  OPENGLES_FOUND        - system has OpenGLES
#  OPENGLES_INCLUDE_DIR  - the GL include directory
#  OPENGLES_LIBRARIES    - Link these to use OpenGLES

IF (WIN32)
  IF (CYGWIN)

    FIND_PATH(OPENGLES_INCLUDE_DIR GLES/gl.h )

    FIND_LIBRARY(OPENGLES_gl_LIBRARY libgles_cm )

  ELSE (CYGWIN)

    IF(MSVC)
      #The user hast to provide this atm. GLES can be emulated via Desktop OpenGL
      #using the ANGLE project found at: http://code.google.com/p/angleproject/
      SET (OPENGLES_gl_LIBRARY import32 CACHE STRING "OpenGL ES 1.x library for win32")
    ENDIF(MSVC)

  ENDIF (CYGWIN)

ELSE (WIN32)

  IF (APPLE)

        create_search_paths(/Developer/Platforms)
        findpkg_framework(OpenGLES)
    set(OPENGLES_gl_LIBRARY "-framework OpenGLES")

  ELSE(APPLE)

    FIND_PATH(OPENGLES_INCLUDE_DIR GLES/gl.h
      /usr/openwin/share/include
      /opt/graphics/OpenGL/include /usr/X11R6/include
      /usr/include
      /opt/vc/include
    )

    FIND_PATH(OPENGLES2_INCLUDE_DIR GLES2/gl2.h
      /usr/openwin/share/include
      /opt/graphics/OpenGL/include /usr/X11R6/include
      /usr/include
      /opt/vc/include
    )

    FIND_PATH(OPENGLES3_INCLUDE_DIR GLES3/gl3.h
      /usr/openwin/share/include
      /opt/graphics/OpenGL/include /usr/X11R6/include
      /usr/include
      /opt/vc/include
    )

    FIND_PATH(OPENGLES31_INCLUDE_DIR GLES3/gl31.h
      /usr/openwin/share/include
      /opt/graphics/OpenGL/include /usr/X11R6/include
      /usr/include
      /opt/vc/include
    )

    FIND_LIBRARY(OPENGLES_gl_LIBRARY
      NAMES GLES_CM GLESv1_CM
      PATHS /opt/graphics/OpenGL/lib
            /usr/openwin/lib
            /usr/shlib /usr/X11R6/lib
            /usr/lib
            /opt/vc/lib
    )

    FIND_LIBRARY(OPENGLES_gl2_LIBRARY
      NAMES GLESv2
      PATHS /opt/graphics/OpenGL/lib
            /usr/openwin/lib
            /usr/shlib /usr/X11R6/lib
            /usr/lib
            /opt/vc/lib
    )

    FIND_LIBRARY(OPENGLES_gl3_LIBRARY
      NAMES GLESv2
      PATHS /opt/graphics/OpenGL/lib
            /usr/openwin/lib
            /usr/shlib /usr/X11R6/lib
            /usr/lib
            /opt/vc/lib
    )


    # On Unix OpenGL most certainly always requires X11.
    # Feel free to tighten up these conditions if you don't
    # think this is always true.

    IF (OPENGLES_gl_LIBRARY)
      IF(NOT X11_FOUND)
        INCLUDE(FindX11)
      ENDIF(NOT X11_FOUND)
      IF (X11_FOUND)
        SET (OPENGLES_LIBRARIES ${X11_LIBRARIES})
      ENDIF (X11_FOUND)
    ENDIF (OPENGLES_gl_LIBRARY)

  ENDIF(APPLE)
ENDIF (WIN32)

SET( OPENGLES_FOUND "NO" )
IF(OPENGLES_gl_LIBRARY)

    SET( OPENGLES_LIBRARIES ${OPENGLES_gl_LIBRARY} ${OPENGLES_LIBRARIES}  )

    SET( OPENGLES_FOUND "YES" )

ENDIF(OPENGLES_gl_LIBRARY)

SET( OPENGLES2_FOUND "NO" )
IF(OPENGLES_gl2_LIBRARY)
SET( OPENGLES_LIBRARIES ${OPENGLES_gl2_LIBRARY} ${OPENGLES_LIBRARIES} )

    SET( OPENGLES2_FOUND "YES" )

ENDIF(OPENGLES_gl2_LIBRARY)

SET( OPENGLES3_FOUND "NO" )
IF(OPENGLES_gl3_LIBRARY)
  SET( OPENGLES_LIBRARIES ${OPENGLES_gl3_LIBRARY} ${OPENGLES_LIBRARIES} )
  SET( OPENGLES3_FOUND "YES" )
  IF(OPENGLES31_INCLUDE_DIR)
    SET( OPENGLES31_FOUND "YES" )
  ENDIF(OPENGLES31_INCLUDE_DIR)

ENDIF(OPENGLES_gl3_LIBRARY)


MARK_AS_ADVANCED(
  OPENGLES_INCLUDE_DIR
  OPENGLES2_INCLUDE_DIR
  OPENGLES3_INCLUDE_DIR
  OPENGLES31_INCLUDE_DIR
  OPENGLES_gl_LIBRARY
  OPENGLES_gl2_LIBRARY
  OPENGLES_gl3_LIBRARY
)
