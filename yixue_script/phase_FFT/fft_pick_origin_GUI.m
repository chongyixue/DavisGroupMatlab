
%% 2020-11-25 YXC
%% load group6_cdw_rho.mat from a folder up

% img_obj_viewer_test(FTchoosecenter(rho,5,1,'window','sine'),'Redwhiteblue');


function fft_pick_origin_GUI(map)


%%
% color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';     
color_map_path = fullfile(fileparts(mfilename('fullpath')),'..','..','\STM View\Color Maps\');

nx = size(map.map,1);

%% GUI dimensions 
width = 1000; height = width*2/3;
column1left = 1;
column1right = 11;
labelfontsize = 12;


%% user controlled knobs
mapcolormap = 'Blue1';

FTmaxcolorlim = 0;
FTcolormap = 'Redwhiteblue';
FTwindow = 'sine';
FTshowchoice = 'real';
origin_xpx = 1;
origin_ypx = 1;
originhandle = 0;
FTxlim = [1,nx];
FTylim = [1,nx];
lay = 1;
caxisval = 0;
[maphisto,caxisval]=generate_and_set_color_histogram(map);


%% GUI

h1 = figure(...
    'Units','characters',...
    'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...%'MenuBar','none',...
    'Name',strcat('FFT select Origin GUI ',map.name,'.......'),...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[50 50 width height],...'Resize','off',...'MenuBar','none',...
    'Visible','on');

map_ax = axes(...
    'Parent',h1,...
    'Units','pixels',...
    'Position',[column1left*width/20 height*0.3 width/5*2 width/5*2]);

ft_ax = axes(...
    'Parent',h1,...
    'Units','pixels',...
    'Position',[column1right*width/20 height*0.3 width/5*2 width/5*2],...
    'XLim',[1,nx],'YLim',[1,nx]);


%% menubar
mapview = uimenu('Label','MapDisplay');

    uimenu(mapview,'Label','Select ColorPalette','Callback',@choosePalette_callback);    
    uimenu(mapview,'Label','Adjust Histogram','Callback',@adjusthistogram_callback);

    


%% UI for choosing FT origin
vpos_origin = height*0.18;
dh = height*0.05;
vpos_origin2 = vpos_origin-dh;
hpos_origin_start = column1left*width/20;
originwidth = width/20;
dw = hpos_origin_start*1.2;
uicontrol('Style','text','String','Choose FT origin','Units','pixels',...
    'FontSize',labelfontsize,...
    'Position',[hpos_origin_start vpos_origin originwidth*2.5 originwidth/2]);
originx_editbox = uicontrol('style','edit',...
    'String','1', 'Units','pixels','FontSize',labelfontsize-1,...
    'Position',[hpos_origin_start vpos_origin2 originwidth originwidth/2],...
    'backgroundcolor','w','Callback',@change_origin_callback);
originy_editbox = uicontrol('style','edit',...
    'String','1', 'Units','pixels','FontSize',labelfontsize-1,...
    'Position',[hpos_origin_start+dw vpos_origin2 originwidth originwidth/2],...
    'backgroundcolor','w','Callback',@change_origin_callback);

%% UI for choosing FT zoom
vpos_origin = height*0.18;
vpos_origin3 = vpos_origin2-dh;
hpos_ftzoom_start = column1right*width/20;
originwidth = width/20;
uicontrol('Style','text','String','FT zoom','Units','pixels',...
    'FontSize',labelfontsize,...
    'Position',[hpos_ftzoom_start vpos_origin originwidth*2 originwidth/2]);
xlimleft_editbox = uicontrol('style','edit',...
    'String',num2str(FTxlim(1)), 'Units','pixels','FontSize',labelfontsize,...
    'Position',[hpos_ftzoom_start vpos_origin2 originwidth originwidth/2],...
    'backgroundcolor','w','Callback',@change_zoom_callback);
xlimright_editbox = uicontrol('style','edit',...
    'String',num2str(FTxlim(2)), 'Units','pixels','FontSize',labelfontsize,...
    'Position',[hpos_ftzoom_start+dw vpos_origin2 originwidth originwidth/2],...
    'backgroundcolor','w','Callback',@change_zoom_callback);
ylimleft_editbox = uicontrol('style','edit',...
    'String',num2str(FTylim(1)), 'Units','pixels','FontSize',labelfontsize,...
    'Position',[hpos_ftzoom_start vpos_origin3 originwidth originwidth/2],...
    'backgroundcolor','w','Callback',@change_zoom_callback);
ylimright_editbox = uicontrol('style','edit',...
    'String',num2str(FTylim(2)), 'Units','pixels','FontSize',labelfontsize,...
    'Position',[hpos_ftzoom_start+dw vpos_origin3 originwidth originwidth/2],...
    'backgroundcolor','w','Callback',@change_zoom_callback);

%% UI for clickselect origin
buttonwidth = width/14;
uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[4*width/20 vpos_origin2 buttonwidth height*0.06],...
    'String','Click',...
    'Callback',@click_origin_callback);%,...

