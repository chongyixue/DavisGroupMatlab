function [bdmap, sdmap, bhmap] = smallandbigdefects(tdata)

if isstruct(tdata)
    topo = tdata.map;
else
    topo = tdata;
end


[nx, ny, nz] = size(topo);



admap = im2bw(topo,0.35);

bhmap = im2bw(-1*topo,0.03);

lmap = bwlabel(admap);

lmap2 = lmap;

lmap3 = bwlabel(bhmap);

bhperimeter = bwboundaries(bhmap);

fperimeter = bwboundaries(admap);

thresh = 35;

for i=1:length(fperimeter)
    dum1 = fperimeter{i};
    if size(dum1(:,1),1) > thresh
        [row,col] = find(lmap == i);
        for k=1:length(row)
            lmap(row(k),col(k),1) = lmap(row(k),col(k),1) - i;
        end
    else
        [row,col] = find(lmap2 == i);
        for k=1:length(row)
            lmap2(row(k),col(k),1) = lmap2(row(k),col(k),1) - i;
        end
    end
end

% thresh = 1;
% 
% for i=1:length(fperimeter)
%     dum1 = fperimeter{i};
%     if size(dum1(:,1),1) > thresh
%         [row,col] = find(lmap == i);
%         for k=1:length(row)
%             lmap(row(k),col(k),1) = lmap(row(k),col(k),1) - i;
%         end
%     else
%         [row,col] = find(lmap2 == i);
%         for k=1:length(row)
%             lmap2(row(k),col(k),1) = lmap2(row(k),col(k),1) - i;
%         end
%     end
% end

sdmap = im2bw(abs(lmap),0);

bdmap = im2bw(abs(lmap2),0);

figure, img_plot5(admap);

figure, img_plot5(bdmap);

figure, img_plot5(sdmap);



bdperimeter = bwboundaries(bdmap);

change_color_of_STM_maps(topo,'no')
hold on


for i=1:length(bdperimeter)

    dum1 = bdperimeter{i};
    xxx = dum1(:,2);
    yyy = dum1(:,1);
    plot(xxx,yyy,'-','Color','r','LineWidth',2);
    % line is needed to close the region
    line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','r','LineStyle','-','LineWidth',2);
    

end


sdperimeter = bwboundaries(sdmap);

for i=1:length(sdperimeter)

    dum1 = sdperimeter{i};
    xxx = dum1(:,2);
    yyy = dum1(:,1);
    plot(xxx,yyy,'-','Color','y','LineWidth',2);
    % line is needed to close the region
    line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','y','LineStyle','-','LineWidth',2);
    

end

for i=1:length(bhperimeter)

    dum1 = bhperimeter{i};
    xxx = dum1(:,2);
    yyy = dum1(:,1);
    plot(xxx,yyy,'-','Color','c','LineWidth',2);
    % line is needed to close the region
    line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','c','LineStyle','-','LineWidth',2);
    

end

hold off


end
            