%% BSCCO Gap map
x1 = G.e*1000; x = x1(end:-1:1);

%y1 = G.ave'; y = y1(end:-1:1);
y1 = squeeze(squeeze(G.map(36,64,:)))'; y = y1(end:-1:1);
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
        peaks1 = findpeaks_2(x1,y1,0.004,0,3,4);
        gap_map1(i,j) = min(peaks1(:,2));
        %find -ve edge
        y2 = squeeze(squeeze(map2(i,j,1:end)))';        
        peaks2 = findpeaks_2(x2,y2,0.004,0,3,4);
        
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
