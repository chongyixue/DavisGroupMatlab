%% rescale spectra by gap scale
x = G.e*1000;
Y = squeeze(squeeze(G.map(35,30,:)));
figure; plot(x,Y)
%%
pos_gap = Gap_Map_Pos.map(35,30);
x0 = x/pos_gap;
figure; plot(x0,Y);
%%
ind0 = find(G.e*1000 == 0);
ind1 = find(G.e*1000 == pos_gap);

ind_space = abs(ind0 - ind1) - 1;
n = 18;
e_space = pos_gap/n;
el1 = round(x(1)/e_space)*e_space; el2 = round(x(end)/e_space)*e_space;
xi = el1:-e_space:el2;
%x1 = 0:e_space:G.e(1)*1000;
%x2 = -e_space:-e_space:G.e(end)*1000;
%xi = [x1(end:-1:1) x2];
%%
yi = interp1(x,Y,xi);
figure; plot(xi,yi,'bx'); hold on;
plot(x,Y,'r');
%% find average number of intervals from 0V to gap value.  
z_ind = find(G.e == 0);
map = G.map;
gap_map = Gap_Map_Neg.map;
sum_ind = 0;
count = 0;
for i = 1:200
    i
    for j = 1:200
        if gap_map(i,j) ~= 0
            count = count + 1;
            gap_index = find(G.e*1000 == gap_map(i,j));
            sum_ind = sum_ind + abs(z_ind - gap_index);
        end
    end    
end
sum_ind/count
%%
% layers to gap
n = 19;
map = G.map;
gap_map = Gap_Map_Neg.map;
x = G.e*1000;
[nr nc nz] = size(map);

indo = find(x == 0);
if x(1) > x(end)
    sign = -1;
elseif x(1) < x(end)
    sign = 1;
else
    display('Do Nothing');
end

%find largest length of new interpolated spectra - this comes from the
%minimum gap width
gap_min = min(min(abs(gap_map(gap_map ~=0))));
e_space = abs(gap_min)/n;
el1 = round(x(1)/e_space)*e_space; el2 = round(x(end)/e_space)*e_space;            
x_use = el1:(sign*e_space):el2; x_use = x_use/gap_min/1000;
%nz_max = (el1 - el2)/e_space + 1;
nz_max = length(x_use);
zero_ind = find(x_use == 0);

new_map = zeros(nr,nc,nz_max);

%l_x = 1;
%x_use = x;
for i = 1:nr
    i
    for j= 1:nc
        gap_val = gap_map(i,j);
        if gap_val ~= 0
            Y = squeeze(squeeze(map(i,j,:)));
            % real energy spacing set by the gap size but in normlized energy,
            % all spacings are equal;
            e_space = abs(gap_val)/n;
            el1 = round(x(1)/e_space)*e_space; el2 = round(x(end)/e_space)*e_space;            
            xi = el1:(sign*e_space):el2;
%             if length(xi) > l_x                
%                 x_use = xi/gap_val/1000;
%                 zero_ind = find(xi == 0);
%                 l_x = length(xi);
%             end
            yi = interp1(x,Y,xi);
            %figure; plot(xi,yi)
            st_pt = zero_ind - round(length(yi)/2) + 1;
            end_pt = zero_ind + round(length(yi)/2) - 1;
            new_map(i,j,st_pt:end_pt) = yi;                
        end
    end
end
%% need to find where the NaN are

for k = 1:nz_max
   nan_sum(k) = sum(sum(isnan(new_map(:,:,k)))) ;
end
figure; plot(x_use,nan_sum);
    
%%
 n= 19;
gap_min = min(min(abs(gap_map(gap_map ~=0))));
e_space = abs(gap_min)/n;
            el1 = round(x(1)/e_space)*e_space; el2 = round(x(end)/e_space)*e_space;            
            xi = el1:(sign*e_space):el2;
length(xi)
(el1 - el2)/e_space + 1
%%
gnew = G;
gnew.e = x_use;
gnew.map = new_map;
gnew.ave = squeeze(mean(mean(gnew.map)));
img_obj_viewer2(gnew)