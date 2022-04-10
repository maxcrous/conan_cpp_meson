project('helloimgui', 'cpp')

opencv_dep = dependency('opencv')
imgui_dep = dependency('imgui')
glfw_dep = dependency('glfw3')
glew_dep = dependency('glew')

executable('helloworld', 'helloworld.cpp',
           dependencies: opencv_dep)

executable('helloimgui', 'imgui_demo.cpp', 'imgui_impl_glfw.cpp', 'imgui_impl_opengl3.cpp',
           dependencies: [imgui_dep, glfw_dep, glew_dep])

