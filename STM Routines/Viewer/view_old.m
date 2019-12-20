function view(cube,e,disty,distx)

% X lets you select a core of spectra, which then are put to workspace.

%start with important variables
hs.cube=cube;
hs.e = e';
%e=flipud(e);

hs.layer=1;%ceil(length(e/2));
[sy,sx,sz] = size(hs.cube);
hs.dos=zeros(1,sz);
hs.sy=sy; hs.sx=sx; hs.sz=sz;

hs.disty=disty;
hs.distx=distx;
hs.ave=squeeze(sum(sum(cube)))/sx/sy;

%create stuff
fh=figure('Color',[1 1 1],'units','centimeter', ...
    'Position',[1,4,22,22],...
    'Color',[0.5 0.5 0.5]);

%coordinates box
coord_tb=annotation('textbox',...
                'units','centimeter',...
                'Position',[0.75 14.5 3.75 6.5]);           
            
            
a0_edit = uicontrol(fh,'Style','Edit',...
                'String','1.0',...
                'units','centimeter',...
                'Position',[5 18.5 1 0.5]);            
            
radius_edit = uicontrol(fh,'Style','Edit',...
                'String','1',...
                'units','centimeter',...
                'Position',[6.5 5.5 2.5 0.5]);
            
mini_edit = uicontrol(fh,'Style','Edit',...
                'String','0',...
                'units','centimeter',...
                'Position',[5 17.5 1 0.5]);
            
maxi_edit = uicontrol(fh,'Style','Edit',...
                'String','0',...
                'units','centimeter',...
                'Position',[6.25 17.5 1 0.5]);

dos_axis = axes('Parent',fh,...
                'units','centimeter',...
                'Position',[10 2 9.5 8]);            

main_axis = axes('Parent',fh,'units','normalized',...
                'units','centimeter',...
                'Position',[10 12 9.5 9.5]);
            
energy_list = uicontrol(fh,'Style','popupmenu',...
                'units','centimeter',...
                'String', num2str(e,'%10.2f'),...
                'Value',hs.layer,...
                'Position',[5 20 2 1],...
                'Callback',{@energy_list_Callback,hs});
            
color_pop = uicontrol(fh,'Style', 'popup',...
       'units', 'centimeter',...
       'String', 'gray|copper|hot|bone|jet|defect',...
       'Position', [5 19 2 1],...
       'Callback', (@set_color_Callback));
       
spectra_pop = uicontrol(fh,'Style', 'popup',...
       'units', 'centimeter',...
       'String', 'Spectra OFF|Spectra ON',...
       'Position', [6.5 6 2.5 1]);

expand_butt = uicontrol(fh,'Style','pushbutton','String','New Display',...
                'units','centimeter',...
                'Position',[5 15 2 1.4],...
                'Callback',{@new_display_Callback});   
   
set_color_Callback
plot_it(hs);            
%set(gcf, 'windowbuttonmotionfcn', {@button2_Callback,hs});
set(gcf, 'windowbuttonmotionfcn', @gtrack_Move);


%axis equal

            
% axitos = axes('Parent',fh,...
%                 'units','centimeter',...
%                 'Position',[1 13.5 4 2]);            
           
function energy_list_Callback(hObject,eventdata,hs)
    hs.layer=get(energy_list,'Value'); 
    plot_it(hs);
end

function gtrack_Move(src,evnt)
    a0=str2double(get(a0_edit,'String')); 
    % get mouse position
    pt = get(gca, 'CurrentPoint');
    xInd = pt(1, 1);
    yInd = pt(1, 2);

    % check if its within axes limits
    %axes(main_axis);
    
    if xInd < min(distx) || xInd > max(distx)
		return;
    elseif yInd < min(disty) || yInd > max(disty)
        return;
    end
    % if within limits then continue
    ddx=max(hs.distx)-min(hs.distx);
    ddy=max(hs.disty)-min(hs.disty);
    
    %find value of map at mouse position
    xLim = xlim(main_axis);
    yLim = ylim(main_axis);
    hs.layer=get(energy_list,'Value');
    mapval = hs.cube(floor((xInd + abs(xLim(1)))/ddx*hs.sx+1),...
        floor((yInd + abs(yLim(1)))/ddy*hs.sx +1),hs.layer);

    str={ 'coords' ; ...
    [ '( ' num2str(xInd, '%6.3f') ' , '  num2str(yInd,'%6.3f') ' )'] ; ...
    ' ' ;...
    'pixel' ; ...
    ['( ' num2str(xInd/ddx*hs.sx,'%6.0f') ' , '...
    num2str(yInd/ddy*hs.sx,'%6.0f') ' )' ];...
    ' ' ; ...
    'a_0' ; ...
    ['( ' num2str(xInd/a0,'%6.2f') ' , ' num2str(yInd/a0,'%6.2f') ' )'];...
    ' '; ...
    ' 2\pi/a_0 ' ; ...
    ['( ' num2str(xInd/(2*pi/a0),'%6.2f') ' , ' num2str(yInd/(2*pi/a0),'%6.2f') ' )'];...
    ' '; ...
    ' Map Value ' ; ...
    ['( ' num2str(mapval, '%6.3f') ' )'];...
    };
    set(coord_tb,'String',str)
    if get(spectra_pop,'Value')==1        
        return;
    else
        axes(dos_axis);       
        set(gca, 'NextPlot', 'replace');
        plot(hs.e,squeeze(hs.cube(floor((xInd+ abs(yLim(1)))/ddx*hs.sx)+ 1,...
            floor((yInd+ abs(yLim(1)))/ddy*hs.sx)+1,:)));
        grid on;
        axes(main_axis);
        return;
    end
