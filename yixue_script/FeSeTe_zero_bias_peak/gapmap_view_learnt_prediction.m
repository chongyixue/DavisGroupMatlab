% 2019-7-11 YXC
% read and plot predictions from machine learning
% gapmap FeSeTe
% need map and two csv files: one for spectra and another for prediction

% predfile example (python coord start from 0, all in terms of index)
%        0   1   2   (left co. right coherence peak, gap.)
%     0  45  73  32  
%     1  23  52  29  
%     2  14  ..  ..  
%     3  42  ..  ..  

% specfile example 
%        0   1   2   3   4 ...
%     1  45  43  32  ..
%     2  23  22  ..  ..
%     3  14  ..  ..  ..
%     4  42  ..  ..  .

function [f,gapmap] = gapmap_view_learnt_prediction(map,varargin)

% map = obj_90708a00_G;
[nx,ny,~] = size(map.map);

energy = map.e*1000;

% middle = 1000*(map.e(1)+map.e(end))/2;
% pathname = "C:\Users\chong\Desktop\FeSeTe\fesete2019\FeSeTe_2019_log";
% datapath = 'C:\Users\chong\Documents\MATLAB\STMdata\FeSeTe_2019\';

pathname = 'C:\Users\chong\Desktop\machine learning\STM\';

name = map.name(1:end-3); %90708

% specfile = 'FST90708_allspec.csv';
specfile = strcat(name,'_allspec.csv');
predfile = strcat(['prediction_',specfile]);
predfile = strcat(pathname,predfile);
specfile = strcat(pathname,specfile);
scramble = 0;
figurename = map.name;

if nargin>1
    pair = fix(nargin-1)/2;
    for prop = 1:pair
        propname = varargin{prop*2-1};
        if strcmp(varargin{prop*2-1},'specfile')==1
            specfile = varargin{prop*2};
            if length(specfile)<55
                specfile = strcat(pathname,specfile);
            end
        elseif strcmp(varargin{prop*2-1},'predfile')==1
            predfile = varargin{prop*2};
            if length(predfile)<55
                predfile = strcat(pathname,predfile);
            end
        elseif strcmp(varargin{prop*2-1},'suffix')==1
            nam = varargin{prop+1};
            name = strcat(nam,name); % FST90708
            specfile = strcat(pathname,name,'_allspec.csv');
            predfile = strcat(pathname,'prediction_',name,'_allspec.csv');
        elseif strcmp(varargin{prop*2-1},'random')==1
            if varargin{prop+1} == 1
                scramble = 1;
            end
        elseif strcmp(varargin{prop*2-1},'name')==1
            figurename = varargin{prop+1};
        else
            dis = strcat(['"',propname,'"',' is not a valid property']);
            disp(dis);
        end
    end
end




specs = xlsread(specfile);
specs(1,:) = [];
specs(:,1) = [];
% size(specs)
pred = xlsread(predfile);
pred(1,:) = [];
pred(:,1) = [];
% size(pred)

asp_r = 2;
w_spec = 0.55;w_xy = 0.2;
ax_xy_pos    = [0.05,0.5,w_xy,w_xy*asp_r];
ax_spect_pos = [0.3 ,0.4,w_spec,w_spec];

f=figure();
f.Position = [400,300,500*asp_r,500];
set(f,'Name',figurename);
w = 0.1;h=0.05;
leftpos = ax_spect_pos; leftpos(1)=leftpos(1)-0.05;leftpos(2) = 0.2;
leftpos(3) = leftpos(3)*1.2;leftpos(4) = 0.05;
rightpos = leftpos; rightpos(2) = 0.1;

annotation('textbox',[leftpos(1)-0.05,leftpos(2),leftpos(3),leftpos(4)],'String','LEFT','LineStyle','none');
annotation('textbox',[rightpos(1)+rightpos(3),rightpos(2),rightpos(3),rightpos(4)],'String','RIGHT','LineStyle','none');



next_button = uicontrol('Parent',f,'Style','pushbutton','String','next',...
    'Units','normalized','Position',[0.87,0.5,0.1,0.1],...
    'BackgroundColor',[0.5,0.85,0.2],'FontSize',14,...
    'Callback',@next_callback);
skip_button = uicontrol('Parent',f,'Style','pushbutton','String','skip',...
    'Units','normalized','Position',[0.87,0.63,0.1,0.1],...
    'FontSize',14,...
    'Callback',@skip_callback);
export_button = uicontrol('Parent',f,'Style','pushbutton','String','export',...
    'Units','normalized','Position',[0.87,0.3,0.1,0.1],...
    'BackgroundColor',[0.5,0.85,0.2],'FontSize',14,...
    'Callback',@export_callback);


remlinear = linspace(1,nx*ny,nx*ny);
if scramble == 1    
    pointer = randperm(nx*ny);
    % size(pointer)
    [~,sortorder] = sort(pointer);
    remlinear = remlinear(sortorder);
end
[xx,yy] = one2xy(remlinear,nx); %% xx and yy - list of x and y coord respectively


% show how many spectra you've viewed
counter = 1;
txt_count = annotation('textbox',[0.05,0.2,w_xy,h],...
            'String','counter = 0','LineStyle','none','FontSize',15);

index = counter;
x = xx(index);y = yy(index);
coord = xy2coord(x,y,nx);
posstring = strcat(['(',num2str(x),' ,',num2str(y),')   ID = ',num2str(remlinear(counter))]);
textbox = annotation('textbox',[0.05,0.5+w_xy*asp_r-0.06,w_xy,h],'String',posstring,'LineStyle','none','FontSize',12);
% spect = squeeze(squeeze(map.map(y,x,:)))';
spect = specs(coord,:)';
maxx = max(spect);minn = min(spect);
rang = maxx-minn;maxx = maxx+rang*0.05;minn = minn-rang*0.05;

