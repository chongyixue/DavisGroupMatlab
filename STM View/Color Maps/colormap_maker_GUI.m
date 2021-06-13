% 2020-12-21 YXC
% make your own color map


function colormap_maker_GUI(varargin)

color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';             

%% GUI dimensions 
width = 800; height = width*2/3;
column1left = 1;
column1right = 11;
labelfontsize = 12;
defaultcolor = 'Magma';



%% GUI

h1 = figure(...
    'Units','characters',...
    'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...%'MenuBar','none',...
    'Name',strcat('colormap maker GUI ',''),...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[50 50 width height],...
    'Resize','off',...
    'Visible','on');

show_ax = axes(...
    'Parent',h1,...
    'Units','pixels',...
    'Position',[column1left*width/20 height*0.75 width/20*18 width/7]);

RGB_ax = axes(...
    'Parent',h1,...
    'Units','pixels',...
    'Position',[column1left*width/20 height*0.3 width/20*18 width/4]);

c = dir([color_map_path '*.mat']);
colors = {};
for i = 1:length(c)
    colors{i} = c(i).name(1:end-4);
end
str = [colors{1} '|'];
for i = 2:length(colors)-1
    str = [str colors{i} '|'];
end
str = [str colors{end}];


buttonwidth = 50;


Draw_button = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[column1left*3*width/20 height*0.2 buttonwidth*2 height*0.06],...
    'String','Click Points',...
    'Callback',@Draw_Callback);%,...

col2 = column1left*6*width/20;
InterpolateR_button = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[col2 height*0.2 buttonwidth height*0.06],...
    'String','Red',...
    'Callback',{@interpolate_user_points,'R'});%,...
InterpolateG_button = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[col2 height*0.15 buttonwidth height*0.06],...
    'String','Green',...
    'Callback',{@interpolate_user_points,'G'});%,...
InterpolateB_button =uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[col2 height*0.1 buttonwidth height*0.06],...
    'String','Blue',...
    'Callback',{@interpolate_user_points,'B'});%,...

col3 = col2 + buttonwidth*1.5;
Name_edit = uicontrol('Parent',h1,...
    'Style','edit',...
    'Units','pixels',...
    'Position',[col3 height*0.2 buttonwidth*2 height*0.06],...
    'String','NewColor');%,...
color_pop = uicontrol(h1,'Style', 'popup',... 
       'units','pixels',...
       'Value',2,...
       'String', str,...
       'Position', [col3 height*0.1 buttonwidth*2 height*0.06],...
       'Callback',@plotselectedcolormap_callback);


SaveButton = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[col3+buttonwidth*2 height*0.2 buttonwidth height*0.06],...
    'String','Save',...
    'Callback',@savenewcolor_callback);


stretch_button = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[column1left*12*width/20 height*0.2 buttonwidth*3 height*0.06],...
    'String','Squish and Stretch',...
    'Callback',@Stretch_Callback);%,...


%% initialize
colorstrip = ones(4,256);
colorstrip = colorstrip.*reshape(linspace(1,256,256),1,[]);
imagesc(show_ax,colorstrip);
setcolor(show_ax,defaultcolor);
axis(show_ax,'off');
deff = load(strcat(color_map_path,defaultcolor));
n = fieldnames(deff);
n=n{1};
RGB = deff.(n);
R = RGB(:,1);
G = RGB(:,2);
B = RGB(:,3);
Rplot=plot(RGB_ax,R,'r');
hold on
Gplot=plot(RGB_ax,G,'g');
Bplot=plot(RGB_ax,B,'b');
xlim(RGB_ax,[0,257]);

%% tempplot
tempplotlist = {};

% we use x and y to store user defined lines
x=[]; 
y=[];



