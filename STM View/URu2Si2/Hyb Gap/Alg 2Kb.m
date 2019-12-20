%%
x2k = obj_90402A05_G.e*1000;
y2k = obj_90402A05_G.ave; y2k = y2k';
%%
y2k = squeeze(squeeze(obj_90402A05_G.map(200,20,:))); y2k = y2k';
%%
x2kb = [x2k(1:7) x2k(46:end-10)];
y2kb = [y2k(1:7) y2k(46:end-10)];
figure; plot(x2kb,y2kb,'x')
p = polyfit(x2kb,y2kb,3);
bkg = polyval(p,x2k);
hold on; plot(x2k,bkg,'r');
%%
figure; plot(x2k,y2k);
%figure; plot(x2k,y2k-bkg,'r'); hold on;
figure; plot(x2k,abs(y2k-bkg));

%%
x2kc = x2k(1:15);
y2kc = y2k(1:15);
figure; plot(x2kc,y2kc,'rx');
p = polyfit(x2kc,y2kc,4);
diff = abs(x2kc(1) - x2kc(2));
x2kc_ref = x2kc(1):diff/10:x2kc(end);
f = polyval(p,x2kc_ref);
hold on; plot(x2kc_ref,f);
[df xf] = num_der2b(2,f,x2kc_ref);
figure; plot(xf,df);
%%

%% find the gap minimum
b1 = 25; b2= 39; %09227A13
%b1 = 43; b2 = 56; %090430A02
xtmp = G.e(b1:b2)*1000;
diff = abs(xtmp(1) - xtmp(2));
[nr nc nz] = size(G.map);
bottom = zeros(nr,nc);
bottom_index = zeros(nr,nc);
for i = 1:nr    
    for j = 1:nc
         ytmp = squeeze(squeeze(G.map(i,j,b1:b2)));
         tmp = xtmp(ytmp == min(ytmp));
         bottom(i,j) = tmp(1);                  
    end
end

% if the values for the gap minimum are too far from the mean, then revisit
% them and employ a peak finding algorithm to revise the estimate

bottom2 = bottom;
std_bottom = std(reshape(bottom,nr*nc,1));
mean_bottom = mean(mean(bottom));
[r_bot c_bot] = find(bottom <= mean_bottom - 2*std_bottom);
ind = length(c_bot);
count = 0;
for n = 1:ind        
    ytmp = squeeze(squeeze(G.map(r_bot(n),c_bot(n),b1:b2)));
    new_peak = findpeaks(xtmp,max(ytmp) - ytmp, 0.014,1,1,3);
    if new_peak(1,2) ~= bottom(r_bot(n),c_bot(n))
        count = count + 1;
    end
    bottom2(r_bot(n),c_bot(n)) = new_peak(1,2);
end
%% 
img_plot2(right_edge2,Cmap.Defect1,'Bottom');
%% generate bottom index
[nr nc nz] = size(G.map);
xtmp = G.e*1000;
bottom_index = zeros(nr,nc);
for i = 1:nr
    
    for j = 1:nc
        
        if bottom2(i,j) ~= 0
            bottom_index(i,j) = find(bottom2(i,j) == xtmp);
        end
    end
end
clear xtmpi j
%%
img_plot2(bottom_index,Cmap.Defect1)
%% refine gap bottom
[nr nc nz] = size(G.map);
bottom3 = zeros(nr,nc);
diff = (G.e(1) - G.e(2))*1000;
for i = 1:nr
    i
    for j = 1:nc
       
        center = bottom_index(i,j);
        if center > 2 && center < nz -2
            ytmp = squeeze(squeeze(G.map(i,j,center-2:center+2))); ytmp = ytmp';
            xtmp = G.e(center-2:center+2)*1000;
            p = polyfit(xtmp,ytmp,2);
            xtmp_ref = xtmp(1):-diff/10:xtmp(end);
            f = polyval(p,xtmp_ref);
            bot = xtmp_ref(f == min(f));
            bottom3(i,j) = bot(1);
        end
    end
