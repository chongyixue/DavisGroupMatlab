function [lattice] = make_dist_lattice_v2
lattice = []; lat_pt = [];
 q1x = [1 0]; q1x = q1x/(norm(q1x));
 q1y = [0 1]; q1y = q1y/(norm(q1y));

theta = pi/2;
theta = 0;
rot_mat = [cos(theta) -sin(theta); sin(theta) cos(theta)];

%Number of atoms + Pixels
lattice_nx = 25;
lattice_ny= 25;
res = 10; % pixels/unit cell for unrotated lattice
pxl_n = lattice_nx*res;
sigma = res;
d = 1/lattice_nx;

if ~mod(theta,pi/2)
    alpha = 1;
else
    % Set an expanded range coefficient which accounts for rotation angle
    % Formula follows from setting making angled lattice large enough so as
    %to be able to extract a square region dimension
    %equivalent to lattice_nx. (just uses pythagoras)   
    alpha = (cos(theta) + sin(theta));
    alpha = alpha*1.2; % extra padding of generated points
end

%generate lattice points with zero degrees rotation
% and store in a nxnx2 grid
for i = 0:alpha*(lattice_nx)
    for j = 0:alpha*(lattice_ny)
        lat_pt(i+1,j+1,:) = res*((i)*q1x + (j)*q1y);
    end
end

%set the lattice centered at (0,0)
max_pxl_x = max(max(lat_pt(:,:,1)));
max_pxl_y = max(max(lat_pt(:,:,2)));
lat_pt(:,:,1) = lat_pt(:,:,1) - max_pxl_x/2;
lat_pt(:,:,2) = lat_pt(:,:,2) - max_pxl_y/2;

%rotate the coordinates by theta degrees
[nr nc nz] = size(lat_pt);
for i = 1:nr
    for j= 1:nc
        x0 = [lat_pt(i,j,2) lat_pt(i,j,1)];
        xx0 = rot_mat*x0';
        lat_pt(i,j,2) = xx0(1); lat_pt(i,j,1) = xx0(2);
    end
end

figure; 
for i = 1:alpha*(lattice_nx)+1
    for j= 1:alpha*(lattice_ny)+1
        if i ==1 && j==1
            plot(lat_pt(i,j,1),lat_pt(i,j,2),'rx');
        else
            plot(lat_pt(i,j,1),lat_pt(i,j,2),'x');
        end
        hold on;
    end
end

%Set up Lattice

min_x = min(min(lat_pt(:,:,1)));
max_x = max(max(lat_pt(:,:,1)));
min_y = min(min(lat_pt(:,:,2)));
max_y = max(max(lat_pt(:,:,2)));
 x = linspace(min_x,max_x,round(alpha*max_pxl_x)); 
 y = linspace(min_y,max_y,round(alpha*max_pxl_y)); 
% y = x;
[xx,yy] = meshgrid(x,y);
ext_lattice = zeros(round(alpha*max_pxl_x),round(alpha*max_pxl_y));
% 
% 
% %Create Drift Terms
% 
% Generate lattice from gaussians
nx = 0.0; ny = 0;
figure;
for j = 1:nr
    for k = 1:nc
       %center point for each atomic site      
       x0 = round([lat_pt(j,k,1), lat_pt(j,k,2)]);
       %plot(lat_pt(j,k,1),lat_pt(j,k,2),'rx'); hold on;     
       ext_lattice = ext_lattice + Gaussian2D_v2(xx,yy,sigma,x0,1);                         
       
    end
end
img_plot2(ext_lattice);

%[r c]  = find(xx >= -(pxl_n/2+res/2) & xx <= pxl_n/2+res/2 & yy >= - (pxl_n/2+res/2) & yy <= pxl_n/2 +res/2);
[r c]  = find(xx >= -(pxl_n/2) & xx <= pxl_n/2 & yy >= - (pxl_n/2) & yy <= pxl_n/2);
min_r = min(r);
min_c = min(c);
max_r = max(r);
max_c = max(c);

%lat_map = zeros(abs(max_r - min_r)+1, abs(max_c-min_c)+1);
lat_map = ext_lattice(min_r:max_r,min_c:max_c);

img_plot2(lat_map);
lattice  = lat_map;

%r = tmp(A);
%5tmp = (lat_pt(:,:,2)); 
%c = tmp(A);
%figure;
%plot(r,c,'o');
% 
% %reposition to put corner at (0,0)
% round_r = round(10000*r)/10000;
% min_r = min(round_r);
% A = (round_r == min_r);
% c(A)
% min_c = min(c(A))
% r = r - min_r;
% c = c - min_c;


% 
% lattice.r = (linspace(0,lattice_nx,pxl_n))';

f=fft2(lat_map - mean(mean(lat_map)));
f=fftshift(f);
f=abs(f);
% 
 img_plot2(f);
% shading flat
% colorbar
% load_color;
% colormap(Cmap.Defect1);
%caxis([0 1e4])
end