update_loc_plot

lefti = pred(coord,1); righti = pred(coord,2);
left = convert2en(lefti,energy);
right = convert2en(righti,energy);
leftx = [left,left];
rightx = [right,right];

leftstr = ' ';leftistr = ' ';rightstr = ' ';rightistr = ' ';gapstr = ' ';
update_lr_str
a1 = annotation('textbox',[0.05,0.35,0.1,0.1],'String',leftstr,'LineStyle','none','FontSize',12);
a2 = annotation('textbox',[0.1,0.3,0.1,0.1],'String',leftistr,'LineStyle','none','FontSize',10);
a3 = annotation('textbox',[0.05,0.25,0.1,0.1],'String',rightstr,'LineStyle','none','FontSize',12);
a4 = annotation('textbox',[0.1,0.2,0.1,0.1],'String',rightistr,'LineStyle','none','FontSize',10);
a5 = annotation('textbox',[0.05,0.4,0.1,0.1],'String',gapstr,'LineStyle','none','FontSize',12);



update_spec



%% callback functions
    function export_callback(hobject,eventdata)
        le = pred(:,1);
        ri = pred(:,2);
%         ga = pred(:,3);
        le = convert2en(le,energy);
        ri = convert2en(ri,energy);
%         ga = convert2en(ga,energy);
        gapmap = map;
        le = reshape(le,nx,ny);
        ri = reshape(ri,nx,ny);
        ga = reshape((ri-le)/2,nx,ny);
        gapmap.e = [0,-0.001,0.001];
        gapmap.map = gapmap.map(:,:,1:3);
        gapmap.map(:,:,1) = ga';
        gapmap.map(:,:,2) = le';
        gapmap.map(:,:,3) = ri';    
        gapmap.name = strcat(['gapmap_',gapmap.name]);
        gapmap.ave = gapmap.ave(1:3);
        img_obj_viewer_test(gapmap)
    end

    function update_left_Callback(hobject,~)
        l = hobject.Value;
        leftx = [l,l];
        update_plot;
    end

    function update_right_Callback(hobject,~)
        r = hobject.Value;
        rightx = [r,r];
        update_plot;
    end

    function next_callback(hobject,eventdata)
        
        txt_count.String =  strcat(['counter = ',num2str(counter)]);
        counter = counter+1;
        if counter>length(remlinear)
            close(f)
        else
            
            update_spec
        end
    end

    function update_spec(hobject,eventdata)
            x = xx(counter);y = yy(counter);
            coord = xy2coord(x,y,nx);
            posstring = strcat(['(',num2str(x),' ,',num2str(y),')   ID = ',num2str(remlinear(counter))]);
            textbox.String = posstring;
            spect = specs(coord,:)';
            maxx = max(spect);minn = min(spect);
            rang = maxx-minn;maxx = maxx+rang*0.05;minn = minn-rang*0.05;
            
            lefti = pred(coord,1);
            righti = pred(coord,2);
            left = convert2en(lefti,energy);
            right = convert2en(righti,energy);
            leftx = [left,left];
            rightx = [right,right];
            update_loc_plot
            update_plot
            show_lr_values
    end

    function update_lr_str(hobject,eventdata)
        leftstr = strcat([' left  =  ',num2str(left),' mV']);
        rightstr = strcat(['right =  ',num2str(right),' mV']);
        gapstr = strcat(['gap = ',num2str((right-left)/2),' mV']);
        leftistr = strcat([' index = ',num2str(lefti)]);
        rightistr = strcat(['index = ',num2str(righti)]);
    end

    function show_lr_values(hobject,eventdata)
        update_lr_str
        a1.String = leftstr;
        a2.String = leftistr;
        a3.String = rightstr;
        a4.String = rightistr;
        a5.String = gapstr;
    end
    
    function skip_callback(hobject,eventdata)
        remlinear = movetoback(remlinear,counter);
        xx = movetoback(xx,counter);
        yy = movetoback(yy,counter);
        update_spec
    end
    function index = convert2index(en,energylist)
       N = length(energylist);
       index = (N-1)*((en-energylist(1))/(energylist(end)-energylist(1)))+1;
    end

    function en = convert2en(index,energylist)
        N = length(energylist);
        ratio = (index-1)/(N-1);
        en = energylist(1)+ratio*(energylist(end)-energylist(1));
    end
    function list = movetoback(list,index)
       list(end+1)=list(index);
       list(index) = [];
    end

    function update_plot
        ax_spect = subplot('Position',ax_spect_pos);   
        plot(ax_spect,energy,spect);grid on; %spectrum
        hold on
        plot(ax_spect,leftx,[minn,maxx],'r--'); %leftline
        plot(ax_spect,rightx,[minn maxx],'r--'); %rightline
        ylim(ax_spect,[minn maxx]);
        xlim(ax_spect,[energy(1),energy(end)]);
        hold off
    end

    function update_loc_plot
        ax_xy = subplot('Position',ax_xy_pos);
        axis off
        hold on
        imagesc(map.map(:,:,1));
        colormap(gray)
        plot(ax_xy,x,ny-y+1,'r.','MarkerSize',15)
        hold off
    end

    function coord = xy2coord(x,y,nx)
        coord = (y-1)*nx+x;
    end

    function [x,y] = one2xy(coordinate,nx)
        y = fix((coordinate-0.5)/nx)+1;
        x = coordinate - nx*(y-1);
    end



end
