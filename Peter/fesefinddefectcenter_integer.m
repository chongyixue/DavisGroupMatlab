function [data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_integer(data,gx, gy)


% find the locations of the Se- and Fe-atoms, using LF-corrected data
data_loc = data;
phase_map = data_loc.phase_map;
% selocap =  atomic_pos(phase_map,0,0);
selocap =  atomic_pos(phase_map,pi,pi);
fe1locap =  atomic_pos(phase_map,pi,0);
fe2locap =  atomic_pos(phase_map,0,pi);


% get the size of the STM data
[nx, ny, nz] = size(selocap);

cc = 1;
cc1 = 1;
cc2 = 1;

for i=1:nx
    for j=1:ny
        
        if selocap(i,j,1) == 1
            selocex(1, cc) = i;
            selocex(2, cc) = j;
            cc = cc+1;
        end
        
        if fe1locap(i,j,1) == 1
            fe1locex(1, cc1) = i;
            fe1locex(2, cc1) = j;
            cc1 = cc1+1;
        end
        
        if fe2locap(i,j,1) == 1
            fe2locex(1, cc2) = i;
            fe2locex(2, cc2) = j;
            cc2 = cc2+1;
        end
    end
end

% % use the exact location of the Fe-atoms in integer pixel coordinates
% [row1, col1] = find(fe1loc == 1);
% [row2, col2] = find(fe2loc == 1);
% lc1 = length(row1);
% lc2 = length(row2);

% use the exact location of atoms in double pixel coordinates, keep using
% row and col as names for storage
lc1 = length(fe1locex(1,:));
lc2 = length(fe2locex(1,:));

row1 = fe1locex(1,:);
col1 = fe1locex(2,:);

row2 = fe2locex(1,:);
col2 = fe2locex(2,:);

cc1 = 1;
cc2 = 1;



for i=1:lc1
    
       distx1(i) = col1(i) - gx; 
       disty1(i) = row1(i) - gy;
       tdist1(i) = sqrt ( distx1(i)^2 + disty1(i)^2 );

       % find the estimated psoition closest to actual Fe-position
       [dum1, dumind1] = sort(tdist1,'ascend');
    
end    
    
for i=1:lc2
    
       distx2(i) = col2(i) - gx; 
       disty2(i) = row2(i) - gy;
       tdist2(i) = sqrt ( distx2(i)^2 + disty2(i)^2 );

       % find the estimated psoition closest to actual Fe-position
       [dum2, dumind2] = sort(tdist2,'ascend');
    
end  

if tdist1(dumind1(1)) < tdist2(dumind2(1))
    dx = col1(dumind1(1));
    dy = row1(dumind1(1));
else
    dx = col2(dumind2(1));
    dy = row2(dumind2(1));
end

p = 10;
change_color_of_STM_maps(data.map,'no')
hold on 

plot(gx, gy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','b','MarkerFaceColor','b', 'LineWidth', 3);
plot(dx, dy,'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 3);


hold off

% darkorange = [255, 140, 0] / 255;
% royalblue = [0, 191, 255] / 255;
% 
% p = 10;
% change_color_of_STM_maps(data.map,'no')
% hold on 
% 
% for i=1:length(fe1locex(1,:))
%         if fe1locex(1,i) >= 1 && fe1locex(1,i) <= ny && fe1locex(2,i) >= 1 && fe1locex(2,i) <= nx
%     %         plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%             plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','b','MarkerFaceColor','b', 'LineWidth', 2);
%         end
%     end
% 
%     for i=1:length(fe2locex(1,:))
%         if fe2locex(1,i) >= 1 && fe2locex(1,i) <= ny && fe2locex(2,i) >= 1 && fe2locex(2,i) <= nx
%     %         plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%             plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
%         end
%     end
% 
%     for i=1:length(selocex(1,:))
%         if selocex(1,i) >= 1 && selocex(1,i) <= ny && selocex(2,i) >= 1 && selocex(2,i) <= nx
%     %         plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2);
%             plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor',darkorange,'MarkerFaceColor',darkorange, 'LineWidth', 2);
%         end
%     end
% 
% hold off


end