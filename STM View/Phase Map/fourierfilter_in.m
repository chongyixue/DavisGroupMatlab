%Function to take fourier filter of data


function fft = fourierfilter_in(data,r,zm,window)


%cmap = open('C:\MATLAB\ColorMap\IDL_Colormap2.mat');
cmap = open('C:\Analysis Code\MATLAB\ColorMap\IDL_Colormap3.mat');
[nr,nc,nz]=size(data);

switch window
    case 'none'   
        z = 1;
    case 'sine'
        x = linspace(0,pi,nc);
        y = linspace(0,pi,nr);
        z = sin(x)'*sin(y);
    case 'kaiser'
        w = kaiser(nc,6);
        z = w*w';
    case 'gauss'
        w = gausswin(nc);
        z = w*w';
    case 'blackmanharris'
        w = blackmanharris(nc);
        z = w*w';
    otherwise
        z = 1;
end
%apply filter
filt = zeros(nr,nc,nz); %windowed data
ff = zeros(nr,nc,nz); % fourier transformed data (real and imaginary)
f = zeros(nr,nc,nz); % one of real/imaginary/amplitude/phase of FT
for k=1:nz
    filt(:,:,k) = data(:,:,k).*z;
end


        for k=1:nz 
            ff(:,:,k) = fftshift(fft2(filt(:,:,k)));  
        end


%Fourier filter Lattice
fft.org = data; %Original image
fft.oz = ifftshift(ff); %fft2 matrix at origin
fft.cz = ff; % fft2 matrix at centre
fft.real = real(ff(:,:,k)); %Real part of transform 
fft.imag = imag(ff); %Imaginary part of transform
fft.abs = abs(ff); %Absolute value of transform
fft.s = size (fft.abs); % Size of absolute transform matrix 
n = fft.s(1); %Matrix Sizee
k0 = 2*pi/n; 
k = linspace(-k0*(n/2+1),k0*(n/2-1),n);



figure; pcolor(fft.abs); shading flat; axis equal
zoom(zm)
% [xii,yii] = ginput(1);
[nr,nc] = size(fft.abs);

xii = (nr+1)/2;
yii = (nr+1)/2;


[cy,cx]=ndgrid(-yii+1:n-yii,-xii+1:n-xii); %Circle of points
% [cy,cx]=ndgrid(-yi+1:n-yi,-xi+1:n-xi); %Circle of points
cx=abs(cx);cy=abs(cy); 
distance=(cx.^2+cy.^2).^0.5; %set distance from point

fft.filter = zeros(nr,nc,nz);
fft.filter(distance<=r)=1;

% fft.z1 = ifft2((fft.oz.*ifftshift(fft.filter))); %Create reference image z
% fft.z = real(fft.z1);
figure; pcolor(k,k,fft.filter); shading flat; axis equal
 f1 = fft.filter.*ff;
 fft.z = (ifft2(ifftshift(f1)));
 fft.z1 = real(fft.z);




end