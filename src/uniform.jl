function Uniform(prog::Program, name::String)
	u = @glcall( (:glGetUniformLocation, lib), Uniform,
		(Program, Ptr{GLchar}), prog, name)
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
			@glcall(($(Symbol("glUniform1", t, "v")), lib), Void,
				(Uniform, $T), u, val)
		write(u::Uniform, val::Vector2{$T}) =
			@glcall(($(Symbol("glUniform2", t, "v")), lib), Void,
				(Uniform, GLsizei, Ptr{Vector2{$T}}), u, 1, &val)
		write(u::Uniform, val::Vector3{$T}) =
			@glcall(($(Symbol("glUniform3", t, "v")), lib), Void,
				(Uniform, GLsizei, Ptr{Vector3{$T}}), u, 1, &val)
		write(u::Uniform, val::Vector4{$T}) =
			@glcall(($(Symbol("glUniform4", t, "v")), lib), Void,
				(Uniform, GLsizei, Ptr{Vector4{$T}}), u, 1, &val)

		# Write matrix
		write(u::Uniform, mat::Matrix2x2{$T}) =
			@glcall(($(Symbol("glUniformMatrix2", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix2x2{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix2x3{$T}) =
			@glcall(($(Symbol("glUniformMatrix2x3", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix2x3{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix2x4{$T}) =
			@glcall(($(Symbol("glUniformMatrix2x4", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix2x4{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix3x2{$T}) =
			@glcall(($(Symbol("glUniformMatrix3x2", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix3x2{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix3x3{$T}) =
			@glcall(($(Symbol("glUniformMatrix3", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix3x3{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix3x4{$T}) =
			@glcall(($(Symbol("glUniformMatrix3x4", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix3x4{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix4x2{$T}) =
			@glcall(($(Symbol("glUniformMatrix4x2", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix4x2{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix4x3{$T}) =
			@glcall(($(Symbol("glUniformMatrix4x3", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix4x3{$T}}),
				u, 1, false, &mat)
		write(u::Uniform, mat::Matrix4x4{$T}) =
			@glcall(($(Symbol("glUniformMatrix4", t, "v")), lib), Void,
				(Uniform, GLsizei, GLboolean, Ptr{Matrix4x4{$T}}),
				u, 1, false, &mat)
	end
end

write(u::Uniform, val::Bool) = write(u, convert(UInt32, val))

