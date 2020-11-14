clear all
clc

Fs= 10000;

fileID = fopen('output.txt','r');
formatSpec = '%d';
x = fscanf(fileID,formatSpec);

thd(x)