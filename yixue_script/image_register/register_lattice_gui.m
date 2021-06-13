% 2020-4-22 YXC
% GUI to produce grid, manually select atoms, simultaneous zoom


function maphistory = register_lattice_gui(map1,map2)



%% temporary values, might change into user control later
currentmap1 = map1;
currentmap2 = map2;
currentmap = currentmap1;
currentmaptracker = 1;
axcol1 = 'Blue1';
axcol2 = 'Blue1';

%% determine if plotted data is line-subtracted (more pretty and better contrast)
plotpreptopo = 0;
currentplot1 = currentmap1;
currentplot2 = currentmap2;


%%
leftcol = 'r';
rightcol = 'k';

Cmap = load_min_colormaps; Cmap = Cmap.Blue2;
map1layer = 1;
map2layer = 1;


inner_f = 0;
inner_enlist = 0;
fh_temp = 0;

Bragglist{1} = []; % in the callback, this will be filled [#,1]=x, [#,2]=y
Bragglist{2} = [];

subpxBragglist{1} = [];
subpxBragglist{2} = [];

gridlinepairs = cell(2,6);
xlimleft = [0.5 size(map1.map,1)+0.5];
ylimleft = [0.5 size(map1.map,2)+0.5];
xlimright = [0.5 size(map2.map,1)+0.5];
ylimright = [0.5 size(map2.map,2)+0.5];
%% construction lines and ref points holders
contructioncolorleft = 'w';
contructioncolorright = 'y';

contructionlines = cell(2,1);
contructionlines{1} = zeros(6,4); % ...(n,:) is in the form of [x1,x2,y1,y2]
contructionlines{2} = zeros(6,4);
ncontructionlines = [0,0];

contructionpoints = cell(2,1);
contructionpoints{1} = zeros(6,2);
contructionpoints{2} = zeros(6,2);
npoints = [0,0];

copycontructionlines = [0,0];
copypoints = [0,0];
pointsize = 20;

%% dimension parameters: axes 8/20 width each, with 1/20 blank of each sides
width = 1200; height = width*2/3;
column1left = 1;
column2left = 3;
column1right = 11;
column2right = 13;

col2lefthalf = 4;
col2righthalf = 14;

col3left = 6;
col3right = 16;

col3lefthalf = 7;
col3righthalf = 17;

middle = 9;

prog_w = width*3/35;  %progress bar width
lev1 = height*0.94;
lev2 = height*0.91;
prog_l = 2*width/20+0*width*3/30;




%% create figure and make two image axes for map1 and map2


h1 = figure(...
'Units','characters',...
'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...
'MenuBar','none',...
'Name',strcat('Image Register Viewing Tool.......',map1.name,'.......',map2.name),...
'NumberTitle','off',...
'Units','pixels',...
'Position',[50 10 width height],...
'Resize','off',...
'Visible','on');

color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';             

%% status display

status_text = cell(10,2);
currentmap_pointer = [1,1];


for jj=1:size(status_text,1)
    status_text{jj,1} = uicontrol('Parent',h1,...
        'Style','text',...
        'Units','pixels',...
        'Position',[0.3*width/20+(jj-1)*prog_w lev1 prog_w height*0.03],...
        'String','',...
        'ForegroundColor','Red');%,...
    status_text{jj,2} = uicontrol('Parent',h1,...
        'Style','text',...
        'Units','pixels',...
        'Position',[0.3*width/20+(jj-1)*prog_w lev2 prog_w height*0.03],...
        'String','',...
        'ForegroundColor','Red');%,...
end

buttonwidth = 50;
backbutton = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[19*width/20-2*buttonwidth lev2 buttonwidth height*0.06],...
    'String','Back',...
    'Callback',@StepBack_Callback);%,...
nextbutton = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[19*width/20-1*buttonwidth lev2 buttonwidth height*0.06],...
    'String','Forward',...
    'Callback',@StepForward_Callback);%,...
    

% 
% dummy = uicontrol('Parent',h1,...
%     'Style','pushbutton',...
%     'Units','pixels',...
%     'Position',[1*width/20+0*width*3/30 lev1 prog_w height*0.03],...
%     'String','Dummy button');%,...
%     'Callback',@zoomout_Callback);
% dummy2 = uicontrol('Parent',h1,...
%     'Style','pushbutton',...
%     'Units','pixels',...
%     'Position',[1*width/20+0*width*3/30 lev2 prog_w height*0.03],...
%     'String','Dummy button');%,...
%     'Callback',@zoomout_Callback);
% dummy = uicontrol('Parent',h1,...
%     'Style','pushbutton',...
%     'Units','pixels',...
%     'Position',[1*width/20+8*width*3/30 lev1 prog_w height*0.03],...
%     'String','Dummy button');%,...
%     'Callback',@zoomout_Callback);
% dummy2 = uicontrol('Parent',h1,...
%     'Style','text',...
%     'Units','pixels',...
%     'Position',[1*width/20+7*width*3/30 lev2 prog_w height*0.03],...
%     'String','==> DummyButton',...
%     'ForegroundColor','Red');%,...


img1_axes = axes(...
'Parent',h1,...
'Units','pixels',...
'Position',[column1left*width/20 height*0.3 width/5*2 width/5*2]);
% axis off


img2_axes = axes(...
'Parent',h1,...
'Units','pixels',...
'Position',[column1right*width/20 height*0.3 width/5*2 width/5*2]);


active_maptitle = uicontrol(...
'Parent',h1,...
'Units','pixels',...
'Position',[9*width/20 height*0.8 width*2/20 height*0.05],...
'String','Active: left',...
'Style','text');

axeslinkornot = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[9*width/20 height*0.78 width*2/20 height*0.04],...
    'String','Unlink FOV',...
    'Callback',@AxesLinkage_Callback);

zoomallout = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[9*width/20 height*0.74 width*2/20 height*0.04],...
    'String','Zoom out',...
    'Callback',@zoomout_Callback);

DoneButton = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[18.5*width/20 height*0.03 width*1/20 width*0.5/20],...
    'String','Done',...
    'Callback',@Done_Callback);

%% middel panel ANALYSIS
Stretch = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[middle*width/20 height*0.66 width*2/20 height*0.04],...
    'String','Scale',...
    'Callback',@scale_Callback);

CropFOV =uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[middle*width/20 height*0.62 width*2/20 height*0.04],...
    'String','Crop FOV',...
    'Callback',@CropFOV_Callback);

CropAdvice = zeros(2,4);

Match_Pixel =uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[middle*width/20 height*0.58 width*2/20 height*0.04],...
    'String','Match Pixel-Dims',...
    'Callback',@Change_PixDim_Callback);

LF =uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[middle*width/20 height*0.54 width*2/20 height*0.04],...
    'String','Lawler-Fujita',...
    'Callback',{@LF_Callback,1});
XCorr_button =uicontrol('Parent',h1,...
    'Style','togglebutton',...
    'Units','pixels',...
    'Position',[middle*width/20 height*0.50 width*2/20 height*0.04],...
    'String','Cross-Correlation',...
    'Value',0,...
    'Callback',@Xcorr_Callback);
Dummy =uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[middle*width/20 height*0.46 width*2/20 height*0.04],...
    'String','Dummy Operation',...
    'Callback',@Dummy_Callback);

FollowAdviceButton =uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[middle*width/20 height*0.38 width*2/20 height*0.04],...
    'String','Follow Advice',...
    'Callback',@FollowAdvice_Callback);

AdviceStatus = 0;


AlternateDecisionButton =uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[middle*width/20 height*0.34 width*2/20 height*0.04],...
    'String','Alternate Decision',...
    'Callback',@Alternate_Decision_Callback);

%% analysis feedback windows
Xcorr_axes = axes(...
    'Parent',h1,...
    'Units','pixels',...
    'Position',[8.5*width/20 height*0.06 width/7 width/7],...
    'Visible','Off');
XCorr = [];
sug_move = [0,0];
% Xcorrlegend = [];

Feedback_text = uicontrol('Parent',h1,...
    'Style','text',...
    'Units','pixels',...
    'Position',[8*width/20 height*0.00 width*4/20 height*0.06],...
    'String','The quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog');

%% maphistory
maphistory = cell(4,10);%10 operations should suffice?
%3rd and 4th index is to keep track of operations for map1 and map2

maphistory{1,1} = map1;
maphistory{2,1} = map2;
maphistory{3,1} = "Original";
maphistory{4,1} = "Original";



%% initiate radiobuttons for Braggs and contructionlines
leftBraggcheckbox = cell(6,1);
rightBraggcheckbox = cell(6,1);

leftConstructionCheckbox = cell(6,1);
rightConstructionCheckbox = cell(6,1);

leftPointsCheckbox = cell(6,1);
rightPointsCheckbox = cell(6,1);

for ib=1:6
    leftBraggcheckbox{ib} = uicontrol('Parent',h1,...
        'Style','checkbox',...
        'Units','pixels',...
        'Position',[column1left*width/20 (0.2-0.03*(ib-1))*height 2*width/20 4*height/100],...
        'Visible','off',...
        'Callback',@updateAll);
%         'Callback',{@plotgrids_Callback,1,ib,'r'});%1 left, ib-index of Bragg
    rightBraggcheckbox{ib} = uicontrol('Parent',h1,...
        'Style','checkbox',...
        'Units','pixels',...
        'Position',[column1right*width/20 (0.2-0.03*(ib-1))*height 2*width/20 4*height/100],...
        'Visible','off',...
        'Callback',@updateAll);
    %% piggyback for contruction lines
    leftConstructionCheckbox{ib} = uicontrol('Parent',h1,...
        'Style','checkbox',...
        'Units','pixels',...
        'Position',[column2left*width/20 (0.2-0.03*(ib-1))*height 2*width/20 4*height/100],...
        'Visible','off',...
        'Callback',@updateAll);
%         'Callback',{@plotgrids_Callback,1,ib,'r'});%1 left, ib-index of Bragg
    rightConstructionCheckbox{ib} = uicontrol('Parent',h1,...
        'Style','checkbox',...
        'Units','pixels',...
        'Position',[column2right*width/20 (0.2-0.03*(ib-1))*height 2*width/20 4*height/100],...
        'Visible','off',...
        'Callback',@updateAll);
    
    %% piggyback for construction points
    leftPointsCheckbox{ib} = uicontrol('Parent',h1,...
        'Style','checkbox',...
        'Units','pixels',...
        'Position',[col3left*width/20 (0.2-0.03*(ib-1))*height 2*width/20 4*height/100],...
        'Visible','off',...
        'Callback',@updateAll);
%         'Callback',{@plotgrids_Callback,1,ib,'r'});%1 left, ib-index of Bragg
    rightPointsCheckbox{ib} = uicontrol('Parent',h1,...
        'Style','checkbox',...
        'Units','pixels',...
        'Position',[col3right*width/20 (0.2-0.03*(ib-1))*height 2*width/20 4*height/100],...
        'Visible','off',...
        'Callback',@updateAll);
    
    
end

