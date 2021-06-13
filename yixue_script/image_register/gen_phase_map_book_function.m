% Rahul Sharma April 2020
%calculates phase map
%currently for a single layer

function [AQ_amp,AQ_phase] = gen_phase_map_book_function(data,Qx,Qy,varargin)

%%%data object
% data = nb30;
%%% Pixel coordinates of desired Q-peak
% Qx_px = 253;
% Qy_px = 236;
Qx_px = Qx;
Qy_px = Qy;
%%% pixel width in real space to average over
sig = 3;
phasename = 'AQ_phase';
ampname = 'AQ_amp';

if nargin>3
    for i=1:length(varargin)
        if mod(i,2)==1
            property = varargin{i};
        else
            value = varargin{i};
            % change default values
            switch property
                case 'sig'
                    sig=value;
                case 'phasename'
                    phasename = value;
                case 'ampname'
                    ampname = value;           
                    
                    
            end
        end
    end
end





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
    Qx =  interpolate(q,Qx_px) -  q(ceil((nr+1)/2)); % fix k value offsets
    Qy =  interpolate(q,Qy_px) - q(ceil((nr+1)/2)); % fix k value offsets
else   
    Qx = interpolate(q,Qx_px);
    Qy = interpolate(q,Qy_px);
end
%craete filter
filt = Gaussian2D(1:nr,1:nc,sig,sig,0,[Qx_px,Qy_px],1);
% filt = Gaussian2D(1:nr,1:nc,sig,sig,0,[Qx_px- nr/2+1, Qy_px - nc/2+1],1);
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

AQ_amp = mat2STM_Viewer(AQ_amp,1,1,1,ampname);
AQ_phase = mat2STM_Viewer(AQ_phase,1,1,1,phasename);



    function Q = interpolate(q,px)
        lowindex = floor(px);
        highindex = ceil(px);
        
        qlow = q(lowindex); qhigh = q(highindex);
        p = polyfit([lowindex,highindex],[qlow,qhigh],1);
        Q = polyval(p,px);
        
    end




end