end
img_plot2(bottom3,Cmap.Defect1);
%%
img_plot2(bottom2,Cmap.Defect1,'gap minimum: inter 2');
clear new_peak ind mean_bottom std_bottom tmp xtmp ytmp n nr nc nz b1 b2 i j r_bot c_bot bottom count
%%
%img_plot2(bottom2(50:200,1:150),Cmap.Defect1,'gap minimum: inter 2');

%bottom_filt = gauss_filter_image(left_edge(51:200,1:150),20,20);
bottom_filt = gauss_filter_image(right_edge_b - left_edge_b,20,20);
FT_bottom = fourier_transform2d(bottom_filt - mean(mean(bottom_filt)),'sine','','');
img_plot2(FT_bottom,Cmap.Defect1,['right edge - pt1 = ' num2str(pt1) ' pt2 = ' num2str(pt2)])
caxis([20 400]);

%%
FT_sym_gap_b = symmetrize_image(linear2D_image_correct([1.95 -2.09],[-2.02 -1.98],FT_bottom,FT_T.r),'d','v');
%FT_sym_left_b = symmetrize_image(linear2D_image_correct([1.95 -2.09],[-2.02 -1.98],FT_bottom,FT_T.r),'d','v');
img_plot2(symmetrize_image(linear2D_image_correct([1.95 -2.09],[-2.02 -1.98],FT_bottom,FT_T.r),'d','v'),Cmap.Defect1,['right edge - pt1 = ' num2str(pt1) ' pt2 = ' num2str(pt2)]);
caxis([30 350])
%% find maximum point

[nr nc nz] = size(G.map);
xtmp = G.e*1000;

st_pt = 1;
max_pt = nan(nr,nc);
energy = G.e*1000;
%n1 = 150; n2 = 256;
for i = 1:nr
    i
    for j = 1:nc
        end_pt = bottom_index(i,j);
        if end_pt ~=0
        x = energy(st_pt:end_pt);
        y = squeeze(squeeze(G.map(i,j,st_pt:end_pt)));
        peaks1 = findpeaks(x,y,0.004,22,1,4); 
        peaks2 = findpeaks(x,y,0.004,22,2,4); 
        peaks3 = findpeaks(x,y,0.004,22,3,4); 

        peak_sort = sort([peaks1(end,2) peaks2(end,2) peaks3(end,2)]);
        peak_point = peak_sort(end);
        peak_sort = [peak_sort(1) peak_sort];
        
        tol = 0.1; % how much the left peak has to differ in height from the bottom of gap
        for k = 1:3
            if (y(find(x == peak_point)) >= (1+tol)*y(end))
                break;
            else               
                peak_point = peak_sort(end-k);
            end
        end
        max_pt(i,j) = peak_point;
        end
    end
end
img_plot2(max_pt,Cmap.Defect1,'left edge');
max_pt(isnan(max_pt)) = 0;
clear i j k peak_sort peak_point peaks1 peaks2 peaks3 x y end_pt st_pt energy;
%% generate max point index
[nr nc nz] = size(G.map);
xtmp = G.e*1000;
max_index = zeros(nr,nc);
for i = 1:nr
    
    for j = 1:nc
        
        %if max_pt(i,j) ~= 0
        tmp = find(max_pt(i,j) == xtmp);
        if ~isempty(tmp)
            max_index(i,j) = find(max_pt(i,j) == xtmp);
        end
    end
end
clear xtmpi j
img_plot2(max_index,Cmap.Defect1, 'max pt index');

%% find left edge
[nr nc nz] = size(G.map);
left_edge = zeros(nr,nc);
energy = G.e*1000;
diff = abs(energy(1)-energy(2));
lag = 6;
pwr = 4;
res = 500;
for i = 1:nr
    i
    for j = 1:nc
        if max_index(i,j) - lag > pwr
            ytmp = squeeze(squeeze(G.map(i,j,:)));
            ytmp = ytmp(1:max_index(i,j)- lag);  ytmp = ytmp';
            xtmp = energy(1:max_index(i,j)-lag);
            p = polyfit(xtmp,ytmp,pwr);
            xtmp_ref = xtmp(1):diff/res:xtmp(end);
            f = polyval(p,xtmp_ref);
            [df xf] = num_der2b(2,f,xtmp_ref);
            %[df2 xf2] = num_der2b(3,f,xtmp_ref);
            %l_pt = xtmp_ref(abs(df2) == min(abs(df2))); l_pt = mean(l_pt);
            l_pt = xf(df==max(df)); l_pt = l_pt(1);
