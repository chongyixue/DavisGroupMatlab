% lets make figure 1
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%

%this is panel A
figure(1),
%subaxis(3,2,1, 'Spacing', sp, 'Padding', 0, 'Margin', 0),
h = [1 2 3 4];
X = repmat(h,1,4);
Y =repmat(h,4,1);
Y = Y(:)';
iron_mark=30;
Xs = [1.5 2.5 3.5 1.5 3.5];
Ys = [1.5 2.5 1.5 3.5 3.5];
Xs2 = [1.5 2.5 3.5 2.5];
Ys2 = [2.5 1.5 2.5 3.5];
Se_mark = 60;
Se_mark2 = 40;
plot(X,Y,'.k','MarkerSize',iron_mark);
hold on
plot(Xs,Ys,'.b','MarkerSize',Se_mark2);
plot(Xs2,Ys2,'.b','MarkerSize',Se_mark);
plot([Xs2 1.5],[Ys2 2.5],'-k','LineWidth',2);
plot([2 3 3 2 2],[2 2 3 3 2],'--k','LineWidth',2);
%plot(Xs2,Ys2,'or','MarkerSize',Se_mark2);
hold off
axis([0 5 0 5]);
axis square
axis off

%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%this is panel B
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
plot([k_x_g k_x_g -k_x_g -k_x_g],[k_y_g -k_y_g k_y_g -k_y_g],'.b', 'MarkerSize', 10);
hold on
plot([k_x_m k_x_m -k_x_m -k_x_m]+pi/a,[k_y_m -k_y_m k_y_m -k_y_m],'.b', 'MarkerSize', 10);
plot([k_x_m k_x_m -k_x_m -k_x_m]-pi/a,[k_y_m -k_y_m k_y_m -k_y_m],'.b', 'MarkerSize', 10);
%plot([k_x_m k_x_m -k_x_m -k_x_m]+pi/a,[k_y_m -k_y_m k_y_m -k_y_m],'.b', 'MarkerSize', 10);
plot([k_x_m k_x_m -k_x_m -k_x_m],[k_y_m -k_y_m k_y_m -k_y_m]+pi/a,'.b', 'MarkerSize', 10);
plot([k_x_m k_x_m -k_x_m -k_x_m],[k_y_m -k_y_m k_y_m -k_y_m]-pi/a,'.b', 'MarkerSize', 10);
plot([0 pi/a 0 -pi/a 0],[pi/a 0 -pi/a 0 pi/a],'-k','LineWidth',1);
plot([-pi/a pi/a pi/a -pi/a -pi/a],[-pi/a -pi/a pi/a pi/a -pi/a],'--k','LineWidth',1);
hold off
axis([-1.6 1.6 -1.6 1.6]);
ax2 = gca;
%xis off
%ax2.FontSize = 12;
% ax2.TickLength = [0.02 0.02];
% ax2.LineWidth = 2;
axis square
axis off

%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%this is panel C
res = 2000+1;
%cell dimensions
a = 2.7;
b=2.7;
t = 10;
k_x = linspace(-pi/t/a,pi/t/a,res);
k_y = linspace(-pi/t/b,pi/t/b,res);
k_x2 = linspace(0,pi/t/a,(res-1)/2+1);
k_y2 = linspace(0,pi/t/b,(res-1)/2+1);


[Kx, Ky] = meshgrid(k_x,k_y);
[Kx2, Ky2] = meshgrid(k_x2,k_y2);

E_h = 10;
x_0 = 0.132/2;
m_hx = x_0^2/(2*E_h);
c1 = 1/2/m_hx/E_h;
m_hy = m_hx*1.6^2;

%band
E = E_h - Kx.^2./(2*m_hx)-Ky.^2./(2*m_hy);

%gap
gmax = 2.3;
gmin = -0.1;
alpha = atan2(Ky2,Kx2);
gap_model2 = (gmax-gmin)./(1+exp(4*(alpha-68/180*pi)))+gmin;
temp1 = fliplr(gap_model2);
temp2 = [temp1(:,1:(end-1)) gap_model2];
temp3 = flipud(temp2);
temp4 = [temp3(1:(end-1),:);temp2];
%imagesc(temp4);
gap_model2 = temp4;

