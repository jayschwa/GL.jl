import GL
import GLFW

GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 4)
GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 2)
GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE)
GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, 1)
window = GLFW.CreateWindow(500, 500, "Hello Cube")
GLFW.MakeContextCurrent(window)

println("Vendor:   ", GL.GetString(GL.VENDOR))
println("Renderer: ", GL.GetString(GL.RENDERER))
println("Version:  ", GL.GetString(GL.VERSION))
println("GLSL:     ", GL.GetString(GL.SHADING_LANGUAGE_VERSION))

shader_source = Dict(
GL.VERTEX_SHADER => """
#version 150

in vec3 vertex_position;
in vec3 vertex_color;

out vec3 fragment_color;

void main()
{
    gl_Position = vec4(vertex_position, 1.0);
    fragment_color = vertex_color;
}
""",
GL.FRAGMENT_SHADER => """
#version 150

in vec3 fragment_color;

out vec4 FragColor;

void main()
{
    FragColor = vec4(fragment_color, 1.0);
}
""")

shader_program = GL.Program(shader_source)

# Loop until the user closes the window
while !GLFW.WindowShouldClose(window)

    GLFW.SwapBuffers(window)
    GLFW.PollEvents()
end

GLFW.DestroyWindow(window)
