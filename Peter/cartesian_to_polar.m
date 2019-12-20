function polar_data = cartesian_to_polar(data)
%assume zero of coordinate system is at the center
polar_data = data;
if isstruct(data) % check if data is a full data structure
    [nr,nc,nz]=size(data.map);
    tmp_data = data.map;    
else % single data image
    [nr,nc,nz] = size(data);
    tmp_data = data;
end
%set X,Y, theta, and r based on first layer (all other layers have the same
%coordinate system);
M = tmp_data(:,:,1);
[Y X z]=find(M);
 X0=nc/2; Y0=nr/2;
 X=X-X0; Y=Y-Y0;
 theta = atan2(Y,X);
 rho = sqrt(X.^2+Y.^2);
 
 % Determine the minimum and the maximum x and y values:
 rmin = min(rho); tmin = min(theta);
 rmax = max(rho); tmax = max(theta);

 % Define the resolution of the grid:
 rres=nr; % # of grid points for R coordinate. (change to needed binning)
 tres=nc; % # of grid points for theta coordinate (change to needed binning)
 polar_map = zeros(rres,tres,nz);
 %coordinates for interpolated polar coordiantes
 [rhoi,thetai] = meshgrid(linspace(rmin,rmax,rres),linspace(tmin,tmax,tres));
 
for i = 1:nz
    M = tmp_data(:,:,i);
    [Y X z]=find(M);
    F = TriScatteredInterp(rho,theta,z,'natural');
    %Evaluate the interpolant at the locations (rhoi, thetai).
    %The corresponding value at these locations is Zinterp: 
    Zinterp = F(rhoi,thetai);
    polar_map(:,:,i) = Zinterp;
    
end

if isstruct(data)
    polar_data.map = polar_map;
    polar_data.r = 1:rres;
    polar_data.rhoi = rhoi;
    polar_data.thetai = thetai;
    polar_data.var = [polar_data.var '_polar'];
    polar_data.ops{end+1} = ['polar conversion'];
    img_obj_viewer2(polar_data);
else
    polar_data = polar_map;
end
end