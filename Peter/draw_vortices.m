function draw_vortices(data)
  
load_color;
if isstruct(data)
    tmp_data = data.map;
else
    tmp_data = data;
end
[nr nc nz] = size(tmp_data);


ll = length(data.vortex_layer);
for i=1:ll
    pos = data.vortex_pos{i};
    layer = data.vortex_layer{i};

        
    img_plot2(tmp_data(:,:,layer),Cmap.Blue2);

    hold on 
    l=length(pos);
    if l > 1
        for k=1:l
            region=pos{k};
            plot(region(:,1),region(:,2),'-','Color','r','LineWidth',2);
            % line is needed to close the region
            line([region(end,1),region(1,1)],[region(end,2),region(1,2)],'Color','r','LineStyle','-','LineWidth',2);
        end
    else
    end
    hold off
    
end

%zlayer = zero energy layer
for j = 1:length(data.e)
    if data.e(j) == 0
        zlayer = j;
    end
end

img_plot2(tmp_data(:,:,zlayer),Cmap.Blue2);
hold on

for i=1:ll
    pos = data.vortex_pos{i};
    layer = data.vortex_layer{i};


    l=length(pos);
    if l > 1
        for k=1:l
            region=pos{k};
            plot(region(:,1),region(:,2),'-','Color','r','LineWidth',2);
            % line is needed to close the region
            line([region(end,1),region(1,1)],[region(end,2),region(1,2)],'Color','r','LineStyle','-','LineWidth',2);
        end
    else
    end
    
end

hold off

img_plot2(tmp_data(:,:,zlayer),Cmap.Blue2);
hold on

vc = 1; 
% cohlen = coherence length, roughly 40 Angstroem from vortex fits for
% Fe(Te, Se)
cohlen = 80 / ( data.r(2)-data.r(1) );

for i=1:ll
    pos = data.vortex_pos{i};
    layer = data.vortex_layer{i};

    

    l=length(pos);
    if l > 1
        for k=1:l
            region=pos{k};
            x = mean(region(:,1));
            y = mean(region(:,2));
            
            if vc==1
                vcx(vc) = x;
                vcy(vc) = y;
                vc = vc+1;
                line([x,x],[y-1,y+1],'Linewidth',2,'Color','y');
                line([x-1,x+1],[y,y],'Linewidth',2, 'Color','y');
%                 plot(region(:,1),region(:,2),'-','Color','r','LineWidth',2);
                % line is needed to close the region
%                 line([region(end,1),region(1,1)],[region(end,2),region(1,2)],'Color','r','LineStyle','-','LineWidth',2);
            else
                cohcc = 0;
                for m=1:vc-1
                    dist = sqrt( (vcx(m)-x)^2+(vcy(m)-y)^2 );
                    
                    if dist > cohlen
                    else
                        cohcc = cohcc +1;
                    end
                end
                
                if cohcc == 0
                        vcx(vc) = x;
                        vcy(vc) = y;
                        vc = vc+1;
                        line([x,x],[y-1,y+1],'Linewidth',2,'Color','y');
                        line([x-1,x+1],[y,y],'Linewidth',2, 'Color','y');
%                         plot(region(:,1),region(:,2),'-','Color','r','LineWidth',2);
                        % line is needed to close the region
%                         line([region(end,1),region(1,1)],[region(end,2),region(1,2)],'Color','r','LineStyle','-','LineWidth',2);
                end
                    
            end
    end
    
    end
end

hold off

vortexcount = vc -1

end