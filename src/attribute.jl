function GetAttribLocation(prog::Program, name::String)
	ret = @glcall( (:glGetAttribLocation, lib), Attribute,
		(Program, Ptr{GLchar}), prog, name)
	if ret < 0
		GetError()
		error("attribute not found")
	else
		return ret
	end
end

function EnableVertexAttribArray(attr::Attribute)
	@glcall( (:glEnableVertexAttribArray, lib), Void, (Attribute,), attr)
end

function VertexAttribPointer(attr::Attribute, size::Integer, typ::Integer,
	normalize::Bool, stride::Integer, ptr::Integer)

	@glcall( (:glVertexAttribPointer, lib), Void,
		(Attribute, GLint, GLenum, GLboolean, GLsizei, Ptr{GLvoid}),
		attr, size, typ, normalize, stride, Ptr{GLvoid}(ptr))
	GetError()
end

