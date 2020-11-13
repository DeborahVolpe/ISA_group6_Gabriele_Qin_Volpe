clear all
close all
clc

Fs= 10000;

fileID = fopen('output.txt','r');
formatSpec = '%d';
x = fscanf(fileID,formatSpec);

thd(x,Fs,10)