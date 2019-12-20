%%
[nr nc nz] = size(G.map);
b1 = 33; b2 = 65;
xtmp = G.e(b1:b2)*1000;

%ytmp = G.ave(b1:b2);
ytmp =squeeze(squeeze(G.map(177,142,b1:b2)));
ytmp2 = max(ytmp) - ytmp;
peak1 = findpeaks_3(xtmp,ytmp2,0.003,1,2,5);       
%peak1 = peak1(max(peak1(peak1(:,3) == max(peak1(:,3)),1)),:);
figure; plot(xtmp,ytmp);
x = xtmp;
y = ytmp2;
%% find dip
b1 = 35; b2 = 65;
xtmp = G.e(b1:b2)*1000;
[nr nc nz] = size(G.map);
bottom = zeros(nr,nc);
for i = 1:nr
    i
    for j = 1:nc      
        ytmp = squeeze(squeeze(G.map(i,j,b1:b2)));
        ytmp2 = max(ytmp) - ytmp;
        peak1 = findpeaks_3(xtmp,ytmp2,0.003,1,2,5);
        if peak1(1,1) ~=0 
            peak1 = peak1(max(peak1(peak1(:,3) == max(peak1(:,3)),1)),:);
        end
        bottom(i,j) = peak1(1,2);
    end
end
img_plot2(bottom,Cmap.Defect1);
%%
[nr nc nz] = size(G.map);
b1 = 23; b2 = 60;
xtmp = G.e(b1:b2)*1000;

%ytmp = G.ave(b1:b2);
ytmp =squeeze(squeeze(G.map(104,69,b1:b2)));
peak1 = findpeaks_3(xtmp,ytmp,0.00085,1,4,7);       
%peak1 = peak1(max(peak1(peak1(:,3) == max(peak1(:,3)),1)),:);
figure; plot(xtmp,ytmp);
x = xtmp;
y = ytmp;

%% find peak
b1 = 23; b2 = 55;
xtmp = G.e(b1:b2)*1000;
[nr nc nz] = size(G.map);
top = zeros(nr,nc);
for i = 1:nr
    i
    for j = 1:nc      
        ytmp = squeeze(squeeze(G.map(i,j,b1:b2)));
        peak1 = findpeaks_3(xtmp,ytmp,0.00085,1,4,7);
        if peak1(1,1) ~=0 
            peak1 = peak1(max(peak1(peak1(:,3) == max(peak1(:,3)),1)),:);
        end
        top(i,j) = peak1(1,2);
    end
end
img_plot2(top,Cmap.Defect1,['b1 = ' num2str(b1) ' b2 = ' num2str(b2)]);
FT_top = fourier_transform2d(top,'sine','','');
img_plot2(FT_top,Cmap.Defect1,['b1 = ' num2str(b1) ' b2 = ' num2str(b2)])
caxis([0 160]);
%% gap correlation with conductance map
[nr nc nz] = size(G.map);
gap_min_corr = zeros(nz,1);
for k = 1:nz
    gap_min_corr(k) = corr2(right_edge,G.map(:,:,k));
end
figure; plot(G.e*1000,abs(gap_min_corr));
clear nr nc nz k;
%%
[nr nc nz] = size(G.map);
bottom_index = zeros(nr,nc);
energy = G.e*1000;
for i = 1:nr
    for j = 1:nc        
        bottom_index(i,j) = find_gap_ind(bottom(i,j),energy);       
    end
end
img_plot2(bottom_index,Cmap.Defect1);
%%
G_data = G;
[nr nc nz] = size(G_data.map);
%%
res = 0.05;
xtmp = G_data.e*1000;
xfine = x;
xx = 24; yy = 45;
pt1 = bottom_index(xx,yy)+5;
pt2 =  pt1 + 15;

%pt1 = 44;
%pt2 = 75;
        ytmp =  squeeze(squeeze(G_data.map(xx,yy,:))); ytmp = ytmp';  
        figure; plot(xtmp(pt1:pt2),ytmp(pt1:pt2));
        [p,S]= polyfit(xtmp(pt1:pt2),ytmp(pt1:pt2),6);                
        xfine = xtmp(pt1):res:xtmp(pt2);
        y2 = polyval(p,xfine);  
        hold on; plot(xfine,y2,'r');
        [dy2 x2] = num_der2b(2,y2,xfine);   
        %figure; plot(x2,dy2)
        pp = findpeaks_3(x2,max(dy2) - dy2,0.00001,1,1,9)
            %pp = pp(min(peak1(peak1(:,3) == max(peak1(:,3)),1)),:);
        %x0 = x2(dy2 == min(dy2));
        x0 = pp(1,2);
        r_edge = x0(1);
        
        figure; plot(xtmp,ytmp)
         hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));
