function new_img = broaden_dist(img,factor)
mean_val = mean(mean(img));
factor_img = (mean_val - img)*factor;
mean(mean(factor_img))
new_img = img + factor_img.*img;

end