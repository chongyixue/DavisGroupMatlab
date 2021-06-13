% Rahul Sharma April 2020
%calculates phase map
%currently for a single layer
%%%data object

function [AQ_phase,AQ_wavephase,lockinAmp,AQ_lockedin,phase] = gen_phase_map_paper_function(data,Qx,Qy,varargin)

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

    
    %% delele this after debugging
%     mat2STM_Viewer(datamat,1,1,1)
%     mat2STM_Viewer(largedatamat,1,1,1)
%     [~,~,~,comparereal,compareimag,phase] = gen_phase_map_paper_function(datamat,Qx,Qy,varargin{:},'padding',0);
% %     mat2STM_Viewer(compareimag,1,1,1)
%     [AQ_phase,AQ_wavephase,lockinAmp]=signaltophases(comparereal,compareimag,phase);
%     img_obj_viewer_test(AQ_phase)
    
    %%
    largex = padx*2+nr;largey = pady*2+nc;
    centerX = ceil((largex+1)/2);centerY = ceil((largey+1)/2);
    dQx = Qx-center; dQy = Qy-center;
    dQx = dQx*largex/nc; dQy = dQy*largey/nr;
    Qx = dQx+centerX; Qy = dQy+centerY;

    %% dummy is for normalization, both values with modified Qs for larger FOV (0 on the extra paddings)
    [~,~,~,lockedin,phase] = gen_phase_map_paper_function(largedatamat,Qx,Qy,varargin{:},'padding',0);
%     [~,~,~,dummylocin,~] = gen_phase_map_paper_function(dummymat,Qx,Qy,varargin{:},'padding',0);
    
    gaussfiltk = makefilt(largex,largey,sig);
    
%     figure,imagesc(real(lockedin));title('Real part of Datapad(r)*exp(iQr)');axis square;axis off
%     figure,imagesc(real(dummymat));title('Dummypad');axis square;axis off
    
    AQ = getlockedin_compoenent(lockedin,gaussfiltk);
    %     Dummy= getlockedin_compoenent(dummylocin,gaussfiltk);
    Dummy= getlockedin_compoenent(dummymat,gaussfiltk);

%     figure,imagesc(real(AQ));title('Real part of IFT[Lock(Datapad(q)]');axis square;axis off
%     figure,imagesc(real(Dummy));title('Real part of IFT[Dummypad(q)*Gauss(q=0)]');axis square;axis off
    
    AQ = AQ./Dummy;
    AQ_real = real(AQ);
    AQ_imag = imag(AQ);
    AQ_lockedin = AQ_real+1i*AQ_imag;   
    
    Locin_cell = cropNmaps(padx+1,padx+nr,pady+1,pady+nc,AQ_real,AQ_imag,phase);
    
    AQ_real = Locin_cell{1};
    AQ_imag = Locin_cell{2};
    phase = Locin_cell{3};
    
    [AQ_phase,AQ_wavephase,lockinAmp]=signaltophases(AQ_real,AQ_imag,phase);

    
    
    
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
    
    AQ_lockedin = AQ_real_lockedin+1i*AQ_imag_lockedin;
    
    gaussfiltk = makefilt(nr,nc,sig);
  
    AQ_real = getlockedin_compoenent(AQ_real_lockedin,gaussfiltk);
    AQ_imag = getlockedin_compoenent(AQ_imag_lockedin,gaussfiltk);

%     figure,imagesc(AQ_imag);title("imag no pad")
%     figure,imagesc(AQ_imag);title("real no pad")
    
    [AQ_phase,AQ_wavephase,lockinAmp]=signaltophases(AQ_real,AQ_imag,phase);

end

    function filter = makefilt(nx,ny,rsig)
        %Fourier filter with the given sig. convert sigma to sigma in k space
        sigx = nx/(2*pi*rsig);
        sigy = ny/(2*pi*rsig);
        centerx = ceil((nx+1)/2);
        centery = ceil((ny+1)/2);
        filter = Gaussian2D(1:nx,1:ny,sigx,sigy,0,[centerx centery],1);
    end
        
    function outputcell = cropNmaps(x1,x2,y1,y2,varargin)
        N = length(varargin);
        outputcell = cell(1,N);
        for iMap=1:N
           outputcell{iMap} = crop_dialogue(varargin{iMap},[x1,x2],[y1,y2],'noplot'); 
        end
        
    end


    function AQ = getlockedin_compoenent(lockedinsignal,filtk)
        AQ = ifft2(ifftshift(fftshift(fft2(lockedinsignal)).*filtk));
    end
    
    % given integrated locked in signals (real,imag), get phases
    function [AQ_phase,AQ_wavephase,lockinAmp]=signaltophases(AQ_real,AQ_imag,phase)
        AQ_amp = abs(AQ_real+1i*AQ_imag);
        
        AQ_phase = atan2(real(AQ_imag),real(AQ_real));
        AQ_phase = mod(AQ_phase,2*pi);
        
        
        AQ_wave_phase = mod(phase+AQ_phase,2*pi);
        
        
        AQ_amp = mat2STM_Viewer(AQ_amp,1,1,1,LIname);
        AQ_phase = mat2STM_Viewer(AQ_phase,1,1,1,ampname);
        AQ_wavephase = mat2STM_Viewer(AQ_wave_phase,1,1,1,phasename);
        lockinAmp = AQ_amp;
        
        
    end



end