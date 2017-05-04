################################################################################
#   Utilities
################################################################################

# Masks
const DEPTH_BUFFER_BIT   = 0x00000100
const STENCIL_BUFFER_BIT = 0x00000400
const COLOR_BUFFER_BIT   = 0x00004000

function Clear(mask::Integer)
	@glcall( (:glClear, lib), Void, (GLuint,), mask)
end

# Capabilities
const BLEND                    = 0x0BE2
const CULL_FACE                = 0x0B44
const DEPTH_TEST               = 0x0B71
const DITHER                   = 0x0BD0
const POLYGON_OFFSET_FILL      = 0x8037
const SAMPLE_ALPHA_TO_COVERAGE = 0x809E
const SAMPLE_COVERAGE          = 0x80A0
const SCISSOR_TEST             = 0x0C11
const STENCIL_TEST             = 0x0B90

function Disable(cap::Integer)
	@glcall( (:glDisable, lib), Void, (GLenum,), cap)
end

function Enable(cap::Integer)
	@glcall( (:glEnable, lib), Void, (GLenum,), cap)
end

# Error codes
const NO_ERROR          = 0
const INVALID_ENUM      = 0x0500
const INVALID_VALUE     = 0x0501
const INVALID_OPERATION = 0x0502
const OUT_OF_MEMORY     = 0x0505

function GetError()
	ret = @glcall( (:glGetError, lib), GLenum, ())
	if ret != NO_ERROR
		error(ret)
	end
end

function GetString(name::Integer)
	ret = @glcall( (:glGetString, lib), Ptr{GLubyte}, (GLenum,), name)
	if ret != C_NULL
		unsafe_string(ret)
	else
		GetError()
	end
end

function GetStringi(name::Integer, index::Integer)
	ret = @glcall( (:glGetStringi, lib), Ptr{GLubyte}, (GLenum, GLuint), name, index)
	if ret != C_NULL
		unsafe_string(ret)
	else
		GetError()
	end
end

GetString(name::Integer, index::Integer) = GetStringi(name, index)

# String names
const VENDOR                   = 0x1F00
const RENDERER                 = 0x1F01
const VERSION                  = 0x1F02
const SHADING_LANGUAGE_VERSION = 0x8B8C
const EXTENSIONS               = 0x1F03

function Viewport(width::Integer, height::Integer)
	@glcall( (:glViewport, lib), Void,
		(GLint, GLint, GLsizei, GLsizei),
		0, 0, width, height)
end

