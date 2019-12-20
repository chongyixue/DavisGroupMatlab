function correlation = ncorr2(x_img,y_img)
x = x_img - mean(mean(x_img));
y = y_img - mean(mean(y_img));

correlation = corr2(x,y);
end

