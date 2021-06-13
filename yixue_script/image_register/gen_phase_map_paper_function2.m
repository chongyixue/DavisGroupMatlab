% Rahul Sharma April 2020
%calculates phase map
%currently for a single layer
%%%data object

function [AQ_phase,AQ_wavephase,lockinAmp] = gen_phase_map_paper_function(data,Qx,Qy,varargin)

% data = nb30;
%%% Pixel coordinates of desired Q-peak
% Qx_px = 253;
% Qy_px = 236;
Qx_px = Qx;
Qy_px = Qy;


if isstruct(data)
    [nr, nc] = size(data.map);
    datamat = data.map;
else
    [nr,nc] = size(data);
    datamat = data;
end
r = linspace(1,nr,nr);
center = ceil((nr+1)/2);

%% pixel width in real space to average over
nperiod = sqrt(sum(([Qx Qy]-center).^2));
periodsize = nr/nperiod;
sig = periodsize/pi;


phasename = 'AQ_phase';
ampname = 'AQ_amp';
LIname = 'AQ_lockedinamp';
padding = 1;

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
                case 'lockedinname'
                    LIname = value;
                case 'padding'
                    padding = value;
                    
            end
        end
    end
end

%% padding for Kazu's normalization stuff
if padding == 1
    padx = round(nr/2);
    pady = round(nc/2);
    largedatamat = zeros(2*padx+nr,2*pady+nc);
    dummymat  = zeros(2*padx+nr,2*pady+nc);
    dummymat(padx+1:padx+nr,pady+1:pady+nc)=1;
    largedatamat(padx+1:padx+nr,pady+1:pady+nc)=datamat;
    
%     mat2STM_Viewer(datamat,1,1,1)
%     mat2STM_Viewer(largedatamat,1,1,1)
    
    largex = padx*2+nr;largey = pady*2+nc;
    centerX = ceil((largex+1)/2);centerY = ceil((largey+1)/2);
    dQx = Qx-center; dQy = Qy-center;
    dQx = dQx*largex/nc; dQy = dQy*largey/nr;
    Qx = dQx+centerX; Qy = dQy+centerY;

       
    [AQ_phase,AQ_wavephase,lockinAmp] = gen_phase_map_paper_function(largedatamat,Qx,Qy,varargin{:},'padding',0);
    img_obj_viewer_test(AQ_phase)
    [AQ_phaseD,AQ_wavephaseD,lockinAmpD] = gen_phase_map_paper_function(dummymat,Qx,Qy,varargin{:},'padding',0);
    img_obj_viewer_test(AQ_phaseD)
    AQ_phase = crop_dialogue(AQ_phase,[padx+1,padx+nr],[pady+1,pady+nc],'noplot');
    AQ_wavephase = crop_dialogue(AQ_wavephase,[padx+1,padx+nr],[pady+1,pady+nc],'noplot');
    lockinAmp = crop_dialogue(lockinAmp,[padx+1,padx+nr],[pady+1,pady+nc],'noplot');
    AQ_phaseD = crop_dialogue(AQ_phaseD,[padx+1,padx+nr],[pady+1,pady+nc],'noplot');
    AQ_wavephaseD = crop_dialogue(AQ_wavephaseD,[padx+1,padx+nr],[pady+1,pady+nc],'noplot');
    lockinAmpD = crop_dialogue(lockinAmpD,[padx+1,padx+nr],[pady+1,pady+nc],'noplot');
    AQ_phase.map = AQ_phase.map./AQ_phaseD.map;
    AQ_wavephase.map = AQ_wavephase.map./AQ_wavephaseD.map;
    lockinAmp.map = lockinAmp.map./lockinAmpD.map;
    
    
