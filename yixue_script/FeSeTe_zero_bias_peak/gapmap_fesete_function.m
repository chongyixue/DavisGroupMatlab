% 2019-7-8 YXC
% gapmap for FeSeTe - multipeaks...
% machine learning

function f = gapmap_fesete_function(map,varargin)

[nx,ny,nz] = size(map.map);

energy = map.e*1000;
middle = 1000*(map.e(1)+map.e(end))/2;
% pathname = "C:\Users\chong\Desktop\FeSeTe\fesete2019\FeSeTe_2019_log";
% datapath = 'C:\Users\chong\Documents\MATLAB\STMdata\FeSeTe_2019\';

pathname = 'C:\Users\chong\Desktop\machine learning\STM\';
name = map.name(1:end-3);
% filename = 'FST90708.csv';
% file = strcat(pathname,filename);
remmat = ones(nx,ny);
%remmat will be exactly in the form of matrix, i.e. mat(ypix,xpix)

if nargin>1
    pair = fix(nargin-1)/2;
    for prop = 1:pair
        propname = varargin{prop*2-1};
        if strcmp(varargin{prop*2-1},'remmat')==1
            remmat = varargin{prop+1};
        elseif strcmp(varargin{prop*2-1},'name')==1
            name = varargin{prop+1};
        elseif strcmp(varargin{prop*2-1},'suffix')==1
            nam = varargin{prop+1};
            name = strcat(nam,name);
        else
            dis = strcat(['"',propname,'"',' is not a valid property']);
            disp(dis);
        end
    end
end

file = strcat(pathname,name,'.csv');

if isfile(file)
    
else
%     head = zeros(1,nz+3);
%     dlmwrite(file,head','delimiter',',','-append')
%     header = cell(1,nz+3);
    header = cell(1,nz+3);
    head = cell2table(header);
    writetable(head,file,'Delimiter',',');
%     header{1} = 'coordinate';
%     for i = 1:nz
%         header{i+1}=i;
%     end
%     header{nz+2} = 'left';
%     header{nz+3} = 'right';
%     xlswrite(file,header);
end


% check for already logged coordinate
[visited,~] = xlsread(file,'A:A'); %visited is a 1D coordinate
remmat_visited = ones(nx*ny,1);
remmat_visited(visited) = 0;
remmat_visited = reshape(remmat_visited,nx,ny)';

% check for remaining spectra to be added and randomly order toinspect
[X,Y] = meshgrid(linspace(1,nx,nx),linspace(1,ny,ny));
remmat = xy2coord(X,Y,nx).*remmat';
remmat = remmat.*remmat_visited; %exclude stuff from excel
remlinear = nonzeros(remmat);
pointer = randperm(length(remlinear));
[~,sortorder] = sort(pointer);
remlinear = remlinear(sortorder);
[xx,yy] = one2xy(remlinear,nx); %% xx and yy - list of x and y coord respectively

asp_r = 2;
w_spec = 0.55;w_xy = 0.2;
ax_xy_pos    = [0.05,0.5,w_xy,w_xy*asp_r];
ax_spect_pos = [0.3 ,0.4,w_spec,w_spec];


f=figure;
f.Position = [400,300,500*asp_r,500];
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



%[right up width height]
left = uicontrol('Parent',f,'Style','slider','Units','normalized',...
    'Position',leftpos,...
    'value',middle, 'min',energy(1), 'max',energy(end),...
    'callback',@update_left_Callback);
% lh_left = addlistener(left,'Value','PreSet',@(a,b)disp('hi'));
right = uicontrol('Parent',f,'Style','slider','Units','normalized',...
    'Position',rightpos,...
    'value',middle, 'min',energy(1), 'max',energy(end),...
    'callback',@update_right_Callback);




counter = 1;
txt_count = annotation('textbox',[0.05,0.2,w_xy,h],...
            'String','counter = 0','LineStyle','none','FontSize',15);
index = counter;
x = xx(index);y = yy(index);
coord = xy2coord(x,y,nx);
posstring = strcat(['(',num2str(x),' ,',num2str(y),')   ID = ',num2str(remlinear(counter))]);
textbox = annotation('textbox',[0.05,0.5+w_xy*asp_r-0.06,w_xy,h],'String',posstring,'LineStyle','none','FontSize',12);
spect = squeeze(squeeze(map.map(y,x,:)))';
maxx = max(spect);minn = min(spect);
rang = maxx-minn;maxx = maxx+rang*0.05;minn = minn-rang*0.05;

update_loc_plot
% left = 30;
% right = 70;

leftx = [middle,middle];
rightx = [middle,middle]; %yrange = [minn,maxx];




update_plot
%     % get spectrum plus points plus coordinate with leftright edge into correct
%     % form for excel logging
%     spec = zeros(1,nz+3);
%     spec(1,1) = coord;
%     spec(1,2:nz+1) = spect;
%     spec(1,end-1:end) = [left,right];


% dlmwrite(file,spec,'delimiter',',','-append')




%% callback functions


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
        
        % get spectrum plus points plus coordinate with leftright edge into correct
        % form for excel logging
        spec = zeros(1,nz+3);
        spec(1,1) = coord;
        spec(1,2:nz+1) = spect;
        
        spec(1,end-1:end) = [convert2index(leftx(1),energy),convert2index(rightx(1),energy)];
%         file
        dlmwrite(file,spec,'delimiter',',','-append')
        txt_count.String =  strcat(['counter = ',num2str(counter)]);
        counter = counter+1;
        if counter>length(remlinear)
            close(f)
        else
            update_spec
%             x = xx(counter);y = yy(counter);
%             coord = xy2coord(x,y,nx);
%             posstring = strcat(['(',num2str(x),' ,',num2str(y),')   ID = ',num2str(remlinear(counter))]);
%             textbox.String = posstring;
%             spect = squeeze(squeeze(map.map(y,x,:)))';
%             maxx = max(spect);minn = min(spect);
%             rang = maxx-minn;maxx = maxx+rang*0.05;minn = minn-rang*0.05;
%             
%             update_loc_plot
%             update_plot
        end
    end

    function update_spec(hobject,eventdata)
            x = xx(counter);y = yy(counter);
            coord = xy2coord(x,y,nx);
            posstring = strcat(['(',num2str(x),' ,',num2str(y),')   ID = ',num2str(remlinear(counter))]);
            textbox.String = posstring;
            spect = squeeze(squeeze(map.map(y,x,:)))';
            maxx = max(spect);minn = min(spect);
            rang = maxx-minn;maxx = maxx+rang*0.05;minn = minn-rang*0.05;
            

            update_loc_plot
            update_plot
    end

    function skip_callback(hobject,eventdata)
        remlinear = movetoback(remlinear,counter);
        xx = movetoback(xx,counter);
        yy = movetoback(yy,counter);
        update_spec
%         x = xx(counter);y = yy(counter);
%         posstring = strcat(['(',num2str(x),' ,',num2str(y),')   ID = ',num2str(remlinear(counter))]);
%         textbox.String = posstring;
%         spect = squeeze(squeeze(map.map(y,x,:)))';
%         maxx = max(spect);minn = min(spect);
%         rang = maxx-minn;maxx = maxx+rang*0.05;minn = minn-rang*0.05;
%         coord = xy2coord(x,y,nx);
%         update_loc_plot
%         update_plot
    end
    function index = convert2index(en,energylist)
       N = length(energylist);
       index = (N-1)*((en-energylist(1))/(energylist(end)-energylist(1)))+1;
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





