%% test script for eigenvalues after unfolding 10 orbital model


% eigeps2Dss = fese_Hirschfeld_tb_5orbital(250, 0);

E_m = eigeps2Dss(:,:,4)*1000;

eps3 = 0.5;
A1 = ((E_m-1.5)'.^2) < eps3^2;
A2 = (E_m'.^2) < (eps3^2);
A3 = ((E_m+1.5)'.^2) < eps3^2;
A = A1+A2+A3;
A(A>1)=1;
figure(4), imagesc( A), colormap(gray),colormap(flipud(colormap));

% E_m = eigeps2Daa(:,:,4)*1000;
% 
% eps3 = 0.75;
% A1 = ((E_m-1.5)'.^2) < eps3^2;
% A2 = (E_m'.^2) < (eps3^2);
% A3 = ((E_m+1.5)'.^2) < eps3^2;
% A = A1+A2+A3;
% A(A>1)=1;
% figure(4), imagesc( A), colormap(gray),colormap(flipud(colormap));