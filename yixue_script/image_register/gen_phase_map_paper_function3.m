% Rahul Sharma April 2020
%calculates phase map
%currently for a single layer
%%%data object

function [AQ_amp,AQ_phase] = gen_phase_map_paper_function3(data,Qx,Qy,varargin)

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




if isstruct(data)==0
    data = mat2STM_Viewer(data,1,1,1,'A');
end
% data = polyn_subtract(data,0,'noplot');
[nr, nc] = size(data.map);
datamat = data.map;


r = linspace(1,nr,nr);

[rx,ry] = meshgrid(r,r);

center = ceil((nr+1)/2);%after FT, center pix is this center
center2 = floor(nr/2);  % but for fftshift, center px is this center.

Qx = abs(Qx_px-center);
Qy = abs(Qy_px-center);

Qx = 2*pi*(Qx)/nr;
Qy = 2*pi*(Qy)/nr;

%get locked in images
phase = (Qx.*rx + Qy.*ry);
% figure,imagesc(abs(phase))
AQ_lockedin = datamat.*exp(1i*phase);
% AQ_real_lockedin = datamat.*cos(phase);
% AQ_imag_lockedin = datamat.*sin(phase);
% figure,imagesc(real(exp(1i*phase)))
% figure,imagesc(real(AQ_lockedin));title("real")
% figure,imagesc(imag(AQ_lockedin));title("imag")

%Fourier filter with the given sig. convert sigma to sigma in k space
sig = nr/(2*pi*sig);sig=5;
filt = Gaussian2D(1:nr,1:nc,sig,sig,0,[center center],1);
%remember that ft of gaussian is a gaussian %filt now is in k space
% FT filt will need a bit more thinking as the center of FT for fftshift is
% different

%%
% figure,imagesc(abs(AQ_lockedin))

%% separate sine and cosine
% AQ_lockedinReal = real(AQ_lockedin);
% AQ_lockedinImag = imag(AQ_lockedin);
% 
% AQ_lockedinRealft = ft(AQ_lockedinReal,'real','ft');
% AQ_lockedinImagft = ft(AQ_lockedinImag,'real','ft');
% AQlockedinQReal_filt = AQ_lockedinRealft;
% AQlockedinQReal_filt.map = AQ_lockedinRealft.map.*filt;
% AQlockedinQImag_filt = AQ_lockedinImagft;
% AQlockedinQImag_filt.map = AQ_lockedinImagft.map.*filt;
% 
% % figure,imagesc(AQlockedinQReal_filt.map)
% 
% AQfiltreal = ft(AQlockedinQReal_filt,'real','ift');
% AQfiltimag = ft(AQlockedinQImag_filt,'real','ift');
% % 
% % figure,imagesc(AQfiltreal.map)
% % figure,imagesc(AQfiltimag.map)
% 
% AQamp = atan2(AQfiltimag.map,AQfiltreal.map);
% AQ_amp = mat2STM_Viewer(AQamp,1,1,1,'A');
% AQ_phase = mat2STM_Viewer(mod(AQ_amp.map+phase,2*pi),1,1,1,'A');

%% entirely in complex
AQ_lockedin = mat2STM_Viewer(AQ_lockedin,1,1,1,'A');
AQlockedinQ = ft(AQ_lockedin,'complex','ft');



% figure,imagesc(abs(AQlockedinQ.map))
AQlockedinQfilt = AQlockedinQ;
AQlockedinQfilt.map = AQlockedinQ.map.*filt;

ArealQ = AQlockedinQfilt;AimagQ = AQlockedinQfilt;
ArealQ.map = real(AQlockedinQfilt.map);
AimagQ.map = imag(AQlockedinQfilt.map);
AQ_ampreal = ft(ArealQ,'real','ift');
AQ_ampimag = ft(AimagQ,'real','ift');



AQ_amp = ft(AQlockedinQfilt,'phase','ift');


figure,imagesc(AQ_amp.map);title("here")
figure,imagesc(atan2(AQ_ampimag.map,AQ_ampreal.map));title("there")
AQ_phase = AQ_amp;
% figure,imagesc(AQ_amp.map);title("here")
% figure,imagesc(AQ_phase.map);title("there")
AQ_phase.map = mod(phase+AQ_amp.map,2*pi);


    function newdata =  ft(data,option,dir)
        if isstruct(data)==0
            datastruct = mat2STM_Viewer(data,1,1,1,'A');
        else
            datastruct = data;
        end
        datastruct = fourier_transform2d(datastruct,'none',option,dir);
        newdata = datastruct;
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