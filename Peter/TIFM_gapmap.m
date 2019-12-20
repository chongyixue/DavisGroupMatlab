function gapmap=TIFM_gapmap(data,cutoff)


map = data.map;
en =data.e*1000;

[nx, ny, nz] = size(map);

gapmap = zeros(nx,ny,1);
cc =1;
gapvec = zeros(nx*ny,1,1);
for i=1:nx
    for j=1:ny
        spec = squeeze(map(i,j,:));
        smspec = sgolayfilt(spec,3,11);
        spec = smspec;
%         figure, plot(en,spec,'k+-',en,smspec,'ro-','LineWidth',2);
        ctspec = spec-cutoff;
        ctind = find(ctspec <=0);
        if length(ctind) >= 2
            dum1 = en(ctind(1));
            dum2 = en(ctind(end));
%         figure, plot(en,spec,'k','LineWidth',2);
%         line([dum1 dum1],[0 max(spec)],'LineWidth',2,'Color','b');
%         line([dum2 dum2],[0 max(spec)],'LineWidth',2,'Color','r');
            gapmap(i,j,1) = (dum2 - dum1)/2;
        else
            gapmap(i,j,1) = 0;
        end
        gapvec(cc) = gapmap(i,j,1);
        cc = cc+1;
    end
end

figure, img_plot4(gapmap);
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