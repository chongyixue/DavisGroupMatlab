%% BSCCO Gap map
x1 = G.e*1000; x = x1(end:-1:1);

%y1 = G.ave'; y = y1(end:-1:1);
y1 = squeeze(squeeze(G.map(43,12,:)))'; y = y1(end:-1:1);
%% BSCCO Gap map
tic;
[nr nc nz] = size(G.map);
%find the midpoint of spectra (different if there are even or odd number of
%points
if (mod(nz,2) == 0)
    mid_point1 = floor(nz/2);
    mid_point2 = mid_point1 + 1;
else
    mid_point1 = find(G.e == 0) - 1;
    mid_point2 = mid_point1 + 2;
end

% split spectrum in two to find peaks separately
x1 = G.e(1:mid_point1)*1000;
map1 = G.map(:,:,1:mid_point1);
x2 = G.e(mid_point2:end)*1000;
map2 = G.map(:,:,mid_point2:end);
% rearrange spectrum starting from -ve to +ve energies
if G.e(1) > G.e(end)
    x1 = x1(end:-1:1);
    map1 = map1(:,:,end:-1:1);
    x2 = x2(end:-1:1);
    map2 = map2(:,:,end:-1:1);
end
%nr = 50; nc = 50;
gap_map1 = zeros(nr,nc);
gap_map2 = zeros(nr,nc);

for i = 1:nr
    i
    for j = 1:nc                     
        %find +ve edge
        y1 = squeeze(squeeze(map1(i,j,1:mid_point1)))'; 
        peaks1 = findpeaks(x1,y1,0.004,0,3,4);
        gap_map1(i,j) = min(peaks1(:,2));
        %find -ve edge
        y2 = squeeze(squeeze(map2(i,j,1:end)))';        
        peaks2 = findpeaks(x2,y2,0.004,0,3,4);
        
        if peaks2(end,2) > -10
            if size(peaks2,1) > 1
                gap_map2(i,j) = peaks2(end-1,2);
            else                
                gap_map2(i,j) = 0;
            end
        else
            gap_map2(i,j) = max(peaks2(:,2));
        end
    end
end
% option - set bad points to the mode of map
gap_map1(find(gap_map1 == 0)) = mode(mode(gap_map1));
gap_map2(find(gap_map2 == 0)) = mode(mode(gap_map2));

img_plot2(gap_map1,Cmap.Defect1,'BSCCO Gap Map +ve');
img_plot2(gap_map2,Cmap.Defect1,'BSCCO Gap Map -ve');


toc        
clear map1 map2 i j peaks1 peaks2 nr nc nz x1 x2 y1 y2 mid_point1 mid_point2
%%
x1 = G.e*1000; x = x1(end:-1:1);
n = 10;
%y1 = G.ave'; y = y1(end:-1:1);
y1 = squeeze(squeeze(G.map(r(n),c(n),:)))'; y = y1(end:-1:1);
%%
[nr nc nz] = size(G.map);
gap1_index = zeros(nr,nc);
gap2_index = zeros(nr,nc);
energy = G.e*1000;
for i = 1:nr
    i
    for j = 1:nc
        gap1_index(i,j) = find(gap_map1(i,j) == energy);       
        gap2_index(i,j) = find(gap_map2(i,j) == energy);
    end
end
img_plot2(gap1_index,Cmap.Defect1,'BSCCO Gap Map +ve');
img_plot2(gap2_index,Cmap.Defect1,'BSCCO Gap Map -ve');

clear nr nc nz i j energy 
%% map the height of the coherence peaks
[nr nc nz] = size(G.map);
gap1_height = zeros(nr, nc);
gap2_height = zeros(nr, nc);
for i = 1:nr
    i
    for j = 1:nc
        gap1_height(i,j) = G.map(i,j,gap1_index(i,j));
        gap2_height(i,j) = G.map(i,j,gap2_index(i,j));
    end
end
img_plot2(gap1_height,copper,'Height 1');
img_plot2(gap2_height,copper,'Height 2');
%% map the total current up the coherence peaks
% uses simple rectangle rule to do the integration
[nr nc nz] = size(G.map);
if (mod(nz,2) == 0)
    mid_point1 = floor(nz/2);
    mid_point2 = mid_point1 + 1;
else
    mid_point1 = find(G.e == 0) - 1;
    mid_point2 = mid_point1 + 2;
end

current_map1 = zeros(nr, nc);
current_map2 = zeros(nr, nc);
for i = 1:nr
    i
    for j = 1:nc
        current_map1(i,j) = sum(G.map(i,j,gap1_index(i,j):mid_point1));
        current_map2(i,j) = sum(G.map(i,j,mid_point2:gap2_index(i,j)));
    end
end
img_plot2(current_map1,Cmap.Defect1,'Current Map 1');
img_plot2(current_map2,Cmap.Defect1,'Current Map 2');
current_excess = current_map1 - current_map2;
%% map the total charge up the coherence peaks using sim. current map
% uses simple rectangle rule to do the integration
% NOTE:  Need to fix I-map so that 0-bias corresponds to zero current
[nr nc nz] = size(G.map);
if (mod(nz,2) == 0)
    mid_point1 = floor(nz/2);
    mid_point2 = mid_point1 + 1;
else
    mid_point1 = find(G.e == 0) - 1;
    mid_point2 = mid_point1 + 2;
end
dV = abs(I.e(1) - I.e(2))*1000;
charge_map1 = zeros(nr, nc);
charge_map2 = zeros(nr, nc);
for i = 1:nr
    i
    for j = 1:nc
        charge_map1(i,j) = sum(I.map(i,j,gap1_index(i,j):mid_point1))*dV;
        charge_map2(i,j) = -1*sum(I.map(i,j,mid_point2:gap2_index(i,j)))*dV;
    end
end
img_plot2(charge_map1,Cmap.Defect1,'Charge Map 1');
img_plot2(charge_map2,Cmap.Defect1,'Charge Map 2');
clear  i j nr nc nz
%% Find dips just beyond coherence peaks
[nr nc nz] = size(G.map);
%nr = 100; nc = 100;
neg_dip = zeros(nr,nc);
pos_dip = zeros(nr,nc);
x1 = G.e*1000;
for i = 1:nr
    i
    for j = 1:nc
        y1 = squeeze(squeeze(G.map(i,j,:))); y1 = y1';
        % find dip on negative side
        x_neg = x1(gap2_index(i,j) +1 :end); y_neg = y1(gap2_index(i,j)+1:end);
        [p_neg,S_neg] = polyfit(x_neg,y_neg,4);
        f_neg = polyval(p_neg,x_neg,S_neg);
        x = x_neg(end:-1:1); y = f_neg(end:-1:1); y = max(y) - y;
        neg = findpeaks(x,y,0.001,0,1,3); neg_dip(i,j) = neg(end,2);
        % find dip on negative side
        x_pos = x1(1:gap1_index(i,j)); y_pos = y1(1:gap1_index(i,j));
        [p_pos,S_pos] = polyfit(x_pos,y_pos,4);
        f_pos = polyval(p_pos,x_pos,S_pos);
        x = x_pos(end:-1:1); y = f_pos(end:-1:1); y = max(y) - y;
        pos = findpeaks(x,y,0.001,0,1,3); pos_dip(i,j) = pos(1,2);
    end
end
pos_dip (pos_dip == 0) = min(abs(G.e*1000));
neg_test(neg_test == 0) = -1*min(abs(G.e*1000));
img_plot2(neg_dip,Cmap.Defect1,'Negative Dip');
img_plot2(pos_dip,Cmap.Defect1,'Positive Dip');

%%
n = 2;
%r = 26; c=30;
x1 = G.e*1000;
y1 = squeeze(squeeze(G.map(r(n),c(n),:))); y1 = y1';
x_neg = x1(gap2_index(r(n),c(n))+1:end); y_neg = y1(gap2_index(r(n),c(n))+1:end);
figure; plot(x_neg,y_neg,'x');
[p_neg,S_neg] = polyfit(x_neg,y_neg,4);
f_neg = polyval(p_neg,x_neg,S_neg);
hold on; plot(x_neg,f_neg,'r');
neg = (x_neg(f_neg == min(f_neg)));

%[dy_neg dx_neg] = num_der2b(1,f_neg,x_neg);
hold on; plot([neg neg],ylim,'m'); %figure; plot(dx_neg,dy_neg,'k');
x = x_neg(end:-1:1); y = f_neg(end:-1:1); 
y = max(y) - y;
neg2 = findpeaks(x,y,0.001,0,1,3); neg2 = neg2(end,2);
hold on;  hold on; plot([neg2 neg2],ylim,'g'); 
%[y0 x0] = num_der2b(2,f_neg,x_neg);
%hold on; plot([x0(find_zero(y0)) x0(find_zero(y0))],ylim,'k');
%% index maps for pos_dip neg_dip
[nr nc nz] = size(G.map);
neg_dip_index = zeros(nr,nc);
pos_dip_index = zeros(nr,nc);
energy = G.e*1000;
for i = 1:nr
    i
    for j = 1:nc
        pos_val = pos_dip(i,j);
        pos_dip_index(i,j) = find(pos_val == energy);       
        neg_val = neg_dip(i,j);             
        neg_dip_index(i,j) = find(neg_val == energy);
    end
end
%% 
x1 = G.e*1000;
y1 = squeeze(squeeze(G.map(9,77,:))); y1 = y1';
x_pos = x1(1:gap1_index(i,j)); y_pos = y1(1:gap1_index(i,j));

figure; plot(x_pos,y_pos,'x');
[p_pos,S_pos] = polyfit(x_pos,y_pos,4);
f_pos = polyval(p_pos,x_pos,S_pos);
hold on; plot(x_pos,f_pos,'r')
x = x_pos(end:-1:1); y = f_pos(end:-1:1); y = max(y) - y;
pos = findpeaks(x,y,0.001,0,1,3);

%% Find E1* values - inflection points near the humps beyond coherence peaks
[nr nc nz] = size(G.map);
%nr = 100; nc = 100;
E_neg = zeros(nr,nc);
E_pos = zeros(nr,nc);
x1 = G.e*1000;

for i = 1:nr
    i
    for j = 1:nc
        y1 = squeeze(squeeze(G.map(i,j,:))); y1 = y1';
        x_pos = x1(1:gap1_index(i,j)-4); y_pos = y1(1:gap1_index(i,j)-4);        
        if length(y_pos) <= 3
            pos = 0;
        else
            [p_pos,S_pos] = polyfit(x_pos,y_pos,4);
            f_pos = polyval(p_pos,x_pos,S_pos);
            [df_pos dx_pos] = num_der2b(1,f_pos,x_pos);
            x = dx_pos(end:-1:1); y = df_pos(end:-1:1); 
            pos = findpeaks(x,y,0.001,min(y),2,3); pos = pos(end,2);            
        end
        E_pos(i,j) = pos;
    end
end

img_plot2(E_pos,Cmap.Defect1,'E* Positive iter1');
%% E1* second interation to get rid of high valued outliers 
E_pos2 = E_pos;
mean_E_pos = mean(mean(E_pos2));
std_E_pos = std(reshape(E_pos2,length(E_pos2)*length(E_pos2),1));
[r c] = find(E_pos2 >= 90);%(mean_E_pos + 2*std_E_pos) );

