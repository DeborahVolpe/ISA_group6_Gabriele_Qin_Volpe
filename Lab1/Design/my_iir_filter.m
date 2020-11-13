fs=10000; %% sampling frequency
f1=500;  %% first sinewave freq (in band)
f2=4500; %% second sinnewave freq (out band)

N=1; %% filter order
nb=11; %% number of bits

T=1/500; %% maximum period
tt=0:1/fs:10*T; %% time samples

x1=sin(2*pi*f1*tt); %% first sinewave
x2=sin(2*pi*f2*tt); %% second sinewave

x=(x1+x2)/2; %% input signal

[bi, ai, bq, aq] = myiir_design(N, nb) %% filter design

y=filter(bq, aq, x); %% apply filter

%% plots
figure(1)
plot(tt,x1,'--','LineWidth',0.5);
hold on
plot(tt,x2,'--','LineWidth',0.5);
plot(tt,x, 'b','LineWidth',1.2);
plot(tt, y, 'r','LineWidth',1.2);

xlabel('\textit{time $[s]$} ','Interpreter','latex','FontSize', 14);
ylabel('\textit{Amplitude}','Interpreter','latex','FontSize', 14);
title ('\textbf{Filter applied on an specific input}','Interpreter','latex','FontSize', 14);
xlim([0 0.02])
ylim([-1.2 1.5])
legend('\textit{$sin(2\pi 500t)$}','\textit{$sin(2\pi 4500t)$}', '\textit{$\frac{sin(2\pi 4500t)+sin(2\pi 500t)}{2}$}','\textit{$output(t)$}','Interpreter','latex','Location','northeast', 'FontSize', 12)
grid on

print -depsc IIR_evalouation

figure(2)
plot(tt,x, 'b','LineWidth',1.2);
hold on
plot(tt, y, 'r','LineWidth',1.2);

xlabel('\textit{time $[s]$} ','Interpreter','latex','FontSize', 14);
ylabel('\textit{Amplitude}','Interpreter','latex','FontSize', 14);
title ('\textbf{Filter applied on an specific input}','Interpreter','latex','FontSize', 14);
xlim([0 0.02])
ylim([-1.2 1.5])
legend('\textit{$\frac{sin(2\pi 4500t)+sin(2\pi 500t)}{2}$}','\textit{$output(t)$}','Interpreter','latex','Location','northeast', 'FontSize', 12)
grid on

print -depsc IIR_evalouation_input_output

figure(3)
plot(tt,x1,'m','LineWidth',0.5);
hold on
plot(tt,x2,'b','LineWidth',0.5);
plot(tt,x, 'r','LineWidth',1.5);

xlabel('\textit{time $[s]$} ','Interpreter','latex','FontSize', 14);
ylabel('\textit{Amplitude}','Interpreter','latex','FontSize', 14);
title ('\textbf{Filter applied on an specific input}','Interpreter','latex','FontSize', 14);
xlim([0 0.02])
ylim([-1.2 1.5])
legend('\textit{$sin(2\pi 500t)$}','\textit{$sin(2\pi 4500t)$}', '\textit{$\frac{sin(2\pi 4500t)+sin(2\pi 500t)}{2}$}','Interpreter','latex','Location','northeast', 'FontSize', 12)
grid on

print -depsc IIR_evalouation_inputs


%% quantize input and output
xq=floor(x*2^(nb-1));
idx=find(xq==2^(nb-1));
xq(idx)=2^(nb-1)-1;

yq=floor(y*2^(nb-1));
idy=find(yq==2^(nb-1));
yq(idy)=2^(nb-1)-1;

%% save input and output
fp=fopen('samples.txt','w');
fprintf(fp,'%d\n', xq);
fclose(fp);

fp=fopen('resultsm.txt', 'w');
fprintf(fp, '%d\n', yq);
fclose(fp);
