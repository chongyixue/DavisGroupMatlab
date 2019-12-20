function new_img = fix_pxls_1(img,threshold)
[nr nc] = size(img);
mean_val = mean(mean(img));
std_val = std(reshape(img,nr*nc,1));
new_img = zeros(nr,nc);
for i = 1:nr
    for j = 1:nc
        new_img(i,j) = img(i,j);
        if abs(img(i,j)- mean_val) > threshold*std_val
            new_img(i,j) = mean_val;
        end
    end
end
end