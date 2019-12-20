% load('/Users/andreykostin/Data/Em.mat');
% 
% load('/Users/andreykostin/Data/alpha.mat');


% E_g = eigeps2Daa(:,:,3)*1000;
% clear eigepsDaa eigepsDss
% load('/Users/andreykostin/Data/delta.mat');
% E_eps = eigeps2Daa_delta(:,:,4)*1000;

% 
% temp = E_g(2:end,:);
% temp2 = [flipud(temp);E_g];
% temp3 = temp2(:,2:end);
% temp4 = [fliplr(temp3) temp2];
% 
% E_g = temp4;
% clear temp temp2 temp3 temp4


%a=2.708
s = 0.20*pi/2.708;
res = 2000+1;
k_x = linspace(-s,s,res);
k_y = linspace(-s,s,res);

res2 = 500+1;
k_x2 = linspace(0.8*pi,1.2*pi,res2)/2.7;
k_y2 = linspace(-0.2*pi,0.2*pi,res2)/2.7;

% figure(5),
% contour(2*(k_x2-pi/2.7),2*k_y2,E_eps',[0 0],'k')


% E_m = E_m+1.1;
% A = abs(E_m')<0.2;
map = [1 1 1;0 0 1];

eg = linspace(-2.1,-0.90,13);
xg = [-0.122,-0.109,-0.109,-0.103,-0.103,-0.097,-0.090,-0.084,-0.090,-0.084,-0.071,-0.064,-0.064];
yg = [-0.077,-0.103,-0.109,-0.116,-0.129,-0.135,-0.148,-0.155,-0.167,-0.174,-0.174,-0.180,-0.200];

eg_peter = linspace(-2.1,-0.8,14);
xg_peter = [0.122,0.10948,0.10304,0.10304,0.10304,0.0966,0.10304,0.0966,0.09016,0.08372,0.07728,0.07084,0.0644,0.0644];
yg_peter = [-0.077,-0.10304,-0.10948,-0.11592,-0.12236,-0.1288,-0.14168,-0.15456,-0.15456,-0.161,-0.161,-0.16744,-0.16744,-0.17388];


em = linspace(-0.9,-0.50,5);


xm = [-0.262,-0.292,-0.314,-0.337,-0.359];
ym = [-0.082,-0.082,-0.075,-0.067,-0.060];

xm_peter = [0.26964,0.28462,0.31458,0.33705,0.34454];
ym_peter = [-0.08239,-0.0749,-0.06741,-0.05992,-0.05243];

xm_peter2 = 0.23219;
ym_peter2 = -0.08239;

xm_peter3 = [0.10989,0.15984,0.18981,0.22977,0.24975,0.25974,0.28971,0.28971,0.31968,0.34968,0.36963,0.36963];
ym_peter3 = [-0.05994,-0.05994,-0.06993,-0.06993,-0.06993,-0.06993,-0.05994,-0.05994,-0.06993,-0.07992,-0.04995,0];

%xm_peter3 = [0.22977,0.24975,0.25974,0.28971,0.28971,0.31968,0.33966,0.35964,0.36963];
%ym_peter3 = [-0.06993,-0.06993,-0.06993,-0.05994,-0.05994,-0.06993,-0.07992,-0.04995,0];

% xm_peter4 = [0.35964, 0.36963];
% ym_peter4 = [-0.04995, 0];

xm_peter4 = [0.36963];
ym_peter4 = [0];

figure(1),
p=0;
%subplot(1,2,1),
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
%imagesc(2*[-0.25 0.25],2*[-0.25 0.25],A), colormap(map);
%imagesc(2*[-0.25 0.25],2*[-0.25 0.25],0), colormap(gray);
%hold on
%plot([xg xg -xg -xg],[yg -yg yg -yg],'.k', 'MarkerSize', 25);
%plot([xm xm -xm -xm],[ym -ym ym -ym],'.r', 'MarkerSize', 25);
%plot([xg xg -xg -xg],[yg -yg yg -yg],'.k', 'MarkerSize', 25);
%imagesc(2*[-0.25 0.25],2*[-0.25 0.25],10), colormap(gray);

p = 3;
% plot([xg_peter xg_peter -xg_peter -xg_peter],[yg_peter -yg_peter yg_peter -yg_peter],'ok', 'MarkerSize', p,'MarkerFaceColor','k');
% hold on
% %plot([xm xm -xm -xm],[ym -ym ym -ym],'.k', 'MarkerSize', 25);
% plot([xm_peter xm_peter -xm_peter -xm_peter],[ym_peter -ym_peter ym_peter -ym_peter],'ok', 'MarkerSize', p,'MarkerFaceColor','k');
% plot([xm_peter2 xm_peter2 -xm_peter2 -xm_peter2],[ym_peter2 -ym_peter2 ym_peter2 -ym_peter2],'ok', 'MarkerSize', p,'MarkerFaceColor','k');
% %plot([xm_peter3 xm_peter3 -xm_peter3 -xm_peter3],[ym_peter3 -ym_peter3 ym_peter3 -ym_peter3],'.b', 'MarkerSize', 25);
% plot([xm_peter4 xm_peter4 -xm_peter4 -xm_peter4],[ym_peter4 -ym_peter4 ym_peter4 -ym_peter4],'ok', 'MarkerSize', p,'MarkerFaceColor','k');

%contour(2.25*(k_x2-pi/2.7),2*k_y2,E_eps',[6 6],'k')

%contour(2*k_x,2*k_y,E_g',linspace(0,15,15),'k')
% hold off

%%
xg1 = [xg_peter xg_peter -xg_peter -xg_peter];
yg1 = [yg_peter -yg_peter yg_peter -yg_peter];

xm1 = [xm_peter xm_peter -xm_peter -xm_peter];
ym1 = [ym_peter -ym_peter ym_peter -ym_peter];

xm2 = [xm_peter2 xm_peter2 -xm_peter2 -xm_peter2];
ym2 = [ym_peter2 -ym_peter2 ym_peter2 -ym_peter2];

xm3 = [xm_peter4 xm_peter4 -xm_peter4 -xm_peter4];
ym3 = [ym_peter4 -ym_peter4 ym_peter4 -ym_peter4];

crad = 0.005;
%%
xg_error = [0.02576,0.01932,0.02576,0.02576,0.02576,0.02576,0.01932,0.02576,0.02576,0.01932,0.01932,0.01932,0.02576,0.02576];

xm_error = [0.02247,0.02247,0.02247,0.02247,0.02247];

xm_error2 = 0.02247;

xm_error4 = [0.02997];

% xm_error4 = [0.02997, 0.02997];

xgerror1 = 0.75*[xg_error xg_error xg_error xg_error];

xmerror1 = 0.75*[xm_error xm_error xm_error xm_error];

xmerror2 = 0.75*[xm_error2 xm_error2 xm_error2 xm_error2];

xmerror3 = 0.75*[xm_error4 xm_error4 xm_error4 xm_error4];
%%
rectangle('Position',[xg1(1)-crad/2,yg1(1)-crad/2,crad,crad],'Curvature',[1,1],...
          'FaceColor','k','LineStyle','none')
      
% plot(xg1(1), yg1(1),'ok', 'MarkerSize', p,'MarkerFaceColor','k');      
hold on

verrorbar(xg1(1), yg1(1), xgerror1(1),'k');
herrorbar(xg1(1), yg1(1), xgerror1(1),'k');

for i=2 : length(xg1)
    rectangle('Position',[xg1(i)-crad/2,yg1(i)-crad/2,crad,crad],'Curvature',[1,1],...
          'FaceColor','k','LineStyle','none')
%     plot(xg1(i), yg1(i),'ok', 'MarkerSize', p,'MarkerFaceColor','k');    
    verrorbar(xg1(i), yg1(i),  xgerror1(i),'k');
    herrorbar(xg1(i), yg1(i),  xgerror1(i),'k');  
end

for i=1 : length(xm1)
    rectangle('Position',[xm1(i)-crad/2,ym1(i)-crad/2,crad,crad],'Curvature',[1,1],...
          'FaceColor','k','LineStyle','none')
%     plot(xm1(i), ym1(i),'ok', 'MarkerSize', p,'MarkerFaceColor','k');
    verrorbar(xm1(i), ym1(i),  xmerror1(i),'k');
    herrorbar(xm1(i), ym1(i), xmerror1(i),'k');    
end

for i=1 : length(xm2)
    rectangle('Position',[xm2(i)-crad/2,ym2(i)-crad/2,crad,crad],'Curvature',[1,1],...
          'FaceColor','k','LineStyle','none')
%     plot(xm2(i), ym2(i),'ok', 'MarkerSize', p,'MarkerFaceColor','k');  
    verrorbar(xm2(i), ym2(i), xmerror2(i),'k');
    herrorbar(xm2(i), ym2(i), xmerror2(i),'k');    
end

for i=1 : length(xm3)
    rectangle('Position',[xm3(i)-crad/2,ym3(i)-crad/2,crad,crad],'Curvature',[1,1],...
          'FaceColor','k','LineStyle','none')
%     plot(xm3(i), ym3(i),'ok', 'MarkerSize', p,'MarkerFaceColor','k');
    verrorbar(xm3(i), ym3(i), xmerror3(i),'k');
    herrorbar(xm3(i), ym3(i), xmerror3(i),'k');  
end
hold off



%%
%plot(2*[k_x_g k_x_g -k_x_g -k_x_g],2*[k_y_g -k_y_g k_y_g -k_y_g],'.b', 'MarkerSize', 10);
%plot([-0.5 0.5],[0 0],'--k','LineWidth',1);
%plot([0 0],[-0.5 0.5],'--k','LineWidth',1);
%plot(2*[k_x_m k_x_m -k_x_m -k_x_m],2*[k_y_m -k_y_m k_y_m -k_y_m],'.b', 'MarkerSize', 10);

%hold off
axis equal
axis(2*[-0.25 0.25 -0.20 0.20]);
%axis(2*[-0.25 0.25 -0.25 0.25]);
%axis(2*[-0.25 0 -0.25 0.25]);
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
ax2.XTick = linspace(-0.4,0.4,5);
ax2.YTick = linspace(-0.4,0.4,5);
%axis square
%axis off
%ax2.XTick = linspace(0,90,7);
%xlabel('q_x (A^{-1})','FontSize',20);
%ylabel('q_y (A^{-1})','FontSize',20);

figsiz=[25 25];
fig_siz(figsiz);
%pbaspect([1.25 1 1])

figw
box on

% figure(2),
% contour(2*k_x,2*k_y,E_g',[0 0],'k')