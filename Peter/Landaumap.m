function [llmap,dmap,mmap] = Landaumap(data,avp,avpw)

tic

map = data.map;
ev = data.e * 1000;
[nx,ny,nz] = size(map);
np = length(avp);
llmap = zeros(nx,ny,np);

for i=1:nx
    for j=1:ny
        spec = squeeze(map(i,j,:));
        for k=1:np
            sp = spec(avp(k)-avpw(k):avp(k)+avpw(k));
            sp = sp + abs(min(sp));
            [dum0,maxi] = max(sp);
            navp = avp(k) - avpw(k) + maxi;
            
            sp = spec(navp-avpw(k):navp+avpw(k));
            sp = sp + abs(min(sp));
            en = ev(navp-avpw(k):navp+avpw(k))';
            slp = (sp(end)-sp(1))/(en(end) - en(1));
            bkg = slp * en;
            spl = sp - bkg;
%             figure, plot(en,sp,'r',en,spl,'k','LineWidth',2);
            cm = sum(sp.*en)/sum(sp);
%             cmc = sum(spl.*en)/sum(spl);
            
%             guess = [slp,mean(sp),cmc,abs(ev(2)-ev(1)),mean(sp)];
%             low = [-inf,0,cmc-2*(en(2)-en(1)),0,0];
%             upp = [inf,2*max(sp),cmc+2*(en(2)-en(1)),abs(en(end)-en(1)),max(sp)];
%             [y_new, p,gof]=lorentzian2(sp,en,guess,low,upp);
%             figure, plot(en,sp,'ko',en,y_new,'r','LineWidth',2)
%             line([cm,cm],[min(sp),max(sp)],'LineWidth',2,'Color','b');
%             line([cmc,cmc],[min(sp),max(sp)],'LineWidth',2,'Color','k');
%             line([p.c,p.c],[min(sp),max(sp)],'LineWidth',2,'Color','r');
            llmap(i,j,k) = cm;
%             llmap(i,j,k) = p.c;
            clear sp en cm navp;
        end
    end
end

dmap = abs((llmap(:,:,3) - llmap(:,:,1))/2)+llmap(:,:,1);
mmap = llmap(:,:,2) - dmap;
gapvec = reshape(mmap,nx*ny,1);
meangap = mean(gapvec)
stdgap = std(gapvec)

for i=1:nx
    for j=1:ny
        if mmap(i,j,1) < meangap - 3*stdgap
            mmap(i,j,1) = meangap - 3*stdgap;
        elseif mmap(i,j,1) > meangap + 3*stdgap
            mmap(i,j,1) = meangap + 3*stdgap;
        end
    end
end

toc
%%
% mmap = wiener2(mmap,[5 5]);
gapvec = reshape(mmap,nx*ny,1);
meangap = mean(gapvec)
stdgap = std(gapvec)

change_color_of_STM_maps(mmap,'no')
fh = gcf;
cmap = get(fh,'Colormap');

figure, hist(gapvec,50);


binranges = linspace(min(gapvec),max(gapvec),15);
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
% set(ax,'XTick',round(binranges(1:2:end)));
xlabel('Mass Gap [mV]','fontsize',16,'fontweight','b')
ylabel('Count','fontsize',16,'fontweight','b')


%%

gapvec = reshape(dmap,nx*ny,1);
meangap = mean(gapvec)
stdgap = std(gapvec)

for i=1:nx
    for j=1:ny
        if dmap(i,j,1) < meangap - 3*stdgap
            dmap(i,j,1) = meangap - 3*stdgap;
        elseif dmap(i,j,1) > meangap + 3*stdgap
            dmap(i,j,1) = meangap + 3*stdgap;
        end
    end
end
%%
% mmap = wiener2(mmap,[5 5]);
gapvec = reshape(dmap,nx*ny,1);
meangap = mean(gapvec)
stdgap = std(gapvec)

change_color_of_STM_maps(dmap,'no')
fh = gcf;
cmap = get(fh,'Colormap');

figure, hist(gapvec,50);


binranges = linspace(min(gapvec),max(gapvec),15);
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
% set(ax,'XTick',round(binranges(1:2:end)));
xlabel('Dirac Point [mV]','fontsize',16,'fontweight','b')
ylabel('Count','fontsize',16,'fontweight','b')





end