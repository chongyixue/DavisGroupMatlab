function view2(data2)
global data 
data = data2;
layer=1;%ceil(length(e/2));
[sy,sx,sz] = size(data.map);
dos=zeros(1,sz);

disty=data.r;
distx=data.r;

%create figures and menus
fh=figure('Name', [data.name, '-',num2str(data.type)],...
        'units','centimeter', ...
        'Position',[1,4,22,22],...
        'Color',[0.5 0.5 0.5]);
    
f = uimenu('Label','Workspace');

%coordinates box
coord_tb=annotation('textbox',...
                'units','centimeter',...
                'Position',[0.75 14.5 3.75 6.5],...
                'Color',[1,1,1]);           
            
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
                'String', num2str(1000*data.e','%10.2f'),...
                'Value',layer,...
                'Position',[5 20 2 1],...
                'Callback',{@redraw_map_Callback,data});
            
color_pop = uicontrol(fh,'Style', 'popup',...
       'units', 'centimeter',...
       'String', 'gray|copper|hot|bone|jet|defect',...
       'Position', [5 19 2 1],...
       'Callback', (@set_color_Callback));
       
spectra_pop = uicontrol(fh,'Style', 'popup',...
       'units', 'centimeter',...
       'String', 'Spectra OFF|Spectra ON',...
       'Position', [6.5 6 2.5 1]);

redraw_butt = uicontrol(fh,'Style','pushbutton','String','REDRAW',...
                'units','centimeter',...
                'Position',[5 15 2 1.4],...
                'Callback',{@redraw_map_Callback,data});   
   
set_color_Callback
plot_it(data);            
set(gcf, 'windowbuttonmotionfcn', {@gtrack_Move,data});
     
% axitos = axes('Parent',fh,...
%                 'units','centimeter',...
%                 'Position',[1 13.5 4 2]);            

function plot_it(fdata)
   layer=get(energy_list,'Value'); 
   mini=str2num(get(mini_edit,'String'));
   maxi=str2num(get(maxi_edit,'String'));
   [mini,maxi]= get_colormap_limits((fdata.map(:,:,layer)),mini/100,maxi/100,'h');
   pcolor(distx',disty, fdata.map(:,:,layer));
   caxis([mini,maxi]);      
   shading interp; 
   axis equal;
end


function redraw_map_Callback(hObject,eventdata,fdata)
    layer=get(energy_list,'Value'); 
    plot_it(fdata);
end

function gtrack_Move(src,evnt,fdata)
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
    ddx=max(distx)-min(distx);
    ddy=max(disty)-min(disty);
    
    %find value of map at mouse position
    xLim = xlim(main_axis);
    yLim = ylim(main_axis);
    layer=get(energy_list,'Value');
    mapval = fdata.map(floor((yInd + abs(yLim(1)))/ddx*sx+1),...
        floor((xInd + abs(xLim(1)))/ddx*sx +1),layer);

    str={ 'coords' ; ...
    [ '( ' num2str(xInd, '%6.3f') ' , '  num2str(yInd,'%6.3f') ' )'] ; ...
    ' ' ;...
    'pixel' ; ...
    ['( ' num2str(yInd/ddy*sy,'%6.0f') ' , '...
    num2str(xInd/ddx*sx,'%6.0f') ' )' ];...
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
        plot(fdata.e,squeeze(fdata.map(floor((yInd+ abs(yLim(1)))/ddy*sx)+ 1,...
            floor((xInd+ abs(xLim(1)))/ddx*sx)+1,:)));
        grid on;
        axes(main_axis);
        return;
    end
end

function new_display_Callback(hObject,eventdata,data)
return;

end
function button2_Callback(hObject,eventdata,fdata)
    %check to see that spectra option is on
    if get(spectra_pop,'Value') == 1
        axes(dos_axis); cla; axes(main_axis); 
        return;
    %check to see that the mouse is on the plot of the map
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
    ddx=max(distx)-min(distx);
    ddy=max(disty)-min(disty);
    
    %find value of map at mouse position
    layer=get(energy_list,'Value');
    mapval = fdata.map(floor(yInd/ddy*sx)+1,floor(xInd/ddx*sx)+1,layer);
    return;
    end
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

end