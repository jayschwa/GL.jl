function Uniform(prog::Program, name::String)
	u = ccall( (:glGetUniformLocation, lib), Uniform,
		(Program, Ptr{GLchar}), prog, bytestring(name))
	if u.location < 0
		GetError()
		error("uniform ", name, " not found")
	else
		return u
	end
end

import Base.write
importall ImmutableArrays

for (T,t) in ((Float32, "f"), (Int32, "i"), (UInt32, "ui"))
	@eval begin
		# Write single vector
		write(u::Uniform, val::$T) =
			ccall(($(string("glUniform1", t)), lib), Void,
				(Uniform, $T), u, val)
		write(u::Uniform, val::Vector2{$T}) =
			ccall(($(string("glUniform2", t, "v")), lib), Void,
				(Uniform, GLsizei, Ptr{Vector2{$T}}), u, 1, &val)
		write(u::Uniform, val::Vector3{$T}) =
			ccall(($(string("glUniform3", t, "v")), lib), Void,
				(Uniform, GLsizei, Ptr{Vector3{$T}}), u, 1, &val)
		write(u::Uniform, val::Vector4{$T}) =
			ccall(($(string("glUniform4", t, "v")), lib), Void,
				(Uniform, GLsizei, Ptr{Vector4{$T}}), u, 1, &val)

		# Write matrix
		write(u::Uniform, mat::Matrix2x2{$T}) =
			ccall(($(string("glUniformMatrix2", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix2x2{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix2x3{$T}) =
			ccall(($(string("glUniformMatrix2x3", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix2x3{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix2x4{$T}) =
			ccall(($(string("glUniformMatrix2x4", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix2x4{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix3x2{$T}) =
			ccall(($(string("glUniformMatrix3x2", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix3x2{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix3x3{$T}) =
			ccall(($(string("glUniformMatrix3", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix3x3{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix3x4{$T}) =
			ccall(($(string("glUniformMatrix3x4", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix3x4{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix4x2{$T}) =
			ccall(($(string("glUniformMatrix4x2", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix4x2{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix4x3{$T}) =
			ccall(($(string("glUniformMatrix4x3", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix4x3{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix4x4{$T}) =
			ccall(($(string("glUniformMatrix4", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix4x4{$T}}),
				u, 1, false, &mat)
	end
end

write(u::Uniform, val::Bool) = write(u, convert(UInt32, val))