%% find right edge
G_data = G;
[nr nc nz] = size(G_data.map);
%nr = 100; nc = 100;
xtmp = G_data.e*1000;
res = 0.05;
%xfine = x(pt1):res:x(pt2);
%xfine = x;
right_edge = zeros(nr, nc);
mean_index = floor(mean(mean(bottom_index)));
for i = 1:nr
    i
    for j = 1:nc
        
        pt1 = min(bottom_index(i,j),nz); 
        if pt1 == 0
            pt1 = mean_index;
        end
        
        pt1 = min(pt1+1,nz); % good set
        %pt2 =  min(pt1 + 15,nz);
        pt2 = 80;
        
       % pt1 = min(pt1-6,nz);
        %pt2 =  min(pt1 + 35,nz);
        %pt1 = 50;
        %pt2 = 75;
        ytmp =  squeeze(squeeze(G_data.map(i,j,:))); ytmp = ytmp';   
        [p,S]= polyfit(xtmp(pt1:pt2),ytmp(pt1:pt2),6);                
        xfine = xtmp(pt1):res:xtmp(pt2);     
        y2 = polyval(p,xfine);        
        [dy2 x2] = num_der2b(2,y2,xfine);                  
        pp = findpeaks_3(x2,max(dy2) - dy2,0.0001,1,1,7);
        if pp(1,1) ~=0
            x0= pp(1,2);
            right_edge(i,j) = x0;          
        end
        %x0 = x2(dy2 == min(dy2(1000:5000)));

        
        %figure; plot(xfine,y2,'r'); hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        %figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));
     
    end
end
img_plot2(right_edge,Cmap.Defect1,['right edge - pt1 = ' num2str(pt1) ' pt2 = ' num2str(pt2)]);
%%
right_edge2 = gauss_filter_image(bottom,15,15);
FT_right = fourier_transform2d(right_edge2 - mean(mean(right_edge2)),'sine','','');
img_plot2(FT_right,Cmap.Defect1,['right edge - pt1 = ' num2str(pt1) ' pt2 = ' num2str(pt2)])
caxis([20 100]);
%%
img_plot2(symmetrize_image(linear2D_image_correct([2.18 -2.36],[-2.26 -2.29],FT_right,FT_topo.r),'v','d'),Cmap.Defect1,['right edge - pt1 = ' num2str(pt1) ' pt2 = ' num2str(pt2)]);
caxis([40 200])
%%
clear i j x0 xtmp nr nc nz p res x2 xfine dy2 y2 ytmp S
%%

%%
mn_right = mean(mean(right_edge))
std_right = std(reshape(right_edge,200*200,1))
[r1 c1] = find(right_edge >= mn_right + 3.5*std_right);
[r2 c2] = find(right_edge <= mn_right - 3.5*std_right);
%%
res = 0.05;
xtmp = G_data.e*1000;
xfine = x;
n = 1;
xx = r1(n); yy = c1(n);
pt1 = bottom_index(xx,yy)+5; pt2 =  pt1 + 15;
        ytmp =  squeeze(squeeze(G_data.map(xx,yy,:))); ytmp = ytmp';  
        figure; plot(xtmp(pt1:pt2),ytmp(pt1:pt2));
        [p,S]= polyfit(xtmp(pt1:pt2),ytmp(pt1:pt2),9);                
        xfine = xtmp(pt1):res:xtmp(pt2);
        y2 = polyval(p,xfine);        
        [dy2 x2] = num_der2b(2,y2,xfine);   
        %figure; plot(x2,dy2)
        pp = findpeaks_3(x2,max(dy2) - dy2,0.00001,1,1,7)
            %pp = pp(min(peak1(peak1(:,3) == max(peak1(:,3)),1)),:);
        %x0 = x2(dy2 == min(dy2));
        x0 = pp(1,2);
        r_edge = x0(1);
        
        figure; plot(xtmp,ytmp)
         hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));
%%
x1 = G.e*1000;
y1 = G.ave;
 [p,S]= polyfit(x1,y1',17);                
 y2 = polyval(p,x1);
 figure; plot(x1,y1); hold on; plot(x1,y2,'r')