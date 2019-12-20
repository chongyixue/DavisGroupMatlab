function y = img_corr(layered_img,img)
[nr nc nz] = size(layered_img);
y = zeros(nz,1);
for i = 1:nz
    y(i) = corr2(layered_img(:,:,i),img);
end
curve_plot(1:nz,y,'b');
