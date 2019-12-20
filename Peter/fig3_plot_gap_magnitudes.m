%% test script for eigenvalues after unfolding 10 orbital model


res = 500;

[eigeps2Dss,eigeps2Daa] = fese_Hirschfeld_tb_5orbital_complete2(res, 0);


shift = 0.000;

% (pi,0) point

em = [1.3,1.2,1.1,0.9,0.8,0.7,0.6,0.5,0.3];
xm = [0.15984,0.18981,0.23219,0.26964,0.28462,0.31458,0.33705,0.34454,0.36963];
ym = [0.05994,0.06993,0.08239,0.08239,0.0749,0.06741,0.05992,0.05243,0];

% (0,0) point

eg = linspace(2.1,0.8,14);
xg = [0.122,0.10948,0.10304,0.10304,0.10304,0.0966,0.10304,0.0966,0.09016,0.08372,0.07728,0.07084,0.0644,0.0644];
yg = [0.077,0.10304,0.10948,0.11592,0.12236,0.1288,0.14168,0.15456,0.15456,0.161,0.161,0.16744,0.16744,0.17388];



% 

k_y = linspace(-0.2*pi, 0.2*pi, res+1);
k_x = linspace(pi-0.2*pi, pi+0.2*pi, res+1);



E_eps = (eigeps2Dss(:,:,4)'-shift)*1000;
[Gx,Gy] = gradient(E_eps);
gx = Gx./sqrt(Gx.^2+Gy.^2);
gy = Gy./sqrt(Gx.^2+Gy.^2);

scale = 1.0;
qx = (scale)*(k_x-pi);
qy = (scale)*k_y;

[Qx, Qy] = meshgrid(qx,qy);

%----------------------------
%effective gamma elliptical band
E0 = 10;
a = 0.135^2/E0;
b = 0.20^2/E0;
E_gamma = E0 - Qx.^2/a - Qy.^2/b;




figure(1),
clf

hold on
contour(qx,qy,E_eps,[0 0],'k','LineWidth',1);
e_eps_contour = contourc(qx,qy,E_eps,[0 0]);
e_eps_contour = e_eps_contour(:,2:end);

N = numel(xm);
clear xf yf
for i=1:N
    diff = (e_eps_contour(1,:)-xm(i)).^2+(e_eps_contour(2,:)-ym(i)).^2;
    [m,ind] = min(diff);
    xf(i) = e_eps_contour(1,ind(1));
    yf(i) = e_eps_contour(2,ind(1));
end

diff = (e_eps_contour(1,:)).^2;
[m,ind] = min(diff);
tempx = e_eps_contour(1,ind(1));
tempy = e_eps_contour(2,ind(1));

xf = [tempx xf];
yf = [tempy yf];
em2 = [1.5 em];

%hold on

scale2=0.04;
X = scale2*interp2(Qx,Qy,gx,xf,yf).*em2+xf;
Y = scale2*interp2(Qx,Qy,gy,xf,yf).*em2+yf;



p=25;

plot([xm xm -xm -xm],[ym -ym ym -ym],'.g', 'MarkerSize', p);
plot([xf xf -xf -xf],[yf -yf yf -yf],'.r', 'MarkerSize', p);
plot([X X -X -X],[Y -Y Y -Y],'.b', 'MarkerSize', p);

%plot([xg xg -xg -xg],[yg -yg yg -yg],'.r', 'MarkerSize', p);



% plot([-0.5 -0.5 0.5 0.5 -0.5],[-0.5 0.5 0.5 -0.5 -0.5],'-k');
% plot([-0.4 -0.4 0.4 0.4 -0.4],[-0.4 0.4 0.4 -0.4 -0.4],'-k');
hold off

axis equal
axis(1*[-0.5 0.5 -0.5 0.5]);
ax = gca;
ax.XTick = linspace(-0.4,0.4,5);
ax.YTick = linspace(-0.4,0.4,5);
figw
box on
figsiz = 3*[10 10];
fig_siz(figsiz);
%axis off

clear Gx Gy
[Gx,Gy] = gradient(E_gamma);
gx = -Gx./sqrt(Gx.^2+Gy.^2);
gy = -Gy./sqrt(Gx.^2+Gy.^2);
e_g_contour = contourc(qx,qy,E_gamma,[0 0]);
e_g_contour = e_g_contour(:,2:end);

N = numel(xg);
clear xf2 yf2
for i=1:N
    diff = (e_g_contour(1,:)-xg(i)).^2+(e_g_contour(2,:)-yg(i)).^2;
    [m,ind] = min(diff);
    xf2(i) = e_g_contour(1,ind(1));
    yf2(i) = e_g_contour(2,ind(1));
end

diff = (e_g_contour(1,:)).^2;
[m,ind] = min(diff);
tempx = e_g_contour(1,ind(1));
tempy = e_g_contour(2,ind(1));

xf2 = [xf2 tempx];
yf2 = [yf2 tempy];
eg2 = [eg 0.3];

diff = (e_g_contour(2,:)).^2;
[m,ind] = min(diff);
tempx = e_g_contour(1,ind(1));
tempy = e_g_contour(2,ind(1));

xf2 = [tempx xf2];
yf2 = [tempy yf2];
eg2 = [2.3 eg2];



X = scale2*interp2(Qx,Qy,gx,xf2,yf2).*eg2+xf2;
Y = scale2*interp2(Qx,Qy,gy,xf2,yf2).*eg2+yf2;


figure(2),
clf,
hold on
plot([xg xg -xg -xg],[yg -yg yg -yg],'.g', 'MarkerSize', p);
plot([xf2 xf2 -xf2 -xf2],[yf2 -yf2 yf2 -yf2],'.r', 'MarkerSize', p);

contour(qx,qy,E_gamma,[0 0],'k','LineWidth',1);
plot([X X -X -X],[Y -Y Y -Y],'.b', 'MarkerSize', p);
hold off
axis equal
axis(1*[-0.5 0.5 -0.5 0.5]);
ax2 = gca;
ax2.XTick = linspace(-0.4,0.4,5);
ax2.YTick = linspace(-0.4,0.4,5);
figw
box on
figsiz = 3*[10 10];
fig_siz(figsiz);

%------------------------------

theta_g = atan2(yg,xg)/(2*pi)*360;
theta_m = atan2(yf,xf)/(2*pi)*360;

em2 = [1.5 em];

em2 = fliplr(em2);
em = fliplr(em);

theta_m = fliplr(theta_m);
theta_m_outline = [theta_m(1) theta_m(2) theta_m(6) theta_m(9) theta_m(10)];
em_outline=[em2(1) em2(2) em2(6) em2(9) em2(10)];
%eg_outline = [2.4 eg 0.3];
eg_outline = [2.3 eg 0.3];
eg_outline = [eg_outline(1) eg_outline(3) eg_outline(15) eg_outline(16)];
theta_g_outline = [0 theta_g 90];
theta_g_outline = [theta_g_outline(1) theta_g_outline(3) theta_g_outline(15) theta_g_outline(16)];

figure(4),
clf
plot(theta_m_outline,em_outline,'.r','MarkerSize',25);
hold on
plot(theta_g_outline,eg_outline,'.k','MarkerSize',25);
hold off
figsiz = 1.5*[10 10];
fig_siz(figsiz)

figure(3),
clf,
theta_m_full = [theta_m fliplr(180-theta_m) theta_m+180 fliplr(360-theta_m)];
theta_m_outline = [theta_m_outline fliplr(180-theta_m_outline) theta_m_outline+180 fliplr(360-theta_m_outline)];
theta_g_outline = [theta_g_outline fliplr(180-theta_g_outline) theta_g_outline+180 fliplr(360-theta_g_outline)];

theta_g_full = [theta_g fliplr(180-theta_g) theta_g+180 fliplr(360-theta_g)];
theta_g_full2 = [0 theta_g_full(1:14) 90 theta_g_full(15:28) 180 theta_g_full(29:42) 270 theta_g_full(43:56) 360];

theta_m_full2 = [theta_m_full(1:10) theta_m_full(12:20) theta_m_full(22:30) theta_m_full(32:40)];
theta_m_full3 = [theta_m_full(1:9) theta_m_full(12:20) theta_m_full(22:29) theta_m_full(32:40)];

theta_m_outline = [theta_m_outline(1:5) theta_m_outline(7:10) theta_m_outline(12:15) theta_m_outline(17:20)];
theta_g_outline = [theta_g_outline(1:4) theta_g_outline(6:8) theta_g_outline(10:12) theta_g_outline(14:16)];

em_full = [em2 fliplr(em2) em2 fliplr(em2)];
em_outline = [em_outline fliplr(em_outline) em_outline fliplr(em_outline)];
eg_outline = [eg_outline fliplr(eg_outline) eg_outline fliplr(eg_outline)];


eg_full = [eg fliplr(eg) eg fliplr(eg)];
%eg_full2 = [2.4 eg_full(1:14) 0.3 eg_full(15:28) 2.4 eg_full(29:42) 0.3 eg_full(43:56) 2.4];
eg_full2 = [2.3 eg_full(1:14) 0.3 eg_full(15:28) 2.3 eg_full(29:42) 0.3 eg_full(43:56) 2.3];

em_full2 = [em_full(1:10) em_full(12:20) em_full(22:30) em_full(32:40)];
em_full3 = [em_full(1:9) em_full(12:20) em_full(22:29) em_full(32:40)];

em_outline = [em_outline(1:5) em_outline(7:10) em_outline(12:15) em_outline(17:20)];
eg_outline = [eg_outline(1:4) eg_outline(6:8) eg_outline(10:12) eg_outline(14:16)];

xx = 0:0.5:360;
temp = -fliplr(xx);
temp2 = xx+360;
xx2 = [temp(1:end-1) xx temp2(2:end)];
em_expanded = [em_full2(1:end-1) em_full2 em_full2(2:end)];
em_expanded_outline = [em_outline(1:end-1) em_outline em_outline(2:end)];

eg_expanded_outline = [eg_outline(1:end-1) eg_outline eg_outline(2:end)];

temp = -fliplr(theta_m_full2);
temp2 = theta_m_full2 + 360;
theta_m_expanded = [temp(1:end-1) theta_m_full2 temp2(2:end)];
temp = -fliplr(theta_m_outline);
temp2 = theta_m_outline +360;
theta_m_expanded_outline = [temp(1:end-1) theta_m_outline temp2(2:end)];
temp = -fliplr(theta_g_outline);
temp2 = theta_g_outline +360;
theta_g_expanded_outline = [temp(1:end-1) theta_g_outline temp2(2:end)];
%yy = spline(theta_m_full2,em_full2,xx);


yy = pchip(theta_m_expanded_outline,em_expanded_outline,xx2);

temp = -fliplr(theta_g_full2);
temp2 = theta_g_full2 + 360;
theta_g_expanded = [temp(1:end-1) theta_g_full2 temp2(2:end)];

eg_expanded = [eg_full2(1:end-1) eg_full2 eg_full2(2:end)];
yy2 = pchip(theta_g_expanded_outline,eg_expanded_outline,xx2);



plot([theta_g 180-theta_g theta_g+180 360-theta_g],[eg eg eg eg],'.k','MarkerSize',25);
hold on
plot([0 90 180 270 360],[2.3 0.3 2.3 0.3 2.3],'ok','MarkerSize',7);
plot(theta_m_full3,em_full3,'.r','MarkerSize',25);
plot([90 270],[1.5 1.5],'or','MarkerSize',7);
plot(xx2,yy,'--r','LineWidth',1);
plot(xx2,yy2,'--k','LineWidth',1);
hold off
axis([0 360 0 2.5]);
ax3 = gca;
ax3.XTick = linspace(0,360,9);
ax3.YTick = linspace(0,2.5,6);
figw
box on
figsiz = 1.5*[25 10];
fig_siz(figsiz)

angl_g_data_spline = xx2;
gap_g_data_spline = yy2;
angl_g_data = [theta_g 180-theta_g theta_g+180 360-theta_g];
gap_g_data = [eg eg eg eg];
angl_g_data_sym = [0 90 180 270 360];
gap_g_data_sym = [2.3 0.3 2.3 0.3 2.3];

angl_e_data_spline = xx2;
gap_e_data_spline = yy;
angl_e_data = theta_m_full3;
gap_e_data = em_full3;
angl_e_data_sym = [90 270];
gap_e_data_sym = [1.5 1.5];
