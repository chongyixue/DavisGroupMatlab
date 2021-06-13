% 2020-4-8 YXC
% investigate simulating lattice by giving a few k-points

% input k1x,k1y,k2x,k2y,...
function topo = simulate_lattice_with_k(varargin)

points = nargin;
kpoints = zeros(floor(points/2),2);

for i=1:points
    if mod(i,2)==0
        ind = i/2;
        kpoints(ind,1)=varargin{i-1};
        kpoints(ind,2) = varargin{i};
    end
end



maxp = max(max(kpoints))*10;
if mod(maxp,2)==0
    maxp=maxp+1;
end
if mod(nargin,2)==1
    maxp = varargin{end};
    kpoints = kpoints - maxp/2;
end


[X, Y] = meshgrid(linspace(0,2*pi,maxp+1),linspace(0,2*pi,maxp+1));
% [X, Y] = meshgrid(-0:1:maxp-1, -0:1:maxp-1);
% figure,imagesc(cos(X))
% X = X/(maxp*2*pi);
[nx,ny,~] = size(X);
f = zeros(nx,ny,1);
% size(f)
for j=1:points/2
    kx = kpoints(j,1);
    ky = kpoints(j,2);
    f(:,:,1) = f(:,:,1) + cos(kx*X+squeeze(ky*Y));
end
% figure,imagesc(f)

topo.map = f;
topo.topo1=f;
topo.type = 2;
topo.ave = [0];
topo.name = 'lattice';
topo.r = 0:1:maxp;
topo.r = topo.r';
topo.coord_type = 'r';
topo.e = 0;
topo.info = [];
topo.ops = '';
topo.var = 'simulation';

% topo.info.w_factor = 1;
% topo.info.w_zero = 0;

img_obj_viewer_test(topo);

end



