% YXC 2019-10-12
% BST - alloying of BS. Assume layer by layer growth

% first layer random with probability of Bi at each site = p0
% subsequent layers: p>p0 for Sb sites and p<p0 for Bi sites
% N = nx*ny = total sites
% N*p is constant for all layers
% total 

p0 = 0.2;
p_inc = 0.6;
nx = 300;
ny = nx;
layers = 100;
Np = nx*ny*p0;
n = 3;
radius_average = 11;

clear BSTmap
BSTmap.map = ones(nx,ny,layers);
BSTmap.type = 0;
BSTmap.ave = zeros(layers,1);
BSTmap.name = 'BSTalloy';
BSTmap.r = ones(1,nx);
BSTmap.coord_type = 'r';
BSTmap.e = linspace(1,layers,layers)/1000;
BSTmap.ops = '';
BSTmap.var = 'G';


delp = linspace(-0.2,0.8,100);
BSTmap.map = ones(nx,ny,length(delp));

BSTmap.ave = zeros(length(delp),1);
BSTmap.e = delp/1000;
for i = 1:length(delp)
    p_inc = delp(i);
    BiMask = double(rand(nx,ny)<p0);
    % BSTmap.map(:,:,1) = double(rand(nx,ny)<p0);
    NB = sum(sum(BSTmap.map(:,:,1)));
    pnew = p0+p_inc;
    for lay = 2:layers
        %     BiMask = BSTmap.map(:,:,lay-1);
        
        %     BiMask = averagedmask(BiMask,radius_average);
        
        
        NB = sum(sum(BiMask));
        NS = nx*ny-NB;
        q_inc = NB*p_inc/NS;
        qnew = p0-q_inc;
        pmask = BiMask*pnew + (1-BiMask)*(qnew);
        
        BiMask = double(rand(nx,ny)<pmask);
        %     BSTmap.map(:,:,lay) = double(rand(nx,ny)<pmask);
    end
    BSTmap.map(:,:,i) = BiMask;
end


    
% lastnlayers = sum(BSTmap.map(:,:,end-n+1:end),3);
% BSTmap.map(:,:,1) = lastnlayers;

img_obj_viewer_test(BSTmap)


function blurred = averagedmask(matrix,pixels)
% in = sum(sum(matrix))
[nx,ny] = size(matrix);
blurred=matrix;
for x = pixels+1:nx-pixels
    for y = pixels+1:ny-pixels
        blurred(x,y) = sum(sum(matrix(x-pixels:x+pixels,y-pixels:y+pixels)))/((pixels*2+1)^2);
    end
end

% out = sum(sum(blurred))
end