for i = 1:length(r)
    i    
    y1 = squeeze(squeeze(G.map(r(i),c(i),:))); y1 = y1';
    x_pos = x1(3:gap1_index(r(i),c(i))-4); y_pos = y1(3:gap1_index(r(i),c(i))-4);        
    if length(y_pos) <= 3
        pos = 0;
    else
        [p_pos,S_pos] = polyfit(x_pos,y_pos,4);
        f_pos = polyval(p_pos,x_pos,S_pos);
        [df_pos dx_pos] = num_der2b(1,f_pos,x_pos);
        x = dx_pos(end:-1:1); y = df_pos(end:-1:1); 
        pos = findpeaks(x,y,0.001,min(y),2,3); pos = pos(1,2);            
    end
    E_pos2(r(i),c(i)) = pos;

end
img_plot2(E_pos2,Cmap.Defect1,'E* Positive iter 2');

%%
mean_E_pos = mean(mean(E_pos2))
std_E_pos = std(reshape(E_pos2,length(E_pos2)*length(E_pos2),1))
[r c] = find(E_pos >= 93);%(mean_E_pos + 2*std_E_pos) );
%% E1* testing
n=1;
r = 228; c = 90;
y1 = squeeze(squeeze(G.map(r(n),c(n),:))); y1 = y1';
x_pos = x1(3:gap1_index(r(n),c(n))-4); y_pos = y1(3:gap1_index(r(n),c(n))-4);  

