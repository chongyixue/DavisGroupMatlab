% 2019-9-20 YXC
% crop subtracted G8 and G0 registered map 150px centering 267,444 then put on workspace
% as no and yes

plotlayer = 18;
pix =5;

%% corners
% x = [84,66,45,67,99];
% y = [73,92,67,49,91];
%% center
x = [26,47,67,46,64,83,65,81,102,97,117];
y = [65,48,34,85,67,54,105,89,71,104,86];
% x = [64,83,81,102];
% y = [67,54,89,71];

%% edge
% x = [34,53,56,74,89,74,110];
% y = [76,101,59,81,98,45,81];

%% allspace
x = [75];
y = [75];
pix = 100;
%% codes


[spectra_no,~]=points_average_spectra(no,x,y,pix,plotlayer);
[spectra_yes,energy]=points_average_spectra(yes,x,y,pix,plotlayer);

figure,plot(energy,spectra_no,'b','LineWidth',5)
hold on
plot(energy,spectra_yes,'r','LineWidth',5)
plot(energy,spectra_yes-spectra_no,'color',[0,0.5,0])