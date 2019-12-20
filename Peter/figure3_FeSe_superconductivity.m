eg = linspace(-2.1,-0.90,13);
xg = [-0.122,-0.109,-0.109,-0.103,-0.103,-0.097,-0.090,-0.084,-0.090,-0.084,-0.071,-0.064,-0.064];
yg = [-0.077,-0.103,-0.109,-0.116,-0.129,-0.135,-0.148,-0.155,-0.167,-0.174,-0.174,-0.180,-0.200];
em = linspace(-0.9,-0.50,5);
xm = [-0.262,-0.292,-0.314,-0.337,-0.359];
ym = [-0.082,-0.082,-0.075,-0.067,-0.060];

% r = sqrt(x.^2+y.^2);
% cos_theta = x./r;
% sin_theta = y./r;
% gap_1 = abs(e1);
% x1 = gap_1.*cos_theta;
% y1 = gap_1.*sin_theta;
% figure(59),
% plot(0.5*[x1 x1 -x1 -x1],0.5*[y1 -y1 y1 -y1],'.k', 'MarkerSize', 25);
figure(60),
p=0;
subplot(1,2,1),
%subaxis(1,2,1, 'Spacing', 0.2, 'Padding', 0, 'Margin', 0),
%k_x = linspace(0,0.1,100);
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
plot([xg xg -xg -xg],[yg -yg yg -yg],'.k', 'MarkerSize', 25);
hold on
plot([xm xm -xm -xm],[ym -ym ym -ym],'.r', 'MarkerSize', 25);
plot(2*[k_x_g k_x_g -k_x_g -k_x_g],2*[k_y_g -k_y_g k_y_g -k_y_g],'.b', 'MarkerSize', 10);
plot(2*[k_x_m k_x_m -k_x_m -k_x_m],2*[k_y_m -k_y_m k_y_m -k_y_m],'.b', 'MarkerSize', 10);
hold off
axis(2*[-0.25 0.25 -0.25 0.25]);
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
ax2.XTick = linspace(-0.5,0.5,5);
ax2.YTick = linspace(-0.5,0.5,5);
axis square
%ax2.XTick = linspace(0,90,7);
xlabel('q_x (A^{-1})','FontSize',20);
ylabel('q_y (A^{-1})','FontSize',20);

angles_g = atan(yg./xg);
angles_m = atan(ym./xm);

alpha = linspace(0,pi/2,100);
gmax = 2.3;
gmin = 0.3;
gap_model1 = (gmax+gmin)/2 + (gmax-gmin)/2 * cos(2*alpha);
gmin2 = -0.1;
gap_model2 = (gmax-gmin2)./(1+exp(4*(alpha-68/180*pi)))+gmin2;
gm = 1.25;
%gap_model_m = gm*(1-exp(-4.5*alpha));
gap_model_m = gm./(1+exp(-8*(alpha-12/180*pi)));

%subaxis(1,2,2, 'Spacing', 0.2, 'Padding', 0, 'Margin', 0),
subplot(1,2,2),
plot(angles_g*180/pi,-eg,'.k','MarkerSize',25);
hold on
plot(angles_m*180/pi,-em,'.r','MarkerSize',25);
plot(0,2.3,'ok','MarkerSize',10);
plot([0 90],[0.2 0.2],'--k','LineWidth',3);
plot(90,1.25,'or','MarkerSize',10);
%plot(alpha*180/pi,gap_model1,'--b','LineWidth',2);
plot(alpha*180/pi,gap_model2,'--b','LineWidth',1);
plot(alpha*180/pi,gap_model_m,'--b','LineWidth',1);
axis([0 90 0 2.5]);
ax = gca;
ax.FontSize = 20;
ax.TickLength = [0.02 0.02];
ax.LineWidth = 2;
ax.XTick = linspace(0,90,7);
axis square
xlabel('Angle (degrees)','FontSize',20);
ylabel('Gap (mV)','FontSize',20);
hold off