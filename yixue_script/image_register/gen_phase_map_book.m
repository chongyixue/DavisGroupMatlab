%calculates phase map
%currently for a single layer
%%%data object
data = nb30;
%%% Pixel coordinates of desired Q-peak
Qx_px = 253;
Qy_px = 236;
%%% pixel width in real space to average over
sig = 3;

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
%craete filter
filt = Gaussian2D(1:nr,1:nc,sig,sig,0,[Qx_px, Qy_px],1);
%get Aq
Aq = fftshift(fft2(data.map));
%filtered Aq
filt_Aq = Aq.*filt;
%filtered Ar
filt_Ar = ifft2(ifftshift(filt_Aq));

%get locked in images
phase = Qx.*rx + Qy.*ry;

%Fourier filter with the given sig
AQ_real = cos(phase).*filt_Ar;
AQ_imag = sin(phase).*filt_Ar;

%remember that ft of gaussian is a gaussian
AQ_amp = abs(AQ_real+1i*AQ_imag);
AQ_phase = atan2(real(AQ_imag),real(AQ_real));

mat2STM_Viewer(AQ_amp,'AQ_amp',1,1,1);
mat2STM_Viewer(AQ_phase,'AQ_phase',1,1,1);

