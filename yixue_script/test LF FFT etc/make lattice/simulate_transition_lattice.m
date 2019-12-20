function topo_rec_comp_tet_sum = simulate_transition_lattice(nr,ax,ay,angle,varargin)

%change angle to radians
anglename = num2str(angle);
angledegree = angle;
angle = angle*pi/180;

%defining geometry in k-space
%parallelogram of sides ax, ay skewed to angle angle.
p = ay*cos(angle);
q = ax*cos(angle);
angle2 = atan((ax-ay*sin(angle))/p);
r = ay*sin(angle+angle2);
k1x = 0;
k1y = 1/p;
k2x = cos(angle2)/r;
k2y = sin(angle2)/r;
k3x = cos(angle)/q;
k3y = -sin(angle)/q;

k1 = (k1x^2 + k1y^2)^0.5;
k2 = (k2x^2 + k2y^2)^0.5;
k3 = (k3x^2 + k3y^2)^0.5;


[X, Y] = meshgrid(-0:1:nr-1, -0:1:nr-1);

% c = 0.5;
%
% qx1 = 1*c;
% qy1 = 0;
%
% qx2 = 0;
% qy2 = 1*c;
%
%
% phase1 = qx1*X + qy1*Y;
% phase2 = qx2*X + qy2*Y;



a1 = 1;
a2 = (sin(angledegree*pi/60))^2;%very arbitrarily assign 3rd Bragg peak such that it disappear in tetragonal
a3 = 1;

[nx, ny, nz] = size(X);
f = zeros(nx, ny, 3);

f(:,:,1) = a1*cos(k1x*X+k1y*Y);
f(:,:,2) = a3*cos(k3x*X+k3y*Y);
f(:,:,3) = a2*cos(k2x*X+k2y*Y);

% f(:,:,2) = a2*cos(phase2);% cos(y)
% f(:,:,3) = a3*cos(phase2);%cos(x)*cos(y)
% f(:,:,3) = a3*cos(phase1).*cos(phase2);%cos(x)*cos(y)

topo_rec_comp.map = f;
topo_rec_comp.type = 0;
topo_rec_comp.ave = [];
topo_rec_comp.name = strcat('transition',anglename);
topo_rec_comp.r = 0:1:nr-1;
topo_rec_comp.coord_type = 'r';
topo_rec_comp.e = 1:1:2;
topo_rec_comp.info = [];
topo_rec_comp.ops = '';
topo_rec_comp.var = 'simulation';

topo_rec_comp_tet_sum = topo_rec_comp;
topo_rec_comp_tet_sum.map = [];
topo_rec_comp_tet_sum.e = 1;
topo_rec_comp_tet_sum.name =strcat('transition',anglename);

topo_rec_comp_tet_sum.map(:,:,1) = f(:,:,1) + f(:,:,2) +f(:,:,3);
% topo_rec_comp_tet_sum.map(:,:,1) = f(:,:,1) + f(:,:,2)%+f(:,:,3);
% topo_rec_comp_tet_sum.map(:,:,1) = f(:,:,3);

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
if nargin < 5
    img_obj_viewer_yxc(topo_rec_comp_tet_sum)
end



end