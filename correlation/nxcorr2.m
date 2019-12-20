function corr_img = nxcorr2(x_img,y_img)
[nrx ncx] = size(x_img);
[nry ncy] = size(y_img);

nr = max(nrx,nry); nc = max(ncx,ncy);
x = x_img - mean(mean(x_img));
y = y_img - mean(mean(y_img));

corr_img = xcorr2(x,y);
%crop the image at the size of largest input image
st_r = floor(nr/2) + 1; st_c = floor(nc/2) + 1;
corr_img = corr_img(st_r:st_r + nr,st_c:st_c + nc);
end