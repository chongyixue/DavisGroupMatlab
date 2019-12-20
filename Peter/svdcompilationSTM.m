function svdcompilationSTM(data,varargin)
%function svdcompilationSLM(data,varargin)
%
%Takes the spectrum of the input STM data and executes a Singular Value
%Decomposition (SVD) with the reference spectra in varargin. The SVD is 
%calculated by the m - file "SVDSTM". 
%The maximum of the component maps is determined and all cmaps are
%normalized to it. After that they get multiplied by 255. They are now
%scaled to the uint8 range of RGB. By taking every component and assigning
%it to one of the three RGB - colors, a colormap containing the information
%about the abundance of the different components is created. If two
%components exist at the same place, a mix of the two RGB - colors will be
%observed, respectively for three components. 
%If more than three components are used, a new colormap will created
%starting with the first RGB - color and so on.
%P.O. Sprau June 2010
%
%Inputs
%------
%data           LDOS map STM
%
%varargin       the reference spectra. by using the varargin command the
%               number of input arguments is arbitrary.

% create the component maps and calculate the maximum according to the scan
% type. Set a marker.

Cmaps=SVDSTM(data,varargin);
scale=max(max(max(Cmaps)));


% get the number of components
nocp=length(varargin);


% according to the scan type the RGB - maps are created and plotted. The
% try catch structures are used to plot the filtered pixels if they exist.
% Since the code is just a iteration of if-else and for loops, only the
% first element of it is commented.

    %initialize temporary variable and the RGB - map
    cmp=Cmaps;
    RGBMap=uint8(zeros(size(Cmaps,1),size(Cmaps,2),3,nocp));
    % assign the individual components to one of three RGB - maps and plot
    % it. Sum the single RGB - maps to create the map with all components
    % (maximum of three). This one is also plotted.
    for i=1:nocp
        if mod((i+2),3)==0
            RGBMap(:,:,1,i) = uint8(255/scale*cmp(:,:,i));
            RGBMap(:,:,2,i) = 0;
            RGBMap(:,:,3,i) = 0;
            RGBMapAll=uint8(sum(RGBMap(:,:,:,i),4));
            figure;
            subplot(2,2,1)

            imagesc(RGBMapAll)
            axis image;
            % label the plots
            xlabel('X-Position ','FontSize',11,'FontWeight','normal')
            ylabel('y-Position ','FontSize',11,'FontWeight','normal')
            titlestr=['Overlay of all components: ' ['\color{red}' num2str(i)...
                '\color{black}'] ];
            title(titlestr,'FontSize',14,'FontWeight','bold')
            subplot(2,2,2)
            imagesc(RGBMap(:,:,:,i))
            axis image;
            xlabel('X-Position ','FontSize',11,'FontWeight','normal')
            ylabel('y-Position ','FontSize',11,'FontWeight','normal')
            title(['Component \color{red}' num2str(i) '\color{black}'],...
                'FontSize',14,'FontWeight','bold')
        elseif mod((i+1),3)==0
            RGBMap(:,:,1,i) = 0;
            RGBMap(:,:,2,i) = uint8(255/scale*cmp(:,:,i));
            RGBMap(:,:,3,i) = 0;
            RGBMapAll=uint8(sum(RGBMap(:,:,:,i-1:i),4));
            subplot(2,2,1)
            imagesc(RGBMapAll)
            axis image;
            xlabel('X-Position ','FontSize',11,'FontWeight','normal')
            ylabel('y-Position ','FontSize',11,'FontWeight','normal')
            titlestr=['Overlay of all components: ' ['\color{red}' num2str(i-1)...
                '\color{black}, ' '\color{green}' num2str(i) '\color{black}'] ];
            title(titlestr,'FontSize',14,'FontWeight','bold')
            subplot(2,2,3)
            imagesc(RGBMap(:,:,:,i))
            axis image;
            xlabel('X-Position ','FontSize',11,'FontWeight','normal')
            ylabel('y-Position ','FontSize',11,'FontWeight','normal')
            title(['Component \color{green} ' num2str(i) '\color{black}'],...
                'FontSize',14,'FontWeight','bold')
        elseif mod(i,3)==0
            RGBMap(:,:,1,i) = 0;
            RGBMap(:,:,2,i) = 0;
            RGBMap(:,:,3,i) = uint8(255/scale*cmp(:,:,i));
            RGBMapAll=uint8(sum(RGBMap(:,:,:,i-2:i),4));
            subplot(2,2,1)
            imagesc(RGBMapAll)
            axis image;
            xlabel('X-Position ','FontSize',11,'FontWeight','normal')
            ylabel('y-Position ','FontSize',11,'FontWeight','normal')
            titlestr=['Overlay of all components: ' ['\color{red}' num2str(i-2)...
                '\color{black}, ' '\color{green}' num2str(i-1) '\color{black}, '...
                '\color{blue}' num2str(i) '\color{black}'] ];
            title(titlestr,'FontSize',14,'FontWeight','bold')
            subplot(2,2,4)
            imagesc(RGBMap(:,:,:,i))
            axis image;
            xlabel('X-Position ','FontSize',11,'FontWeight','normal')
            ylabel('y-Position ','FontSize',11,'FontWeight','normal')
            title(['Component \color{blue}' num2str(i) '\color{black}'], ...
                'FontSize',14,'FontWeight','bold')
        end   
    end



end