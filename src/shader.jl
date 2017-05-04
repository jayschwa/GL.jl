const FRAGMENT_SHADER = 0x00008B30
const VERTEX_SHADER   = 0x00008B31

FragmentShader(src::String) = Shader(FRAGMENT_SHADER, src)
VertexShader(src::String) = Shader(VERTEX_SHADER, src)

function Shader(typ::Integer, src::String)
	s = Shader(typ)
	ShaderSource(s, src)
	CompileShader(s)
	return s
end

function Shader(typ::Integer)
	ret = @glcall( (:glCreateShader, lib), Shader, (GLenum,), typ)
	if ret == 0
		GetError()
		error("shader creation failed")
	end
	return ret
end

function ShaderSource(s::Shader, src::String)
	@glcall( (:glShaderSource, lib), Void,
		(Shader, GLsizei, Ref{Ptr{GLchar}}, Ref{GLint}),
		s, 1, pointer(src), GLint(length(src)))
end

function CompileShader(s::Shader)
	@glcall( (:glCompileShader, lib), Void, (Shader,), s)
	if !GetShader(s, COMPILE_STATUS)
		error(GetShaderInfoLog(s))
	end
end

const COMPILE_STATUS = 0x8B81

function GetShader(s::Shader, param::Integer)
	ret = GLint[-1]
	@glcall( (:glGetShaderiv, lib), Void,
		(Shader, GLenum, Ptr{GLint}), s, param, ret)
	ret = ret[1]
	if ret == -1
		GetError()
		error("no output")
	elseif param in (COMPILE_STATUS, DELETE_STATUS)
		return ret == 1
	else
		return ret
	end
end

function GetShaderInfoLog(s::Shader)
	size = GetShader(s, INFO_LOG_LENGTH)
	buf = Array(GLchar, size)
	@glcall( (:glGetShaderInfoLog, lib), Void,
		(Shader, GLsizei, Ptr{GLsizei}, Ptr{GLchar}),
		s, size, &size, buf)
	return unsafe_string(buf, size)
end
