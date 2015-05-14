import GL
import GLFW

GLFW.Init()
GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 4)
GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 2)
GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE)
GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, 1)
window = GLFW.CreateWindow(500, 500, "Hello Cube")

println("Vendor:   ", GL.GetString(GL.VENDOR))
println("Renderer: ", GL.GetString(GL.RENDERER))
println("Version:  ", GL.GetString(GL.VERSION))
println("GLSL:     ", GL.GetString(GL.SHADING_LANGUAGE_VERSION))

while !GLFW.WindowShouldClose(window)
	GLFW.SwapBuffers(window)
end

GLFW.Terminate()

