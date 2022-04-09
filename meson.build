project('helloworld', 'cpp')

opencv_dep = dependency('opencv')
implot_dep = dependency('implot')
imgui_dep = dependency('imgui')

executable('helloworld', 'helloworld.cpp',
           dependencies: opencv_dep)
executable('helloimplot', 'implot_demo.cpp', 
           dependencies: [implot_dep, imgui_dep])
