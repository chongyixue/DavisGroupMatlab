%% right gap edge
G_data = G;
[nr nc nz] = size(G_data.map);
pt1 = 27; pt2 = 50;
%nr = 1; nc = 1;
%load_color;
x = G_data.e*1000;
res = 0.001;
xfine = x(pt1):res:x(pt2);
%xfine = x;
gap_map1 = zeros(nr, nc);
for i = 1:nr
    i
    for j = 1:nc
        y =  squeeze(squeeze(G_data.map(i,j,:))); y = y';   
        %y = G_data.ave; y = y';
        %y = squeeze(squeeze(G_data.map(1,200,:))); y = y';
        [p,S]= polyfit(x(pt1:pt2),y(pt1:pt2),6);
        %y2 = polyval(p,x(pt1:pt2));
        %[dy2 x2] = num_der2(2,y2,x(pt1:pt2));
        
        y2 = polyval(p,xfine);        
        [dy2 x2] = num_der2b(2,y2,xfine);        
        %x0 = x2((abs(dy2)==max(abs(dy2(1:end-4)))));
        
        x0 = x2(dy2 == min(dy2(1000:5000)));
        
        gap_map1(i,j) = x0;
        %figure; plot(x,y); hold on; plot(xfine,y2,'r'); hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        %figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));
        
    end
end
figure; pcolor(gap_map1); shading flat; colormap(Cmap.Defect1);
%%
figure; plot(x,y); hold on; plot(xfine,y2,'r'); hold on; plot([x0 x0],get(gca,'ylim')); xlim([2 8]);
        figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));
%%
G_data = G;
%% left gap edge
pt3 = 1; pt4 = 35;
[nr nc nz] = size(G_data.map);
%nr = 1; nc = 1;
x = G_data.e*1000;
res = 0.001;
xfine = x(pt3):res:x(pt4);
%xfine = x;
gap_map2 = zeros(nr, nc);
count = 1;
for i = 1:nr
    i
    for j = 1:nc
        
        y =  squeeze(squeeze(G_data.map(i,j,:))); y = y';   
        %y = G_data.ave; y = y';
        %y = squeeze(squeeze(G_data.map(2,150,:))); y = y';
        [p,S]= polyfit(x(pt3:pt4),y(pt3:pt4),20);        
        %y2 = polyval(p,x(pt1:pt2));
        
        
        y2 = polyval(p,xfine);      
        
        %[dy2 x2] = num_der2b(2,y2,xfine);
        %figure; plot(x2,dy2,'g');
        x0 = xfine(y2 == max(y2(600:end-500)));                
       if x0 < -3 || x0 > 3
           r(count) = i; c(count) = j;
           count = count +1;
       end
        gap_map2(i,j) = x0;
        %figure; plot(x,y); hold on; plot(xfine,y2,'r'); hold on; plot([x0 x0],get(gca,'ylim')); xlim([-5 2])
        %figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));
        
    end
end
figure; pcolor(gap_map2); shading flat; colormap(Cmap.Defect1);
%%
figure; pcolor(gap_map2); shading flat; colormap(Cmap.Defect1);
%%
% gap_map2filt = gauss_filter2d(gap_map2,2,2); %this gives a 'nematic'
% ft????
gap_map2filt = gauss_filter2d(gap_map2,20,7);
figure; pcolor(gap_map2filt); shading flat; colormap(Cmap.Defect1);
%%
ft_gap = fourier_tr2d(gap_map2filt,'sine','','ft');
figure; pcolor(ft_gap); shading flat; colormap(Cmap.Defect1);
%% find gap of current divided maps
% 
G_data = Gmod;
[nr nc nz] = size(G_data.map);
pt1 = 46; pt2 = 70;
%nr = 1; nc = 1;
%load_color;
x = G_data.e*1000;
res = 0.001;
xfine = x(pt1):res:x(pt2);
%xfine = x;
gap_map1 = zeros(nr, nc);
for i = 1:nr
    i
    for j = 1:nc
        y =  squeeze(squeeze(G_data.map(i,j,:))); y = y';   
        %y = G_data.ave; y = y';
        %y = squeeze(squeeze(G_data.map(14,69,:))); y = y';
        [p,S]= polyfit(x(pt1:pt2),y(pt1:pt2),5);
        
        %y2 = polyval(p,x(pt1:pt2));
        %[dy2 x2] = num_der2(2,y2,x(pt1:pt2));
        
        y2 = polyval(p,xfine);        
        
        [dy2 x2] = num_der2b(2,y2,xfine);        
        
        %x0 = x2((abs(dy2)==max(abs(dy2(1:end-4)))));
        
        x0 = mean(x2(dy2 == max(dy2(2000:4000))));        
        gap_map1(i,j) = x0;
        
        %figure; plot(x,y); hold on; plot(xfine,y2,'r'); hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        %figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));
        
    end
end
figure; pcolor(gap_map1); shading flat; colormap(Cmap.Defect1);
%%
ft_gap = fourier_tr2d(gap_map1,'sine','','ft');
figure; pcolor(ft_gap); shading flat; colormap(Cmap.Defect1);
%% find gap of current divided maps
% left gap edge
G_data = Gmod;
pt3 = 35; pt4 = 45;
[nr nc nz] = size(G_data.map);
%nr = 1; nc = 1;
x = G_data.e*1000;
res = 0.001;
xfine = x(pt3):res:x(pt4);
%xfine = x;
gap_map2 = zeros(nr, nc);
for i = 1:nr
    i
    for j = 1:nc
        y =  squeeze(squeeze(G_data.map(i,j,:))); y = y';   
        %y = G_data.ave; y = y';
        %y = squeeze(squeeze(G_data.map(25,120,:))); y = y';
        [p,S]= polyfit(x(pt3:pt4),y(pt3:pt4),6);        
        %y2 = polyval(p,x(pt1:pt2));
        
        y2 = polyval(p,xfine);      
        %[dy2 x2] = num_der2b(2,y2,xfine);
        %figure; plot(x2,dy2,'g');
        x0 = mean(xfine(y2 == min(y2(500:2400))));                
        gap_map2(i,j) = x0;
        %figure; plot(x,y); hold on; plot(xfine,y2,'r'); hold on; plot([x0 x0],get(gca,'ylim')); %xlim([-5 2])
        %figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));
        
    end
end
figure; pcolor(gap_map2); shading flat; colormap(Cmap.Defect1);
%%
ft_gap2 = fourier_tr2d(gap_map2,'sine','','ft');
figure; pcolor(ft_gap2); shading flat; colormap(Cmap.Defect1);
%%
gap = gap_map1 - gap_map2;
figure; pcolor(gap); shading flat; colormap(Cmap.Defect4);
%%
ft_gap_t = fourier_tr2d(gap,'sine','','ft');
figure; pcolor(ft_gap_t); shading flat; colormap(Cmap.Defect1);