gap = gap_model2;
%gap = 0;
eps2 = 0.2;
w1 = 2.0;
A1 = abs(w1^2-E.^2-gap.^2)<eps2;
w2 = 1.5;
A2 = abs(w2^2-E.^2-gap.^2)<eps2;
w3 = 1.0;
A3 = abs(w3^2-E.^2-gap.^2)<eps2;
B = abs(E)<eps2;
A = A1 + A2 + A3;
A(A>1)=1;
C = 5*A+B;
C(C>5)=5;
clear A1 A2 A3
figure(3),
%subaxis(3,2,3, 'Spacing', sp, 'Padding', 0, 'Margin', 0),
imagesc([k_x(1) k_x(end)], [k_y(1) k_y(end)], C), colormap(gray), colormap(flipud(colormap));
hold on
%imagesc([k_x(1) k_x(end)], [k_y(1) k_y(end)], A2), colormap(gray), colormap(flipud(colormap));
%imagesc([k_x(1) k_x(end)], [k_y(1) k_y(end)], A3), colormap(gray), colormap(flipud(colormap));
ax_s = 0.13;
plot([-ax_s ax_s],[0 0],'--k');
plot([0 0],[-ax_s ax_s],'--k');
sx = 0.058;
sy = 0.044;
px = 0.058;
py = 0.048;
px2 = 0.047;
py2 = 0.072;
px3 = 0.033;
py3 = 0.092;

% drawArrow([-sx sy],[sx -sy]);
% drawArrow([-sx sy],[-sx -sy]);
% drawArrow([-sx sy],[sx sy]);
plot([px px -px -px],[py -py -py py],'.b','MarkerSize',30);
plot([px2 px2 -px2 -px2],[py2 -py2 -py2 py2],'.r','MarkerSize',30);
plot([px3 px3 -px3 -px3],[py3 -py3 -py3 py3],'.m','MarkerSize',30);
arrow([-sx sy],[sx -sy]);
arrow([-sx sy],[-sx -sy]);
arrow([-sx sy],[sx sy]);

tx = 0.04;
ty = 0.08;
% arrow([-tx ty],[tx -ty]);
% arrow([-tx ty],[-tx -ty]);
% arrow([-tx ty],[tx ty]);

