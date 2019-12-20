function fese_plot_rspace_defect_linecuts(data, dx, dy, ev)



for k=1:length(dx)
    
    xe = dx(k) + 15; 
    ye = dy(k) - 15;
%     lcutx = line_cut_v4(data,[dx(k), dy(k)],[xe, dy(k)],2);
%     lcuty = line_cut_v4(data,[dx(k), dy(k)],[dx(k), ye],2);
    
    lcutx = line_cut_topo_angle(data, data.map(:,:,1), [dx(k), dy(k)], 15, 180, 2); 
    lcuty = line_cut_topo_angle(data, data.map(:,:,1), [dx(k), dy(k)], 15, 270, 2); 
    
    dcut{k, 1} = lcutx.r;
    dcut{k, 2} = lcutx.cut;
    dcut{k, 3} = lcuty.r;
    dcut{k, 4} = lcuty.cut;

end

figure, plot(dcut{1,1}, dcut{1, 2}(:, data.e*1000 == ev), '.-', 'LineWidth', 2, 'MarkerSize',10)
hold on
for k=2:length(dx)
    
    plot(dcut{k,1}, dcut{k, 2}(:, data.e*1000 == ev), '.-', 'LineWidth', 2, 'MarkerSize',10)
    
end

hold off

figure, plot(dcut{1,3}, dcut{1, 4}(:, data.e*1000 == ev), '.-', 'LineWidth', 2, 'MarkerSize',10)
hold on
for k=2:length(dx)
    
    plot(dcut{k,3}, dcut{k, 4}(:, data.e*1000 == ev), '.-', 'LineWidth', 2, 'MarkerSize',10)
    
end

hold off


%% plot line-cuts on the appropriate layer

figureset_img_plot(data.map(:,:, data.e*1000 == ev));
hold on
for k=1:length(dx)
    
    xe = dx(k) + 15; 
    ye = dy(k) - 15;
    
    plot([dx(k) dx(k)],[dy(k) ye],'y');
    plot([dx(k) xe],[dy(k) dy(k)],'y');
end

for k=1:length(dx)
    
    xe = dx(k) - 15; 
    ye = dy(k) + 15;
    
    plot([dx(k) dx(k)],[dy(k) ye],'r');
    plot([dx(k) xe],[dy(k) dy(k)],'r');
end
hold off

end