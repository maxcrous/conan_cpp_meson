project('helloworld', 'cpp')

opencv_dep = dependency('opencv')
imgui_dep = dependency('imgui')

executable('helloworld', 'helloworld.cpp',
           dependencies: opencv_dep)
executable('helloimgui', 'imgui_demo.cpp', 
           dependencies: imgui_dep)
