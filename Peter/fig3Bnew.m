%% test script for eigenvalues after unfolding 10 orbital model


% eigeps2Dss = fese_Hirschfeld_tb_5orbital(250, 0);
res = 100;
eigeps2D = fese_Hirschfeld_tb_soc_pos_contcret(res, 0);
shift = 0.004;

xm_peter = [0.26964,0.28462,0.31458,0.33705,0.34454];
ym_peter = [-0.08239,-0.0749,-0.06741,-0.05992,-0.05243];
xm_peter2 = 0.23219;
ym_peter2 = -0.08239;
xm_peter3 = 0.36963;
ym_peter3 = 0;

xm_peter4 = [0.10989,0.15984,0.18981,0.22977,0.24975,0.25974,0.28971,0.28971,0.31968,0.34968,0.36963,0.36963];
ym_peter4 = [-0.05994,-0.05994,-0.06993,-0.06993,-0.06993,-0.06993,-0.05994,-0.05994,-0.06993,-0.07992,-0.04995,0];

xm_extra = [0.10989,0.15984,0.18981];
ym_extra = [-0.05994,-0.05994,-0.06993];


% E_m = (eigeps2D(:,:,11)-0.008)*1000;
% 
% eps3 = 0.5;
% A1 = ((E_m-1.5)'.^2) < eps3^2;
% A2 = (E_m'.^2) < (eps3^2);
% A3 = ((E_m+1.5)'.^2) < eps3^2;
% A = A1+A2+A3;
% A(A>1)=1;
%figure(2), imagesc( A), colormap(gray),colormap(flipud(colormap));

k_y = linspace(-0.2*pi, 0.2*pi, res+1);
k_x = linspace(pi-0.2*pi, pi+0.2*pi, res+1);

E_m = (eigeps2D(:,:,13)-shift)*1000;

eps3 = 0.5;
A1 = ((E_m-1.5)'.^2) < eps3^2;
A2 = (E_m'.^2) < (eps3^2);
A3 = ((E_m+1.5)'.^2) < eps3^2;
A = A1+A2+A3;
A(A>1)=1;
% figure(3), imagesc( A2), colormap(gray),colormap(flipud(colormap));


E_m2 = (eigeps2D(:,:,15)-shift)*1000;

eps3 = 0.5;
A1 = ((E_m2-1.5)'.^2) < eps3^2;
A2 = (E_m2'.^2) < (eps3^2);
A3 = ((E_m2+1.5)'.^2) < eps3^2;
A = A1+A2+A3;
A(A>1)=1;
% figure(4), imagesc( A2), colormap(gray),colormap(flipud(colormap));

figure,
clf
% scale = 1.05;
scale = 1.0;

contour((scale)*(k_x-pi),(scale)*k_y,E_m',[0 0],'r');
hold on
contour((scale)*(k_x-pi),(scale)*k_y,E_m2',[0 0],'r');

p=5;
plot([xm_peter xm_peter -xm_peter -xm_peter],[ym_peter -ym_peter ym_peter -ym_peter],'ok', 'MarkerSize', p,'MarkerFaceColor','k');
plot([xm_peter2 xm_peter2 -xm_peter2 -xm_peter2],[ym_peter2 -ym_peter2 ym_peter2 -ym_peter2],'ok', 'MarkerSize', p,'MarkerFaceColor','k');
plot([xm_peter3 xm_peter3 -xm_peter3 -xm_peter3],[ym_peter3 -ym_peter3 ym_peter3 -ym_peter3],'ok', 'MarkerSize', p,'MarkerFaceColor','k');
%plot([xm_peter4 xm_peter4 -xm_peter4 -xm_peter4],[ym_peter4 -ym_peter4 ym_peter4 -ym_peter4],'ok', 'MarkerSize', p,'MarkerFaceColor','g');
plot([xm_extra xm_extra -xm_extra -xm_extra],[ym_extra -ym_extra ym_extra -ym_extra],'ok', 'MarkerSize', p,'MarkerFaceColor','g');

hold off

% E_m = eigeps2Daa(:,:,4)*1000;
% 
% eps3 = 0.75;
% A1 = ((E_m-1.5)'.^2) < eps3^2;
% A2 = (E_m'.^2) < (eps3^2);
% A3 = ((E_m+1.5)'.^2) < eps3^2;
% A = A1+A2+A3;
% A(A>1)=1;
% figure(4), imagesc( A), colormap(gray),colormap(flipud(colormap));