%Fourier Filter using a gaussian filter

function fft = fourierfilter_in2(data,r,zm,window);


cmap = open('C:\MATLAB\ColorMap\IDL_Colormap2.mat');

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
k = linspace(-k0*(n/2),k0*(n/2),n);



figure; pcolor(k,k,fft.abs); shading flat; axis equal
% zoom(zm)
% [xii,yii] = ginput(1);
% [nr,nc] = size(fft.abs);
xii = (nc+1)/2;
yii = (nr+1)/2;



% fft.z1 = ifft2((fft.oz.*ifftshift(fft.filter))); %Create reference image z
% fft.z = real(fft.z1);
FTTopo = fourier_tr2d(data,'',0,'');
ret = customgauss([nr,nc], r, r, 0, 0, 1, [0,0]);
FTgauss = fourier_tr2d(ret,'',0,'');
figure; pcolor(ret); shading flat; axis equal
 f1 =ret.*FTTopo;
 fft.z = (ifft2(ifftshift(f1)));
fft.z1 = real(fft.z);




end