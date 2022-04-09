project('helloworld', 'cpp')

opencv_dep = dependency('opencv')
implot_dep = dependency('implot')

executable('helloworld', 'helloworld.cpp',
           dependencies: opencv_dep)
executable('helloimplot', 'implot_demo.cpp', 
           dependencies: implot_dep)