% lw = 1;
% plot(k_x_g,k_y_g ,'--k', 'LineWidth',lw);
% plot(k_x_g,-k_y_g ,'--k', 'LineWidth',lw);
% plot(-k_x_g,k_y_g ,'--k', 'LineWidth',lw);
% plot(-k_x_g,-k_y_g ,'--k', 'LineWidth',lw);
hold off
axis([-0.15 0.15 -0.15 0.15]);
axis square
axis off
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%this is panel D
load('/Users/andreykostin/Data/Em.mat');
E_m = (E_m-1.5) / 2;
eps3 = 0.10;
A1 = ((E_m-1.5)'.^2) < eps3^2;
A2 = (E_m'.^2) < (eps3^2);
A3 = ((E_m+1.5)'.^2) < eps3^2;
A = A1+A2+A3;
A(A>1)=1;
figure(4), imagesc( A), colormap(gray),colormap(flipud(colormap));


res = 1000+1;
%cell dimensions
a = 2.7;
b=2.7;
t = 4;
k_x = linspace(-pi/t/a,pi/t/a,res);
k_y = linspace(-pi/t/b,pi/t/b,res);
k_x2 = linspace(0,pi/t/a,(res-1)/2+1);
k_y2 = linspace(0,pi/t/b,(res-1)/2+1);
[Kx2, Ky2] = meshgrid(k_x2,k_y2);

%gap
alpha = atan2(Ky2,Kx2);
gmax = 1.5;
gap_model2 = gmax*(1-exp(-4*alpha));
temp1 = fliplr(gap_model2);
temp2 = [temp1(:,1:(end-1)) gap_model2];
temp3 = flipud(temp2);
temp4 = [temp3(1:(end-1),:);temp2];
%imagesc(temp4);
gap_model2 = temp4;

gap = gap_model2;

w1 = 1.4;
w2 = 1.2;
w3 = 1.0;
eps2 = 0.1;
A1 = abs(w1^2-E_m'.^2-gap.^2)<eps2;
A2 = abs(w2^2-E_m'.^2-gap.^2)<eps2;
A3 = abs(w3^2-E_m'.^2-gap.^2)<eps2;
B = abs(E_m')<0.1;
A = A1+A2+A3;
A(A>1)=1;
C = 5*A+B;
C(C>5)=5;

figure(4),imagesc([-0.25 0.25],[-0.25 0.25],C), colormap(gray), colormap(flipud(colormap));
hold on
plot([-0.25 0.25],[0 0],'--k');
plot([0 0],[-0.25 0.25],'--k');
sx2 = 0.06;
sy2 = 0.045;
arrow([-sx2 sy2],[sx2 -sy2]);
arrow([-sx2 sy2],[-sx2 -sy2]);
arrow([-sx2 sy2],[sx2 sy2]);


px4 = 0.058;
py4 = 0.048;
px5 = 0.1415;
py5 = 0.06;
px6 = 0.19;
py6 = 0.051;

plot([px4 px4 -px4 -px4],[py4 -py4 -py4 py4],'.b','MarkerSize',30);
plot([px5 px5 -px5 -px5],[py5 -py5 -py5 py5],'.r','MarkerSize',30);
plot([px6 px6 -px6 -px6],[py6 -py6 -py6 py6],'.m','MarkerSize',30);


hold off
axis([-0.3 0.3 -0.3 0.3]);
axis off
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%this is panel E
figure(5),
%subaxis(3,2,5, 'Spacing', sp, 'Padding', 0, 'Margin', 0),

ax_s = 0.20;
plot([-ax_s ax_s],[0 0],'--k');
hold on
plot([0 0],[-ax_s ax_s],'--k');

ms1 = 30;
plot(2*px,2*py,'.b','MarkerSize',ms1);
plot(2*px,0,'.b','MarkerSize',ms1);
plot(0,2*py,'.b','MarkerSize',ms1);
plot(-2*px,-2*py,'.b','MarkerSize',ms1);
plot(-2*px,0,'.b','MarkerSize',ms1);
plot(0,-2*py,'.b','MarkerSize',ms1);
plot(-2*px,2*py,'.b','MarkerSize',ms1);
plot(2*px,-2*py,'.b','MarkerSize',ms1);

plot(2*px2,2*py2,'.r','MarkerSize',ms1);
plot(2*px2,0,'.r','MarkerSize',ms1);
plot(0,2*py2,'.r','MarkerSize',ms1);
plot(-2*px2,-2*py2,'.r','MarkerSize',ms1);
plot(-2*px2,0,'.r','MarkerSize',ms1);
plot(0,-2*py2,'.r','MarkerSize',ms1);
plot(-2*px2,2*py2,'.r','MarkerSize',ms1);
plot(2*px2,-2*py2,'.r','MarkerSize',ms1);

plot(2*px3,2*py3,'.m','MarkerSize',ms1);
plot(2*px3,0,'.m','MarkerSize',ms1);
plot(0,2*py3,'.m','MarkerSize',ms1);
plot(-2*px3,-2*py3,'.m','MarkerSize',ms1);
plot(-2*px3,0,'.m','MarkerSize',ms1);
plot(0,-2*py3,'.m','MarkerSize',ms1);
plot(-2*px3,2*py3,'.m','MarkerSize',ms1);
plot(2*px3,-2*py3,'.m','MarkerSize',ms1);

hold off
axis([-0.25 0.25 -0.25 0.25]);
axis square
axis off
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%---------------------------------------------------------------------%
%this is panel F
figure(6),
%subaxis(3,2,6, 'Spacing', sp, 'Padding', 0, 'Margin', 0),

ax_s2 = 0.45;
plot([-ax_s2 ax_s2],[0 0],'--k');
hold on
plot([0 0],[-ax_s2 ax_s2],'--k');

ms1 = 30;
plot(2*px4,2*py4,'.b','MarkerSize',ms1);
plot(2*px4,0,'.b','MarkerSize',ms1);
plot(0,2*py4,'.b','MarkerSize',ms1);
plot(-2*px4,-2*py4,'.b','MarkerSize',ms1);
plot(-2*px4,0,'.b','MarkerSize',ms1);
plot(0,-2*py4,'.b','MarkerSize',ms1);
plot(-2*px4,2*py4,'.b','MarkerSize',ms1);
plot(2*px4,-2*py4,'.b','MarkerSize',ms1);

plot(2*px5,2*py5,'.r','MarkerSize',ms1);
plot(2*px5,0,'.r','MarkerSize',ms1);
plot(0,2*py5,'.r','MarkerSize',ms1);
plot(-2*px5,-2*py5,'.r','MarkerSize',ms1);
plot(-2*px5,0,'.r','MarkerSize',ms1);
plot(0,-2*py5,'.r','MarkerSize',ms1);
plot(-2*px5,2*py5,'.r','MarkerSize',ms1);
plot(2*px5,-2*py5,'.r','MarkerSize',ms1);

plot(2*px6,2*py6,'.m','MarkerSize',ms1);
plot(2*px6,0,'.m','MarkerSize',ms1);
plot(0,2*py6,'.m','MarkerSize',ms1);
plot(-2*px6,-2*py6,'.m','MarkerSize',ms1);
plot(-2*px6,0,'.m','MarkerSize',ms1);
plot(0,-2*py6,'.m','MarkerSize',ms1);
plot(-2*px6,2*py6,'.m','MarkerSize',ms1);
plot(2*px6,-2*py6,'.m','MarkerSize',ms1);

hold off
axis([-0.55 0.55 -0.55 0.55]);
axis square
axis off



