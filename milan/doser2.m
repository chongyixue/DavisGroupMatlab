function doser2(cube,e,disty,distx)

% X lets you select a core of spectra, which then are put to workspace.

%start with imprtant wariables
hs.cube=cube;
%e=flipud(e);
hs.e=e;

hs.layer=1;%ceil(length(e/2));
[sy,sx,sz] = size(hs.cube);
hs.dos=zeros(1,sz);
hs.sy=sy; hs.sx=sx; hs.sz=sz;

hs.disty=disty;
hs.distx=distx;

hs.ave=squeeze(sum(sum(cube)))/sx/sy;

%create stuff
fh=figure('Color',[1 1 1],'units','centimeter', ...
    'Position',[2,2,20,22]);

radius_edit = uicontrol(fh,'Style','Edit',...
                'String','10',...
                'units','centimeter',...
                'Position',[1 20 2 1]);
            
coord_tb=annotation('textbox',...
                'units','centimeter',...
                'Position',[1 8 5 5]);           
            
            
a0_edit = uicontrol(fh,'Style','Edit',...
                'String','5.4730',...
                'units','centimeter',...
                'Position',[1 18 2 1]);            
            
mini_edit = uicontrol(fh,'Style','Edit',...
                'String','0',...
                'units','centimeter',...
                'Position',[1 16 2 1]);
            
maxi_edit = uicontrol(fh,'Style','Edit',...
                'String','10',...
                'units','centimeter',...
                'Position',[3.5 16 2 1]);

main_axis = axes('Parent',fh,'units','normalized',...
                'units','normalized',...
                'Position',[.4 .05 .55 .4]);

dos_axis = axes('Parent',fh,...
                'units','normalized',...
                'Position',[.4 .53 .55 .4]);
            
axitos = axes('Parent',fh,...
                'units','centimeter',...
                'Position',[1 13.5 4 2]);            
           

carpet_butt = uicontrol(fh,'Style','pushbutton','String','get carpet',...
                'units','centimeter',...
                'Position',[1 .5 2 1.4],...
                'Callback',{@button1_Callback,hs});
            
spectra_butt = uicontrol(fh,'Style','pushbutton','String','get spectra',...
                'units','centimeter',...
                'Position',[3.3 .5 2 1.4],...
                'Callback',{@button2_Callback,hs});
            
toggle_graph = uicontrol(fh,'Style','togglebutton',...
                'units','centimeter',...
                'String','add?',...
                'Value',0,'Position',[5.3 0.5 1.5 1.4]...
                );
                        
energy_list = uicontrol(fh,'Style','listbox',...
                'units','centimeter',...
                'String',cellstr(num2str(e)),...
                'Value',hs.layer,...
                'Position',[1 2 5 5],...
                'Callback',{@energy_list_Callback,hs});            

set(gcf, 'windowbuttonmotionfcn', @gtrack_Move);        
            
%axes(axitos);
%axis off;
%box on;
%axes(main_axis);
    axes(main_axis);
%first plot
%colormap gray
plot_it(hs);


%callbacks DOS spectra

function button2_Callback(hObject,eventdata,hs)
axes(dos_axis); cla;   axes(main_axis)   
but=1;

r=str2double(get(radius_edit,'String'));
adding=get(toggle_graph,'Value');

hold off;

plot_it(hs);

 m=colormap(cool(10));colormap gray;

 nr_click=0;
 
while but==1

    nr_click=nr_click+1;
    
    [xi,yi,but] = ginput(1);
    yi=yi/max(hs.disty)*hs.sy; xi=xi/max(hs.distx)*hs.sx; %dist to coord
    
    xn=floor(xi);yn=floor(yi);
    
    if r>0 
       %make abstand matrix
       [cy,cx]=ndgrid(-yi+1:hs.sy-yi,-xi+1:hs.sx-xi);
       cx=abs(cx);cy=abs(cy);
       abstand=(cx.^2+cy.^2).^0.5;
       ind=find(abstand<=r);
       n=length(ind);
       hs.dos=zeros(1,hs.sz);
       for k=1:sz
           now=hs.cube(:,:,k);
           hs.dos(k)=sum(now(abstand<=r))/n;
       end
    
       set(gca, 'NextPlot', 'add');
       N=256;
       t=(0:N)*2*pi/N;
       plot( (r*cos(t)+xn)/hs.sx*max(hs.distx),...
           (r*sin(t)+yn)/hs.sy*max(hs.disty),'b');
    else
       set(gca, 'NextPlot', 'add');
       hs.dos=squeeze(hs.cube(yn,xn,:));
       plot( (xn+.5)*max(hs.distx)/hs.sx,...
           (yn+.5)*max(hs.disty)/hs.sy,'bx');
    end
    
   
   
     axes(dos_axis);
   set(gca,'XGrid','on')
    if adding==1
        j=mod(nr_click,9)+1;
        set(gca, 'NextPlot', 'add');
        plot(hs.e,hs.dos,...
            'Color',[m(j,1) m(j,2) m(j,3)],...
            'LineWidth',2);
      
        set(gca, 'NextPlot', 'replace');
    else
        plot(hs.e,abs(hs.dos), 'Linewidth',2);
       
    end
    axes(main_axis)
    assignin('base',['d' num2str(nr_click, '%02d')],hs.dos);
