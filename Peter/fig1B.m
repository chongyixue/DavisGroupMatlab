%this is panel B, fig 1

load('/Users/andreykostin/Data/Em_2000.mat');
E_m = (E_m-1.5) / 2;
A = abs(E_m')<0.7;

map = [1 1 1;0 0 1];

sp=0;
a = 2.7;
c1_g = 230;
r_g = 1.6^2;
c2_g = c1_g/r_g;
c1_m = 20;
r_m = (1/4.5)^2;
c2_m = c1_m/r_m;
k_x_g = linspace(0,sqrt(1/c1_g),300);
k_y_g = sqrt((1-c1_g*k_x_g.^2)/c2_g);
k_x_m = linspace(0,sqrt(1/c1_m),300);
k_y_m = sqrt((1-c1_m*k_x_m.^2)/c2_m);

figure(2),
%subaxis(3,2,2, 'Spacing', sp, 'Padding', 0, 'Margin', 0),
imagesc([-0.25 0.25]+pi/a,[-0.25 0.25],A); %colormap(flipud(colormap));
hold on
imagesc([-0.25 0.25]-pi/a,[-0.25 0.25],A);
imagesc([-0.25 0.25],[-0.25 0.25]+pi/a,A); 
imagesc([-0.25 0.25],[-0.25 0.25]-pi/a,A), colormap(map); %colormap(flipud(colormap));
plot([k_x_g k_x_g -k_x_g -k_x_g],[k_y_g -k_y_g k_y_g -k_y_g],'.b', 'MarkerSize', 10);
%plot([k_x_m k_x_m -k_x_m -k_x_m]+pi/a,[k_y_m -k_y_m k_y_m -k_y_m],'.b', 'MarkerSize', 10);
%plot([k_x_m k_x_m -k_x_m -k_x_m]-pi/a,[k_y_m -k_y_m k_y_m -k_y_m],'.b', 'MarkerSize', 10);
%plot([k_x_m k_x_m -k_x_m -k_x_m]+pi/a,[k_y_m -k_y_m k_y_m -k_y_m],'.b', 'MarkerSize', 10);
%plot([k_x_m k_x_m -k_x_m -k_x_m],[k_y_m -k_y_m k_y_m -k_y_m]+pi/a,'.b', 'MarkerSize', 10);
%plot([k_x_m k_x_m -k_x_m -k_x_m],[k_y_m -k_y_m k_y_m -k_y_m]-pi/a,'.b', 'MarkerSize', 10);
plot([0 pi/a 0 -pi/a 0],[pi/a 0 -pi/a 0 pi/a],'-k','LineWidth',1);
plot([-pi/a pi/a pi/a -pi/a -pi/a],[-pi/a -pi/a pi/a pi/a -pi/a],'--k','LineWidth',1);
%plot([-pi/a pi/a 0 0],[0 0 -pi/a pi/a],'.k','MarkerSize',25);
arrow([0 0],0.5*[pi/a 0],'Length',110,'Width',5,'TipAngle',20);
arrow([0 0],0.5*[0 -pi/a],'Length',100,'Width',5,'TipAngle',25);

hold off
axis([-1.6 1.6 -1.6 1.6]);
ax2 = gca;
%xis off
%ax2.FontSize = 12;
% ax2.TickLength = [0.02 0.02];
% ax2.LineWidth = 2;
axis square
axis off

figsiz=[25 25];
fig_siz(figsiz);
figw