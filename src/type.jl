importall ImmutableArrays

typealias GLboolean  Int32
typealias GLbyte     Int8
typealias GLubyte    UInt8
typealias GLchar     UInt8
typealias GLshort    Int16
typealias GLushort   UInt16
typealias GLint      Int32
typealias GLuint     UInt32
typealias GLint64    Int64
typealias GLuint64   UInt64
typealias GLsizei    UInt32
typealias GLenum     UInt32
typealias GLintptr   Ptr
typealias GLsizeiptr Int
typealias GLfloat    Float32
typealias GLdouble   Float64
typealias GLvoid     Void

immutable Object
	handle::GLuint
end

immutable Shader
	handle::Object
end

immutable Program
	handle::Object
end

typealias Buffer      Object
typealias Texture     Object
typealias VertexArray Object

typealias Attribute GLint

immutable Uniform
	location::GLint
end
+(u::Uniform, i::Integer) = Uniform(u.location+i)

typealias Vec2 Vector2{Float32}
typealias Vec3 Vector3{Float32}
typealias Vec4 Vector4{Float32}

