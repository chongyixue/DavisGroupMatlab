function topo_rec_comp_tet_sum = simulate_pseudo_tetragonal_lattice_kspace(nr,varargin)

%force odd pixels
if mod(nr,2)==0 
    nr = nr + 1;
end
    
[X, Y] = meshgrid(-0:1:nr-1, -0:1:nr-1);
center = (nr+1)/2;
away = floor(nr/10);


if nargin > 1
    
    x1 = center + away;%right up
    y1 = center + away;
    x2 = center - away;%left up
    y2 = center + away;
    x3 = center - away;%left down
    y3 = center - away;
    x4 = center + away;%down right
    y4 = center - away;
    
else
     
    x1 = center + away;%right
    y1 = center;
    x2 = center;%up
    y2 = center + away;
    x3 = center - away;%left
    y3 = center;
    x4 = center;%down
    y4 = center - away;
end

[nx, ny, nz] = size(X);
f = zeros(nx, ny, 1);

f(:,:,1) = 0;
f(x1,y1,1) = 1;
f(x2,y2,1) = 1;
f(x3,y3,1) = 1;
f(x4,y4,1) = 1;


topo_rec_comp.map = f;
topo_rec_comp.type = 0;
topo_rec_comp.ave = [];
topo_rec_comp.name = 'k_space';
topo_rec_comp.r = 0:1:nr-1;
topo_rec_comp.coord_type = 'r';
topo_rec_comp.e = 1:1:2;
topo_rec_comp.info = [];
topo_rec_comp.ops = '';
topo_rec_comp.var = 'simulation';

topo_rec_comp_tet_sum = topo_rec_comp;
topo_rec_comp_tet_sum.map = [];
topo_rec_comp_tet_sum.e = 1;
topo_rec_comp_tet_sum.name = 'sum of rec. topo ind. components';

topo_rec_comp_tet_sum.map(:,:,1) = f(:,:,1);


% for i=2:3
%     topo_rec_comp_tet_sum.map(:,:,i) =  f(:,:,i-1);
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