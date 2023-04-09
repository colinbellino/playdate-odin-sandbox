mkdir build
cd build
cmake .. -G "NMake Makefiles"

nmake clean
nmake
odin build ../src -out=../OdinTests.pdx/pdex.dll -debug -build-mode:shared
PlaydateSimulator ../OdinTests.pdx
cd ..