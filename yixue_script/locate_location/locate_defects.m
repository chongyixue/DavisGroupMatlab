% 2019-6-28 YXC
% plot and mark some spots from 90628a00 100nm map/topo

topo =  prep_topo_linewise(obj_90626A00_T.topo1);
matrix = topo;

% newmap = contrast(matrix,10);
% figure,imagesc(matrix)
% colormap(bone);

% x pixel to right, y down.
% suspected vortex location -first of which is in 90628a00
vortex_x = [170,250,250,125,80,98,80];
vortex_y = [52,203,86,88,141,197,114];

% defect that seems to not have ZBS
defect_x = [38,253,40,49];
defect_y = [235,55,64,210];

% question mark
quest_x = [9];
quest_y = [222];

figure,imagesc(matrix);
colormap(bone)
hold on

for i = 1:length(vortex_x)
    plot(vortex_x(i),vortex_y(i),'rx','MarkerSize',10)
    hold on
end

for ii = 1:length(defect_x)
    plot(defect_x(ii),defect_y(ii),'ro','MarkerSize',10)
    hold on
end

for iii = 1:length(quest_x)
    plot(quest_x(iii),quest_y(iii),'ko','MarkerSize',10)
    hold on
end






