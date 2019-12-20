
img_plot2(Delta_NR_pos);
colormap(Cmap.PurBlaCop);
caxis([-0.001 0.001])


for i=1:size(avg_spct.pos_site,1)
    hold on;
    plot(avg_spct.pos_site(i,2),avg_spct.pos_site(i,1),'b.');
    
end

img_plot2(Delta_NR_pos);
colormap(Cmap.PurBlaCop);
caxis([-0.001 0.001])

for i=1:size(avg_spct.neg_site,1)
    
    hold on;
    plot(avg_spct.neg_site(i,2),avg_spct.neg_site(i,1),'r.');
    
end