end

function new_display_Callback(hObject,eventdata,hs)
return;

end
function button2_Callback(hObject,eventdata,hs)
    %check to see that spectra option is on
    if get(spectra_pop,'Value') == 1
        axes(dos_axis); cla; axes(main_axis); 
        'no spectra yet'
        return;
    %if check to see that the mouse is on the plot of the map
    else        
        pt = get(gca, 'CurrentPoint');
        xInd = pt(1, 1)
        yInd = pt(1, 2)
        % check if its within axes limits
        xLim = get(gca, 'XLim');	
        yLim = get(gca, 'YLim');
        if xInd < min(distx) || xInd > max(distx)
            return;
        elseif yInd < min(disty) || yInd > max(disty)
            return;
        end
    % if within limits then continue
    ddx=max(hs.distx)-min(hs.distx);
    ddy=max(hs.disty)-min(hs.disty);
    
    %find value of map at mouse position
    hs.layer=get(energy_list,'Value');
    mapval = hs.cube(floor(xInd/ddx*hs.sx)+1,floor(yInd/ddy*hs.sx)+1,hs.layer);
    return;
    end




%         axes(dos_axis); cla;   axes(main_axis)
%         but=1;
%         r=str2double(get(radius_edit,'String'));
%     %adding=get(toggle_graph,'Value');
%         hold off;
%         plot_it(hs);
%      %m=colormap(cool(10));colormap gray;
%     nr_click=0;
%  
%     while but==1
%         nr_click=nr_click+1;
%         [xi,yi,but] = ginput(1);
%         %dist to coord
%         yi=yi/max(hs.disty)*hs.sy; xi=xi/max(hs.distx)*hs.sx; 
%         xn=floor(xi);yn=floor(yi);
%       
%         if r>0 
%        %make abstand matrix
%        [cy,cx]=ndgrid(-yi+1:hs.sy-yi,-xi+1:hs.sx-xi);
%        cx=abs(cx);cy=abs(cy);
%        abstand=(cx.^2+cy.^2).^0.5;
%        ind=find(abstand<=r);
%        n=length(ind);
%        hs.dos=zeros(1,hs.sz);
%        for k=1:sz
%            now=hs.cube(:,:,k);
%            hs.dos(k)=sum(now(abstand<=r))/n;
%        end
%     
%        set(gca, 'NextPlot', 'add');
%        N=256;
%        t=(0:N)*2*pi/N;
%        plot( (r*cos(t)+xn)/hs.sx*max(hs.distx),...
%            (r*sin(t)+yn)/hs.sy*max(hs.disty),'b');
%     else
%        set(gca, 'NextPlot', 'add');
%        hs.dos=squeeze(hs.cube(yn,xn,:));
%        plot( (xn+.5)*max(hs.distx)/hs.sx,...
%            (yn+.5)*max(hs.disty)/hs.sy,'bx');
%     end
%     
%    
%    
%      axes(dos_axis);
%    set(gca,'XGrid','on')
%     if adding==1
%         j=mod(nr_click,9)+1;
%         set(gca, 'NextPlot', 'add');
%         plot(hs.e,hs.dos,...
%             'Color',[m(j,1) m(j,2) m(j,3)],...
%             'LineWidth',2);
%       
%         set(gca, 'NextPlot', 'replace');
%     else
%         plot(hs.e,abs(hs.dos), 'Linewidth',2);
%        
%     end
%     axes(main_axis)
%     assignin('base',['d' num2str(nr_click, '%02d')],hs.dos);
%end

end

function set_color_Callback(hObject, evendata)
    val = get(color_pop,'Value');
    if val == 1
        colormap(gray)
    elseif val == 2
        colormap(copper)
    elseif val == 3
        colormap(hot)
    elseif val == 4
        colormap(bone)
    elseif val == 5
        colormap(jet)
    elseif val == 6
        colormap(defect)
    end
end

function plot_it(hs)
   hs.layer=get(energy_list,'Value'); 
   mini=str2num(get(mini_edit,'String'));
   maxi=str2num(get(maxi_edit,'String'));
   [mini,maxi]= get_colormap_limits((hs.cube(:,:,hs.layer)),mini/100,maxi/100,'h');
   pcolor(hs.distx',hs.disty, hs.cube(:,:,hs.layer));
   caxis([mini,maxi]);      
   shading interp; 
   axis equal;
end




end
