%% 
img_plot2(obj_90216A20_T.map);
%%
n = 18;
pix = 256;
g1 = Gaussian_v2(1:pix,1:pix,n,n,0,[144,77],1);
g2 = Gaussian_v2(1:pix,1:pix,n,n,0,[77,113],1);
g3 = Gaussian_v2(1:pix,1:pix,n,n,0,[114,181],1);
g4 = Gaussian_v2(1:pix,1:pix,n,n,0,[181,145],1);
img_plot2(g1+g2+g3+g4);
filter = g1+g2+g3+g4;
%%
filter  = Gaussian_v2(1:256,1:256,40,40,0,[128.5,128.5],1);
filter = 1;
%%
F = fourier_transform2d(topo,'none','complex','ft');
F_filt = F.*filter;
img_plot2(abs(F_filt));
caxis([0,5]);
%%
new_topo = fourier_transform2d(F_filt,'none','complex','ift');
img_plot2(real(pix_dim(new_topo,800)))
