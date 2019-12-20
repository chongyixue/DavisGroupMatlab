function new_data = zero_lyr_mean_sub(data,layer)
new_data = data;
mean_val = mean(mean(new_data.map(:,:,layer)));
new_data.map = new_data.map - mean_val;
new_data.ave = new_data.ave - mean_val;
end