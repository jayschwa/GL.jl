importall ImmutableArrays

typealias GLboolean  Bool
typealias GLbyte     Int8
typealias GLubyte    Uint8
typealias GLchar     Uint8
typealias GLshort    Int16
typealias GLushort   Uint16
typealias GLint      Int32
typealias GLuint     Uint32
typealias GLint64    Int64
typealias GLuint64   Uint64
typealias GLsizei    Uint32
typealias GLenum     Uint32
typealias GLintptr   Ptr
typealias GLsizeiptr Int
typealias GLfloat    Float32
typealias GLdouble   Float64
typealias GLvoid     Void

immutable Object
	handle::GLuint
end
Object(x) = Object(convert(GLuint,x))

immutable Shader
	handle::Object
end
Shader(x) = Shader(Object(x))

immutable Program
	handle::Object
end
Program(x) = Program(Object(x))

typealias Buffer      Object
typealias Texture     Object
typealias VertexArray Object

typealias Attribute GLint

immutable Uniform
	location::GLint
end
Uniform(location) = Uniform(convert(GLint, location))
+(u::Uniform, i::Integer) = Uniform(u.location+i)

typealias Vec2 Vector2{Float32}
typealias Vec3 Vector3{Float32}
typealias Vec4 Vector4{Float32}

