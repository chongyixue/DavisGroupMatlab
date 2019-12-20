function topo_rec_comp_hex_sum = simulate_hex_lattice(nr)


[X, Y] = meshgrid(-0:1:nr-1, -0:1:nr-1);

c = 0.5;

qx1 = 1*c;
qy1 = 0;

qx2 = 1/2*c;
qy2 = sqrt(3)/2*c;

qx3 = -1/2*c;
qy3 = sqrt(3)/2*c;

phase1 = qx1*X + qy1*Y;
phase2 = qx2*X + qy2*Y;
phase3 = qx3*X + qy3*Y;


a1 = 1;
a2 = 1;
a3 = 1;


[nx, ny, nz] = size(X);
f = zeros(nx, ny, 3);

f(:,:,1) = a1*cos(phase1);
f(:,:,2) = a2*cos(phase2);
f(:,:,3) = a3*cos(phase3);


topo_rec_comp.map = f;
topo_rec_comp.type = 0;
topo_rec_comp.ave = [];
topo_rec_comp.name = 'rec. topo ind. components';
topo_rec_comp.r = 0:1:nr-1;
topo_rec_comp.coord_type = 'r';
topo_rec_comp.e = 1:1:3;
topo_rec_comp.info = [];
topo_rec_comp.ops = '';
topo_rec_comp.var = 'simulation';

topo_rec_comp_hex_sum = topo_rec_comp;
topo_rec_comp_hex_sum.map = [];
topo_rec_comp_hex_sum.e = 1;
topo_rec_comp_hex_sum.name = 'sum of rec. topo ind. components';

topo_rec_comp_hex_sum.map(:,:,1) = f(:,:,1) + f(:,:,2) + f(:,:,3);

% for i=2:4
%     topo_rec_comp_hex_sum.map(:,:,i) =  f(:,:,i-1);
% end


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