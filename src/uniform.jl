function Uniform(prog::Program, name::String)
	ret = ccall( (:glGetUniformLocation, lib), GLint,
		(Program, Ptr{GLchar}), prog, bytestring(name))
	if ret < 0
		GetError()
		error("uniform ", name, " not found")
	else
		return Uniform(ret)
	end
end

import Base.write
importall ImmutableArrays

for (T,t) in ((Float32, "f"), (Int32, "i"), (Uint32, "ui"))
	@eval begin
		# Write single vector
		write(u::Uniform, val::$T) =
			ccall(($(string("glUniform1", t)), lib), Void,
				(GLint, $T), u.location, val)
		write(u::Uniform, val::Vector2{$T}) =
			ccall(($(string("glUniform2", t, "v")), lib), Void,
				(GLint, GLsizei, Ptr{Vector2{$T}}), u.location, 1, &val)
		write(u::Uniform, val::Vector3{$T}) =
			ccall(($(string("glUniform3", t, "v")), lib), Void,
				(GLint, GLsizei, Ptr{Vector3{$T}}), u.location, 1, &val)
		write(u::Uniform, val::Vector4{$T}) =
			ccall(($(string("glUniform4", t, "v")), lib), Void,
				(GLint, GLsizei, Ptr{Vector4{$T}}), u.location, 1, &val)

		# Write matrix
		write(u::Uniform, mat::Matrix2x2{$T}) =
			ccall(($(string("glUniformMatrix2", t, "v")), lib), Void,
				(GLint, GLsizei, GLboolean, Ptr{Matrix2x2{$T}}),
				u.location, 1, false, &mat)
		write(u::Uniform, mat::Matrix2x3{$T}) =
			ccall(($(string("glUniformMatrix2x3", t, "v")), lib), Void,
				(GLint, GLsizei, GLboolean, Ptr{Matrix2x3{$T}}),
				u.location, 1, false, &mat)
		write(u::Uniform, mat::Matrix2x4{$T}) =
			ccall(($(string("glUniformMatrix2x4", t, "v")), lib), Void,
				(GLint, GLsizei, GLboolean, Ptr{Matrix2x4{$T}}),
				u.location, 1, false, &mat)
		write(u::Uniform, mat::Matrix3x2{$T}) =
			ccall(($(string("glUniformMatrix3x2", t, "v")), lib), Void,
				(GLint, GLsizei, GLboolean, Ptr{Matrix3x2{$T}}),
				u.location, 1, false, &mat)
		write(u::Uniform, mat::Matrix3x3{$T}) =
			ccall(($(string("glUniformMatrix3", t, "v")), lib), Void,
				(GLint, GLsizei, GLboolean, Ptr{Matrix3x3{$T}}),
				u.location, 1, false, &mat)
		write(u::Uniform, mat::Matrix3x4{$T}) =
			ccall(($(string("glUniformMatrix3x4", t, "v")), lib), Void,
				(GLint, GLsizei, GLboolean, Ptr{Matrix3x4{$T}}),
				u.location, 1, false, &mat)
		write(u::Uniform, mat::Matrix4x2{$T}) =
			ccall(($(string("glUniformMatrix4x2", t, "v")), lib), Void,
				(GLint, GLsizei, GLboolean, Ptr{Matrix4x2{$T}}),
				u.location, 1, false, &mat)
		write(u::Uniform, mat::Matrix4x3{$T}) =
			ccall(($(string("glUniformMatrix4x3", t, "v")), lib), Void,
				(GLint, GLsizei, GLboolean, Ptr{Matrix4x3{$T}}),
				u.location, 1, false, &mat)
		write(u::Uniform, mat::Matrix4x4{$T}) =
			ccall(($(string("glUniformMatrix4", t, "v")), lib), Void,
				(GLint, GLsizei, GLboolean, Ptr{Matrix4x4{$T}}),
				u.location, 1, false, &mat)
	end
end

write(u::Uniform, val::Bool) = write(u, convert(Uint32, val))

