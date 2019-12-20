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

figure(1), clf

C = contour(k_x,k_y,E_eps,[0 0],'k','LineWidth',1);
C_eps = contourc(k_x,k_y,E_eps, [0,0]);
hold on
C = contour(k_x,k_y,E_alpha,[0 0],'k','LineWidth',1);
C_gam = contourc(k_x,k_y,E_alpha,[0 0]);
hold off
% axis equal
axis tight

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