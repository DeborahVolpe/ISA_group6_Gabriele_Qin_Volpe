clc
clear all
close all

fileID1 = fopen('fb_values.txt','r');
fb = fscanf(fileID1,'%d\n');
fclose(fileID1);

fileID2 = fopen('ff_values.txt','r');
ff = fscanf(fileID2,'%d\n');
fclose(fileID2);

fileID3 = fopen('output.txt','r');
output = fscanf(fileID3,'%d\n');
fclose(fileID3);

fileID4 = fopen('samples.txt','r');
samples = fscanf(fileID4,'%d\n');
fclose(fileID4);

fileID5 = fopen('w_values.txt','r');
w = fscanf(fileID5,'%d\n');
fclose(fileID5);

fileID6 = fopen('y_values.txt','r');
y = fscanf(fileID6,'%d\n');
fclose(fileID6);

fs=10000 %% sampling frequency
T=1/500; %% maximum period
tt=0:1/fs:10*T; %% time samples

y1 = 1023*ones(length(tt));
y2 = -1024*ones(length(tt));

figure(1)
plot(tt,samples,'*','LineWidth',0.5);

hold on
plot(tt,w,'*','LineWidth',0.5);
plot(tt,ff,'*','LineWidth',0.5);
plot(tt,fb,'*','LineWidth',0.5);
plot(tt,y,'*','LineWidth',0.5);
plot(tt, output, '*','LineWidth',0.5);
plot(tt, y1,'r');
plot(tt, y2, 'r');
grid on

xlabel('\textit{Time $[s]$} ','Interpreter','latex','FontSize', 14);
ylabel('\textit{Value}','Interpreter','latex','FontSize', 14);
title ('\textbf{Value of internal variable of the filter}','Interpreter','latex','FontSize', 14);
xlim([0 0.02])
ylim([-1200 1200])
legend('\textit{samples}','\textit{w}','\textit{ff}', '\textit{fb}', '\textit{y}',  '\textit{output}','Interpreter','latex','Location','southeast', 'FontSize', 10)

print -depsc IIR_variable_studies
