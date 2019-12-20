%% find the gap minimum
%b1 = 19; b2= 36; %09227A13
b1 = 35; b2 = 70; %090430A02
xtmp = G.e(b1:b2)*1000;
[nr nc nz] = size(G.map);
bottom = zeros(nr,nc);
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
img_plot2(bottom2,Cmap.Defect1,'gap minimum: inter 2');
clear new_peak ind mean_bottom std_bottom tmp xtmp ytmp n nr nc nz b1 b2 i j r_bot c_bot bottom count
%% gap minimum correlation with conductance map
[nr nc nz] = size(G.map);
gap_min_corr = nan(nz,1);
for k = 1:nz
    gap_min_corr(k) = corr2(bottom2,G.map(:,:,k));
end
figure; plot(G.e*1000,abs(gap_min_corr));
clear nr nc nz k;

%% find the left gap edge
% by looking to the left of the gap minimum find the first real peak

[nr nc nz] = size(G.map);
xtmp = G.e*1000;
bottom_index = zeros(nr,nc);
for i = 1:nr
    for j = 1:nc
        bottom_index(i,j) = find(bottom2(i,j) == xtmp);
    end
end
clear xtmpi j
st_pt = 1;
left_edge = nan(nr,nc);
energy = G.e*1000;
%n1 = 150; n2 = 256;
for i = 1:nr
    i
    for j = 1:nc
        end_pt = bottom_index(i,j);
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
        left_edge(i,j) = peak_point;
    end
end
img_plot2(left_edge,Cmap.Defect1,'left edge');
clear i j k peak_sort peak_point peaks1 peaks2 peaks3 x y end_pt st_pt energy nr nc nz tol xtmp;
%% check for outlying points
mean_left_edge = mean(mean(left_edge));
std_left_edge = std(reshape(left_edge,200*200,1));
[r c] = find(left_edge <= mean_left_edge - 1*std_left_edge);
%% check out outlying points 
n = 10;
st_pt = 1;
end_pt = bottom_index(r(n),c(n));
x = G.e(st_pt:end_pt)*1000;
y = squeeze(squeeze(G.map(r(n),c(n),st_pt:end_pt)));
figure; plot(G.e*1000,squeeze(squeeze(G.map(r(n),c(n),:))));
left_edge(r(n),c(n))
bottom2(r(n),c(n))
%% try polynomial fits to not well found left edges
n = 500;
res = 0.1;
st_pt = 20;
end_pt = bottom_index(r(n),c(n));
x = G.e(st_pt:end_pt)*1000;

y = squeeze(squeeze(G.map(r(n),c(n),st_pt:end_pt))); y = y';
[p,S]= polyfit(x,y,6);                
        xfine = x(1):res:x(end);
        y2 = polyval(p,xfine); 
        figure; plot(x,y,'x'); hold on; plot(xfine,y2,'r');         
        x0 = xfine(find(y2 == max(y2)));
        hold on; plot([x0 x0], get(gca,'ylim'),'g')
%%
left_edge2 = left_edge;
st_pt = 20;
res = 0.1;

for n = 1:length(r);
    n        
    end_pt = bottom_index(r(n),c(n));  
    x = G.e(st_pt:end_pt)*1000;
    y = squeeze(squeeze(G.map(r(n),c(n),st_pt:end_pt))); y = y';
    [p,S]= polyfit(x,y,6);                
    xfine = x(1):res:x(end);
    y2 = polyval(p,xfine); 
    [h ind] = findpeaks(y2);
    %x0 = xfine(find(y2 == max(y2)));
    if ~isempty(ind)
        x0 = xfine(ind); x0 = x0(end);
    end
    left_edge2(r(n),c(n)) = x0;
end
img_plot2(left_edge2,Cmap.Defect1,'left edge2');
%% check for outlying points
mean_left_edge2 = mean(mean(left_edge2));
std_left_edge2 = std(reshape(left_edge2,200*200,1));
[r2 c2] = find(left_edge2 <= mean_left_edge2 - 3*std_left_edge2);
%% check out outlying points 
n = 5;
st_pt = 20;
end_pt = bottom_index(r2(n),c2(n));
x = G.e(st_pt:end_pt)*1000;
y = squeeze(squeeze(G.map(r2(n),c2(n),st_pt:end_pt)));
figure; plot(G.e*1000,squeeze(squeeze(G.map(r2(n),c2(n),:))));
left_edge2(r2(n),c2(n))
bottom2(r2(n),c2(n))
y = y';
[p,S]= polyfit(x,y,6);                
        xfine = x(1):res:x(end);
        y2 = polyval(p,xfine); 
        figure; plot(x,y,'x'); hold on; plot(xfine,y2,'rx');         
        x0 = xfine(find(y2 == max(y2)));
[h ind] = findpeaks(y2);
        hold on; plot([x0 x0], get(gca,'ylim'),'g')
        hold on; plot([xfine(ind) xfine(ind)], get(gca,'ylim'),'m')