%% column 1
copytoright = uicontrol('Parent',h1,...
    'Style','checkbox',...
    'Units','pixels',...
    'Position',[width/20 (0.2+0.04)*height 4*width/20 4*height/100],...
    'String','Copy to right',...
    'Visible','off',...
    'Callback',@updateAll);

copytoleft = uicontrol('Parent',h1,...
    'Style','checkbox',...
    'Units','pixels',...
    'Position',[11*width/20 (0.2+0.04)*height 4*width/20 4*height/100],...
    'String','Copy to left',...
    'Visible','off',...
    'Callback',@updateAll);

%% column 2
AddLinesLeft = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[column2left*width/20 (0.2+0.04)*height 4*width/40 4*height/100],...
    'String','Add Construction Lines',...
    'Callback',{@construction_lines_Callback,1,contructioncolorleft});
AddLinesRight = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[column2right*width/20 (0.2+0.04)*height 4*width/40 4*height/100],...
    'String','Add Construction Lines',...
    'Callback',{@construction_lines_Callback,2,contructioncolorleft});


%% column 2.5
Remove_leftlines_checkbox = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[col2lefthalf*width/20 (0.2)*height 4*width/80 4*height/100],...
    'String','Remove',...
    'Visible','off',...
    'Callback',{@removelines_Callback,1});
Remove_rightlines_checkbox = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[col2righthalf*width/20 (0.2)*height 4*width/80 4*height/100],...
    'String','Remove',...
    'Visible','off',...
    'Callback',{@removelines_Callback,2});
AddLinesToRight = uicontrol('Parent',h1,...
    'Style','togglebutton',...
    'Units','pixels',...
    'Position',[column2left*width/20 (0.2-0.03*(6-1))*height 4*width/50 4*height/140],...
    'String','Copy To Right',...
    'Visible','off',...
    'Callback',@updateAll);
AddLinesToLeft = uicontrol('Parent',h1,...
    'Style','togglebutton',...
    'Units','pixels',...
    'Position',[column2right*width/20 (0.2-0.03*(6-1))*height 4*width/50 4*height/140],...
    'String','Copy To Left',...
    'Visible','off',...
    'Callback',@updateAll);

%% column 3 construction points
AddPointsLeft = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[col3left*width/20 (0.2+0.04)*height 4*width/40 4*height/100],...
    'String','Add Reference Points',...
    'Callback',{@points_Callback,1,contructioncolorleft});
AddPointsRight = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[col3right*width/20 (0.2+0.04)*height 4*width/40 4*height/100],...
    'String','Add Reference Points',...
    'Callback',{@points_Callback,2,contructioncolorleft});


%% column 3.5
Remove_leftpoints_checkbox = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[col3left*width/20+4*width/65 (0.2)*height 4*width/80 4*height/140],...
    'String','Remove',...
    'Visible','off',...
    'Callback',{@removepoints_Callback,1});
Remove_rightpoints_checkbox = uicontrol('Parent',h1,...
    'Style','pushbutton',...
    'Units','pixels',...
    'Position',[col3right*width/20+4*width/65 (0.2)*height 4*width/80 4*height/140],...
    'String','Remove',...
    'Visible','off',...
    'Callback',{@removepoints_Callback,2});
AddPointsToRight = uicontrol('Parent',h1,...
    'Style','togglebutton',...
    'Units','pixels',...
    'Position',[col3left*width/20 (0.2-0.03*(6-1))*height 4*width/65 4*height/140],...
    'String','Copy To Right',...
    'Visible','off',...
    'Callback',@updateAll);
AddPointsToLeft = uicontrol('Parent',h1,...
    'Style','togglebutton',...
    'Units','pixels',...
    'Position',[col3right*width/20 (0.2-0.03*(6-1))*height 4*width/65 4*height/140],...
    'String','Copy To Left',...
    'Visible','off',...
    'Callback',@updateAll);
%%

linktrack = 1;
linkaxes([img1_axes,img2_axes]);  %so that they zoom together
zh = zoom(h1); set(zh,'Enable','off');






%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Menu Bar%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    



f4 = uimenu('Label','Zoom OFF','Callback',@zoom_Callback);

analysis = uimenu('Label','Analysis');
    selectcurrentmap = uimenu(analysis,'Label','Active Image');
        uimenu(selectcurrentmap,'Label','Left','Callback',@leftactive);
        uimenu(selectcurrentmap,'Label','Right','Callback',@rightactive);
    chooseFTpeak = uimenu(analysis,'Label','Choose Bragg Peaks');
        uimenu(chooseFTpeak,'Label','Draw','Callback',@DrawBraggPeaks_Callback);
        uimenu(chooseFTpeak,'Label','Coordinates','Callback',@BraggPeaks_coordinate_Callback);
    oldLF = uimenu(analysis,'Label','LF no padding','Callback',{@LF_Callback,0});
    Follow = uimenu(analysis,'Label','Follow');
        uimenu(Follow,'Label','LF','Callback',@follow_LF_Callback);
        uimenu(Follow,'Label','Shear','Callback',@follow_shear_callback);

image_mani = uimenu('Label','Image Operation');
    Shear = uimenu(image_mani,'Label','Shear Correct');
        uimenu(Shear,'Label','triangular','Callback',@hex_shear);
        uimenu(Shear,'Label','orthorhombic','Callback',@tetrashear);
        
view = uimenu('Label','View');

    colorpalette = uimenu(view,'Label','ColorPalette');
        uimenu(colorpalette,'Label','Left','Callback',{@choosePalette_callback,1});
        uimenu(colorpalette,'Label','Right','Callback',{@choosePalette_callback,2});
        uimenu(colorpalette,'Label','Both','Callback',{@choosePalette_callback,3});
        
    Adjusthist = uimenu(view,'Label','Adjust Histogram');
        uimenu(Adjusthist,'Label','Left','Callback',{@adjusthistogram_callback,1});
        uimenu(Adjusthist,'Label','Right','Callback',{@adjusthistogram_callback,2});
      
    tiltplane = uimenu(view,'Label','Subtract plane');
        uimenu(tiltplane,'Label','Yes','Callback',{@tiltplane_callback,1});
        uimenu(tiltplane,'Label','No','Callback',{@tiltplane_callback,0});
    subpxBragview = uimenu(view,'Label','Subpixel Braggs');
        uimenu(subpxBragview,'Label','Left','Callback',@subpxleft);
        uimenu(subpxBragview,'Label','Right','Callback',@subpxright);
    linedivider = uimenu(view,'Label','divide line');
        uimenu(linedivider,'Label','-10','Callback',{@divide_callback,-10});
        uimenu(linedivider,'Label','-5','Callback',{@divide_callback,-5});
        uimenu(linedivider,'Label','-3','Callback',{@divide_callback,-3});
        uimenu(linedivider,'Label','-2','Callback',{@divide_callback,-2});
        uimenu(linedivider,'Label','2','Callback',{@divide_callback,2});
        uimenu(linedivider,'Label','3','Callback',{@divide_callback,3});
        uimenu(linedivider,'Label','5','Callback',{@divide_callback,5});
        uimenu(linedivider,'Label','10','Callback',{@divide_callback,10});
    lineextender = uimenu(view,'Label','extend line');
        uimenu(lineextender,'Label','-10','Callback',{@extend_callback,-10});
        uimenu(lineextender,'Label','-5','Callback',{@extend_callback,-5});
        uimenu(lineextender,'Label','-3','Callback',{@extend_callback,-3});
        uimenu(lineextender,'Label','-2','Callback',{@extend_callback,-2});
        uimenu(lineextender,'Label','2','Callback',{@extend_callback,2});
        uimenu(lineextender,'Label','3','Callback',{@extend_callback,3});
        uimenu(lineextender,'Label','5','Callback',{@extend_callback,5});
        uimenu(lineextender,'Label','10','Callback',{@extend_callback,10});

Externalplot = uimenu('Label','Plot');
    uimenu(Externalplot,'Label','linecut','Callback',@plotlinecut_callback);
        
        
Export_to_img_viewer = uimenu('Label','Export');
    uimenu(Export_to_img_viewer,'Label','From Left','Callback',{@open_in_viewer_Callback,1});
    uimenu(Export_to_img_viewer,'Label','From Right','Callback', {@open_in_viewer_Callback,2});

Export_to_img_viewer = uimenu('Label','Import');
    Work = uimenu(Export_to_img_viewer,'Label','From Workspace');
        uimenu(Work,'Label','To Left','Callback',{@Import_from_viewer_Callback,1,1});
        uimenu(Work,'Label','To Right','Callback',{@Import_from_viewer_Callback,1,2});

    GUI = uimenu(Export_to_img_viewer,'Label','From GUI');
        uimenu(GUI,'Label','To Left','Callback',{@Import_from_viewer_Callback,2,1});
        uimenu(GUI,'Label','To Right','Callback',{@Import_from_viewer_Callback,2,2});




    
%%  %%%%%%%%%%%%%%%%%%%%%%%% MAIN - Initialize %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% for histogram values
% generate a histogram for each layer of data.  Will be used for setting
% color axis limit.  Also include the dimensions of img_obj.

[histoleft,caxisvalleft] = generate_and_set_color_histogram(currentmap1);
[historight,caxisvalright] = generate_and_set_color_histogram(currentmap2);
imagesc(img1_axes,currentmap1.map); % so that the color limit is set
imagesc(img2_axes,currentmap2.map);


%%

plot_img1_Callback
plot_img2_Callback


% uiwait(gcf);%wait so that we get values
% let's not do this so that we can do other operations in parallel.