[p_pos,S_pos] = polyfit(x_pos,y_pos,3);
f_pos = polyval(p_pos,x_pos,S_pos);
[df_pos dx_pos] = num_der2b(1,f_pos,x_pos);
x = dx_pos(end:-1:1); y = df_pos(end:-1:1); 
pos = findpeaks(x,y,0.001,min(y),2,3); pos = pos(1,2);
figure; plot(x_pos,y_pos,'x'); hold on; plot(x_pos,f_pos,'r');
hold on; plot([pos pos], ylim,'g');
figure; plot(dx_pos,df_pos,'b'); hold on; hold on; plot([pos pos], ylim,'g');
%% Find E2* values - inflection points near the humps beyond coherence peaks
[nr nc nz] = size(G.map);
%nr = 100; nc = 100;
E_neg = zeros(nr,nc);
x1 = G.e*1000;

for i = 1:nr
    i
    for j = 1:nc
        y1 = squeeze(squeeze(G.map(i,j,:))); y1 = y1';
        x_neg = x1(gap2_index(i,j)+4:end); y_neg = y1(gap2_index(i,j)+4:end);        
        if length(y_neg) <= 3
            pos = 0;
        else
            [p_neg,S_neg] = polyfit(x_neg,y_neg,4);
            f_neg = polyval(p_neg,x_neg,S_neg);
            [df_neg dx_neg] = num_der2b(1,f_neg,x_neg);
            x = dx_neg(end:-1:1); y = df_neg(end:-1:1); 
            neg = findpeaks(x,y,0.001,min(y),2,3); neg = neg(1,2);            
        end
        E_neg(i,j) = neg;
    end
