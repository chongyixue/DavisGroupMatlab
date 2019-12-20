%Function to create reference images sin(q.r) and cos(q.r) for two vectors
%qx qy centred at the origin

%UNITS FROM T.r

function ref = find_ref2(data)

%Set up Axis
[nrow,ncol] = size(data.map);
ref.distx = data.r([1:nrow]);
ref.disty = data.r([1:ncol]);
%cmap = open('C:\MATLAB\ColorMap\IDL_Colormap2.mat');
cmap = open('C:\Analysis Code\MATLAB\ColorMap\IDL_Colormap3.mat');


%FT of image
n = nrow;
[k f] = fourier_block(data.map,nrow,'sine');
fshift = fftshift(f);
k0 = 2*pi/(max(data.r)-min(data.r));
k = linspace(-k0*(n/2+1),k0*(n/2-1),n);
ref.k = k;



%Plot FT
figure; pcolor(k,k,abs(fshift)); shading flat; colormap(cmap.Defect1); axis equal;

% zm = input('zoom = ');
zm = 3;
zoom (zm);

%Recored Points
disp('Click on X Bragg Peak');[xi,yi] = ginput(1); % Find qx end 
disp('Click on Y Bragg Peak');[xii,yii] = ginput(1); %Find qy end
zoom(zm+1);
disp('Click on Centre Point');[xiii,yiii] = ginput(1);  %Centre
ref.qx = [xi,yi]' - [xiii,yiii]';% Qx
ref.qy = [xii,yii]'-[xiii,yiii]';% Qy

[X Y] = meshgrid(ref.disty,ref.distx);

% % qx and qy reference functions
ref.sinex= sin(xi*X + yi*Y); ref.cosinex= cos(xi*X + yi*Y);
ref.siney= sin(xii*X + yii*Y); ref.cosiney = cos(xii*X + yii*Y);



% %Plots of ref images
figure ; pcolor(ref.sinex); shading flat; colormap(cmap.Invgray); title('Sine x Ref Image');
figure ; pcolor(ref.cosinex); shading flat; colormap(cmap.Invgray); title('Cos x Ref image');
figure ; pcolor(ref.siney); shading flat; colormap(cmap.Invgray); title('Sine y Ref Image');
figure ; pcolor(ref.cosiney); shading flat; colormap(cmap.Invgray); title('Cos y Ref image');



end