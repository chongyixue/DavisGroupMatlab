%Function to create reference images sin(q.r) and cos(q.r) for two vectors
%qx qy centred at the origin

%UNITS IN PIXELS

function ref = find_ref3(data);

%Set up Axis
[nrow,ncol] = size(data.map);
ref.disty=[1:nrow];
ref.distx=[1:ncol];

ref.con = nrow/max(data.r);

cmap = open('C:\MATLAB\ColorMap\IDL_Colormap2.mat');

% fft = fourier_tr2d(data,'sine',0,'');
n = nrow;
[k f] = fourier_block(data.map,nrow,'sine');
fshift = fftshift(f);
k0 = 2*pi/(nrow);
k = linspace(-k0*(n/2+1),k0*(n/2-1),n);
ref.k = k;
figure; pcolor(k,k,abs(fshift)); shading flat; colormap(cmap.Defect1); axis off; axis equal;

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




[X Y] = meshgrid(1:nrow,1:ncol);

% q1 and q2 reference functions
ref.sinex= sin(xi*X + yi*Y); ref.cosinex= cos(xi*X + yi*Y);
ref.siney= sin(xii*X + yii*Y); ref.cosiney = cos(xii*X + yii*Y);




% %Plots
figure ; pcolor(ref.distx', ref.disty ,ref.sinex); shading flat; colormap(cmap.Invgray); title('Sine x Ref Image');
figure ; pcolor(ref.distx', ref.disty ,ref.cosinex); shading flat; colormap(cmap.Invgray); title('Cos x Ref image');
figure ; pcolor(ref.distx', ref.disty ,ref.siney); shading flat; colormap(cmap.Invgray); title('Sine y Ref Image');
figure ; pcolor(ref.distx', ref.disty ,ref.cosiney); shading flat; colormap(cmap.Invgray); title('Cos y Ref image');



end