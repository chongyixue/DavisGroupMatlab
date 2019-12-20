function new_img = crop_img(img,x1,x2,y1,y2)
[nr nc nz] = size(img);
new_img = zeros(abs(x1-x2)+1,abs(y1-y2)+1,nz);
%size(new_img)
for k = 1:nz
    new_img(:,:,k) = img(x1:x2,y1:y2,k);
end
end