%               if (l_pt == xf(1)) || (l_pt == xf(end))
%                   l_pt = xf(df == min(df));
%               end
            left_edge(i,j) = l_pt(1);
        end
    end
end
%%
img_plot2(left_edge,Cmap.Defect1,'left edge');
left_edge_crop = left_edge1(51:200,1:150);
%img_plot2(left_edge(51:200,1:150),Cmap.Defect1,'left edge crop');
%%
img_plot2(left_edge - left_edge1,Cmap.Defect1)
%%
[r1 c1] = find((left_edge < -5.9)|(left_edge > -1.5));
%% refine left_edge
l_r = length(r1);
left_edge1 = left_edge;
for i = 1:l_r
    i
    if max_index(r1(i),c1(i)) - lag > pwr
    ytmp = squeeze(squeeze(G.map(r1(i),c1(i),:)));
    ytmp = ytmp(1:max_index(r1(i),c1(i))- lag);  ytmp = ytmp';
    xtmp = energy(1:max_index(r1(i),c1(i))-lag);
    p = polyfit(xtmp,ytmp,pwr);
    xtmp_ref = xtmp(1):diff/res:xtmp(end);
    f = polyval(p,xtmp_ref);
    [df xf] = num_der2b(3,f,xtmp_ref);
    if (sign(df(1))~= sign(df(end)))
        l_pt = xf(abs(df) == min(abs(df))); l_pt = mean(l_pt);
        left_edge1(r1(i),c1(i)) = l_pt;
    end
    end
    
end

img_plot2(left_edge1,Cmap.Defect1,'left edge 1');
%% refine left edge 1
[r2 c2] = find((left_edge1 < -5.9)|(left_edge1 > -4));
l_r = length(r2)
left_edge2 = left_edge1;
for i = 1:l_r
    i
    if max_index(r2(i),c2(i)) - lag > pwr
        ytmp = squeeze(squeeze(G.map(r2(i),c2(i),:)));
        ytmp = ytmp(1:max_index(r2(i),c2(i))- lag);  ytmp = ytmp';
        xtmp = energy(1:max_index(r2(i),c2(i))-lag);
        p = polyfit(xtmp,ytmp,pwr);
        xtmp_ref = xtmp(1):diff/res:xtmp(end);
        f = polyval(p,xtmp_ref);
        [df xf] = num_der2b(3,f,xtmp_ref);
        if (sign(df(1))== sign(df(end)))
            for j = 1:lag  
                
                ytmp = squeeze(squeeze(G.map(r2(i),c2(i),:)));
                ytmp = ytmp(1:max_index(r2(i),c2(i))- lag + j);
                ytmp = ytmp';
                xtmp = energy(1:max_index(r2(i),c2(i))-lag + j);
                p = polyfit(xtmp,ytmp,pwr);
                xtmp_ref = xtmp(1):diff/res:xtmp(end);
                f = polyval(p,xtmp_ref);
                [df2 xf2] = num_der2b(3,f,xtmp_ref);
                if (sign(df2(1)) ~= sign(df2(end)))
                    l_pt = xf2(abs(df2) == min(abs(df2))); 
                    l_pt = mean(l_pt);
                    left_edge2(r2(i),c2(i)) = l_pt;
                    break;
                end
            end
        end
    end     
end
%%
img_plot2(left_edge2,Cmap.Defect1,'left edge 2');

