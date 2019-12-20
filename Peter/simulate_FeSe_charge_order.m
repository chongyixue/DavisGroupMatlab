function [topo_rec_comp, topo_rec_comp_sum] = simulate_FeSe_charge_order(nr, ampllist)


[X, Y] = meshgrid(-nr:1:nr, -nr:1:nr);

qx1 = 0.1;
qy1 = 0;

qx2 = 0;
qy2 = 0.1;

qx3 = 0.1;
qy3 = 0.1;

qx4 = 0.1;
qy4 = -0.1;

qx5 = 0.2;
qy5 = 0;

qx6 = 0;
qy6 = 0.2;

qx7 = 0.2;
qy7 = 0.1;

qx8 = 0.2;
qy8 = -0.1;

qx9 = 0.1;
qy9 = 0.2;

qx10 = 0.1;
qy10 = -0.2;

qx11 = 0.2;
qy11 = 0.2;

qx12 = 0.2;
qy12 = -0.2;

phase1 = qx1*X + qy1*Y;
phase2 = qx2*X + qy2*Y;
phase3 = qx3*X + qy3*Y;
phase4 = qx4*X + qy4*Y;
phase5 = qx5*X + qy5*Y;
phase6 = qx6*X + qy6*Y;
phase7 = qx7*X + qy7*Y;
phase8 = qx8*X + qy8*Y;
phase9 = qx9*X + qy9*Y;
phase10 = qx10*X + qy10*Y;
phase11 = qx11*X + qy11*Y;
phase12 = qx12*X + qy12*Y;

a1 = ampllist(1);
a2 = ampllist(2);
a3 = ampllist(3);
a4 = ampllist(4);
a5 = ampllist(5);
a6 = ampllist(6);
a7 = ampllist(7);
a8 = ampllist(8);
a9 = ampllist(9);
a10 = ampllist(10);
a11 = ampllist(11);
a12 = ampllist(12);

[nx, ny, nz] = size(X);
f = zeros(nx, ny, 12);

f(:,:,1) = a1*cos(phase1);
f(:,:,2) = a2*cos(phase2);
f(:,:,3) = a3*cos(phase3);
f(:,:,4) = a4*cos(phase4);
f(:,:,5) = a5*cos(phase5);
f(:,:,6) = a6*cos(phase6);
f(:,:,7) = a7*cos(phase7);
f(:,:,8) = a8*cos(phase8);
f(:,:,9) = a9*cos(phase9);
f(:,:,10) = a10*cos(phase10);
f(:,:,11) = a11*cos(phase11);
f(:,:,12) = a12*cos(phase12);

topo_rec_comp.map = f;
topo_rec_comp.type = 0;
topo_rec_comp.ave = [];
topo_rec_comp.name = 'rec. topo ind. components';
topo_rec_comp.r = 1:1:nx;
topo_rec_comp.coord_type = 'r';
topo_rec_comp.e = 1:1:12;
topo_rec_comp.info = [];
topo_rec_comp.ops = '';
topo_rec_comp.var = 'simulation';

topo_rec_comp_sum = topo_rec_comp;
topo_rec_comp_sum.map = [];
topo_rec_comp_sum.e = 1:1:12;
topo_rec_comp_sum.name = 'sum of rec. topo ind. components';

topo_rec_comp_sum.map(:,:,1) = f(:,:,1) + f(:,:,2);

for i=2:11
    topo_rec_comp_sum.map(:,:,i) = topo_rec_comp_sum.map(:,:,i-1) + f(:,:,i+1);
end

topo_rec_comp_sum.map = cat(3, f(:,:, 1), topo_rec_comp_sum.map);

% oosim = f1+f2+f3;
% bosim = f1+f2-f3;
% 
% figure, imagesc(f1), axis equal
% 
% figure, imagesc(f1+f2), axis equal
% 
% figure, imagesc(f1+f2+f3), axis equal
% 
% figure, imagesc(f1+f2+f3+4), axis equal
% % 
% figure, imagesc(f1+f2+f3+f4+f5), axis equal
% 
% figure, imagesc(f1+f2+f3+f4+f5+f6), axis equal
% 
% figure, imagesc(f1+f2+f3+f4+f5+f6+f7), axis equal
% 
% figure, imagesc(f1+f2+f3+f4+f5+f6+f7+f8), axis equal
% 
% figure, imagesc(f1+f2+f3+f4+f5+f6+f7+f8+f9), axis equal


end