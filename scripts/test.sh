python3 ../test/testing/ifel.py > out1
./run.sh --input=../test/testing/ifel.py
./code > out2
diff out1 out2

