% make number of pixel even for image processing purpose(symmetrizing)
% 18/9/2017
% Yi Xue Chong

function data = make_pixel_even(data)
s = length(data);
if mod(s,2)==1
    data = pix_dim(data,length(data)+1);
end
end