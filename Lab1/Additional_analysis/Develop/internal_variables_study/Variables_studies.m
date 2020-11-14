clc
clear all
close all

fileID1 = fopen('sx_b0_values.txt','r');
sx_b0 = fscanf(fileID1,'%d\n');
fclose(fileID1);

fileID2 = fopen('sx_c0_c1_values.txt','r');
sx_c0_c1 = fscanf(fileID2,'%d\n');
fclose(fileID2);

fileID3 = fopen('sx_c0_values.txt','r');
sx_c0 = fscanf(fileID3,'%d\n');
fclose(fileID3);

fileID4 = fopen('sx_c1_values.txt','r');
sx_c1 = fscanf(fileID4,'%d\n');
fclose(fileID4);

fileID5 = fopen('sy_c2_values.txt','r');
sy_c2 = fscanf(fileID5,'%d\n');
fclose(fileID5);

fileID6 = fopen('w_values.txt','r');
w = fscanf(fileID6,'%d\n');
fclose(fileID6);

fileID7 = fopen('output_ver2.txt','r');
y = fscanf(fileID7,'%d\n');
fclose(fileID7);

fileID8 = fopen('samples.txt','r');
x = fscanf(fileID8,'%d\n');
fclose(fileID8);



fs=10000 %% sampling frequency
T=1/500; %% maximum period
tt=0:1/fs:10*T; %% time samples
tt2= -3/fs:1/fs: 10*T;

y1 = 1023*ones(length(tt));
y2 = -1024*ones(length(tt));

figure(1)
plot(tt,x,'*','LineWidth',0.5);

hold on
plot(tt2,sx_b0,'*','LineWidth',0.5);
plot(tt2,sx_c0_c1,'*','LineWidth',0.5);
plot(tt2,sx_c1,'*','LineWidth',0.5);
plot(tt2,sx_c0,'*','LineWidth',0.5);
plot(tt2, sy_c2, '*','LineWidth',0.5);
plot(tt2, w, '*','LineWidth',0.5);
plot(tt, y, '*','LineWidth',0.5);
plot(tt, y1,'r');
plot(tt, y2, 'r');
grid on

xlabel('\textit{Time $[s]$} ','Interpreter','latex','FontSize', 14);
ylabel('\textit{Value}','Interpreter','latex','FontSize', 14);
title ('\textbf{Value of internal variable of the optimized filter direct form I}','Interpreter','latex','FontSize', 14);
xlim([0 0.02])
ylim([-1200 1200])
legend('\textit{samples}','\textit{sx\_b0}','\textit{sx\_c0\_c1}', '\textit{sx\_c1}', '\textit{sx\_c0}', '\textit{sy\_c2}', '\textit{w}','\textit{output}','Interpreter','latex','Location','southeast', 'FontSize', 10)

print -depsc IIR_variable_studies_opt_direct_I
