%% test script for eigenvalues after unfolding 10 orbital model


% eigeps2Dss = fese_Hirschfeld_tb_5orbital(250, 0);

eigeps2D = fese_Hirschfeld_tb_soc_pos_contcret(100, 0);
n = 100;
% E_m = (eigeps2D(:,:,11)-0.008)*1000;
% 
% eps3 = 0.5;
% A1 = ((E_m-1.5)'.^2) < eps3^2;
% A2 = (E_m'.^2) < (eps3^2);
% A3 = ((E_m+1.5)'.^2) < eps3^2;
% A = A1+A2+A3;
% A(A>1)=1;
% figure(2), imagesc( A), colormap(gray),colormap(flipud(colormap));


%%
k_x = linspace(-0.2*pi, 0.2*pi, n+1);
k_y = linspace(pi-0.2*pi, pi+0.2*pi, n+1);

%%

E_m = (eigeps2D(:,:,13)-0.000)*1000;

eps3 = 0.5;
A1 = ((E_m-1.5)'.^2) < eps3^2;
A2 = (E_m'.^2) < (eps3^2);
A3 = ((E_m+1.5)'.^2) < eps3^2;
A = A1+A2+A3;
A(A>1)=1;
% figure(3), imagesc( A), colormap(gray),colormap(flipud(colormap));
% figure, contour(k_x,k_y,E_m',[0 0],'.k');


E_m2 = (eigeps2D(:,:,15)-0.000)*1000;

eps3 = 0.5;
A1 = ((E_m2-1.5)'.^2) < eps3^2;
A2 = (E_m2'.^2) < (eps3^2);
A3 = ((E_m2+1.5)'.^2) < eps3^2;
A = A1+A2+A3;
A(A>1)=1;
% figure(4), imagesc( A), colormap(gray),colormap(flipud(colormap));
% figure, contour(k_x,k_y,E_m2',[0 0],'.k');

figure, contour(k_x,k_y,E_m2',[0 0],'.k');
hold on
contour(k_x,k_y,E_m',[0 0],'.k');
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