else
    
    
    [rx,ry] = meshgrid(r,r);
    
    
    Qx = (Qx_px-center);
    Qy = (Qy_px-center);
    
    Qx = 2*pi*(Qx)/nr;
    Qy = 2*pi*(Qy)/nr;
    
    
    %get locked in images
    phase = Qx.*rx + Qy.*ry;
    AQ_real_lockedin = datamat.*cos(phase);
    AQ_imag_lockedin = datamat.*sin(phase);
    
    center = ceil((nr+1)/2);
    %Fourier filter with the given sig. convert sigma to sigma in k space
    sig = nr/(2*pi*sig);%sig=5;
    filt = Gaussian2D(1:nr,1:nc,sig,sig,0,[center center],1);
    % filt = Gaussian2D(1:nr,1:nc,sig,sig,0,[nr/2+1 nr/2+1],1);
    
    
    
    % filt = fftshift(fft2(fftshift(filt)));
    % figure,imagesc(real(filt))
    % figure,imagesc(abs(filt))
    
    %% YXC explore
    % figure,imagesc(cos(phase));title("cos(phase)");axis off;
    % figure,imagesc(sin(phase));title("sin(phase)");axis off;
    
    
    % figure,imagesc(AQ_real_lockedin)
    % title("real lockin");axis off;
    % figure,imagesc(AQ_imag_lockedin)
    % title("imag lockin");axis off;
    
    % limx = sort([nr-Qx+2-mod(nr,2),Qx]);
    % limx(1) = limx(1)-4;limx(2)=limx(2)+4;
    
    
    % figure,imagesc(abs(fftshift(fft2(AQ_real_lockedin))))
    % title("real lockin fft");axis off;xlim(limx);ylim([center-1,center+1]);
    % figure,imagesc(abs(fftshift(fft2(AQ_imag_lockedin))))
    % title("imag lockin fft");axis off;xlim(limx);ylim([center-1,center+1]);
    %
    %
    % figure,imagesc(abs(fftshift(fft2(AQ_real_lockedin)).*filt));
    % title("Gauss filt real lockin fft");axis off; xlim(limx);ylim([center-1,center+1]);
    % figure,imagesc(abs(fftshift(fft2(AQ_imag_lockedin)).*filt));
    % title("Gauss filt imag lockin fft");axis off;xlim(limx);ylim([center-1,center+1]);
    
    %%
    z = sin(linspace(0,pi,nr)')*sin(linspace(0,pi,nr));
    % figure,plot(sin(linspace(0,pi,nr)))
    % figure,imagesc(z);
    
    %remember that ft of gaussian is a gaussian %filt now is in k space
    AQ_real = ifft2(ifftshift(fftshift(fft2(AQ_real_lockedin)).*filt));
    AQ_imag = ifft2(ifftshift(fftshift(fft2(AQ_imag_lockedin)).*filt));
    
    % AQ_real = ifft2(ifftshift(fftshift(fft2(AQ_real_lockedin.*z)).*filt));
    % AQ_imag = ifft2(ifftshift(fftshift(fft2(AQ_imag_lockedin.*z)).*filt));
    
    
    
    AQ_amp = abs(AQ_real+1i*AQ_imag);
    % figure,imagesc(AQ_amp)
    AQ_phase = atan2(real(AQ_imag),real(AQ_real));
    AQ_phase = mod(AQ_phase,2*pi);
    % figure,imagesc(AQ_phase)
    % title("AQ phase");axis off;colormap(gca,hsv);caxis([0 2*pi])
    AQ_wave_phase = mod(phase+AQ_phase,2*pi);
    % figure,imagesc(AQ_wave_phase)
    % title("XL AQ phase");axis off;colormap(gca,hsv);caxis([0 2*pi])
    AQ_amp = mat2STM_Viewer(AQ_amp,1,1,1,LIname);
    AQ_phase = mat2STM_Viewer(AQ_phase,1,1,1,ampname);
    AQ_wavephase = mat2STM_Viewer(AQ_wave_phase,1,1,1,phasename);
    lockinAmp = AQ_amp;
    
end

    function Q = interpolate(q,px)
        if px == round(px)
            Q = q(px);
        else
            lowindex = floor(px);
            highindex = ceil(px);
            
            qlow = q(lowindex); qhigh = q(highindex);
            p = polyfit([lowindex,highindex],[qlow,qhigh],1);
            Q = polyval(p,px);
        end
%         Q
    end



end