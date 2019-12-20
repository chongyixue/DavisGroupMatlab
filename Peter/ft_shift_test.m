%% test FT shift ( real and imaginary parts)

clear nx ny X Y xdata
nx = 100;
ny = 100;

cx = (nx-1)/2 + 1;
cy = (ny-1)/2 + 1;

%% Create meshgrid for fit-function
[X,Y]=meshgrid(1:1:nx,1:1:ny,1);

xdata(:,:,1)=X;
xdata(:,:,2)=Y;
%% Starting guess for the following fit function
% calculate the center of intensity / mass com coordinates
% 
% cx = 1;
% cy = 1;

gx = 75.9;
gy = 45.1;
sx = gx - cx;
sy = gy - cy;

x0 = [1; gx; 5; gy; 5; 0; 0];


finalfit=twodgauss(x0,xdata);
figure, imagesc(finalfit)
axis image


finalfit = ifftshift(finalfit);
figure, imagesc(finalfit)
axis image
% 
% finalfit=twodgauss(x0,xdata);
% figure, imagesc(finalfit)
% axis image
% 
% finalfit = fftshift(finalfit);
% figure, imagesc(finalfit)
% axis image


fft_finalfit = ( fourier_transform2d_vb(finalfit,'none','complex','ft') );

figure, imagesc(real(fft_finalfit))
axis image

figure, imagesc(imag(fft_finalfit))
axis image

figure, imagesc(ifftshift(real(fft_finalfit)))
axis image

figure, imagesc(ifftshift(imag(fft_finalfit)))
axis image

% testx = exp(1i*2*pi*sx/nx*(X-cx));
% testy = exp(1i*2*pi*sy/ny*(Y-cy));

testx = exp(1i*2*pi*sx/nx*(X-cx));
testy = exp(1i*2*pi*sy/ny*(Y-cx));

fft_finalfit = (fft_finalfit) .* testx .* testy;

figure, imagesc(real(fft_finalfit))
axis image

figure, imagesc(imag(fft_finalfit))
axis image


ifft_finalfit = fourier_transform2d_vb(fft_finalfit,'none','real','ift');

figure, imagesc( ( ifft_finalfit ) )
axis image
figure, imagesc( fftshift( ifft_finalfit ) )
axis image

%%

tdata = obj_60701A00_T;
gdata = obj_60701a00_G;

% energies of map
ev = gdata.e;
le = length(ev);

% Find the energy layer corresponding to the chemical potential if the
% number of layers is odd, or corresponding to the layer closest to the
% chemical potential in the case of an even number of layers
if mod(le, 2) == 0
    zlayer = le - le/2;
else
    for j = 1:le
        if ev(j) == 0
            zlayer = j;
        end
    end
    zlayer = zlayer - 1;
end

for i=1:zlayer
    me(i) = ev(i);
    pe(i) = ev(le+1-i);
end

gdata=polyn_subtract2(gdata,0);

topo = tdata.map(12:121, 12:121, 1);
map = gdata.map(12:121, 12:121, :);

[nx, ny, nz] = size(map);


%%
cm1 = double(circlematrix([nx,ny],4,69,55));
pn1 = sum(sum(cm1));
cmr1 = repmat(cm1, 1, 1, zlayer);

cm2 = double(circlematrix([nx,ny],4,56,43));
pn2 = sum(sum(cm2));
cmr2 = repmat(cm2, 1, 1, zlayer);
%%

cx = nx/2 + 1;
cy = ny/2 + 1;

clear X Y xdata
%% Create meshgrid for fit-function
[X,Y]=meshgrid(1:1:nx,1:1:ny,1);

xdata(:,:,1)=X;
xdata(:,:,2)=Y;
%% Starting guess for the following fit function
% calculate the center of intensity / mass com coordinates

gx = 54;
gy = 59;
sx = gx - cx;
sy = gy - cy;

testx = exp(1i*2*pi*sx/nx*(X-cx));
testy = exp(1i*2*pi*sy/ny*(Y-cy));


topo = ifftshift(topo);
figure, imagesc(topo)
axis image

topoft = ( fourier_transform2d_vb(topo,'none','complex','ft') );

figure, imagesc(real(topoft))
axis image

figure, imagesc(imag(topoft))
axis image


testx = exp(1i*2*pi*sx/nx*(X-cx));
testy = exp(1i*2*pi*sy/ny*(Y-cy));


topoft = (topoft) .* testx .* testy;

figure, imagesc(real(topoft))
axis image

figure, imagesc(imag(topoft))
axis image

realft = zeros(nx, ny, nz);
imagft = zeros(nx, ny, nz);

for i=1:nz
   dmap = ifftshift(map(:,:,i));
   dmapft = ( fourier_transform2d_vb(dmap,'sine','complex','ft') );
   dmapft = (dmapft) .* testx .* testy;
   realft(:,:,i) = real(dmapft);
   imagft(:,:,i) = imag(dmapft);
end

obj_60701a00_G_FT_real = obj_60701a00_G;
obj_60701a00_G_FT_real.map = realft;

obj_60701a00_G_FT_imaginary = obj_60701a00_G;
obj_60701a00_G_FT_imaginary.map = imagft;


symrealmap = zeros(nx, ny, zlayer);
asymrealmap = zeros(nx, ny, zlayer);
symimagmap = zeros(nx, ny, zlayer);
asymimagmap = zeros(nx, ny, zlayer);

for i=1:zlayer
    symrealmap(:,:,i) = realft(:,:,le+1-i) + realft(:,:,i);
    asymrealmap(:,:,i) = realft(:,:,le+1-i) - realft(:,:,i);
    symimagmap(:,:,i) = imagft(:,:,le+1-i) + imagft(:,:,i);
    asymimagmap(:,:,i) = imagft(:,:,le+1-i) - imagft(:,:,i);
end

obj_60701a00_G_FT_symreal = obj_60701a00_G;
obj_60701a00_G_FT_symreal.map = symrealmap;

obj_60701a00_G_FT_symimaginary = obj_60701a00_G;
obj_60701a00_G_FT_symimaginary.map = symimagmap;

obj_60701a00_G_FT_asymreal = obj_60701a00_G;
obj_60701a00_G_FT_asymreal.map = asymrealmap;

obj_60701a00_G_FT_asymimaginary = obj_60701a00_G;
obj_60701a00_G_FT_asymimaginary.map = asymimagmap;



%% calculate the individual average intensity for the individual q-vectors
%% inside the area defined through the circular masks
arp1 = squeeze(sum ( sum ( asymrealmap .* (cmr1) ) ) / pn1);

arp2 = squeeze(sum ( sum ( asymrealmap .* (cmr2) ) ) / pn2);

aip1 = squeeze(sum ( sum ( asymimagmap .* (cmr1) ) ) / pn1);

aip2 = squeeze(sum ( sum ( asymimagmap .* (cmr2) ) ) / pn2);




pe = abs(pe)*1000;

figure, plot(pe, arp1,'-o','color','r', 'LineWidth', 2, 'MarkerSize', 15);
title('Anti-Symmetrized real part of FT of conductance pi zero');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

figure, plot(pe, arp2,'-o','color','b', 'LineWidth', 2, 'MarkerSize', 15);
title('Anti-Symmetrized real part of FT of conductance zero pi');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

figure, plot(pe, aip1,'-o','color','r', 'LineWidth', 2, 'MarkerSize', 15);
title('Anti-Symmetrized imaginary part of FT of conductance pi zero');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

figure, plot(pe, aip2,'-o','color','b', 'LineWidth', 2, 'MarkerSize', 15);
title('Anti-Symmetrized imaginary part of FT of conductance zero pi');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on