%%
n = 151;
left_edge1(r1(n),c1(n))
r = r1(n);
c = c1(n);
r =73;
c= 105;
x2k = obj_90402A05_G.e*1000;
y2k = obj_90402A05_G.ave; y2k = y2k';
%figure; plot(x2k,y2k);
y2k = squeeze(squeeze(obj_90402A05_G.map(r,c,:))); y2k = y2k';
%figure; plot(x2k,y2k);
x2kc = x2k(1:max_index(r,c)-6);
y2kc = y2k(1:max_index(r,c)-6);
figure; plot(x2kc,y2kc,'rx');
p = polyfit(x2kc,y2kc,4);
diff = abs(x2kc(1) - x2kc(2));
x2kc_ref = x2kc(1):diff/10:x2kc(end);
f = polyval(p,x2kc_ref);
hold on; plot(x2kc_ref,f);
[df xf] = num_der2b(2,f,x2kc_ref);
[df2 xf2] = num_der2b(3,f,x2kc_ref);
figure; plot(xf,df); hold on;
plot(xf2,df2,'r');
ext_pt2 = xf2(abs(df2) == min(abs(df2))); ext_pt2 = mean(ext_pt2)
ext_pt = xf(df == max(df));
if ext_pt == xf(1) || ext_pt ==xf(end)
    ext_pt = xf(df == min(df))
end
ext_pt
[ddf xfd] = num_der2b(1,f,x2kc_ref);
figure; plot(xfd,ddf,'g');
%% gap correlation with conductance map
[nr nc nz] = size(G.map);
gap_min_corr = zeros(nz,1);
for k = 1:nz
    gap_min_corr(k) = corr2(left_edge1,G.map(:,:,k));
end
figure; plot(G.e*1000,abs(gap_min_corr));
clear nr nc nz k;

%% find right edge
G_data = G;
[nr nc nz] = size(G_data.map);
%pt1 = 27; pt2 = 50;
%nr = 1; nc = 1;
%load_color;
xtmp = G_data.e*1000;
res = 0.001;
%xfine = x(pt1):res:x(pt2);
%xfine = x;
right_edge = zeros(nr, nc);
for i = 140
    i
    for j = 112
        pt1 = bottom_index(i,j) +1 ; pt2 =  min(pt1 + 23,nz);
        %pt1 = bottom_index(i,j) ; pt2 =  min(pt1 + 23,nz);
        ytmp =  squeeze(squeeze(G_data.map(i,j,:))); ytmp = ytmp';   
        %y = G_data.ave; y = y';
        %y = squeeze(squeeze(G_data.map(1,200,:))); y = y';
        [p,S]= polyfit(xtmp(pt1:pt2),ytmp(pt1:pt2),4);                
        xfine = xtmp(pt1):res:xtmp(pt2);
        y2 = polyval(p,xfine);        
        [dy2 x2] = num_der2b(2,y2,xfine);                
        [dy3 x3] = num_der2b(3,y2,xfine);
        figure; plot(xtmp,ytmp)
        figure; plot(x2,dy2); hold on; plot(x3,abs(dy3),'r');
        if sign(dy3(1)) ~= sign(dy3(end))
            x0 = x3(abs(dy3) == min(abs(dy3)));
             right_edge(i,j) = mean(x0);
        x0 = x2(dy2 == min(dy2(1000:5000)))
        end
        %right_edge(i,j) = mean(x0);
        %right_edge(i,j) = x0(1);
        %figure; plot(xtmp,ytmp); hold on; plot(xfine,y2,'r'); hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        %figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));
        
    end
end
%
img_plot2(right_edge,Cmap.Defect1,'right_edge');
caxis([2 7]);
%%
%% find right edge
G_data = G;
[nr nc nz] = size(G_data.map);
%nr = 100; nc = 100;
xtmp = G_data.e*1000;
res = 0.01;
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
        
        pt1 = min(pt1+3,nz); % good set
        pt2 =  min(pt1 + 11,nz);
        %pt2 = 80;
        
       % pt1 = min(pt1-6,nz);
        %pt2 =  min(pt1 + 35,nz);
        %pt1 = 50;
        %pt2 = 75;
        ytmp =  squeeze(squeeze(G_data.map(i,j,:))); ytmp = ytmp';   
        [p,S]= polyfit(xtmp(pt1:pt2),ytmp(pt1:pt2),7);                
        xfine = xtmp(pt1):res:xtmp(pt2);     
        y2 = polyval(p,xfine);        
        [dy2 x2] = num_der2b(2,y2,xfine);                  
        pp = findpeaks_3(x2,max(dy2) - dy2,0.00001,1,1,7);
        %if pp(1,1) ~=0
            x0= pp(1,2);
            right_edge(i,j) = x0;          
        %end
        %x0 = x2(dy2 == min(dy2(1000:5000)));        
        %figure; plot(xfine,y2,'r'); hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        %figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));     
    end
