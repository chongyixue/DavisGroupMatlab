function [data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_se_atom(data,gx, gy)


% find the locations of the Se- and Fe-atoms, using LF-corrected data
data_loc = data;
phase_map = data_loc.phase_map;
[selocap, selocex] =  atomic_pos_v2(phase_map,0,0, data);
[fe1locap, fe1locex] =  atomic_pos_v2(phase_map,0,0, data);
[fe2locap, fe2locex] =  atomic_pos_v2(phase_map,0,0, data);


% get the size of the STM data
[nx, ny, nz] = size(data.map);

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



end