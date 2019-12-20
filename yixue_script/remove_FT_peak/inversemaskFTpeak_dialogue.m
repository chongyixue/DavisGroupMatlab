% do drawing thing to select area for removal
% do drawing thing to select area to replicate (for noise)

function map = inversemaskFTpeak_dialogue(data,layer,color_lim,c_map)

data =select_FT_region(data,layer,color_lim,c_map,1);
data = fourier_transform2d(data,'none','real','ift');
map = data;
map.ave = average_spectrum_map(map);

end