function filt_img = fourier_filter_dc(img,filt_width)
[nr nc] = size(img);
ft_img = fourier_transform2d(img,'none','complex','ft');
img_plot2(abs(ft_img));
filt = Gaussian2D(1:nr,1:nc,filt_width,filt_width,0,[nr/2+1 nc/2+1],1);
%img_plot2(filt);

filt_ft = ft_img.*filt;
filt_img = fourier_transform2d(filt_ft,'none','complex','ift');

%img_plot2(abs(filt_img));
end