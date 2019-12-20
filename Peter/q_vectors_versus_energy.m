% clear all
% load('/Users/andreykostin/Documents/MATLAB/Analysis Code/MATLAB/FeSe figs/q3q1Gamma.mat');
% load('/Users/andreykostin/Documents/MATLAB/Analysis Code/MATLAB/FeSe figs/q3q1M.mat');
load('C:\Users\pspra\OneDrive\New folder\gap_splines.mat');
% load('C:\Users\Peter\OneDrive\New folder\gap_splines.mat');

%gamma definitions
q1g = q1_lorparcomb(:,3);
eg1 = q1_lorparcomb(:,4);
q3g = q3_lorparcomb(:,3);
eg3 = q3_lorparcomb(:,4);
q2xg = 1.03*[0.122,0.10948,0.10304,0.10304,0.10304,0.0966,0.10304,0.0966,0.09016,0.08372,0.07728,0.07084,0.0644,0.0644];
q2yg = 1.03*abs([-0.077,-0.10304,-0.10948,-0.11592,-0.12236,-0.1288,-0.14168,-0.15456,-0.15456,-0.161,-0.161,-0.16744,-0.16744,-0.17388]);
q2g = sqrt(q2xg.^2+q2yg.^2);
eg2 = abs(linspace(-2.1,-0.8,14));

%gamma errors
q2g_error = 1.03*0.75*[0.02576,0.01932,0.02576,0.02576,0.02576,0.02576,0.01932,0.02576,0.02576,0.01932,0.01932,0.01932,0.02576,0.02576];
q1g_error = 1.03*0.75*q1_lorparcomb(:,5);
q3g_error = 1.03*0.75*q3_lorparcomb(:,5);

%epsilon definitions
q1e = q1m_lorparcomb(:,3);
ee1 = q1m_lorparcomb(:,4);
q3e = q3m_lorparcomb(:,3);
ee3 = q3m_lorparcomb(:,4);

%--------------
%define gaps
load('C:\Users\pspra\OneDrive\New folder\input_5Band_FeSe_SM_2D_fake_susc_comb_spec_gap.mat','dat1','dat2');
% load('C:\Users\Peter\OneDrive\New folder\input_5Band_FeSe_SM_2D_fake_susc_comb_spec_gap.mat','dat1','dat2');
ang2=angle( dat2(:,2)-round(dat2(:,2)/pi)*pi + 1i * (dat2(:,3)-round(dat2(:,3)/pi)*pi) );
ang1=angle( dat1(:,2)-round(dat1(:,2)/pi)*pi + 1i * (dat1(:,3)-round(dat1(:,3)/pi)*pi) );

gap_g = abs(dat1(:,1));
ang_g = ang1/pi*180+180;
[ang_g,I] = sort(ang_g);

scalar = 2.3/max(gap_g);


indices2=round(dat2(:,2)/pi)>0;
gap_e = dat2(indices2,1);
ang_e = ang2(indices2)/pi*180+180;
[ang_e,I2] = sort(ang_e);

gap_g = scalar*gap_g;
gap_g = gap_g(I);
gap_e = scalar*gap_e;
gap_e = gap_e(I2);

gap_g = [2.3; gap_g];
ang_g = [0; ang_g];
%----------------------------------

%----------------------------
%effective gamma elliptical band
E0 = 10;
a = 0.135^2/E0;
b = 0.20^2/E0;
kx = linspace(0,0.135,200);
ky = sqrt(b*(E0-kx.^2/a));
angle_gamma = atan(ky./kx)*180/pi;
%--------------------------------
ang = 0:0.5:360;
gap_g_intpl = pchip(ang_g,gap_g,ang);
gap_e_intpl = pchip(ang_e,gap_e,ang);

gap_g_FS = interp1(ang,gap_g_intpl,angle_gamma,'spline');
gap_g_FS2 = interp1(angl_g_data_spline,gap_g_data_spline,angle_gamma,'spline');


figure(2), clf
plot(-kx, ky,'-k', -kx, -ky,'-k',kx, -ky,'-k', kx,ky,'-k','LineWidth',2);
axis([-0.2 0.2 -0.2 0.2]);
axis square
%axis equal

figure(3), clf
plot(ang_g,gap_g,'.k','MarkerSize',25);
hold on
plot(ang_e,gap_e,'.r','MarkerSize',25);
plot(ang,gap_g_intpl,'-k','LineWidth',2);
plot(ang,gap_e_intpl,'-r','LineWidth',2);
plot(angle_gamma,gap_g_FS,'.b','MarkerSize',25);
plot(angl_g_data_spline,gap_g_data_spline,'--k','LineWidth',2);
hold off
xlim([0 360])
ylim([0 2.5])
xlabel('angle (degrees)');
ylabel('-g_k');
ylabel('|g_k|');
ax = gca;
ax.XTick = linspace(0,360,9);
ax.YTick = linspace(0,2.5,6);
figw
figsiz = 1.5*[25 10];
fig_siz(figsiz);

figure(1), clf
plot(eg1,100*q1g,'.k','MarkerSize',25);
hold on
plot(eg3,100*q3g,'.r','MarkerSize',25);
plot(eg2,100*q2g,'.b','MarkerSize',25);

verrorbar(eg1,100*q1g,100*q1g_error,'.k');
verrorbar(eg3,100*q3g,100*q3g_error,'.r');
verrorbar(eg2,100*q2g,100*q2g_error,'.b');

% plot(gap_g_FS,100*kx,'--r','LineWidth',2);
% plot(gap_g_FS,100*ky,'--k','LineWidth',2);
% plot(gap_g_FS,100*sqrt(kx.^2+ky.^2),'--b','LineWidth',2);
plot(gap_g_FS2,100*kx,'-r','LineWidth',2);
plot(gap_g_FS2,100*ky,'-k','LineWidth',2);
plot(gap_g_FS2,100*sqrt(kx.^2+ky.^2),'-b','LineWidth',2);


ax1 = gca;
axis([0.2 2.4 0 22]);
ax1.XTick = linspace(0.4,2,5);
ax1.YTick = linspace(5,20,4);
figw
box on
hold off


