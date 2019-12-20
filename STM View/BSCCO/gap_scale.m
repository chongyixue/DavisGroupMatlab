function new_data = gap_scale(data,gap_map)
[nr nc nz] = size(data.map);
x = data.e*1000;
% determine the best number of intervals to assign from OV to the gap
% energy based on the average number of intervals over the whole map
zero_ind = find(data.e == 0);
sum_ind = 0;
count = 0;
for i = 1:nr
    for j = 1:nc
        if gap_map(i,j) ~= 0
            count = count + 1;
            gap_val = find_gap_val(gap_map(i,j),x);
            gap_index = find(x == gap_val);
            %gap_index = find(x == gap_map(i,j));
            sum_ind = sum_ind + abs(zero_ind - gap_index);
        end
    end    
end
n = round(sum_ind/count) - 1;


if x(1) > x(end)
    sign = -1;
elseif x(1) < x(end)
    sign = 1;
else
    display('Data Insufficient for Scaling');
    return;
end

%find largest length of new interpolated spectra - this comes from the
%minimum gap width
gap_min = min(min(abs(gap_map(gap_map ~=0))))
gap_min = find_gap_val(gap_min,x)
e_space = abs(gap_min)/n;
e1 = round(x(1)/e_space)*e_space; e2 = round(x(end)/e_space)*e_space;            
x_rescale = e1:(sign*e_space):e2; x_rescale = x_rescale/gap_min/1000;
nz_max = length(x_rescale);
zero_ind = find(x_rescale == 0);

new_map = zeros(nr,nc,nz_max);

for i = 1:nr
    i
    for j= 1:nc
        %gap_val = gap_map(i,j)
        gap_val = find_gap_val(gap_map(i,j),x);
        if gap_val ~= 0
            Y = squeeze(squeeze(data.map(i,j,:)));
            % real energy spacing set by the gap size but in normlized energy,
            % all spacings are equal;
            e_space = abs(gap_val)/n;
            e1 = round(x(1)/e_space)*e_space; e2 = round(x(end)/e_space)*e_space;            
            xi = e1:(sign*e_space):e2;
            yi = interp1(x,Y,xi);
            %align the midle of new_map in the z-direciton with the middle
            %of the newly interpolated spectrum
            st_pt = zero_ind - round(length(yi)/2) + 1;
            end_pt = zero_ind + round(length(yi)/2) - 1;
            new_map(i,j,st_pt:end_pt) = yi;                
        end
    end
end
new_data = data;
new_data.e = x_rescale;
new_data.map = new_map;
new_data.ave = squeeze(mean(mean(new_data.map)));
new_data.ops{end+1} = 'Rescale by local gap value - e scaling';
new_data.var = [new_data.var '_e scale'];
img_obj_viewer2(new_data)
end
% if the gap map has values which are not coincident with the actual
% energies in the map to be rescaled, then choose the closest value then is
% present
function gap_val_in_map = find_gap_val(gap,map_energy)
if gap == 0
    gap_val_in_map = 0;
    return;
end
tmp_ind = find(map_energy == gap);
if ~isempty(tmp_ind)
    gap_val_in_map = map_energy(tmp_ind);
    return;
else   
    %display('here');
    subt = gap - map_energy;
    tmp_ind = find(abs(subt) == min(abs(subt)));
    tmp = map_energy(tmp_ind);
    % in case more than one energy is closest, pick the smaller gap value
    if tmp_ind > 1
        tmp = min(abs(map_energy(tmp_ind)));
    end
    gap_val_in_map = tmp;
end
end
    
        
    
