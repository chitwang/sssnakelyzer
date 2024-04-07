cd ../src
g++ -c code.s -o code.o
gcc code.o -o code
./code
cd ../scripts