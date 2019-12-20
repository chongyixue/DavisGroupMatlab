% clear all

%%
% load('t1.mat');
pixelnum = 100;
% the script fese_Hirschfeld_tb_5orbital_bounds_unres_mexable has a typo,
% in line 89 which puts the rows/columns in the "wrong" order, e.g. a
% transpose is needed to fix this again
% remember to use the "new" version of
% moduleBands3Dchemcalc_unrestricted_fig.m from August 1st that has a typo
% corrected for the OO
% [eigeps2Daa] = fese_Hirschfeld_tb_5orbital_bounds_unres_mexable(pixelnum,0,1.2*[-pi pi],1.2*[-pi pi],t1);
[eigeps2Daa] = fese_Hirschfeld_tb_5orbital_bounds_unres_mexable(pixelnum,0,[pi-0.2*pi pi+0.2*pi],0.2*[-pi pi],t1);

[eigeps2Daa_og] = fese_Hirschfeld_tb_5orbital_bounds_unres_mexable(pixelnum,0,[-0.2*pi 0.2*pi],0.2*[-pi pi],t1);

% k_y = linspace(-1.2*pi, 1.2*pi, pixelnum+1);
% k_x = linspace(-1.2*pi, 1.2*pi, pixelnum+1);

k_y = linspace(-0.2*pi, 0.2*pi, pixelnum+1);
k_x = linspace(pi-0.2*pi, pi+0.2*pi, pixelnum+1);

k_y = linspace(-0.2*pi, 0.2*pi, pixelnum+1);
k_x = linspace(-0.2*pi, 0.2*pi, pixelnum+1);

% the 
E_eps = (eigeps2Daa(:,:,4))'*1000;
E_alpha = (eigeps2Daa_og(:,:,3))'*1000;

figure(100), clf

C = contour(k_x,k_y,E_eps,[0 0],'k','LineWidth',2);
C_eps = contourc(k_x,k_y,E_eps, [0,0]);
hold on
C = contour(k_x,k_y,E_alpha,[0 0],'k','LineWidth',2);
C_gam = contourc(k_x,k_y,E_alpha,[0 0]);
hold off
% axis equal
axis tight


%%

res = 500;

[eigeps2Dss,eigeps2Daa] = fese_Hirschfeld_tb_5orbital_complete2(res, 0);


shift = 0.000;


k_y = linspace(-0.2*pi, 0.2*pi, res+1);
k_x = linspace(pi-0.2*pi, pi+0.2*pi, res+1);



