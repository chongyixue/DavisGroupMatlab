function gapminmap=TIFM_gapminmap(data)


map = data.map;
en =data.e*1000;

[nx, ny, nz] = size(map);

gapmap = zeros(nx,ny,1);
maskmap = zeros(nx,ny,1);
invmaskmap = zeros(nx,ny,1);
cc =1;
gapvec = zeros(nx*ny,1,1);
for i=1:nx
    for j=1:ny
        spec = squeeze(map(i,j,:));
        [dum0,dum0ind] = min(spec);
        gapmap(i,j,1) = en(dum0ind);
        gapvec(cc) = gapmap(i,j,1);
        if gapvec(cc) == 170 || gapvec(cc) == 175
            maskmap(i,j,1) = 1;
            invmaskmap(i,j,1) = 0;
        else
            maskmap(i,j,1) = 0;
            invmaskmap(i,j,1) = 1;
        end
        cc = cc+1;
    end
end
gapminmap = gapmap;
figure, img_plot5(maskmap);
figure, img_plot5(invmaskmap);
maskmapm = repmat(maskmap,1,1,nz);
invmaskmapm = repmat(invmaskmap,1,1,nz);
specmin = squeeze(sum(sum(maskmapm .* map)) / sum(sum(maskmap)));
specgap = squeeze(sum(sum(invmaskmapm .* map)) / sum(sum(invmaskmap)));
figure, plot(en,specmin,'k+-',en,specgap,'ro-');
change_color_of_STM_maps(gapmap,'no')
fh = gcf;
cmap = get(fh,'Colormap');

figure, hist(gapvec,25);


binranges = linspace(min(gapvec),max(gapvec),30);
[bincounts] = histc(gapvec,binranges);

bw = binranges(2)-binranges(1);
fcn = round((binranges(1)-min(gapvec))/(max(gapvec)-min(gapvec))*256);
% ecn = round((binranges(1)-min(gapvec))/(max(gapvec)-min(gapvec))*256);
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
set(ax,'XTick',round(binranges(1:2:end)));
xlabel('Gap [mV]','fontsize',16,'fontweight','b')
ylabel('Count','fontsize',16,'fontweight','b')


end