%% %%%%%%%%%%%%%%%%%%%%%% CALLBACK FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% operation callback

    function plotlinecut_callback(~,~)
        nlinesleft = ncontructionlines(1);
        nlinesright = ncontructionlines(2);
        constructionleft = contructionlines{1};
        constructionright = contructionlines{2};
        
        for ii=1:6
            if ii<=nlinesleft
                point = constructionleft(ii,:);
                if leftConstructionCheckbox{ii}.Value == 1
                    xpxleft = point(1:2);
                    ypxleft = point(3:4);
                end
            end
            
            if ii<=nlinesright
                point = constructionright(ii,:);
                if rightConstructionCheckbox{ii}.Value == 1
                    xpxright = point(1:2);
                    ypxright = point(3:4);
                end
            end
            
        end
        left = linecutpoint(1,xpxleft,ypxleft);
        right = linecutpoint(2,xpxright,ypxright);
        xleft = linspace(0,1,length(left));
        xright = linspace(0,1,length(right));
        figure,plot(xleft,left,'b');
        hold on
        plot(xright,right,'r');
        legend(["left","right"]');
        
    end

    function points = linecutpoint(leftorright,xpx,ypx)
        dist = sqrt((xpx(1)-xpx(2)).^2+(ypx(1)-ypx(2)).^2);
        p = round(dist);
        x = linspace(xpx(1),xpx(2),p);
        y = linspace(ypx(1),ypx(2),p);
        if leftorright == 1
           % left
            mat = currentmap1.map;
        else
            mat = currentmap2.map;
        end
        nx = size(mat,1);
        [X,Y] = meshgrid(1:1:nx,1:1:nx);
        points = griddata(reshape(X,1,[]),reshape(Y,1,[]),reshape(mat,1,[]),...
            x,y);
        mn = mean(points);
        sd = std(points);
        points = (points-mn)/sd;
    end


    function choosePalette_callback(hobject,eventdata,leftorright)
        
        if leftorright == 1
            palette_sel_dialogue(img1_axes,axcol1);
        elseif leftorright ==2
            palette_sel_dialogue(img2_axes,axcol2);
        else
            palette_sel_dialogue({img1_axes,img2_axes},axcol1);
            axcol2 = axcol1;
        end
    end

    function adjusthistogram_callback(hobject,eventdata,leftorright)
        if leftorright == 1
            layer = 1;
            set(h1,'Userdata',caxisvalleft); %due to how the following function is written, 'UserData' stores these vals
            data_histogram_better_dialogue(layer,histoleft,h1,img1_axes);
        else
            layer = 1;
            set(h1,'Userdata',caxisvalright);
            data_histogram_better_dialogue(layer,historight,h1,img2_axes);
        end
    end

    function Dummy_Callback(hObject,eventdata)
        diff = currentmap_pointer(1)-currentmap_pointer(2);
        
        if diff>0 %left more advanced
            maphistory{2,currentmap_pointer(2)+1:currentmap_pointer(1)}=currentmap2;
            maphistory{4,currentmap_pointer(2)+1:currentmap_pointer(1)}='nothing';
            %% update status bar
            status_text{currentmap_pointer(2),2}.FontWeight = 'normal';
            for i=currentmap_pointer(2)+1:currentmap_pointer(1)
                status_text{i,2}.String = 'nothing';
                status_text{i,2}.FontWeight = 'bold';
            end
            currentmap_pointer(2)=currentmap_pointer(1);
        elseif diff<0
            maphistory{1,currentmap_pointer(1)+1:currentmap_pointer(2)}=currentmap1;
            maphistory{3,currentmap_pointer(1)+1:currentmap_pointer(2)}='nothing';
            
            %% update status bar
            status_text{currentmap_pointer(1),1}.FontWeight = 'normal';
            for i=currentmap_pointer(1)+1:currentmap_pointer(2)
                status_text{i,1}.String = 'nothing';
                status_text{i,1}.FontWeight = 'bold';
            end
            currentmap_pointer(1)=currentmap_pointer(2);
        end
        

%         %% advance currentmap_pointer and update maphistory
%         if currentmap_pointer(1)<10 %advance only if we have space
%             %% operation
%             newmap1 = currentmap1;
%             newmap1.map = fliplr(currentmap1.map);
%             
%             %% update currentmap_pointer and update maphistory
%             currentmap_pointer(1) = currentmap_pointer(1)+1;
%             maphistory{1,currentmap_pointer(1)} = newmap1;
%             maphistory{3,currentmap_pointer(1)} = 'fliplr     :long description';
%             currentmap1 = newmap1;
%         end
%         
%         if currentmap_pointer(2)<10
%             %% operation
%             newmap2 = currentmap2;
%             newmap2.map = fliplr(currentmap2.map);
%             
%             %% update currentmap_pointer and update maphistory
%             currentmap_pointer(2) = currentmap_pointer(2)+1;
%             maphistory{2,currentmap_pointer(2)} = newmap2;
%             maphistory{4,currentmap_pointer(2)} = 'fliplr     :long description';%11 characters for short
%             currentmap2 = newmap2;
%         end
%         resetAll  %clear Bragg,construction lines
%         updateAll % make new plots and update status bar, maphistory
        
    end

    function FollowAdvice_Callback(hObject,eventdata)
        switch AdviceStatus
            case 0
                % do nothing
            case 1
                %follow XCorr advice
                if currentmaptracker == 1
                    [newmap2,newmap1,t1x1,t1y1,t1x2,t1y2,t2x1,t2y1,t2x2,t2y2]=crop_to_same_FOV(currentmap2,1,1,currentmap1,1+sug_move(1),1+sug_move(2));
                    operation = strcat('XCorr Shift : move left FOV by (right,down)=',num2str(sug_move));
                else
                    [newmap1,newmap2,t2x1,t2y1,t2x2,t2y2,t1x1,t1y1,t1x2,t1y2]=crop_to_same_FOV(currentmap1,1,1,currentmap2,1+sug_move(1),1+sug_move(2));
                    operation = strcat('XCorr Shift : move right FOV by (right,down)=',num2str(sug_move));
                end
                operationleft = strcat(operation,'specifically-CROP from (',num2str([t1x1 t1x2]),') to (',num2str([t1y1,t1y2]),')');
                operationright = strcat(operation,'specifically-CROP from (',num2str([t2x1 t2x2]),') to (',num2str([t2y1,t2y2]),')');

                Advance_Tracker_Callback(3,operationleft,operationright,newmap1,newmap2);
                ResetXCorrPlot_Callback
            case 2
                %% follow crop advice
                leftcrop = 0;rightcrop=0;
                if CropAdvice(1,:)~=0
                    leftcrop = 1;
                end
                if CropAdvice(2,:)~=0
                    rightcrop = 1;
                end
                bothcrop = leftcrop*rightcrop;
                
                if bothcrop==1
                    TL1 = CropAdvice(1,1:2);BR1 =CropAdvice(1,3:4);
                    TL2 = CropAdvice(2,1:2);BR2 =CropAdvice(2,3:4);
                    newdataleft = crop_dialogue(currentmap1,[TL1(1),BR1(1)],[TL1(2),BR1(2)],'noplot');
                    newdataright = crop_dialogue(currentmap2,[TL2(1),BR2(1)],[TL2(2),BR2(2)],'noplot');
                    lefttext = strcat('crop:(',num2str(TL1),') to (',num2str(BR1),')');
                    righttext = strcat('crop:(',num2str(TL2),') to (',num2str(BR2),')');
                    Advance_Tracker_Callback(3,lefttext,righttext,newdataleft,newdataright)
                elseif leftcrop == 1
                    TL1 = CropAdvice(1,1:2);BR1 =CropAdvice(1,3:4);
                    newdataleft = crop_dialogue(currentmap1,[TL1(1),BR1(1)],[TL1(2),BR1(2)],'noplot');
                    lefttext = strcat('crop:(',num2str(TL1),') to (',num2str(BR1),')');
                    Advance_Tracker_Callback(1,lefttext,' ',newdataleft,[])
                else
                    TL2 = CropAdvice(2,1:2);BR2 =CropAdvice(2,3:4);
                    newdataright = crop_dialogue(currentmap2,[TL2(1),BR2(1)],[TL2(2),BR2(2)],'noplot');
                    righttext = strcat('crop:(',num2str(TL2),') to (',num2str(BR2),')');
                    Advance_Tracker_Callback(2,'',righttext,[],newdataright)
                end
        end

    end

    function Alternate_Decision_Callback(hObject,eventdata)
        switch AdviceStatus
            case 0 %do nothing
                
            case 1
                % Xcorr dialogue for choosing x and y and direction
                [map1or2,moveright,movedown] = XCorr_Movement_dialogue(currentmaptracker,sug_move(1),sug_move(2));
                
                if moveright~=0 || movedown ~=0
                    
                    if map1or2 == 1
                        [newmap2,newmap1,t1x1,t1y1,t1x2,t1y2,t2x1,t2y1,t2x2,t2y2]=crop_to_same_FOV(currentmap2,1,1,currentmap1,1+moveright,1+movedown);
                        operation = strcat('XCorr Shift : move left FOV by (right,down)=',num2str([moveright,movedown]));
                    else
                        [newmap1,newmap2,t2x1,t2y1,t2x2,t2y2,t1x1,t1y1,t1x2,t1y2]=crop_to_same_FOV(currentmap1,1,1,currentmap2,1+moveright,1+movedown);
                        operation = strcat('XCorr Shift : move right FOV by (right,down)=',num2str([moveright,movedown]));
                    end
                    operationleft = strcat(operation,'specifically-CROP from (',num2str([t1x1 t1x2]),') to (',num2str([t1y1,t1y2]),')');
                    operationright = strcat(operation,'specifically-CROP from (',num2str([t2x1 t2x2]),') to (',num2str([t2y1,t2y2]),')');
                    
                    Advance_Tracker_Callback(3,operationleft,operationright,newmap1,newmap2);
                    ResetXCorrPlot_Callback
                    
                end
                
            case 2
                % input crop coordinates
                
                nx1 = size(currentmap1.map,1); nx2 = size(currentmap2.map,1);
                Cropchoice= alternate_crop_dialogue(nx1,nx2);
                
                leftcrop = 0;rightcrop=0;
                if Cropchoice(1,:)~=0
                    leftcrop = 1;
                end
                if Cropchoice(2,:)~=0
                    rightcrop = 1;
                end
                bothcrop = leftcrop*rightcrop;
                
                if bothcrop==1
                    TL1 = Cropchoice(1,1:2);BR1 =Cropchoice(1,3:4);
                    TL2 = Cropchoice(2,1:2);BR2 =Cropchoice(2,3:4);
                    newdataleft = crop_dialogue(currentmap1,[TL1(1),BR1(1)],[TL1(2),BR1(2)],'noplot');
                    newdataright = crop_dialogue(currentmap2,[TL2(1),BR2(1)],[TL2(2),BR2(2)],'noplot');
                    lefttext = strcat('crop:(',num2str(TL1),') to (',num2str(BR1),')');
                    righttext = strcat('crop:(',num2str(TL2),') to (',num2str(BR2),')');
                    Advance_Tracker_Callback(3,lefttext,righttext,newdataleft,newdataright)
                elseif leftcrop == 1
                    TL1 = Cropchoice(1,1:2);BR1 =Cropchoice(1,3:4);
                    newdataleft = crop_dialogue(currentmap1,[TL1(1),BR1(1)],[TL1(2),BR1(2)],'noplot');
                    lefttext = strcat('crop:(',num2str(TL1),') to (',num2str(BR1),')');
                    Advance_Tracker_Callback(1,lefttext,' ',newdataleft,[])
                else
                    TL2 = Cropchoice(2,1:2);BR2 =Cropchoice(2,3:4);
                    newdataright = crop_dialogue(currentmap2,[TL2(1),BR2(1)],[TL2(2),BR2(2)],'noplot');
                    righttext = strcat('crop:(',num2str(TL2),') to (',num2str(BR2),')');
                    Advance_Tracker_Callback(2,'',righttext,[],newdataright)
                end   
        end
    end

    function Change_PixDim_Callback(hObject,eventdata)
%         pix_dim(data,newpixdim);
        nx1 = size(currentmap1.map,1);
        nx2 = size(currentmap2.map,1);
        [newdimleft,newdimright]= change_pxdim_dialogue(nx1,nx2);
        
        diff = currentmap_pointer(1)-currentmap_pointer(2);
        if diff<=0 %map2 more advanced, or equal
            if newdimleft ~= nx1
                newdata = pix_dim(currentmap1,newdimleft);
                lefttext = strcat('PixDimTo',num2str(newdimleft),' from ',num2str(nx1));
                Advance_Tracker_Callback(1,lefttext,'',newdata,[]);
            end
            if newdimright ~= nx2
                newdata = pix_dim(currentmap2,newdimright);
                righttext = strcat('PixDimTo',num2str(newdimright),' from ',num2str(nx2));
                Advance_Tracker_Callback(2,'',righttext,[],newdata);
            end
        else
            if newdimright ~= nx2
                newdata = pix_dim(currentmap2,newdimright);
                righttext = strcat('PixDimTo',num2str(newdimright),' from ',num2str(nx2));
                Advance_Tracker_Callback(2,'',righttext,[],newdata);
            end
            if newdimleft ~= nx1
                newdata = pix_dim(currentmap1,newdimleft);
                lefttext = strcat('PixDimTo',num2str(newdimleft),' from ',num2str(nx1));
                Advance_Tracker_Callback(1,lefttext,'',newdata,[]);
            end
            
        end
    end

    function CropFOV_Callback(hObject,eventdata)
        [~,~,validboth]=getmappoints(3,2);
        [~,~,validright]=getmappoints(2,2);
        [~,~,validleft]=getmappoints(1,2);
        AdviceStatus = 2;
        if validboth == 1
            [map1points,map2points,~]=getmappoints(3,2);
            [TL1,BR1] = decideCropPoints(map1points);
            [TL2,BR2] = decideCropPoints(map2points);
            CropAdvice(1,:)=[TL1,BR1];
            CropAdvice(2,:)=[TL2,BR2];
            
            text1 = strcat('Cropleft:(',num2str(TL1),') to (',num2str(BR1),')');
            text2 = strcat('Cropright:(',num2str(TL2),') to (',num2str(BR2),')');
            Feedback_text.String = strcat('Advice: ',text1,text2);
        elseif validleft ==1
            [map1points,~,~]=getmappoints(1,2);
            [TL1,BR1] = decideCropPoints(map1points);
            CropAdvice(1,:)=[TL1,BR1];
            text1 = strcat('Cropleft:(',num2str(TL1),') to (',num2str(BR1),')');
            Feedback_text.String = strcat('Advice: ',text1);
        elseif validright ==1
            [~,map2points,~]=getmappoints(3,2);
            [TL2,BR2] = decideCropPoints(map2points);
            CropAdvice(2,:)=[TL2,BR2];
            text2 = strcat('Cropright:(',num2str(TL2),') to (',num2str(BR2),')');
            Feedback_text.String = strcat('Advice: ',text2);
        else
            Feedback_text.String ='Select 2 and only 2 reference points from at least one map';
            AdviceStatus = 0;
        end
        updateAll
    end

    function [x,y] = Cropplotpoints(TL,BR)
       minx = TL(1)-0.5; 
       miny = TL(2)-0.5;
       maxx = BR(1)+0.5;
       maxy = BR(2)+0.5;
       x = [minx,minx,maxx,maxx,minx];
       y = [maxy,miny,miny,maxy,maxy];        
    end

    function [TL,BR] = decideCropPoints(mappoints)%mappoints in the form of point_i=(i,:) i=1,2
        x = mappoints(:,1);
        y = mappoints(:,2);
        minx = round(min(x));maxx=round(max(x));
        lenx = maxx-minx+1;
        miny = round(min(y));maxy = round(max(y));
        leny = maxy-miny+1;
        nx = min(lenx,leny);
        TL = [minx,miny];
        BR = [minx+nx-1,miny+nx-1];
    end

    function [map1points,map2points,validornot]=getmappoints(leftorrightorboth,npoints)
        map1points = zeros(npoints,2);
        map2points = zeros(npoints,2);
        
        count1 = 0;
        count2 = 0;
        
        for i=1:6
            if leftPointsCheckbox{i}.Value ==1
                count1=count1+1;
                map1points(min(count1,npoints),:)=contructionpoints{1}(i,:);
            end
            if rightPointsCheckbox{i}.Value==1
                count2=count2+1;
                map2points(min(count2,npoints),:)=contructionpoints{2}(i,:);
            end
        end

        if count1==npoints
            validleft =1;
        else
            validleft = 0;
        end
        if count2 ==npoints
            validright = 1;
        else
            validright = 0;
        end
        
        if leftorrightorboth==1
            validornot=validleft;
        elseif leftorrightorboth==2
            validornot=validright;
        else
            validornot=validleft*validright;
        end
        
%         if validornot==1 
%             map2points_alternate = zeros(3,2);
%             map2points_alternate(1,:) = map2points(2,:);
%             map2points_alternate(2,:) = map2points(1,:);
%             
%             % use closest set of points for stretching
%             if sum(sum(map2points.^2))>sum(sum(map2points_alternate.^2))
%                 map2points = map2points_alternate;
%             end
% 
%             if leftorrightorboth==1
%                 if sum(map1points(1,:))>sum(map1points(2,:))
%                     map1points = flipud(map1points);
%                 end
%             elseif leftorrightorboth==2
%                 if sum(map2points(1,:))>sum(map2points(2,:))
%                     map2points = flipud(map2points);
%                 end
%             else
%                 if sum(map1points(1,:))>sum(map1points(2,:))
%                     map1points = flipud(map1points);
%                     map2points = flipud(map2points);
%                 end
%             end
%         end        
        
        
    end

    function scale_Callback(hObject,eventdata)

        [map1points,map2points,validornot]=getmappoints(3,3);
        
%         if count1~=2 || count2~=2
        if validornot == 0
            Feedback_text.String = 'Select 3 and only 3 reference points';
        else
% 
%             map2points_alternate = zeros(2,2);
%             map2points_alternate(1,:) = map2points(2,:);
%             map2points_alternate(2,:) = map2points(1,:);
%             
%             % use closest set of points for stretching
%             if sum(sum(map2points.^2))>sum(sum(map2points_alternate.^2))
%                 map2points = map2points_alternate;
%             end
            
            pa1 = squeeze(map1points(1,:));
            pa2 = squeeze(map1points(2,:));
            pa3 = squeeze(map1points(3,:));
            pb1 = squeeze(map2points(1,:));
            pb2 = squeeze(map2points(2,:));
            pb3 = squeeze(map2points(3,:));
            
            leftpoints = strcat('(',num2str(pa1),') and (',num2str(pa2),') and (',num2str(pa3) ,')');
            rightpoints = strcat('(',num2str(pb1),') and (',num2str(pb2),') and (',num2str(pb3),')');
            
            text = strcat('Scale Match: leftpoints ', leftpoints ,' | rightpoints ',rightpoints);
            
            if currentmaptracker==2
                newmap2 = scale_rotate_match(currentmap1,pa1,pa2,pa3,currentmap2,pb1,pb2,pb3);
%                 newmap2 = scale_to_match(currentmap1,pa1,pa2,currentmap2,pb1,pb2);
                Advance_Tracker_Callback(2,'',text,[],newmap2);
            else
                newmap1 = scale_rotate_match(currentmap2,pb1,pb2,pb3,currentmap1,pa1,pa2,pa3);
%                 img_obj_viewer_test(newmap1)
                Advance_Tracker_Callback(1,text,'',newmap1,[]);
            end
            
            resetAll
            updateAll
        end
    end

    function LF_Callback(hObject,eventdata,padornot)
        %note that I added uiwait(gcf) to both LF functions so that I can
        %get the results here. In future versions change that so that
        %varargin can be utilized for this purpose
        choice = LFchoice_dialogue;
        
        qbragprompt = subpxBragglist{currentmaptracker};
        if choice == 1 %2Braggs
            
            if size(qbragprompt,1)>=2
                if padornot == 0
                    newmap = LF_phase_gen_dialogue(currentmap,qbragprompt(1:2,:));
                else
                    newmap = LF_phase_gen_dialogue_tetra_padding(currentmap,qbragprompt(1:2,:));
                end
            else
                if padornot == 0
                    newmap = LF_phase_gen_dialogue(currentmap);
                else
                    newmap = LF_phase_gen_dialogue_tetra_padding(currentmap);
                end
            end
            text = 'LawlerFujita: 2 peaks LF';
        else
            if size(qbragprompt,1)>=2
                if padornot == 0
                    newmap = LF_phase_gen_dialogue_hex(currentmap,qbragprompt(1:2,:));
                else
                    newmap = LF_phase_gen_dialogue_hex_padding(currentmap,qbragprompt(1:2,:));
                end
            else
                if padornot == 0
                    newmap = LF_phase_gen_dialogue_hex(currentmap);
                else
                    newmap = LF_phase_gen_dialogue_hex_padding(currentmap);
                end
            end
            text = 'LawlerFujita: 3 peaks LF';
        end
        if currentmaptracker == 1
            Advance_Tracker_Callback(1,text,'',newmap,[]);
        else
            Advance_Tracker_Callback(2,'',text,[],newmap);
        end
        
        resetAll
        updateAll
        
    end

    function hex_shear(hobject,eventdata)
        qbragprompt = subpxBragglist{currentmaptracker};
        if size(qbragprompt,1)>=2
            [newmap,q0,p,theta,alpha,q_px] = Shear_correct_hex_dialogue(currentmap,qbragprompt(1:2,:));
        else
           [newmap,q0,p,theta,alpha,q_px] = Shear_correct_hex_dialogue(currentmap);
        end
        text = 'Shear_triangle:';
        text = strcat(text,'based on q_px=',num2str(q_px),', resulting fit q0=',...
            num2str(q0),' p=',num2str(p),' theta=',num2str(theta),' alpha=',num2str(alpha));
        
        if currentmaptracker == 1
            Advance_Tracker_Callback(1,text,'',newmap,[]);
        else
            Advance_Tracker_Callback(2,'',text,[],newmap);
        end
        
        resetAll
        updateAll
    end

    function tetrashear(hobject,eventdata)
        qbragprompt = subpxBragglist{currentmaptracker};
        if size(qbragprompt,1)>=2
            [newmap,q0,p,theta,alpha,q_px] = Shear_correct_tetra_dialogue(currentmap,qbragprompt(1:2,:));
        else
           [newmap,q0,p,theta,alpha,q_px] = Shear_correct_tetra_dialogue(currentmap);
        end
        text = 'Shear_tetra:';
        text = strcat(text,'based on q_px=',num2str(q_px),', resulting fit q0=',...
            num2str(q0),' p=',num2str(p),' theta=',num2str(theta),' alpha=',num2str(alpha));
        
        if currentmaptracker == 1
            Advance_Tracker_Callback(1,text,'',newmap,[]);
        else
            Advance_Tracker_Callback(2,'',text,[],newmap);
        end
        
        resetAll
        updateAll
    end

    function AdvanceLeftTracker_Callback(lefttext,newmapleft)
        if currentmap_pointer(1)<10 %advance only if we have space
            %% update currentmap_pointer and update maphistory
            currentmap_pointer(1) = currentmap_pointer(1)+1;
            maphistory{1,currentmap_pointer(1)} = newmapleft;
            maphistory{3,currentmap_pointer(1)} = lefttext;
            currentmap1 = newmapleft;
        end
        resetAll  %clear Bragg,construction lines
        updateAll % make new plots and update status bar, maphistory
    end

    function AdvanceRightTracker_Callback(righttext,newmapright)
        if currentmap_pointer(2)<10  
            %% update currentmap_pointer and update maphistory
            currentmap_pointer(2) = currentmap_pointer(2)+1;
            maphistory{2,currentmap_pointer(2)} = newmapright;
            maphistory{4,currentmap_pointer(2)} = righttext;%11 characters for short
            currentmap2 = newmapright;
        end
        resetAll  %clear Bragg,construction lines
        updateAll % make new plots and update status bar, maphistory
    end

    function Advance_Tracker_Callback(leftorrightorboth,lefttext,righttext,newmapleft,newmapright)
        if leftorrightorboth == 3
            diffsteps = currentmap_pointer(1)-currentmap_pointer(2);
            if diffsteps>0 %map1 more advanced
                maphistory{2,currentmap_pointer(2)+1:currentmap_pointer(1)} = currentmap2;
                maphistory{4,currentmap_pointer(2)+1:currentmap_pointer(1)} = 'nothing';
                currentmap_pointer(2) = currentmap_pointer(1);
            elseif diffsteps<0
                maphistory{1,currentmap_pointer(1)+1:currentmap_pointer(2)} = currentmap2;
                maphistory{3,currentmap_pointer(1)+1:currentmap_pointer(2)} = 'nothing'; 
                currentmap_pointer(1) = currentmap_pointer(2);
            end            
            AdvanceRightTracker_Callback(righttext,newmapright);
            AdvanceLeftTracker_Callback(lefttext,newmapleft);
        elseif leftorrightorboth == 1
            if currentmap_pointer(1)<=currentmap_pointer(2)
                AdvanceLeftTracker_Callback(lefttext,newmapleft);
            end
        else
            if currentmap_pointer(2)<=currentmap_pointer(1)
                AdvanceRightTracker_Callback(righttext,newmapright);
            end
        end
        resetAll
        updateAll
    end
        
        
    function ResetXCorrPlot_Callback(hObject,eventdata)
       set(Xcorr_axes,'visible','off')
%        Xcorr_axes.Visible = 0;
       Feedback_text.String = '';
       sug_move = [0,0];
       cla(Xcorr_axes)
%        cla(Xcorrlegend)
%        Xcorrlegend.Visible = 'off';
    end

    function Xcorr_Callback(hObject,eventdata)
        if XCorr_button.Value == 1
            
            [nx1,~,~] = size(currentmap1);
            [nx2,~,~] = size(currentmap2);
            if nx1 ~= nx2
                
            else
                if currentmaptracker == 1
                    m1 = currentmap1;
                    m2 = currentmap2;
                    l1 = map1layer; l2 = map2layer;
                    activetext = ' left FOV ';
                else
                    m1 = currentmap2;
                    m2 = currentmap1;
                    l2 = map1layer; l1 = map2layer;
                    activetext = ' right FOV ';
                end
                
                %% plot cross correlation and center and max Xcorr
                XCorr = norm_xcorr2d(m2.map(:,:,l1),m1.map(:,:,l2));
                center = findcenter(m1);
                
                [~,i] = max(max(XCorr));
                [~,j] = max(max(XCorr'));
                
                colormap(Cmap);
                imagesc(Xcorr_axes,XCorr);
                Xcorr_axes.XGrid = 'off';
                Xcorr_axes.YGrid = 'off';
                hold(Xcorr_axes,'on')
                plot(Xcorr_axes,center,center,'r.','MarkerSize',10)
                plot(Xcorr_axes,i,j,'kx','MarkerSize',10)
%                 Xcorrlegend =  legend(Xcorr_axes,'Center','max');
                
                Xcorr_axes.DataAspectRatio = [1 1 1];
                Xcorr_axes.AmbientLightColor = 'white';
                
                %% advice shift m1 is supposed to shift to match m2
                sug_move(1) = i-center;
                sug_move(2) = j-center;
                
                
                suggestion = strcat('suggest: move',activetext,num2str(sug_move(1)),' px right, ',...
                    num2str(sug_move(2)),' down');
                Feedback_text.String = suggestion;
                AdviceStatus=1;
                
%                 [m2,m1] = crop_to_same_FOV(m2,1,1,m1,1+sug_move(1),1+sug_move(2));
                %             img_obj_viewer_test(m1)
                %             img_obj_viewer_test(m2)
                %
                %             sug_move
                
            end
        else
            ResetXCorrPlot_Callback
        end
        
    end

        
%% Step Forward or Backward

    function StepBack_Callback(hObject,eventdata)
        path1 = currentmap_pointer(1);
        path2 = currentmap_pointer(2);
        if path1==path2
            if path1>1
                currentmap_pointer(1)=max(path1-1,1);
                currentmap_pointer(2)=max(path2-1,1);
            end
        elseif path1>path2
            currentmap_pointer(1)=max(path1-1,1);
        else
            currentmap_pointer(2)=max(path2-1,1);
        end
        
        currentmap1 = maphistory{1,currentmap_pointer(1)};
        currentmap2 = maphistory{2,currentmap_pointer(2)};
        
        resetAll
        updateAll
        zoomout_Callback
    end

    function StepForward_Callback(hObject,eventdata)
        path1 = currentmap_pointer(1);
        path2 = currentmap_pointer(2);
        
        if path1==path2
            if path1<10
                % move forward only if there is something
                if isempty(maphistory{1,path1+1})==0
                    currentmap_pointer(1)=min(path1+1,10);
                end
                if isempty(maphistory{2,path2+1})==0
                    currentmap_pointer(2)=min(path2+1,10);
                end
            end
        elseif path1>path2
            if isempty(maphistory{2,path2+1})==0
                currentmap_pointer(2)=min(path1+1,10);
            end
        else
            if isempty(maphistory{1,path1+1})==0
                currentmap_pointer(1)=min(path2+1,10);
            end
        end
        
        currentmap1 = maphistory{1,currentmap_pointer(1)};
        currentmap2 = maphistory{2,currentmap_pointer(2)};
        
        resetAll
        updateAll
        zoomout_Callback
    end

%% callbacks
    
    function follow_LF_Callback(hObject,eventdata)

        if currentmaptracker == 1
            
            if isfield(currentmap2,'tx') && isfield(currentmap2,'ty')
                newmap = LF_correct_map_v2(currentmap2.tx,currentmap2.ty,currentmap1);
                text = 'follow_LF';
                Advance_Tracker_Callback(1,text,'',newmap,[]);
                resetAll
                updateAll
            else
                Feedback_text.String = strcat('Right image was not LF corrected, does not have fields "tx", "ty"');
            end
        else
            if isfield(currentmap1,'tx') && isfield(currentmap1,'ty')
                newmap = LF_correct_map_v2(currentmap1.tx,currentmap1.ty,currentmap2);
                text = 'follow_LF';
                Advance_Tracker_Callback(2,'',text,[],newmap);
                resetAll
                updateAll
            else
                Feedback_text.String = strcat('Left image was not LF corrected, does not have fields "tx", "ty"');
            end                
        end
    end

    function follow_shear_callback(hObject,eventdata)

        if currentmaptracker == 1
            
            if isfield(currentmap2,'ptheta')
                text = 'follow_Shear';
                newmap = shear_correct_hex(currentmap1,[0,0],[0,0],'ptheta',currentmap2.ptheta);
                Advance_Tracker_Callback(1,text,'',newmap,[]);
                resetAll
                updateAll
            else
                Feedback_text.String = strcat('Right image was not shear corrected, does not have fields "ptheta"');
            end
        else
            if isfield(currentmap1,'ptheta') 
                text = 'follow_Shear';
                newmap = shear_correct_hex(currentmap2,[0,0],[0,0],'ptheta',currentmap1.ptheta);
                Advance_Tracker_Callback(2,'',text,[],newmap);
                resetAll
                updateAll
            else
                Feedback_text.String = strcat('Left image was not LF corrected, does not have fields "ptheta"');
            end                
        end
    end
    
    function divide_callback(hobject,eventdata,val)
        val = 1/val;
        if val>0
            scale_lines(abs(val),2);
        else
            scale_lines(abs(val),1);
        end
        updateAll
    end
       
    function extend_callback(hobject,eventdata,val)
        if val>0
            scale_lines(abs(val),2);
        else
            scale_lines(abs(val),1);
        end
        updateAll
    end

    function scale_lines(val,changepoint1or2)
       [indexleft,indexright] = selected_lines_index;
       for iL = 1:length(indexleft)
           points = contructionlines{1}(indexleft(iL),:);%[x1,x2,y1,y2]
           p1 = [points(1),points(3)];
           p2 = [points(2),points(4)];
           if changepoint1or2 == 1
               p1 = p2-(p2-p1)*val;
           elseif changepoint1or2 == 2
               p2 = p1+(p2-p1)*val;
           end
           x1 = p1(1);x2 = p2(1);y1 = p1(2);y2 = p2(2);
           contructionlines{1}(indexleft(iL),:) = [x1,x2,y1,y2];
       end
       for iR = 1:length(indexright)
           points = contructionlines{2}(indexright(iR),:);%[x1,x2,y1,y2]
           p1 = [points(1),points(3)];
           p2 = [points(2),points(4)];
           if changepoint1or2 == 1
               p1 = p2-(p2-p1)*val;
           elseif changepoint1or2 == 2
               p2 = p1+(p2-p1)*val;
           end
           x1 = p1(1);x2 = p2(1);y1 = p1(2);y2 = p2(2);
           contructionlines{2}(indexright(iR),:) = [x1,x2,y1,y2];
       end
       
        
    end


    function setcolor(ax,col)
        if ischar(col)||isstring(col)
%             color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
            color_map_path = fullfile(fileparts(mfilename('fullpath')),'..','..','\STM View\Color Maps\');

            color_map = struct2cell(load([color_map_path col]));
            color_map = color_map{1};
        else
            color_map = col;
        end
        colormap(ax,color_map);
    end

    function subtractlinearplane 
        if isempty(currentplot1)
        if plotpreptopo == 1
            currentplot1 = polyn_subtract(currentmap1,1,'noplot');
            currentplot2 = polyn_subtract(currentmap2,1,'noplot');
        else
            currentplot1 = currentmap1;
            currentplot2 = currentmap2;
        end
        end
    end

    function plot_img1_Callback(hObject,eventdata)
        plot_img_Callback(1);
    end

    function plot_img_Callback(oneortwo)
        subtractlinearplane 
        if oneortwo == 1
            data = currentplot1;
            layer = map1layer;
            ax = img1_axes;
            axcol = axcol1;
            xlim = xlimleft;
            ylim = ylimleft;
            
            caxisvalleft = img1_axes.CLim;
            histoleft = generate_and_set_color_histogram(currentmap1);
            clim = caxisvalleft;
        else
            data = currentplot2;
            layer = map2layer;
            ax = img2_axes;
            axcol = axcol2;
            xlim  = xlimright;
            ylim = ylimright;
            
            caxisvalright = img2_axes.CLim;
            historight = generate_and_set_color_histogram(currentmap2);
            clim = caxisvalright;
        end
        plotdata = data.map(:,:,layer);
        
%         if plotpreptopo == 1
%             plotdata = polyn_subtract(data,1,'noplot').map(:,:,layer);
%         end
        imagesc(ax,plotdata);
        setcolor(ax,axcol);
        
        ax.XLim = xlim;
        ax.YLim = ylim;
        ax.CLim = clim;
        
        ax.XGrid = 'off';
        ax.YGrid = 'off';
        
        
        ax.DataAspectRatio = [1 1 1];
        ax.AmbientLightColor = 'white';
        
        
        hold(ax,'on');
        
        
    end

    function plot_img2_Callback(hObject,eventdata)
        plot_img_Callback(2);
    end


    function zoom_Callback(hObject,eventdata)
        %trig = "triggered"
        if strcmp(get(f4,'Label'),'Zoom OFF')
            %zom = "zoom"
            set(zh,'Enable','on');
            set(f4,'Label','Zoom ON')
        else
            %zom = "nozoom"
            set(zh,'Enable','off');
            set(f4,'Label','Zoom OFF')
        end
    end

    function zoomout_Callback(hObject,eventdata)
       xlim(img1_axes,[0.5 size(currentmap1.map,1)+0.5]); 
       ylim(img1_axes,[0.5 size(currentmap1.map,2)+0.5]); 
       xlim(img2_axes,[0.5 size(currentmap2.map,1)+0.5]);
       ylim(img2_axes,[0.5 size(currentmap2.map,2)+0.5]); 

    end
    
    
    function leftactive(hObject,eventdata)
       currentmap = currentmap1;
       currentmaptracker = 1;
       active_maptitle.String = 'Active: left';

%        updateAll
    end

    function rightactive(hObject,eventdata)
        currentmap = currentmap2;
        currentmaptracker = 2;        
        active_maptitle.String = 'Active: right';

%        updateAll
    end

    function subpxleft(hObjet,eventdata)
        Feedback_text.String = num2str(subpxBragglist{1});
        subpxBragglist{1}
    end

    function subpxright(hObjet,eventdata)
        Feedback_text.String = num2str(subpxBragglist{2});
        subpxBragglist{2}
    end

    function Done_Callback(hObject,eventdata)
        default_name = strcat('maphistory_',map1.name,'_',map2.name);
        answer = wrk_space_dialogue(default_name);
        if ~isempty(answer)
            assignin('base',answer{1},maphistory)
            close(h1)
        end
        
    end

    %% contruction lines callbacks
    function construction_lines_Callback(hObject,eventdata,leftorright,col)
        [pixx,pixy,button]=ginput(1);
        getout = 0;
        switch button
            case 1 %left click
                %                 disp("left click")
                
            case 2 % middle click
                %                 disp("middle click")
                
            case 3 % right click
                getout = 1;
                %                 disp("right click")
            case 27
                %                 disp("escape button")
        end
        
        if getout == 0
            if leftorright == 1
                axes = img1_axes;
            else
                axes = img2_axes;
            end
            col = strcat(col,'.');
            plot(axes,pixx,pixy,col,'MarkerSize',10);
            
            [pixx2,pixy2,button]=ginput(1);
            switch button
                case 1 %left click
                    %                 disp("left click")
                    
                case 2 % middle click
                    %                 disp("middle click")
                    
                case 3 % right click
                    %                 disp("right click")
                case 27
                    %                 disp("escape button")
            end
            
            x = [pixx,pixx2];
            y = [pixy,pixy2];
            %         plot(axes,x,y,col);
            
            
            nlines = ncontructionlines(leftorright);
            
            if nlines<6
                nlines = nlines+1;
                ncontructionlines(leftorright)=nlines;
                lineinput = [x,y];
                
                contructionlines{leftorright}(nlines,:)=lineinput;
                if leftorright==1
                    leftConstructionCheckbox{nlines}.Value=1;
                else
                    rightConstructionCheckbox{nlines}.Value=1;
                end
            end
            updateAll
            
        end
        
    end

    function removelines_Callback(hobject,eventdata,leftorright)
        toberemoved = zeros(6,1);
        n = 1;
        for i=1:ncontructionlines(leftorright)
            if leftorright == 1
                if leftConstructionCheckbox{i}.Value == 0
                    toberemoved(n)=i;
                    n=n+1;
                end
            else
                if rightConstructionCheckbox{i}.Value == 0
                    toberemoved(n)=i;
                    n=n+1;
                end
            end
        end
        toberemoved(n:end)=[];
        toberemoved = fliplr(toberemoved);
%         size(contructionlines{leftorright})
        for j = 1:length(toberemoved)
            contructionlines{leftorright}(toberemoved(j),:)=[];
            contructionlines{leftorright}(end+1,:) = zeros(1,4);            
        end
        ncontructionlines(leftorright) = ncontructionlines(leftorright)-(n-1);  
        
        % make checkbox consistent
        for j=1:6
            if j>ncontructionlines(leftorright)
                if leftorright==1
                    leftConstructionCheckbox{j}.Value=0;
                else
                    rightConstructionCheckbox{j}.Value=0;
                end
            else
                if leftorright==1
                    leftConstructionCheckbox{j}.Value=1;
                else
                    rightConstructionCheckbox{j}.Value=1;
                end
                
            end
        end
        updateAll
    end
    
    %% construction points callbacks
    function points_Callback(hObject,eventdata,leftorright,col)
                [pixx,pixy,button]=ginput(1);
        getout = 0;
        switch button
            case 1 %left click
                %                 disp("left click")
                
            case 2 % middle click
                %                 disp("middle click")
                
            case 3 % right click
                getout = 1;
                %                 disp("right click")
            case 27
                %                 disp("escape button")
        end
        
        if getout == 0
            if leftorright == 1
                axes = img1_axes;
            else
                axes = img2_axes;
            end
            col = strcat(col,'.');
%             plot(axes,100,100,col,'MarkerSize',pointsize);
            plot(axes,pixx,pixy,col,'MarkerSize',pointsize);
            
  
            points = npoints(leftorright);
            
            if points<6
                points = points+1;
                npoints(leftorright)=points;
                pointinput = [pixx,pixy];
                
                contructionpoints{leftorright}(points,:)=pointinput;
                if leftorright==1
                    leftPointsCheckbox{points}.Value=1;
                else
                    rightPointsCheckbox{points}.Value=1;
                end
            end
            updateAll
            
        end
        
    end
    
    function removepoints_Callback(hobject,eventdata,leftorright)
        toberemoved = zeros(6,1);
        n = 1;
        for i=1:npoints(leftorright)
            if leftorright == 1
                if leftPointsCheckbox{i}.Value == 0
                    toberemoved(n)=i;
                    n=n+1;
                end
            else
                if rightPointsCheckbox{i}.Value == 0
                    toberemoved(n)=i;
                    n=n+1;
                end
            end
        end
        toberemoved(n:end)=[];
        toberemoved = fliplr(toberemoved);
%         size(contructionlines{leftorright})
        for j = 1:length(toberemoved)
            contructionpoints{leftorright}(toberemoved(j),:)=[];
            contructionpoints{leftorright}(end+1,:) = zeros(1,2);            
        end
        npoints(leftorright) = npoints(leftorright)-(n-1);  
        
        % make checkbox consistent
        for j=1:6
            if j>npoints(leftorright)
                if leftorright==1
                    leftPointsCheckbox{j}.Value=0;
                else
                    rightPointsCheckbox{j}.Value=0;
                end
            else
                if leftorright==1
                    leftPointsCheckbox{j}.Value=1;
                else
                    rightPointsCheckbox{j}.Value=1;
                end
                
            end
        end
        updateAll

    end

    %% 
    function DrawBraggPeaks_Callback(hObject,eventdata)
        data = currentmap;
        
        %first get amplitude FT displayed
        map = data
        subback0map = polyn_subtract(map,0,3); %something on varargin(3):no-popup
        FTmap = fourier_transform2d(subback0map,'sine','amplitude','ft');
        FTmap.ave = [];
        FTmap.var = [FTmap.var '_ft_amplitude'];
        FTmap.ops{end+1} = 'Fourier Transform: amplitude - sine window - ft direction';
        [~,inner_f,enlist] = img_obj_viewer_test(FTmap);
        inner_enlist = enlist;
        %prompt user to adjust histogram then click ok
        fh_temp=figure('Name', 'Adjust histograms of both maps to your liking',...
            'NumberTitle', 'off',...
            'units','centimeter', ...
            'Position',[1,5,10,2],...
            'Color',[0 0.3 0],...
            'MenuBar', 'none');
        Histograms_adjusted_but = uicontrol(fh_temp,'Style','pushbutton',...
            'String','Histogram adjusted, Select Peaks',...
            'units','normalized',...
            ...%'Position',[0.75 0.1 0.2 0.3],...
            'Position',[0.25 0.4 0.6 0.5],...
            'Callback',{@adjust_histogram_inverse_Callback});
    end


    function BraggPeaks_coordinate_Callback(hObject,eventdata)
        data = guidata(f);
        
        %first get amplitude FT displayed
        map = data;
        img_obj_viewer_test(keep_peak_coord(data))
        
    end

    function tiltplane_callback(hobject,eventdata,yesorno)
        original = plotpreptopo;
        if yesorno==1
            plotpreptopo = 1;
        else
            plotpreptopo = 0;
        end
        if original~=plotpreptopo 
            updateAll
        end
    end

    function plotgrids_Callback(hobject,eventdata,leftorright,Braggnumber,col)
        col
        size(gridlinepairs{leftorright,Braggnumber})
        plotmultiplegridstomap(axestoplot,gridlinepairs{leftorright,Braggnumber},col);
        
        
    end

    function adjust_histogram_inverse_Callback(hObject,evendata)

        % open new window with just the specified layer
        layer=get(inner_enlist,'Value');
        color_lim = get(inner_f,'UserData');
        color_lim = color_lim(layer,:);
        c_map =  get(inner_f,'Colormap');
        
        data = currentmap;
        
        %first get amplitude FT displayed
        map = data;
        subback0map = polyn_subtract(map,0,3); %something on varargin(3):no-popup
        close(fh_temp)
        FT = fourier_transform2d(subback0map,'sine','amplitude','ft');
        Bragg = drawFTpeaks(FT,layer,color_lim,c_map);    
        close(inner_f) %close the FT figure
        Bragglist{currentmaptracker} = Bragg;
        assignin('base','Bragg',Bragg);
        [nBraggs,~]=size(Bragg);
        
        subpxBgs = zeros(nBraggs,2);
        for nb=1:nBraggs
            [gridlinepairs{currentmaptracker,nb},subBg] = plotgrids(currentmap,Bragg(nb,:));
            subpxBgs(nb,:) = subBg;
        end
        subpxBragglist{currentmaptracker} = []; 
        subpxBragglist{currentmaptracker} = subpxBgs; % update subBragglist tracker

        updateAll
    end

    function AxesLinkage_Callback(hObject,eventdata)
       if linktrack == 1
           linktrack = 0;
           axeslinkornot.String = 'Link FOV';
           if strcmp(active_maptitle.String(end-3:end),'left')==1
               linkaxes([img1_axes,img2_axes],'off');
           else
               linkaxes([img2_axes,img1_axes],'off');
           end
       else
           linktrack = 1;
           axeslinkornot.String = 'Unlink FOV';
           if strcmp(active_maptitle.String(end-3:end),'left')==1
               xlimleft = get(img2_axes,'XLim');
               ylimleft = get(img2_axes,'YLim');
               img1_axes.XLim = xlimleft;
               img1_axes.YLim = ylimleft;
               linkaxes([img1_axes,img2_axes]);
           else
               xlimright = get(img1_axes,'XLim');
               ylimright = get(img1_axes,'YLim');
               img2_axes.XLim = xlimright;
               img2_axes.YLim = ylimright;
               linkaxes([img2_axes,img1_axes]);
           end
       end
        
    end

    function updateAll(hObject,eventdata)
        
        %% -1. update colormaps
        axcol1 = get(img1_axes,'Colormap');
        axcol2 = get(img2_axes,'Colormap');
        
        
        %% 0. hold off axes to clear the grids
        hold(img1_axes,'off')
        hold(img2_axes,'off')

        
        
        %% 1. active maptitle
        if currentmaptracker == 1
           active_maptitle.String = 'Active: left';
        else
           active_maptitle.String = 'Active: right';        
        end
        
        %% 2. update plots

        xlimleft = get(img1_axes,'Xlim');
        ylimleft = get(img1_axes,'Ylim');
        xlimright = get(img2_axes,'Xlim');
        ylimright = get(img2_axes,'Ylim');
        
        currentmap1 = maphistory{1,currentmap_pointer(1)};
        currentmap2 = maphistory{2,currentmap_pointer(2)};
        
        
        
        plot_img1_Callback;
        plot_img2_Callback;
        
        
        hold(img1_axes,'on')
        hold(img2_axes,'on')
        
        %% 3. update radiobutton for Braggpeaks and Plot Braggs
        leftBragg = Bragglist{1};        
        rightBragg = Bragglist{2};
        
        [nBraggsleft,~] = size(leftBragg);
        [nBraggsright,~] = size(rightBragg);
        
        constructionleft = contructionlines{1};
        constructionright = contructionlines{2};

        
        Pointsleft = contructionpoints{1};
        Pointsright = contructionpoints{2};

        npointsleft = npoints(1);
        npointsright = npoints(2);
        nlinesleft = ncontructionlines(1);
        nlinesright = ncontructionlines(2);
        
        
        %% allow copy to left/right visible only if Braggs present
        if nBraggsleft == 0
            copytoright.Visible = 0;
        else 
            copytoright.Visible = 1;
        end
        
        if nBraggsright == 0
            copytoleft.Visible = 0;
        else 
            copytoleft.Visible = 1;
        end
        
        
        %% show or hide reference point

        refpoints_remove_optionvisibility_update

        %% show or hide construction lines
        
        linecopy_remove_optionvisibility_update


 
        
        for ii=1:6
            %% Braggs and grids
            if ii>nBraggsleft
                leftBraggcheckbox{ii}.Visible = 'off';
            else
                leftBraggcheckbox{ii}.String = num2str(leftBragg(ii,:));
                leftBraggcheckbox{ii}.Visible = 'on';
                if leftBraggcheckbox{ii}.Value == 1
                    plotmultiplegridstomap(img1_axes,gridlinepairs{1,ii},leftcol);
                    if copytoright.Value ==1
                        plotmultiplegridstomap(img2_axes,gridlinepairs{1,ii},leftcol);
                    end
%                     plotgrids_Callback(1,ii,'r'); % plot red for Bragg left on left image
                end
                
                
            end
            
            
            if ii>nBraggsright
                rightBraggcheckbox{ii}.Visible = 'off';
            else
                rightBraggcheckbox{ii}.String = num2str(rightBragg(ii,:));
                rightBraggcheckbox{ii}.Visible = 'on';
                if rightBraggcheckbox{ii}.Value == 1
                    plotmultiplegridstomap(img2_axes,gridlinepairs{2,ii},rightcol);
                    if copytoleft.Value ==1
                        plotmultiplegridstomap(img1_axes,gridlinepairs{2,ii},rightcol);
                    end
%                     plotgrids_Callback(1,ii,'k'); % plot black for Bragg left on left image
                end
            end
            %% contructionlines
            copycontructionlines(1) = AddLinesToRight.Value;
            copycontructionlines(2) = AddLinesToLeft.Value;
            
            if ii>nlinesleft
                leftConstructionCheckbox{ii}.Visible = 'off';
            else
                leftConstructionCheckbox{ii}.Visible = 'on';
                point = constructionleft(ii,:);
                %possibility of improving line label here
                leftConstructionCheckbox{ii}.String = strcat('line ',num2str(ii));
                
                if leftConstructionCheckbox{ii}.Value == 1
                    plot(img1_axes,point(1:2),point(3:4),contructioncolorleft);
                    
                    if copycontructionlines(1)==1
                        plot(img2_axes,point(1:2),point(3:4),contructioncolorleft);
                    end
                end
            end
            
            if ii>nlinesright
                rightConstructionCheckbox{ii}.Visible = 'off';
            else
                rightConstructionCheckbox{ii}.Visible = 'on';
                point = constructionright(ii,:);
                %possibility of improving line label here
                rightConstructionCheckbox{ii}.String = strcat('line ',num2str(ii));
                
                if rightConstructionCheckbox{ii}.Value == 1
                    plot(img2_axes,point(1:2),point(3:4),contructioncolorright);
                    
                    
                    if copycontructionlines(2)==1
                        plot(img1_axes,point(1:2),point(3:4),contructioncolorright);
                    end
                end
            end
            
            %% construction points      
            
            copypoints(1) = AddPointsToRight.Value;
            copypoints(2) = AddPointsToLeft.Value;
            
            if ii>npointsleft
                leftPointsCheckbox{ii}.Visible = 'off';
            else
                leftPointsCheckbox{ii}.Visible = 'on';
                point = Pointsleft(ii,:);
                %possibility of improving line label here
                leftPointsCheckbox{ii}.String = num2str(point);
                
                if leftPointsCheckbox{ii}.Value == 1
                    plot(img1_axes,point(1),point(2),strcat(contructioncolorleft,'.'),'MarkerSize',pointsize);
                    
                    if copypoints(1)==1
                        plot(img2_axes,point(1),point(2),strcat(contructioncolorleft,'.'),'MarkerSize',pointsize);
                    end
                end
            end
            
            if ii>npointsright
                rightPointsCheckbox{ii}.Visible = 'off';
            else
                rightPointsCheckbox{ii}.Visible = 'on';
                point = Pointsright(ii,:);
                %possibility of improving line label here
                rightPointsCheckbox{ii}.String = num2str(point);
                
                if rightPointsCheckbox{ii}.Value == 1
                    plot(img2_axes,point(1),point(2),strcat(contructioncolorright,'.'),'MarkerSize',pointsize);
                    
                    
                    if copypoints(2)==1
                        plot(img1_axes,point(1),point(2),strcat(contructioncolorright,'.'),'MarkerSize',pointsize);
                    end
                end
            end
            

            
        end
        
        %% 4. update status bar
        for k=1:10
            text = maphistory{3,k};
            text = text(1:min(11,length(text)));
            if isempty(text)~=0
                if k~=1
                    text = strcat('==>',text);
                end
            end
            status_text{k,1}.String = text;
            if currentmap_pointer(1)==k
                status_text{k,1}.FontWeight = 'bold';
            else
                status_text{k,1}.FontWeight = 'normal';
            end
            
            text = maphistory{4,k};
            text = text(1:min(11,length(text)));
            if isempty(text)~=0
                if k~=1
                    text = strcat('==>',text);
                end
            end
            status_text{k,2}.String = text;
            if currentmap_pointer(1)==k
                status_text{k,2}.FontWeight = 'bold';
            else
                status_text{k,2}.FontWeight = 'normal';
            end
        end
        
        %% 5.advice from crop
        if CropAdvice(1,:)~=0
            TL = CropAdvice(1,1:2);BR =CropAdvice(1,3:4);
            [x,y]=Cropplotpoints(TL,BR);
            plot(img1_axes,x,y,'k');
        end
        if CropAdvice(2,:)~=0
            TL = CropAdvice(2,1:2);BR =CropAdvice(2,3:4);
            [x,y]=Cropplotpoints(TL,BR);
            plot(img2_axes,x,y,'k');
        end
        
        %% make it such that the zoom function is still enabled according to previous choice
        if strcmp(get(f4,'Label'),'Zoom OFF')
            set(zh,'Enable','off');
        else
            set(zh,'Enable','on');
        end
        
    end

    function linecopy_remove_optionvisibility_update
        %% show or hide construction lines
        nlinesleft = ncontructionlines(1);
        nlinesright = ncontructionlines(2);
        if nlinesleft == 0
            Remove_leftlines_checkbox.Visible = 0;
            AddLinesToRight.Visible = 0;
        else 
            Remove_leftlines_checkbox.Visible = 1;
            AddLinesToRight.Position(2) = (0.2-0.03*(ncontructionlines(1)))*height ;
            AddLinesToRight.Visible = 1;
        end

        if nlinesright == 0
            Remove_rightlines_checkbox.Visible = 0;
            AddLinesToLeft.Visible = 0;
        else 
            Remove_rightlines_checkbox.Visible = 1;
            AddLinesToLeft.Position(2) = (0.2-0.03*(ncontructionlines(2)))*height ;
            AddLinesToLeft.Visible = 1;
        end
        
    end

    function refpoints_remove_optionvisibility_update 
        npointsleft = npoints(1);
        npointsright = npoints(2);
       
        if npointsleft == 0
            Remove_leftpoints_checkbox.Visible = 0;
            AddPointsToRight.Visible = 0;
        else 
            Remove_leftpoints_checkbox.Visible = 1;
            AddPointsToRight.Position(2) = (0.2-0.03*(npoints(1)))*height ;
            Remove_leftpoints_checkbox.Position(2) = AddPointsToRight.Position(2);
            AddPointsToRight.Visible = 1;
        end
        
        
        if npointsright == 0
            Remove_rightpoints_checkbox.Visible = 0;
            AddPointsToLeft.Visible = 0;
        else 
            Remove_rightpoints_checkbox.Visible = 1;
            AddPointsToLeft.Position(2) = (0.2-0.03*(npoints(2)))*height ;
            Remove_rightpoints_checkbox.Position(2) = AddPointsToLeft.Position(2);
            AddPointsToLeft.Visible = 1;
        end
    end

    function [indexleft,indexright] = selected_lines_index
        % index will be in the form of 
        % indexleft = [2,4] means lines 2 and 4 (from left) are checked
        % indexright = [] means no lines are checkd from right
        indexleft = zeros(6,1);
        indexright = zeros(6,1);
        lefttrack = 1;righttrack = 1;
        
        nlinesleft = ncontructionlines(1);
        nlinesright = ncontructionlines(2);
        for ii = 1:6
            if ii<=nlinesleft
                if leftConstructionCheckbox{ii}.Value == 1
                    indexleft(lefttrack)=ii;
                    lefttrack=lefttrack+1;
                end
            end
            
            
            if ii<=nlinesright
                if rightConstructionCheckbox{ii}.Value == 1
                    indexright(righttrack)=ii;
                    righttrack=righttrack+1;
                end
            end
        end
        indexleft(lefttrack:end)=[];
        indexright(righttrack:end)=[];
    end




%% functions for resettings

    function resetCaxis
        currentplot1 = [];
        currentplot2 = [];
        subtractlinearplane
        [historight,caxisvalright] = generate_and_set_color_histogram(currentplot2);
        [histoleft,caxisvalright] = generate_and_set_color_histogram(currentplot1);
        set(img1_axes,'CLim',caxisvalleft);
        set(img1_axes,'CLim',caxisvalright);
    end

    function resetAll(hObject,eventdata) %except maphistory 
        resetCaxis
        
        
        %mainly parameters that can be changed by user construction
        %lines,Braggs, etc...
        
        for p=1:6
            leftBraggcheckbox{p}.Visible = 0;
            rightBraggcheckbox{p}.Visible = 0;
            
            leftConstructionCheckbox{p}.Visible = 0;
            rightConstructionCheckbox{p}.Visible=0;
            
            leftPointsCheckbox{p}.Visible = 0;
            rightPointsCheckbox{p}.Visible = 0;
            leftPointsCheckbox{p}.Value = 0;
            rightPointsCheckbox{p}.Value = 0;
        end

            
%         currentmap1 = map1;
%         currentmap2 = map2;
        currentmap = currentmap1;
        currentmaptracker = 1;
        
        
        Bragglist{1} = []; % in the callback, this will be filled x = [#,1], y=[#,2]
        Bragglist{2} = [];
        
        gridlinepairs = cell(2,6);
        xlimleft = [0.5 size(currentmap1.map,1)+0.5];
        ylimleft = [0.5 size(currentmap1.map,2)+0.5];
        xlimright = [0.5 size(currentmap2.map,1)+0.5];
        ylimright = [0.5 size(currentmap2.map,2)+0.5];
        
        contructionlines = cell(2,1);
        contructionlines{1} = zeros(6,4);
        contructionlines{2} = zeros(6,4);
        ncontructionlines = [0,0];
        
        contructionpoints = cell(2,1);
        contructionpoints{1} = zeros(6,2);
        contructionpoints{2} = zeros(6,2);
        npoints = [0,0];
        
        copycontructionlines = [0,0];
        copypoints = [0,0];
        
        %% reset advice
        AdviceStatus = 0;
        CropAdvice = zeros(2,4);
        
        %% reset XCorr
        ResetXCorrPlot_Callback
        
    end

%% functions regarding GRIDlines

function plotmultiplegridstomap(axes,varargin)
%input(axes,pairs,col)
for i=1:round((nargin-1)/2)
    col = varargin{i*2};
    pairs = varargin{i*2-1};
    [npairs,~,~]=size(pairs);
    for j=1:npairs
        x = squeeze(pairs(j,:,1));
        y = squeeze(pairs(j,:,2));
        plot(axes,x,y,col);
%         axes.plot(x,y,col);
    end
end



end

function plotgridtomap(map,pairs)
figure,imagesc(map.map);
hold on
[npairs,~,~]=size(pairs);
for j=1:npairs
    x = squeeze(pairs(j,:,1));
    y = squeeze(pairs(j,:,2));
    plot(x,y,'r');
end

end


    function [combinepairs,subpxBgs] = plotgrids(map,varargin)
        totalpairs = 0;
        % figure,imagesc(map.map)
        % hold on
        subpxBgs = zeros(nargin-1,2);
        for i=1:nargin-1
            Bragg = varargin{i};
            [pairs,subBg] = FOVpairs(Bragg(1),Bragg(2),map);
            subpxBgs(i,:) = subBg;
            
            [npairs,~,~]=size(pairs);
            combine{i} = pairs;
            %     for j=1:npairs
            %         x = squeeze(pairs(j,:,1));
            %         y = squeeze(pairs(j,:,2));
            %         plot(x,y,'r');
            %     end
            totalpairs = npairs+totalpairs;
        end
        combinepairs = zeros(totalpairs,2,2);
        pointer = 1;
        for k=1:nargin-1
            pairs = combine{k};
            [npairs,~,~]=size(pairs);
            combinepairs(pointer:pointer-1+npairs,:,:) = pairs;
            pointer = pointer+npairs;
        end
        
    end


% given Braggpeak, and map
function [pairs,Bragg] = FOVpairs(Braggx,Braggy,map,varargin)

%% improvement: varargin to shift grid


%% the rest

    

[Bragg,phase] = subpixelBragg(map,Braggx,Braggy);

assignin('base','pairs',Bragg)

[nx,~,~]=size(map.map);
centerpx = floor(nx/2+1);
dky = Bragg(2)-centerpx;
dkx = Bragg(1)-centerpx;

gradient = -dkx/dky; %kspace to real space, inverse gradient
%     dist = nx/sqrt(dkx^2+dky^2);


if gradient ~= 1/0    
    atomx = 1;
    yspace = nx/abs(dky);
    atomy = yspace*((phase)/(2*pi));

    estimate = round(nx/yspace)-3;
    
    % pairnumber,x,y
    pairs = zeros(estimate+5,2,2);
    
    if gradient > 0
        intercept = atomy-gradient*atomx+(estimate+5)*yspace; % pedagogical
        addorsub = -1;

    else
        intercept = atomy-gradient*atomx;
        addorsub = +1;       
    end
    
    stop = 0;
    count = 0;
    while stop == 0
        [in_or_not,x,y]=boundarypoints(gradient,intercept,nx);
        if in_or_not == 1
            count = count+1;
            pairs(count,1,1)=x(1);
            pairs(count,1,2)=y(1);
            pairs(count,2,1)=x(2);
            pairs(count,2,2)=y(2);
        end
        
        if count>estimate && in_or_not == 0
            stop = 1;
            pairs(count+1:end,:,:)=[];
        end
        intercept = intercept + addorsub*yspace;
    end
    
else
    xspace = nx/abs(dkx);
    lo = 0.5;
    hi = nx+0.5;
    
    atomx = xspace*((phase)/(2*pi));
    estimate = round(nx/yspace)-3;
    pairs = zeros(estimate+5,2,2);
    if atomx<0
        atomx = atomx+xspace;
    end
    count = 0;
    stop = 0;
    while stop == 0
        count = count+1;
        if atomx>xspace
            stop =1;
            pairs(count:end,:,:)=[];
        else        
            pairs(count,1,1)=atomx;
            pairs(count,1,2)=lo;
            pairs(count,2,1)=atomx;
            pairs(count,2,2)=hi;
        end
        atomx = atomx + xspace;

    end



end

end

% given gradient and intercept, and nx for imagesc, return edge coordinate
% pairs
function [in_or_not,x,y]=boundarypoints(gradient,intercept,pixsize)

lo = 0.5;
hi = pixsize+0.5; %translate boundaries from imagesc


in_or_not=1;

left_intercept = polyval([gradient,intercept],lo);
right_intercept = polyval([gradient,intercept],hi);

%% draw two vertical walls on the box sides, consider those lines.
if left_intercept>hi 
    if right_intercept>hi 
        in_or_not = 0;
    elseif right_intercept>lo
        x = [hi,(hi-intercept)/gradient];
        y = [right_intercept,hi];
    else
        x = [(hi-intercept)/gradient,(lo-intercept)/gradient];
        y = [hi,lo];
    end
elseif left_intercept<lo
    if right_intercept<lo
       in_or_not = 0;
    elseif right_intercept<hi
        x = [(lo-intercept)/gradient,hi];
        y = [lo,right_intercept];
    else
        x = [(hi-intercept)/gradient,(lo-intercept)/gradient];
        y = [hi,lo];
    end
else
    if right_intercept>hi
        x = [lo,(hi-intercept)/gradient];
        y = [left_intercept,hi];
    elseif right_intercept<lo
        x = [lo,(lo-intercept)/gradient];
        y = [left_intercept,lo];
    else
        x = [lo,hi];
        y = [left_intercept,right_intercept];
    end
end

if in_or_not==0
    x = [0,0];
    y = [0,0];
end

end
    



% go to the vicinity of the bragg peak and vicinity and weighted average
    function [newBragg,phase] = subpixelBragg(map,x,y)
        window = 5;
        
        %% first do background sub and FT
        mapsub = polyn_subtract(map,0,'noplot'); %dependency
        FTmap = fourier_transform2d(mapsub,'sine','amplitude','ft');
        [nx,~,~] = size(mapsub.map);
        
        %% mask and do weighted average (find center of mass)
        mask = zeros(nx,nx);
        mask(y-window:y+window,x-window:x+window)=FTmap.map(y-window:y+window,x-window:x+window);
        [X,Y] = meshgrid(linspace(1,nx,nx),linspace(1,nx,nx));
        M = sum(sum(mask));
        Braggx = sum(sum(mask.*X))/M;
        Braggy = sum(sum(mask.*Y))/M;
        newBragg = [Braggx,Braggy];
        
        %% get phase of Bragg peak
        FTmap2 = fourier_transform2d(mapsub,'sine','phase','ft');
        % phase = pixel_val_interp(FTmap2.map,Braggx,Braggy);
        phase = FTmap2.map(round(Braggy),round(Braggx));
        % the real and imaginary part oscillate wildly, not a good idea to
        % interpolate
    end


    function newtopo=croptopo(data,x1,x2,y1,y2)
        
        %         [nr nc nz] = size(data.map);
        img = data.map;
        
        
        new_img = crop_img(img,y1,y2,x1,x2);
        
        
        new_data = data;
        new_data.map = new_img;
        new_data.ave = squeeze(mean(mean(new_img)));
        new_data.r = data.r(1:(x2-x1)+1);
        new_data.var = [new_data.var '_crop'];
        new_data.ops{end+1} = ['Crop:' num2str(x1) ' ,' num2str(y1) ':' num2str(x2) ' ,' num2str(y2)];
        %             img_obj_viewer_test(new_data);
        newtopo = new_data;
        
    end

%% more functions for analysis

    function centerpx = findcenter(map)
        if isstruct(map)
            nx = size(map.map,1);
        else
            nx = size(map,1);
        end
        centerpx = ceil((nx+1)/2);
    end

%% import/export callbacks
    function open_in_viewer_Callback(hObject,eventdata,leftorright)
        if leftorright==1
            img_obj_viewer_test(currentmap1);
        else
            img_obj_viewer_test(currentmap2);
        end
    end

    function Import_from_viewer_Callback(hObject,eventdata,workorGUI,leftorright)
        if workorGUI==1
            [str,text] = load_wrkspc_dialogue_withtext;
            
            
            
        else
            [str,text] = load_wrkspc_dialogue_withtext;
 
            
        end
        
        
        
        if leftorright == 1
            newmap1 = evalin('base',str);
            Advance_Tracker_Callback(1,text,' ',newmap1,[])
        else
            newmap2 = evalin('base',str);
            Advance_Tracker_Callback(2,' ',text,[],newmap2)
        end
        
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


end