end
%%
img_plot2(right_edge,Cmap.Defect1,'right_edge');
%caxis([2 7]);
%%
%% find right edge with variable poly fit
G_data = G;
[nr nc nz] = size(G_data.map);
%nr = 100; nc = 100;
xtmp = G_data.e*1000;
res = 0.01;
%xfine = x(pt1):res:x(pt2);
%xfine = x;
right_edge2 = zeros(nr, nc);
mean_index = floor(mean(mean(bottom_index)));
for i = 1:nr
    i
    for j = 1:nc
        
        pt1 = min(bottom_index(i,j),nz); 
        if pt1 == 0
            pt1 = mean_index;
        end
        
        pt1 = min(pt1+3,nz); % good set
        pt2 =  min(pt1 + 11,nz);
        %pt2 = 80;
        
       % pt1 = min(pt1-6,nz);
        %pt2 =  min(pt1 + 35,nz);
        %pt1 = 50;
        %pt2 = 75;
        ytmp =  squeeze(squeeze(G_data.map(i,j,:))); ytmp = ytmp';
        for k=0:1
        [p,S]= polyfit(xtmp(pt1:pt2),ytmp(pt1:pt2),7-k);                
        xfine = xtmp(pt1):res:xtmp(pt2);     
        y2 = polyval(p,xfine);        
        [dy2 x2] = num_der2b(2,y2,xfine);                  
        pp = findpeaks_3(x2,max(dy2) - dy2,0.00001,1,1,7);
        x0= pp(1,2);
        if x0 ~=x2(1) && x0 ~=x2(end)           
            break;
        end
         
        end
        right_edge2(i,j) = x0;
        %x0 = x2(dy2 == min(dy2(1000:5000)));        
        %figure; plot(xfine,y2,'r'); hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        %figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));     
    end
end
img_plot2(right_edge2,Cmap.Defect1,'right_edge');
%caxis([2 7]);
%%
%img_plot2(bottom2(50:200,1:150),Cmap.Defect1,'gap minimum: inter 2');

%bottom_filt = gauss_filter_image(bottom2(51:200,1:150)-left_edge2(51:200,1:150),20,20);
bottom_filt = gauss_filter_image(right_edge2,15,15);
FT_bottom = fourier_transform2d(bottom_filt - mean(mean(bottom_filt)),'sine','','');
img_plot2(FT_bottom,Cmap.Defect1,['right edge - pt1 = ' num2str(pt1) ' pt2 = ' num2str(pt2)])
caxis([20 180]);

%%
img_plot2(symmetrize_image(linear2D_image_correct([1.95 -2.09],[-2.02 -1.98],FT_bottom,FT_T.r),'d','v'),Cmap.Defect1,['right edge - pt1 = ' num2str(pt1) ' pt2 = ' num2str(pt2)]);
caxis([20 200])
%%
res = 0.01;
xtmp = G_data.e*1000;
%xfine = x;
xx = 69; yy = 41;
pt1 = bottom_index(xx,yy) +3;
pt2 =  pt1 + 11;

%pt1 = 44;
%pt2 = 75;
        ytmp =  squeeze(squeeze(G_data.map(xx,yy,:))); ytmp = ytmp';  
        figure; plot(xtmp(pt1:pt2),ytmp(pt1:pt2));
        [p,S]= polyfit(xtmp(pt1:pt2),ytmp(pt1:pt2),7);                
        xfine = xtmp(pt1):res:xtmp(pt2);
        y2 = polyval(p,xfine);  
        hold on; plot(xfine,y2,'r');
        [dy2 x2] = num_der2b(2,y2,xfine);   
        %figure; plot(x2,dy2)
        pp = findpeaks_3(x2,max(dy2) - dy2,0.00001,1,1,7)
            %pp = pp(min(peak1(peak1(:,3) == max(peak1(:,3)),1)),:);
        %x0 = x2(dy2 == min(dy2));
        x0 = pp(1,2);