%% callback functions
    function Stretch_Callback(~,~)
        p  =cell(1,2);
        s = [0,0];
        for ii=1:2
            [pixx,~,button]=ginput(1);
            switch button
                case 3 % right click
                    break
                case 27 % escape button
                    break
                case 1 % left click
                    s(ii) = pixx;
                    p{ii} = plot(RGB_ax,[s(ii),s(ii)],[0,1],'k');
            end
        end
        delete(p{1});
        delete(p{2});
        s = round(s);
        
        
        if s(2)<1
            R = interp1(linspace(1,256,256-s(1)+1),R(s(1):end),1:1:256);
            G = interp1(linspace(1,256,256-s(1)+1),G(s(1):end),1:1:256);
            B = interp1(linspace(1,256,256-s(1)+1),B(s(1):end),1:1:256);

            R = R';G=G';B=B';

        elseif s(2)>255
            R = interp1(linspace(1,256,s(1)),R(1:s(1)),1:1:256);
            G = interp1(linspace(1,256,s(1)),G(1:s(1)),1:1:256);
            B = interp1(linspace(1,256,s(1)),B(1:s(1)),1:1:256);
            
            R = R';G=G';B=B';
        else
            
            R = interpolatecolor(R,s);
            G = interpolatecolor(G,s);
            B = interpolatecolor(B,s);
        end

        updateplotsnewRGB;
    end
        
    function newRGB = interpolatecolor(RGB,s)
        % s = (x1,x2),i.e. y(x1)move to y(x2). if x1<x2 left side
        % strethced, right side shrinked.
        Roriginalleft = RGB(1:s(1));
        Roriginalright = RGB(s(1):end);
        R1 = interp1(linspace(1,s(2),s(1)),Roriginalleft,linspace(1,s(2),s(2)));
        R2 = interp1(linspace(s(2),256,length(Roriginalright)),Roriginalright,s(2):1:256);
        
        newRGB = [R1(1:end-1),R2]';
    end


    function updateplotsnewRGB
        delete(Rplot)
        delete(Gplot)
        delete(Bplot)

        Rplot=plot(RGB_ax,R,'r');
        hold on
        Gplot=plot(RGB_ax,G,'g');
        Bplot=plot(RGB_ax,B,'b');
        setcolor(show_ax,0);

    end

    function savenewcolor_callback(~,~)
        def = [R,G,B];
        name = Name_edit.String;
        filename = strcat(color_map_path,name,'.mat');
        if isfile(filename)
            msgbox(strcat(name ,' already exist! Choose another name'),'Name Error');
        else
            save(filename,'def');
        end
    end
        
        
% imfreehand
    function Draw_Callback(~,~)
%        h = images.roi.Freehand(RGB_ax) 
        stop = 0;
        i = 1;
        while stop==0
            [pixx,pixy,button]=ginput(1);
            switch button
                case 3 % right click
                    stop=1;
                case 27 % escape button
                    stop=1;
                case 1 % left click
                    x(i) = pixx;
                    y(i) = pixy;
                    hold(RGB_ax,'on');
                    tempplotlist{i} = plot(RGB_ax,x(i),y(i),'kx');
            end
            i=i+1;
        end
        x(i:end)=[];
        y(i:end)=[];
        x = reshape(x,[],1);
        y = reshape(y,[],1);
        [x,order] = sort(x);
        y = y(order);
    end



%% functions
    function plotselectedcolormap_callback(~,~)
        val = get(color_pop,'Value');
        selectedcolor = colors{val};
        setcolor(show_ax,selectedcolor);
        deff = load(strcat(color_map_path,selectedcolor));
        n = fieldnames(deff);
        n=n{1};
        RGB = deff.(n);
        R = RGB(:,1);
        G = RGB(:,2);
        B = RGB(:,3);
        delete(Rplot)
        delete(Gplot)
        delete(Bplot)

        Rplot=plot(RGB_ax,R,'r');
        hold on
        Gplot=plot(RGB_ax,G,'g');
        Bplot=plot(RGB_ax,B,'b');

    end


    function interpolate_user_points(~,~,RGorB)
        if ~isempty(x)
            switch RGorB
                case 'R'
                    old = R;
                case 'G'
                    old = G;
                case 'B'
                    old = B;
            end
            
            if x(1)>1
                ind = floor(x(1));
                x = [linspace(1,ind,ind),x']';
                y = [old(1:ind)',y']';
            end
            if x(end)<256
                ind = ceil(x(end));
                x = [x',ind:1:256]';
                y = [y',old(ind:256)']';
            end
            
            new = interp1(x,y,reshape(linspace(1,256,256),[],1));
            lowfilt = new<0;
            highfilt = new>1;
            new = new.*(1-lowfilt)+0.*lowfilt;
            new = new.*(1-highfilt)+1.*highfilt;
            for i=1:length(tempplotlist)
                delete(tempplotlist{i});
            end
            switch RGorB
                case 'R'
                    delete(Rplot);
                    Rplot = plot(RGB_ax,new,'r');
                    R = new;
                case 'G'
                    delete(Gplot);
                    Gplot = plot(RGB_ax,new,'g');
                    G = new;
                case 'B'
                    delete(Bplot);
                    Bplot = plot(RGB_ax,new,'b');
                    B = new;
            end
            x = [];
            y = [];
            setcolor(show_ax,0);
        end
    end



    function setcolor(ax,col)
        if ischar(col)
            color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
            color_map = struct2cell(load([color_map_path col]));
            color_map = color_map{1};
        else
            color_map = [R,G,B];

        end
        colormap(ax,color_map);
    end



end





