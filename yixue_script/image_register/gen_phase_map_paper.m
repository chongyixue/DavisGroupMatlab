%calculates phase map
%currently for a single layer
%%%data object
data = lat;
%%% Pixel coordinates of desired Q-peak
Qx_px = 262;
Qy_px = 250;
%%% pixel width in real space to average over
sig = 5;

[nr, nc] = size(data.map);
r = data.r;
[rx,ry] = meshgrid(r,r);
px_dim = abs(r(1)-r(2));
%define q-space
q0=2*pi/(nc*px_dim);
if mod(nc,2) == 1
    q=linspace(-q0*nc/2,q0*nc/2,nc);
else
    q = linspace(0,q0*nc/2,nc/2+1);
    q = [-1*q(end:-1:1) q(2:end-1)];    
end
%get Qx,Qy in terms of q from pixel coordinates
if mod(nr,2) == 0
    Qx = q(Qx_px) - q((nr/2)+1); % fix k value offsets
    Qy = q(Qy_px) - q((nr/2)+1); % fix k value offsets
else   
    Qx = q(Qx_px);
    Qy = q(Qy_px);
end

%get locked in images
phase = Qx.*rx + Qy.*ry;
AQ_real_lockedin = data.map.*cos(phase);
AQ_imag_lockedin = data.map.*sin(phase);


%Fourier filter with the given sig
filt = Gaussian2D(1:nr,1:nc,sig,sig,0,[nr/2+1 nc/2+1],1);

%remember that ft of gaussian is a gaussian
AQ_real = ifft2(ifftshift(fftshift(fft2(AQ_real_lockedin)).*filt));
AQ_imag = ifft2(ifftshift(fftshift(fft2(AQ_imag_lockedin)).*filt));


AQ_amp = abs(AQ_real+1i*AQ_imag);

AQ_phase = atan2(real(AQ_imag),real(AQ_real));
figure,imagesc(AQ_phase);title('here')
AQ_wave_phase = mod(phase+AQ_phase,2*pi);
figure
imagesc(AQ_amp);axis square; colormap(gca,'gray')
figure
imagesc(AQ_wave_phase);axis square; colormap(gca,hsv)