% use the arrow keys
choose_origin_arrowkeys_pushbutton = uicontrol('Parent',h1,...
    'Style','pushbutton',...'Value',0,
    'Units','pixels',...
    'Position',[hpos_origin_start vpos_origin3 buttonwidth*2 height*0.04],...
    'String','Use Arrow Keys',...
    'Callback',{@arrowkey_move_origin,1},...
    'keypressfcn',{@arrowkey_move_origin,0});


%% UI for selecting colorlimits
uicontrol('Style','text','String','color limit','Units','pixels',...
    'FontSize',labelfontsize,...
    'Position',[hpos_ftzoom_start+3*dw vpos_origin originwidth*1.5 originwidth/2]);

caxislim_editbox = uicontrol('style','edit',...
    'String',num2str(FTmaxcolorlim), 'Units','pixels','FontSize',labelfontsize,...
    'Position',[hpos_ftzoom_start+3*dw vpos_origin2 originwidth*1.5 originwidth/2],...
    'backgroundcolor','w','Callback',@change_climit_callback);

%% UI for selecting FT type (real,imag,absolute)
uicontrol('Style','text','String','Type','Units','pixels',...
    'FontSize',labelfontsize,...
    'Position',[hpos_ftzoom_start+5*dw vpos_origin originwidth originwidth/2]);

FTtype_listbox = uicontrol('style','listbox',...
    'String','real|imag|abs', 'Units','pixels','FontSize',labelfontsize,...
    'Position',[hpos_ftzoom_start+5*dw vpos_origin3 originwidth*1.5 originwidth*1.2],...
    'backgroundcolor','w','Callback',@change_FTtype_callback);

%% energy layer chooser
uicontrol('Style','text',...
    'String','Bias (mV)','Units','pixels',...
    'Position',[column1left*width/20 height*0.91 width/14 width/30]);
