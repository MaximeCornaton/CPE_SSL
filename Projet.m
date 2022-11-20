clear variables 
close all
clc

[d,s,f] = RecordModulation(96000,5);

demodulation(s,f);