%% check out oulying points
x0 = 220; y0 = 105;
st_pt = 1;
end_pt = bottom_index(x0,y0);
x = G.e(st_pt:end_pt)*1000;
y = squeeze(squeeze(G.map(x0,y0,st_pt:end_pt)));
figure; plot(G.e*1000,squeeze(squeeze(G.map(x0,y0,:))));
left_edge(x0,y0)
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
for i = 1:nr
    i
    for j = 1:nc
        pt1 = bottom_index(i,j); pt2 =  pt1 + 23;
        ytmp =  squeeze(squeeze(G_data.map(i,j,:))); ytmp = ytmp';   
        %y = G_data.ave; y = y';
        %y = squeeze(squeeze(G_data.map(1,200,:))); y = y';
        [p,S]= polyfit(xtmp(pt1:pt2),ytmp(pt1:pt2),6);                
        xfine = xtmp(pt1):res:xtmp(pt2);
        y2 = polyval(p,xfine);        
        [dy2 x2] = num_der2b(2,y2,xfine);                
        
        x0 = x2(dy2 == min(dy2(1000:5000)));
        
        right_edge(i,j) = x0(1);
        %figure; plot(x,y); hold on; plot(xfine,y2,'r'); hold on; plot([x0 x0],get(gca,'ylim'));% xlim([2 8]);
        %figure; plot(x2,dy2,'g'); hold on; plot([x0 x0], get(gca,'ylim'));
        
    end
end
img_plot2(right_edge,Cmap.Defect1,'right edge');
clear i j x0 xtmp nr nc nz p pt1 pt2 res x2 xfine dy2 y2 ytmp S
%% 
gap_map = right_edge - left_edge;
img_plot2(gap_map,Cmap.Defect1,'Gap Map');
%% gap height
[nr nc nz] = size(G.map);
en = G.e*1000;
gap_height = zeros(nr,nc);
for i = 1:nr
    for j = 1:nc
        gap_height(i,j) = G.map(i,j,find(en == left_edge(i,j))) - G.map(i,j,bottom_index(i,j));
    end
end
img_plot2(gap_height,Cmap.Defect1,'Gap  Height');
clear i j en nr nc nz 
%% gap correlation with conductance map
[nr nc nz] = size(G.map);
gap_min_corr = zeros(nz,1);
for k = 1:nz
    gap_min_corr(k) = corr2(gap_height,G.map(:,:,k));
end
figure; plot(G.e*1000,abs(gap_min_corr));
clear nr nc nz k;

%% plot on Bragg peaks for unshear corrected data
Bragg_x = [228 25 30 233]; %09227A13
Bragg_y = [241 231 17 27];
hold on; plot(Bragg_x,Bragg_y,'ro','MarkerFaceColor',[1 0 0],...
                'MarkerSize',7); axis equal; 
%% plot on Bragg peaks for shear corrected data that is 4-pixel averaged
Bragg_x = [117 12 13 117]; %09227A13
Bragg_y = [117 117 12 13];
hold on; plot(Bragg_x,Bragg_y,'ro','MarkerFaceColor',[1 0 0],...
                'MarkerSize',7); axis equal; 
%% shear corrected gap map and symmetrized
F_gap_gfilt = fourier_tr2d(gauss_filter2d(gap_map,50,25),'sine','','');
F_gap_gfilt_tr = transform_map5(F_gap_gfilt,F_T.r);
F_gap_gfilt_tr_sym = symmetrize_map5(F_gap_gfilt_tr,'vd');
%img_plot2(pix_avg2(F_gap_gfilt_tr_sym),Cmap.Defect1)
img_plot2(blur(F_gap_gfilt_tr_sym,3,2),Cmap.Defect1)
%% shear corrected left_edge and symmetrized
F_left_edge_gfilt = fourier_tr2d(gauss_filter2d(left_edge,50,25),'sine','','');
F_left_edge_gfilt_tr = transform_map5(F_left_edge_gfilt,F_T.r);
F_left_edge_gfilt_tr_sym = symmetrize_map5(F_left_edge_gfilt_tr,'vd');

%img_plot2((F_left_edge_gfilt_tr_sym),Cmap.Defect1)
img_plot2(pix_avg2(F_left_edge_gfilt_tr_sym),Cmap.Defect1)
%% shear corrected right_edge and symmetrized
F_right_edge_gfilt = fourier_tr2d(gauss_filter2d(right_edge,50,25),'sine','','');
F_right_edge_gfilt_tr = transform_map5(F_right_edge_gfilt,F_T.r);
F_right_edge_gfilt_tr_sym = symmetrize_map5(F_right_edge_gfilt_tr,'vd');

%img_plot2((F_left_edge_gfilt_tr_sym),Cmap.Defect1)
img_plot2(pix_avg2(F_right_edge_gfilt_tr_sym),Cmap.Defect1)
%% shear corrected bottom2 and symmetrized
F_bottom_gfilt = fourier_tr2d(gauss_filter2d(bottom2,50,25),'sine','','');
F_bottom_gfilt_tr = transform_map5(F_bottom_gfilt,F_T.r);
F_bottom_gfilt_tr_sym = symmetrize_map5(F_bottom_gfilt_tr,'vd');

%img_plot2((F_left_edge_gfilt_tr_sym),Cmap.Defect1)
img_plot2(pix_avg2(F_bottom_gfilt_tr_sym),Cmap.Defect1)
%% shear corrected height and symmetrized
F_height_gfilt = fourier_tr2d(gauss_filter2d(gap_height,50,25),'sine','','');
F_height_gfilt_tr = transform_map5(F_height_gfilt,F_T.r);
F_height_gfilt_tr_sym = symmetrize_map5(F_height_gfilt_tr,'vd');

%img_plot2((F_left_edge_gfilt_tr_sym),Cmap.Defect1)
img_plot2(pix_avg2(F_height_gfilt_tr_sym),Cmap.Defect1)
%%
for i=1:511        
        ac_line_cut(i) = ac_gap(i,i);
end
figure; plot(ac_line_cut)