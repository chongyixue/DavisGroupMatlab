% 2019-7-8 YXC
% gapmap for FeSeTe - multipeaks...
% machine learning

map = obj_90708a00_G;
[nx,ny,nz] = size(map.map);
a = zeros(3,4);
a(1,:) = 34;
energy = map.e*1000;
middle = 1000*(map.e(1)+map.e(end))/2;
% pathname = "C:\Users\chong\Desktop\FeSeTe\fesete2019\FeSeTe_2019_log";
% datapath = 'C:\Users\chong\Documents\MATLAB\STMdata\FeSeTe_2019\';

pathname = 'C:\Users\chong\Desktop\machine learning\STM\';
filename = 'test.csv';
file = strcat(pathname,filename);

% csvwrite(file,a)

linearPOS = randi(nx*ny);

[x,y] = one2xy(linearPOS,nx);
posstring = strcat(['(',num2str(x),' ,',num2str(y),')']);

spect = squeeze(squeeze(map.map(y,x,:)))';
maxx = max(spect);minn = min(spect);
rang = maxx-minn;maxx = maxx+rang*0.05;minn = minn-rang*0.05;
coord = xy2coord(x,y,nx);
left = 30;
right = 70;

leftx = [middle,middle];lefty = [minn,maxx];
rightx = [middle,middle]; righty = [minn,maxx];
temp.minn = minn;
temp.maxx = maxx;
temp.x = x; temp.y = y;
temp.spect = spect;


% get spectrum plus points plus coordinate with leftright edge into correct
% form for excel logging
spec = zeros(1,nz+3);
spec(1,1) = coord;
spec(1,2:nz+1) = spect;
spec(1,end-1:end) = [left,right];


% dlmwrite(file,spec,'delimiter',',','-append')

asp_r = 2;
w_spec = 0.4;w_xy = 0.2;
ax_xy_pos    = [0.05,0.5,w_xy,w_xy*asp_r];
ax_spect_pos = [0.35 ,0.5,w_spec,w_spec];


f=figure;
f.Position = [400,300,500*asp_r,500];
set(f,'UserData',temp);
w = 0.1;h=0.05;
annotation('textbox',[0.05,0.5+w_xy*asp_r-0.08,w_xy,h],'String',posstring,'LineStyle','none');
ax_xy = subplot('Position',ax_xy_pos);
axis off
hold on
imagesc(map.map(:,:,1));
colormap(gray)
plot(x,ny-y+1,'rx','MarkerSize',10)
ax_spect = subplot('Position',ax_spect_pos);
plot(ax_spect,energy,spect);
hold on
ylim([minn maxx])
hold off
update_plot(ax_spect,leftx,rightx,righty,spect,energy)

%[right up width height]
left = uicontrol('Parent',f,'Style','slider','Position',[340,150,419,23],...
    'value',middle, 'min',energy(1), 'max',energy(end),'callback',@(src,evt)disp(get(src,'value')));
% lh_left = addlistener(left,'Value','PreSet',@(a,b)disp('hi'));
right = uicontrol('Parent',f,'Style','slider','Position',[340,100,419,23],...
    'value',middle, 'min',energy(1), 'max',energy(end),...
    'callback',@update_plot_Callback);
% lh_right = addlistener(right,'Value',@update_plot_Callback(right.Value));

function update_left_Callback(hobject,~)
hobject
l = hobject.Value;
leftx = [l,l];
% update_plot(leftx,rightx,righty,spect,energy)
end

function update_plot_Callback(hobject,event)
hobject
event
f
end

function update_plot(ax,leftx,rightx,righty,spect,energy)
plot(ax,energy,spect);
hold on
ylim([righty(1) righty(2)])
plot(ax,leftx,righty,'r--');
plot(ax,rightx,righty,'r--');
hold off
hell = 'hell'
end


function coord = xy2coord(x,y,nx)
coord = (y-1)*nx+x;
end

function [x,y] = one2xy(coordinate,nx)
y = fix((coordinate-0.5)/nx)+1;
x = coordinate - nx*(y-1);
end