energy_list_popup = uicontrol('Style','popupmenu',...
    'String', num2str(1000*map.e','%10.2f'),...
    'Value', 1,'Units','pixels',...
    'Position',[column1left*width/20 height*0.86 width/10 width/20],...
    'Callback',{@energy_change_callback},'ButtonDownFcn',{@energy_change_callback});

%% initiate plots

showmap;
[FTreal,FTimag,FTabs,FTcomplex] = FTchoosecenter(map,1,1,'window',FTwindow);
FT = FTreal;
setmaxcolorlim;
showft;

%% Callback functions

    function arrowkey_move_origin(~,E,firstcheck)
%         origin_xpx = roundpixels(origin_xpx);
%         origin_ypx = roundpixels(origin_ypx);
        if firstcheck == 0
%             if choose_origin_arrowkeys_checkbox.Value == 1
                
                % expressfcn
%                 E
                switch E.Key
                    case 'rightarrow'
                        if origin_xpx<nx
                            origin_xpx = origin_xpx + 1;
                        end
                    case 'leftarrow'
                        if origin_xpx>1
                            origin_xpx = origin_xpx - 1;
                        end
                    case 'uparrow'
                        if origin_ypx>1
                            origin_ypx = origin_ypx - 1;
                        end
                    case 'downarrow'
                        if origin_ypx < nx
                            origin_ypx = origin_ypx + 1;
                        end
                        %                     otherwise
                        %                         fprintf(E.Key);
                end
                originx_editbox.String = origin_xpx;
                originy_editbox.String = origin_ypx;
                mark_origin_callback
                change_origin_callback;
%             end
        end
    end
    function roundedpx = roundpixels(px)
        if px<nx/2
            roundedpx = max(1,round(px));
        else
            roundedpx = min(nx,round(px));
        end
    end

    function energy_change_callback(~,~)
        lay = energy_list_popup.Value;
        showmap;
        mark_origin_callback;
        showft;
    end


    function setmaxcolorlim
        n = max(round(nx*0.01),10);
        FTmaxcolorlim = max(max(FT.map(:,:,lay)));
        while sum(sum(FT.map(:,:,lay)>FTmaxcolorlim/10))<n
            FTmaxcolorlim = FTmaxcolorlim/10;
        end
        caxislim_editbox.String = num2str(FTmaxcolorlim);
    end

    function mark_origin_callback(~,~)
       hold(map_ax,'on');
       if originhandle ~= 0
           delete(originhandle);
       end
       originhandle = plot(map_ax,origin_xpx,origin_ypx,'rx');
       
    end

    function change_FTtype_callback(~,~)
        type = FTtype_listbox.Value;
        switch type
            case 1
                FTshowchoice = 'real';
                FT = FTreal;
            case 2
                FTshowchoice = 'imag';
                FT = FTimag;
            case 3
                FTshowchoice = 'abs';
                FT = FTabs;
        end
        showft;
    end

    function change_climit_callback(~,~)
       FTmaxcolorlim = str2double(caxislim_editbox.String);
       caxis(ft_ax,[-FTmaxcolorlim,FTmaxcolorlim]); 
    end

    function click_origin_callback(~,~)
        mark_origin_callback
        [pixx,pixy,button]=ginput(1);
        switch button
            case 1 %left click
                x = round(pixx);
                y = round(pixy);
                if x<nx/2
                    x = max(1,x);
                else
                    x = min(x,nx);
                end
                if y<nx/2
                    y = max(1,y);
                else
                    y = min(y,nx);
                end
                originx_editbox.String = num2str(x);
                originy_editbox.String = num2str(y);
                change_origin_callback;
        end
        
    end

    function change_zoom_callback(~,~)
        FTxlim = [str2double(xlimleft_editbox.String),...
            str2double(xlimright_editbox.String)];
        FTylim = [str2double(ylimleft_editbox.String),...
            str2double(ylimright_editbox.String)];
        ft_ax.XLim = FTxlim;
        ft_ax.YLim = FTylim;
    end

    function change_zoom_drag(~,~)
        FTxlim = get(ft_ax,'XLim');
        FTylim = get(ft_ax,'YLim');
        xlimleft_editbox.String=num2str(FTxlim(1));
        xlimright_editbox.String=num2str(FTxlim(2));
        ylimleft_editbox.String=num2str(FTylim(1));
        ylimright_editbox.String=num2str(FTylim(2));
    end

    function change_origin_callback(~,~)

        origin_xpx = str2double(originx_editbox.String);
        origin_ypx = str2double(originy_editbox.String);
        mark_origin_callback
        [FTreal,FTimag,~] = FTchoosecenter(map,origin_xpx,origin_ypx,'window',FTwindow,...
            'FTcomplex',FTcomplex,FTabs);
        setFTchoice;
        showft;
    end


    function showmap
        imagesc(map_ax,map.map(:,:,lay));
        setcolor(map_ax,mapcolormap);
        map_ax.CLim =caxisval(lay,:); 
    end

    function showft
        change_zoom_drag;
        imagesc(ft_ax,FT.map(:,:,lay));
        caxis(ft_ax,[-FTmaxcolorlim,FTmaxcolorlim]);
        setcolor(ft_ax,FTcolormap);
        xlim(ft_ax,FTxlim);
        ylim(ft_ax,FTylim);
    end

    function setFTchoice
        switch FTshowchoice
            case 'real'
                FT = FTreal;
            case 'imag'
                FT = FTimag;
            otherwise
                FT = FTabs;
        end
    end

%% histogram, color palette from menu bar callbacks
    function choosePalette_callback(~,~)
        palette_sel_dialogue(map_ax,mapcolormap);
    end

    function adjusthistogram_callback(~,~)
        set(h1,'Userdata',caxisval); %due to how the following function is written, 'UserData' stores these vals
        data_histogram_better_dialogue(lay,maphisto,h1,map_ax);
    end

    function [histo,caxis_val] = generate_and_set_color_histogram(data)
        [nr,nc,nz] = size(data.map);
        nn = 1000;
        for kk = 1:nz
            tmp_layer = reshape(data.map(:,:,kk),nr*nc,1);
            tmp_std = std(tmp_layer);
            % pick a common number of bins based on the largest spread of values in
            % one of the layers
            n1 = abs((max(tmp_layer) - min(tmp_layer)))/(2*tmp_std)*1000;
            nn = max(nn,floor(n1));
        end
        clear tmp_layer n1 tmp_std
        
        for kk=1:nz
            [histo.freq(kk,1:nn) histo.val(kk,1:nn)] = hist(reshape(data.map(:,:,kk),nr*nc,1),nn);
        end
        histo.size = [nr nc nz];
        
        %initialize color limit values for each layer in caxis
        caxis_val = zeros(nz,2);
        for kk=1:nz
            caxis_val(kk,1) = min(histo.val(kk,:)); % min value for each layer
            if isnan(caxis_val(kk,1))
                caxis_val(kk,1) = 0;
            end
            caxis_val(kk,2) = max(histo.val(kk,:)); % max value for each layer
            if isnan(caxis_val(kk,2))
                caxis_val(kk,2) = 0;
            end
        end
        
    end

%% functions


    function setcolor(ax,col)
        color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
        color_map = struct2cell(load([color_map_path col]));
        color_map = color_map{1};
        colormap(ax,color_map);
    end

    function [FTreal,FTimag,FTabs,FTcomplex] = FTchoosecenter(map,xpix,ypix,varargin)
        
        window = 'none'; % can be 'sine' usually
        calculateFTcomplex = 1;
        
        if nargin>3
            skipover = 0;
            for i=1:length(varargin)
                if skipover ~=0
                    skipover = skipover-1;
                else
                    switch varargin{i}
                        case 'window'
                            skipover = 1;
                            window = varargin{i+1};
                        case 'FTcomplex' %original complex FT map if already calculated
                            skipover = 2;
                            calculateFTcomplex = 0;
                            FTcomplex = varargin{i+1};
                            FTabs = varargin{i+1};
                        otherwise
                            st = num2str(varargin{i});
                            fprintf(strcat('"',st,'" is not recognized as a property'));
                    end
                    
                end
            end
        end
        
        if calculateFTcomplex == 1
            sub0 = polyn_subtract(map,0,'noplot');
            FTabs  = fourier_transform2d(sub0,window,'amplitude','ft');
            FTcomplex = fourier_transform2d(sub0,window,'complex','ft');
        end
        FTreal = FTabs;
        FTimag = FTabs;
        complexmap = FTcomplex.cpx_map;
        
        nx = size(map.map,1);
        [Kx,Ky] = meshgrid(linspace(0,nx-1,nx),linspace(0,nx-1,nx));
        % figure,imagesc(abs(complexmap));
        complexmap = ifftshift(complexmap);
        
        
        complexmap = complexmap.*exp(2*pi*1i*(Kx)*(xpix-1)/(nx)).*exp(2*pi*1i*(Ky)*(ypix-1)/(nx));
        complexmap = fftshift(complexmap);
        FTreal.map = real(complexmap);
        FTimag.map = imag(complexmap);
        
        FTreal.ave = [];
        FTreal.var = [FTreal.var '_ft_real' ];
        FTreal.ops{end+1} = ['Fourier Transform: real - sine window - ft direction' ];
        FTimag.ave = [];
        FTimag.var = [FTimag.var '_ft_real' ];
        FTimag.ops{end+1} = ['Fourier Transform: imaginary - sine window - ft direction' ];
    end



end


