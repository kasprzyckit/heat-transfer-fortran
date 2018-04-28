#!/bin/bash

N=1000
res="results/"

make clean
make
./HeatTransfer_4 ${N} > $res"error_data4.txt"
python visualise_error.py $res"error_data4.txt" $N $res"4_"$N
./HeatTransfer_8 $N > $res"error_data8.txt"
python visualise_error.py $res"error_data8.txt" $N $res"8_"$N
./HeatTransfer_16 ${N} > $res"error_data16.txt"
python visualise_error.py $res"error_data16.txt" $N $res"16_"$N