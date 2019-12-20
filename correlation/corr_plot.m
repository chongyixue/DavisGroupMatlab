function [x y] = corr_plot(data,image)
[nr nc nz] = size(data.map);
x = data.e;
y = zeros(1,nz);
for k = 1:nz
    y(k) = corr2(data.map(:,:,k),image);
end
figure; plot(x,y);