%         if x0 == x2(end) 
%             pp = findpeaks_3(x2(5:end),max(dy2(5:end)) - dy2(5:end),0.0001,1,1,7)
%         elseif x0 == x2(1)
%             pp = findpeaks_3(x2(3:end),max(dy2(3:end)) - dy2(3:end),0.0001,1,1,7);
%         end
        x0 = pp(1,2);
        r_edge = x0(1);
        
        figure; plot(xtmp,ytmp)
         hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));
%%
[r3 c3 ] = find(right_edge > 3 );
%% find right edge v2
G_data = G;
[nr nc nz] = size(G_data.map);
%nr = 100; nc = 100;
xtmp = G_data.e*1000;
res = 0.01;
%xfine = x(pt1):res:x(pt2);
%xfine = x;
right_edge2 = right_edge;
mean_index = floor(mean(mean(bottom_index)));
l_r3 = length(r3);
for i = 1:l_r3
 i
        pt1 = min(bottom_index(r3(i),c3(i)),nz); 
        if pt1 == 0
            pt1 = mean_index;
        end
        
        pt1 = min(pt1+3,nz); % good set
        pt2 =  min(pt1 + 15,nz);
        %pt2 = 80;
        
       % pt1 = min(pt1-6,nz);
        %pt2 =  min(pt1 + 35,nz);
        %pt1 = 50;
        %pt2 = 75;
        ytmp =  squeeze(squeeze(G_data.map(r3(i),c3(i),:))); ytmp = ytmp'; 
        for k = 0:10  
        [p,S]= polyfit(xtmp(pt1:pt2-k),ytmp(pt1:pt2-k),7);                
        xfine = xtmp(pt1):res:xtmp(pt2-k);     
        y2 = polyval(p,xfine);        
        [dy2 x2] = num_der2b(2,y2,xfine);    
            x2_t = x2; dy2_t = dy2;
            %x2_t = x2(1+k:end); dy2_t = dy2(1+k:end);
            pp = findpeaks_3(x2_t,max(dy2_t) - dy2_t,0.0001,1,1,7);        
            x0 = pp(1,2);
            if x0 ~= x2_t(end) && x0~=x2_t(1)  
                if k~=0
                    
                end
                break;
            end
        end
        %if pp(1,1) ~=0
            x0= pp(1,2);
            right_edge2(r3(i),c3(i)) = x0;          
        %end
        %x0 = x2(dy2 == min(dy2(1000:5000)));        
        %figure; plot(xfine,y2,'r'); hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        %figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));     
end
img_plot2(right_edge2,Cmap.Defect1,'right_edge2');
%caxis([2 7]);
%%

        %%
res = 0.01;
xtmp = G_data.e*1000;
%xfine = x;
xx = 126; yy = 67;
pt1 = bottom_index(xx,yy) +3;
pt2 =  pt1 + 11;

%pt1 = 44;
%pt2 = 75;

        ytmp =  squeeze(squeeze(G_data.map(xx,yy,:))); ytmp = ytmp';  
        for i = 0:5
        figure; plot(xtmp(pt1:pt2-i),ytmp(pt1:pt2-i));
        [p,S]= polyfit(xtmp(pt1:pt2-i),ytmp(pt1:pt2-i),5);                
        xfine = xtmp(pt1):res:xtmp(pt2-i);
        y2 = polyval(p,xfine);  
        hold on; plot(xfine,y2,'r');
        [dy2 x2] = num_der2b(2,y2,xfine);   
        %figure; plot(x2,dy2)
        %for i = 0:10
            i
            x2_t = x2; dy2_t = dy2;
            %x2_t = x2(1+i:end); dy2_t = dy2(1+i:end);
            pp = findpeaks_3(x2_t,max(dy2_t) - dy2_t,0.0001,1,1,3);        
            x0 = pp(1,2);
        if x0 ~= x2_t(end) && x0~=x2_t(1)            
            break;
        end
        end
        x0 = pp(1,2);
        r_edge = x0(1)
        
        figure; plot(xtmp,ytmp)
         hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));