end

img_plot2(E_neg,Cmap.Defect1,'E* Negative iter1');
%% E2* second interation to get rid of high valued outliers 
E_neg2 = E_neg;
mean_E_neg = mean(mean(E_neg2));
std_E_neg = std(reshape(E_neg2,length(E_neg2)*length(E_neg2),1));
[r c] = find(E_neg2 <= -80);%(mean_E_pos + 2*std_E_pos) );

for i = 1:length(r)
    i    
    y1 = squeeze(squeeze(G.map(r(i),c(i),:))); y1 = y1';
    x_neg = x1(gap1_index(r(i),c(i))+4:end-3); y_neg = y1(gap1_index(r(i),c(i))+4:end-3);        
    if length(y_neg) <= 3
        pos = 0;
    else
        [p_neg,S_neg] = polyfit(x_neg,y_neg,4);
        f_neg = polyval(p_neg,x_neg,S_neg);
        [df_neg dx_neg] = num_der2b(1,f_neg,x_neg);
        x = dx_neg(end:-1:1); y = df_neg(end:-1:1); 
        neg = findpeaks(x,y,0.001,min(y),2,3); neg = neg(1,2);            
    end
    E_neg2(r(i),c(i)) = neg;

end
img_plot2(E_neg2,Cmap.Defect1,'E* Negative iter 2');
%%
Omega1 = abs(E_pos2 - gap_map1);
Omega2 = abs(gap_map2 - E_neg2);
img_plot2(Omega1,Cmap.Defect1,'Omega1');
img_plot2(Omega2,Cmap.Defect1,'Omega2');