end

end


%%%% DOS CARPETS
function button1_Callback(hObject,eventdata,hs)


set(gca, 'NextPlot', 'add');
a0=str2double(get(a0_edit,'String')); 
count=0;

while count<2

    axes(gca)
    yrange=max(hs.disty)-min(hs.disty);
    xrange=max(hs.distx)-min(hs.distx);
    [yio,xio,but] = ginput(1); % yio in units
    yi=(yio-min(hs.disty))/yrange*hs.sy; % yi are in pixel
    xi=(xio-min(hs.distx))/xrange*hs.sx;  
    
    xn=floor(xi);yn=floor(yi);  % roued
    
    if count==0
        a=[xi;yi];
        ao=[xio;yio];
    elseif count==1
        b=[xi;yi];
        bo=[xio;yio];
    end
    
    count=count+1;
end

[sy,sx,sz]=size(hs.cube);
r=str2double(get(radius_edit,'String'));
plot([ao(2),bo(2)],[ao(1) bo(1)],'r-','linewidth',1.5);

carp=get_carpet_from_cube(hs.cube,...
    a,b,r);
[ssy,ssx]=size(carp);
kvec=linspace(0,sqrt(sum((ao-bo).^2)),ssx);
kvec=kvec/2/pi*a0;
figure
pcolor(kvec,hs.e,carp);
title(['integr-abst=',num2str(r)])
shading interp; colorbar; colormap 'jet';
sty_carp
ylabel('2pi/a0)')


assignin('base','carpet',carp);
assignin('base','kv',kvec);



end

function energy_list_Callback(hObject,eventdata,hs)
hs.layer=get(energy_list,'Value'); 
%axes(main_axis);
%cla;

plot_it(hs);

end


function plot_it(hs)
     hs.layer=get(energy_list,'Value'); 

    mini=str2num(get(mini_edit,'String'));
     maxi=str2num(get(maxi_edit,'String'));
   [mini,maxi]=...
       get_colormap_limits((hs.cube(:,:,hs.layer)),mini/1000,maxi/1000,'h');
     pcolor(hs.distx',hs.disty,(hs.cube(:,:,hs.layer)));
     shading interp; 
    caxis([mini,maxi]);
   % xlim([-20 20]*2+110)
    %ylim([-20 20]*2+110)
     
    colorbar; 
   % axis equal;*2
 %    caxis([mini,maxi]);
   % myColormap('fft2')
   %plot_bz(sqrt(2));
    colormap gray
  %  drawnow expose
  
   %{ 
     
    
     %axitos
     axes(axitos);   
    plot(axitos,hs.e,hs.ave,'b-',...
         'linewidth',2.5);
     set(gca, 'NextPlot', 'add');
     plot(hs.e(hs.layer),hs.ave(hs.layer),'r+'...
         ,'markersize',14,'linewidth',4);
     axis off
     box on
%    drawnow expose 
     set(gca, 'NextPlot', 'replace');
     axes(main_axis);
     %}
end


function gtrack_Move(src,evnt)
    
a0=str2double(get(a0_edit,'String')); 

% get mouse position
pt = get(gca, 'CurrentPoint');
xInd = pt(1, 1);
yInd = pt(1, 2);

% check if its within axes limits
xLim = get(gca, 'XLim');	
yLim = get(gca, 'YLim');
if xInd < xLim(1) || xInd > xLim(2)
		
	return;
end
if yInd < yLim(1) || yInd > yLim(2)
	return;
end
% write
ddx=max(hs.distx)-min(hs.distx);
ddy=max(hs.disty)-min(hs.disty);
str={ 'coords' ; ...
   [ '( ' num2str(xInd, '%6.3f') ' , '  num2str(yInd,'%6.3f') ' )'  ...
    ', d = '...
     num2str(sqrt((xInd)^2+(yInd)^2),'%6.2f') ];...
    'pixl' ; ...
    ['( ' num2str(xInd/ddx*hs.sx,'%6.0f') ' , '...
    num2str(yInd/ddy*hs.sx,'%6.0f') ' )' ];...
    ' ' ; ...
    'a0' ; ...
    ['( ' num2str(xInd/a0,'%6.2f') ' , ' num2str(yInd/a0,'%6.2f') ' )'];...
    ' '; ...
    ' 2pi/a0 ' ; ...
    ['( ' num2str(xInd/2/pi*a0,'%6.2f') ' , ' num2str(yInd/2/pi*a0,'%6.2f') ...
     ' ) , d = '...
     num2str(sqrt((xInd/2/pi*a0)^2+(yInd/2/pi*a0)^2),'%6.2f') ];...
    };

set(coord_tb,'String',str)


end
end