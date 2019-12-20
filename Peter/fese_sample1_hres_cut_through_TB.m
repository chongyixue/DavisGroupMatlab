%high resolution spectrum cut through twin boundary
test = obj_51109A01_T.topo1(1:60, 1:128, :);
test2 = prep_topo(test);
figure, img_plot5(test2)
cut = line_cut_topo_angle(obj_51109A00_G, obj_51109A00_T, [69, 1], 59, 0, 0);


% list of indices for -15, -12.5, -10, -7.5, -5, -2.5, 0,
% +2.5, +5, +7.5, +10, +12.5, +15 nm from TB
il = [6, 15, 24, 33, 42, 51, 60, 69, 78, 87, 96, 105, 114];
ev = cut.e*1000;
[nx, ny] = size(cut.cut);
aspec = zeros(7, ny);
for i=1:13
    aspec(i, :) = mean(cut.cut(il(i)-1:il(i)+1,:),1);
end

%% plot -15 to 0 nm from TB
cc = 1;
figure, plot(ev, aspec(1, :)); 
hold on
for i=2:7
    plot(ev, aspec(i, :)+cc*2) 
    cc = cc+1;
end

%% plot +15 to 0 nm from TB
cc = 1;
figure, plot(ev, aspec(13, :)); 
hold on
for i=1:6
    plot(ev, aspec(13-i, :)+cc*2) 
    cc = cc+1;
end