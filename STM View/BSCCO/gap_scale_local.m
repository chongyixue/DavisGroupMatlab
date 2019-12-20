function local_scaled_spectra = gap_scale_local(data,Cu_gap_map,Cu_index,Ox_index1,Ox_index2,Oy_index1,Oy_index2,avg_option)

x = data.e*1000;

%symmetric +ve and -ve bias spectrum with zero at the center
zero_ind = find(x == 0);

% if isempty(zero_ind)        
%         zero_ind = find(abs(x) == min(abs(x)),1);
% end
% len_abv_zero = length(zero_ind:length(x)) -1;
% len_bel_zero = length(1:zero_ind);
sum_ind = 0;
% number of usuable Cu sites (has value which indicates all surrounding
% oxygen have good spectra
Cu_good_count = 0;
% gap average over the Cu sites
Cu_gap_avg = 0;
% determine the best number of intervals to assign from OV to the gap
% energy based on the average number of intervals over the whole map

for i=1:length(Cu_index)
    Cu_gap = Cu_gap_map(Cu_index(i,1),Cu_index(i,2));
     if Cu_gap ~=0
    %if Cu_gap_map(Cu_index(i,1),Cu_index(i,2)) ~= 0
        Cu_good_count = Cu_good_count + 1;
        %find value in the energy that is closest to the gap value
        gap_val = find_gap_val(Cu_gap,x);
        %gap_val = find_gap_val(Cu_gap_map(Cu_index(i,1),Cu_index(i,2)),x);        
        gap_index = find(x == gap_val);
        sum_ind = sum_ind + abs(zero_ind - gap_index);
        Cu_gap_avg = Cu_gap_avg + Cu_gap;
        
    end        
end
% number of intervals to use between 0 and 1
Cu_gap_avg = Cu_gap_avg/Cu_good_count;

n = round(sum_ind/Cu_good_count) - 1;

% determine which way the data is energy ordered
if x(1) > x(end)
    sgn = -1;
elseif x(1) < x(end)
    sgn = 1;
else
    display('Data Insufficient for Scaling');
    return;
end

%find largest length of new interpolated spectra - this comes from the
% spectrum of minimum gap width
gap_min = min(min(abs(Cu_gap_map(Cu_gap_map ~=0))))*sign(Cu_gap_avg);
gap_min = find_gap_vals(gap_min,x);
e_space = abs(gap_min)/n;
e1 = round(x(1)/e_space)*e_space; e2 = round(x(end)/e_space)*e_space;            
x_rescale = e1:(sgn*e_space):e2; x_rescale = x_rescale/abs(gap_min)/1000;
nz_max = length(x_rescale);
% new zero index based on the longest length spectrum
zero_ind = find(x_rescale == 0);
% if isempty(zero_ind)
%        zero_ind = find(abs(x_rescale) == min(abs(x_rescale)),1);
% end
% zero_ind
% length(x_rescale)
% x_rescale
% new data set has count-rows, which corresponds to the number of usuable
% Cu sites, 4-columns for the Ox1 Ox2,Oy1,Oy2, spectra, and nz_max-deep to
% hold each spectrum of max length nz_max
local_scaled_spectra.spct = zeros(Cu_good_count,4,nz_max);
local_scaled_spectra.e = x_rescale;

count = 0;
px = avg_option;
for i = 1:length(Cu_index)    
    %gap_val =  find_gap_val(Cu_gap_map(Cu_index(i,1),Cu_index(i,2)),x);
    gap_val =  Cu_gap_map(Cu_index(i,1),Cu_index(i,2));
    if gap_val ~= 0        
        count = count + 1;
        e_space = abs(gap_val)/n;
        e1 = round(x(1)/e_space)*e_space; e2 = round(x(end)/e_space)*e_space;            
        xi = e1:(sgn*e_space):e2;
        
        % find all associated oxygen spectra to the Cu site in the data map
        if px == 0            
            Y_Ox1 = squeeze(squeeze(data.map(Ox_index1(i,1),Ox_index1(i,2),:)));
            Y_Ox2 = squeeze(squeeze(data.map(Ox_index2(i,1),Ox_index2(i,2),:)));
            Y_Oy1 = squeeze(squeeze(data.map(Oy_index1(i,1),Oy_index1(i,2),:)));
            Y_Oy2 = squeeze(squeeze(data.map(Oy_index2(i,1),Oy_index2(i,2),:)));  
        else
            Y_Ox1 = squeeze(mean(mean(data.map(Ox_index1(i,1)-px:Ox_index1(i,1)+px,Ox_index1(i,2)-px:Ox_index1(i,2)+px,:))));
            Y_Ox2 = squeeze(mean(mean(data.map(Ox_index2(i,1)-px:Ox_index2(i,1)+px,Ox_index2(i,2)-px:Ox_index2(i,2)+px,:))));
            Y_Oy1 = squeeze(mean(mean(data.map(Oy_index1(i,1)-px:Oy_index1(i,1)+px,Oy_index1(i,2)-px:Oy_index1(i,2)+px,:))));
            Y_Oy2 = squeeze(mean(mean(data.map(Oy_index2(i,1)-px:Oy_index2(i,1)+px,Oy_index2(i,2)-px:Oy_index2(i,2)+px,:))));      
        end
        % real energy spacing set by the gap size but in normalized energy,
        % all spacings are equal;        
        y_Ox1 = interp1(x,Y_Ox1,xi);
        y_Ox2 = interp1(x,Y_Ox2,xi);
        y_Oy1 = interp1(x,Y_Oy1,xi);
        y_Oy2 = interp1(x,Y_Oy2,xi);      
        %align the middle of local_scaled_spectra in the z-direciton with 
        %the middle of the newly interpolated spectra
        
        st_pt = zero_ind - round(length(y_Ox1)/2) + 1;
        end_pt = zero_ind + round(length(y_Ox1)/2) - 1;

        local_scaled_spectra.spct(count,1,st_pt:end_pt) = y_Ox1;                
        local_scaled_spectra.spct(count,2,st_pt:end_pt) = y_Ox2;
        local_scaled_spectra.spct(count,3,st_pt:end_pt) = y_Oy1;
        local_scaled_spectra.spct(count,4,st_pt:end_pt) = y_Oy2;
    end
end
% count
% k = 650;
% figure; plot(x_rescale,squeeze(squeeze(local_scaled_spectra(k,1,:))));
% hold on;
%  plot(x_rescale,squeeze(squeeze(local_scaled_spectra(k,2,:))),'r');
% hold on;
% plot(x_rescale,squeeze(squeeze(local_scaled_spectra(k,3,:))),'g');
% hold on;
% plot(x_rescale,squeeze(squeeze(local_scaled_spectra(k,4,:))),'m');
% figure; plot(x_rescale,(squeeze(squeeze(local_scaled_spectra(k,3,:) + local_scaled_spectra(k,4,:))/2)),'r')
% hold on; plot(x_rescale,(squeeze(squeeze(local_scaled_spectra(k,1,:) + local_scaled_spectra(k,2,:))/2)),'b')
end


function gap_val_in_map = find_gap_vals(gap,map_energy)
if gap == 0
    gap_val_in_map = 0;
    return;
end
tmp_ind = find(map_energy == gap);
if ~isempty(tmp_ind)
    gap_val_in_map = map_energy(tmp_ind);
    return;
else
    subt = (gap - map_energy)*sign(gap);
    gap_val_in_map = sign(gap)*max(sign(gap)*(map_energy(subt >  0)));    
end
end
    