E_eps = (eigeps2Dss(:,:,4)'-shift)*1000;
[Gx,Gy] = gradient(E_eps);
gx = Gx./sqrt(Gx.^2+Gy.^2);
gy = Gy./sqrt(Gx.^2+Gy.^2);

scale = 1.03;
qx = (scale)*(k_x-pi);
qy = (scale)*k_y;


figure(1000),
clf

contour(qx,qy,E_eps,[0 0],'k','LineWidth',1);
e_eps_contour = contourc(qx,qy,E_eps,[0 0]);
e_eps_contour = e_eps_contour(:,2:end);
C_eps = e_eps_contour;

%% calculate the angle and the kx and ky values in the range 0 to pi/2

% first epsilon pocket
dum1 = find(C_eps(1,2:end)==0);

test3 = atan2(C_eps(2,dum1 + 1), C_eps(1,dum1 + 1));

dum3 = find(test3 > 0);

% dum1(dum3) == pi/2

dum2 = find(C_eps(2,2:end)==0);

test4 = atan2(C_eps(2,dum2 + 1), C_eps(1,dum2 + 1));

dum4 = find(test4 == 0);

% dum2(dum4) == zero

angeps = atan2(C_eps(2,dum1(dum3)+1 : dum2(dum4)+1), C_eps(1,dum1(dum3)+1 : dum2(dum4)+1) );
kxeps = C_eps(1,dum1(dum3)+1 : dum2(dum4)+1);
kyeps = C_eps(2,dum1(dum3)+1 : dum2(dum4)+1);
figure, plot(angeps, kxeps, 'r.')
figure, plot(angeps, kyeps, 'r.')

% next gamma pocket
dum1 = find(C_gam(1,2:end)==0);

test3 = atan2(C_gam(2,dum1 + 1), C_gam(1,dum1 + 1));

dum3 = find(test3 > 0);

% dum1(dum3) == pi/2

dum2 = find(C_gam(2,2:end)==0);

test4 = atan2(C_gam(2,dum2 + 1), C_gam(1,dum2 + 1));

dum4 = find(test4 == 0);

% dum2(dum4) == zero

anggam = atan2(C_gam(2,dum1(dum3)+1 : dum2(dum4)+1), C_gam(1,dum1(dum3)+1 : dum2(dum4)+1) );
kxgam = C_gam(1,dum1(dum3)+1 : dum2(dum4)+1);
kygam = C_gam(2,dum1(dum3)+1 : dum2(dum4)+1);
figure, plot(anggam, kxgam, 'k.')
figure, plot(anggam, kygam, 'k.')
%%
test1 = atan2(C_eps(2,2:end), C_eps(1,2:end));
test2 = atan2(C_gam(2,2:end), C_gam(1,2:end));
figure, plot(test1, 'r.')
figure, plot(test2, 'k.')

%%
% load('/Users/andreykostin/Documents/MATLAB/Analysis Code/MATLAB/FeSe figs/q3q1Gamma.mat');
% load('/Users/andreykostin/Documents/MATLAB/Analysis Code/MATLAB/FeSe figs/q3q1M.mat');
load('C:\Users\pspra\OneDrive\New folder\gap_splines.mat');
% load('C:\Users\Peter\OneDrive\New folder\gap_splines.mat');

%gamma definitions
q1g = q1_lorparcomb(:,3);
eg1 = q1_lorparcomb(:,4);
q3g = q3_lorparcomb(:,3);
eg3 = q3_lorparcomb(:,4);
q2xg = [0.122,0.10948,0.10304,0.10304,0.10304,0.0966,0.10304,0.0966,0.09016,0.08372,0.07728,0.07084,0.0644,0.0644];
q2yg = abs([-0.077,-0.10304,-0.10948,-0.11592,-0.12236,-0.1288,-0.14168,-0.15456,-0.15456,-0.161,-0.161,-0.16744,-0.16744,-0.17388]);
q2g = sqrt(q2xg.^2+q2yg.^2);
eg2 = abs(linspace(-2.1,-0.8,14));

%gamma errors
q2g_error = 0.75*[0.02576,0.01932,0.02576,0.02576,0.02576,0.02576,0.01932,0.02576,0.02576,0.01932,0.01932,0.01932,0.02576,0.02576];
q1g_error = q1_lorparcomb(:,5);
q3g_error = q3_lorparcomb(:,5);

%epsilon definitions
q1e = q1m_lorparcomb(:,3);
ee1 = q1m_lorparcomb(:,4);
q3e = q3m_lorparcomb(:,3);
ee3 = q3m_lorparcomb(:,4);

q2xe = [0.15984,0.18981,0.23219, 0.26964,0.28462,0.31458,0.33705,0.34454, 0.36963];
q2ye = [0.05994,0.06993,0.08239, 0.08239,0.0749,0.06741,0.05992,0.05243, 0];
q2e = sqrt(q2xe.^2+q2ye.^2);
ee2 = [1.3, 1.2, 1.1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.3];

q2e_error = 0.75*[0.04995,0.03996,0.02247, 0.02247,0.02247,0.02247,0.02247,0.02247, 0.02997];
q1e_error = q1m_lorparcomb(:,5);
q3e_error = q3m_lorparcomb(:,5);
%--------------


kxgam = kxgam*2/2.66;
kygam = kygam*2/2.66;
anggam = anggam*180/pi;

gap_g_FS2 = interp1(angl_g_data_spline,gap_g_data_spline,anggam,'spline');

figure(300), clf
plot(eg1,1.03*100*q1g,'.k','MarkerSize',25);
hold on
plot(eg3,1.03*100*q3g,'.r','MarkerSize',25);
plot(eg2,1.03*100*q2g,'.b','MarkerSize',25);

verrorbar(eg1,1.03*100*q1g,1.03*100*q1g_error,'.k');
verrorbar(eg3,1.03*100*q3g,1.03*100*q3g_error,'.r');
verrorbar(eg2,1.03*100*q2g,1.03*100*q2g_error,'.b');

plot(gap_g_FS2,100*kxgam,'-r','LineWidth',2);
plot(gap_g_FS2,100*kygam,'-k','LineWidth',2);
plot(gap_g_FS2,100*sqrt(kxgam.^2+kygam.^2),'-b','LineWidth',2);

axis([0.2 2.4 0 22]);
ax1 = gca;
ax1.XTick = linspace(0.4,2,5);
ax1.YTick = linspace(5,20,4);
figw
box on
hold off



%%

% kxeps = kxeps*2/2.66;
% kyeps = kyeps*2/2.66;
angeps = angeps*180/pi;

gap_e_FS2 = interp1(angl_e_data_spline,gap_e_data_spline,angeps,'spline');

figure(200), clf
plot(ee1,1.03*100*q1e,'.k','MarkerSize',25);
hold on
plot(ee3,1.03*100*q3e,'.r','MarkerSize',25);
plot(ee2,1.03*100*q2e,'.b','MarkerSize',25);

verrorbar(ee1,1.03*100*q1e,1.03*100*q1e_error,'.k');
verrorbar(ee3,1.03*100*q3e,1.03*100*q3e_error,'.r');
verrorbar(ee2,1.03*100*q2e,1.03*100*q2e_error,'.b');

plot(gap_e_FS2,100*kxeps,'-r','LineWidth',2);
plot(gap_e_FS2,100*kyeps,'-k','LineWidth',2);
plot(gap_e_FS2,100*sqrt(kxeps.^2+kyeps.^2),'-b','LineWidth',2);

axis([0.2 1.6 0 42]);
ax1 = gca;
ax1.XTick = linspace(0.2,1.4,4);
ax1.YTick = linspace(10,40,4);
figw
box on
hold off

