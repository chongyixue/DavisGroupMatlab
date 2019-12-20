function plothisto_STMdata(data)



map = data.map;
[nx,ny,nz] = size(map);

gapvec = reshape(map,nx*ny,1);



[minh, maxh] = change_color_of_STM_maps_wo(map,'no');
fh = gcf;
cmap = get(fh,'Colormap');

figure, hist(gapvec,50);


% binranges = linspace(min(gapvec),max(gapvec),50);
binranges = linspace(minh,maxh,50);

[bincounts] = histc(gapvec,binranges);

bw = binranges(2)-binranges(1);
fcn = round((binranges(1)-min(gapvec))/(max(gapvec)-min(gapvec))*256);
if fcn == 0
    fcn =1;
end
fc = cmap(fcn,:);
ec = fc;
figure
bar(binranges(1),bincounts(1),bw,'FaceColor',fc,'EdgeColor',ec);
for i=2:length(binranges)
    fcn = round((binranges(i)-min(gapvec))/(max(gapvec)-min(gapvec))*256);
%     ecn = round((binranges(i)-min(gapvec))/(max(gapvec)-min(gapvec))*256);
    if fcn == 0
        fcn =1;
    end
    fc = cmap(fcn,:);
    ec = fc;
    hold on
    bar(binranges(i),bincounts(i),bw,'FaceColor',fc,'EdgeColor',ec);
    hold off
end

xlim([binranges(1)-bw/2,binranges(end)+bw/2]);
ax = gca;
% set(ax,'XTick',round(binranges(1:2:end)));
xlabel('N(r)','fontsize',20,'fontweight','b')
ylabel('Count','fontsize',20,'fontweight','b')



end