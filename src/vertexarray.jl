function GenVertexArrays(count::Integer)
	a = Array(VertexArray, count)
	@glcall( (:glGenVertexArrays, lib), Void, (GLsizei, Ptr{Buffer}), count, a)
	GetError()
	return a
end

function GenVertexArray()
	return GenVertexArrays(1)[1]
end

function BindVertexArray(va::VertexArray)
	@glcall( (:glBindVertexArray, lib), Void, (VertexArray,), va)
	GetError() # TODO: Benchmark overhead
end
BindVertexArray(va::Integer) = BindVertexArray(VertexArray(va))
