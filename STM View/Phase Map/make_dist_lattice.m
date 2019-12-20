function [lattice, lat_pt] = make_dist_lattice
 q1x = [1 0]; q1x = q1x/(norm(q1x));
 q1y = [0 1]; q1y = q1y/(norm(q1y));

theta = pi/4;
theta = 0;
rot_mat = [cos(theta) -sin(theta); sin(theta) cos(theta)];

%Number of atoms + Pixels
lattice_nx = 35;
lattice_ny= 35;
res = 15;
pxl_n = lattice_nx*res;
sigma = res/3;
d = 1/lattice_nx;

if theta == 0
    alpha = 1;
else
    % set an expanded range coefficient which accounts for rotation angle
    %formula follows from setting making angled lattice large enough so as
    %to be able to extract a square region dimension
    %equivalent to lattice_nx. (just uses pythagoras)
    alpha = (cos(theta) + sin(theta))/(sin(theta)*cos(theta));
    alpha = alpha*1.5; % extra padding of generated points
end

%generate lattice points and store in a nxnx2 grid
for i = 0:alpha*lattice_nx+1    
    for j = 0:alpha*lattice_ny+1
        lat_pt(i+1,j+1,:) = res*((i)*q1x + (j)*q1y);
    end
end
%set the lattice centered at (0,0)
lat_pt(:,:,1) = lat_pt(:,:,1) - alpha*pxl_n/2;
lat_pt(:,:,2) = lat_pt(:,:,2) - alpha*pxl_n/2;

%rotate the coordinates
for i = 1:(alpha*(lattice_nx))+1
    for j= 1:(alpha*(lattice_ny))+1
        x0 = [lat_pt(i,j,2) lat_pt(i,j,1)];
        xx0 = rot_mat*x0';
        lat_pt(i,j,2) = xx0(1); lat_pt(i,j,1) = xx0(2);
    end
end

% figure; 
% for i = 1:alpha*(lattice_nx)+1
%     for j= 1:alpha*(lattice_ny)+1
%         if i ==1 && j==1
%             plot(lat_pt(i,j,1),lat_pt(i,j,2),'rx');
%         else
%             plot(lat_pt(i,j,1),lat_pt(i,j,2),'x');
%         end
%         hold on;
%     end
% end

A = lat_pt(:,:,1) >= -(pxl_n/2+res/2) & lat_pt(:,:,1) <= pxl_n/2+res/2 & lat_pt(:,:,2) >= - (pxl_n/2+res/2) & lat_pt(:,:,2) <= pxl_n/2 +res/2;
tmp = (lat_pt(:,:,1));
r = tmp(A);
tmp = (lat_pt(:,:,2)); 
c = tmp(A);
figure;
plot(r,c,'o');
%reposition to put corner at (0,0)
round_r = round(10000*r)/10000;
min_r = min(round_r);
A = (round_r == min_r);
c(A)
min_c = min(c(A))
r = r - min_r;
c = c - min_c;


%Set up Lattice
alpha = 1;
x = linspace(0,pxl_n,pxl_n); 
y = x;
[xx,yy] = meshgrid(x,y);
lattice.map=zeros(pxl_n,pxl_n);


%Create Drift Terms

driftx = 1:lattice_nx+10;
driftx = driftx.^2/((lattice_nx+10)^2);
%figure; plot(driftx);
driftxx = zeros(lattice_nx);

drifty = 1:lattice_nx+10;
drifty = (-drifty.^2+drifty.^4/((lattice_nx)^2))/(((lattice_nx)^3)/10);
%figure; plot(drifty,'r');
driftyy = zeros(lattice_ny);



% Generate lattice from gaussians
nx = 0.0; ny = 0;
% figure;
% for j = 1:lattice_nx+1
%     for k = 1:lattice_ny+1
%        %center point for each atomic site
%        %x0 = [j*d + nx*driftx(j+2), k*d + ny*drifty(j+2)];
%        x0 = [lat_pt2(j,k,1), lat_pt2(j,k,2)];
%        plot(lat_pt2(j,k,1),lat_pt2(j,k,2),'rx'); hold on;     
%        lattice.map = lattice.map + Gaussian2D_v2(xx,yy,sigma,x0,1);             
%       
%        %driftxx(j+2,k+2) = driftx(j+2);
%        %driftyy(j+2,k+2) = drifty(j+2);
%     end
% end
figure;
for i =1: length(r)
    x0 = [r(i) c(i)];
    plot(r(i),c(i),'rx'); hold on;
    lattice.map = lattice.map + Gaussian2D_v2(xx,yy,sigma,x0,1);  
end


img_plot2(lattice.map);
% 
% lattice.r = (linspace(0,lattice_nx,pxl_n))';

f=fft2(lattice.map-mean(lattice.map(:)));
f=fftshift(f);
f=abs(f);

img_plot2(f);
% shading flat
% colorbar
% load_color;
% colormap(Cmap.Defect1);
%caxis([0 1e4])
end