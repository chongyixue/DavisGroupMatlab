%%
count = 0;
clear corr_img
for i = 0.0:0.005:0.1;
count = count + 1;
 tol = i;

new_img1 = DeltaNR_tile;
new_img2 = OmegaNR_tile;

new_img1(new_img1 < tol & new_img1 > -tol) = 0;
new_img2(new_img2 < tol & new_img2 > -tol) = 0;
corr_img(count) = ncorr2(new_img1(new_img2~=0),new_img2(new_img2~=0));

end
figure; plot(0.0:0.005:0.1,corr_img);
%%
tol = 0.007;
new_img1 = DeltaNR_tile;
new_img2 = OmegaNR_tile;
new_img1(new_img1 < tol & new_img1 > -tol) = 0;
new_img2(new_img2 < tol & new_img2 > -tol) = 0;

tmp =new_img1;
tmp(new_img2==0) = 0;
new_img2(new_img1==0) = 0;
new_img1 = tmp;
clear tmp tol 
img_plot2(binary_domains(new_img1),Cmap.PurBlaCop,'\Delta_N^R');
caxis([-0.035 0.035]);
 xlim([5 105]); ylim([70 170])
img_plot2(binary_domains(new_img2),Cmap.PurBlaCop(end:-1:1,:),'\Omega_N^R');
caxis([-0.05 0.05]);
 xlim([5 105]); ylim([70 170])
 clear new_img1 new_img2
%%  MNQ(r) analysis

f = fourier_transform2d(omega_map_mod,'none','complex','ft');
f_re = real(f);
f_im = imag(f);
%%
x = Omega_Map_mod.r;
y = x;
[xx yy] = meshgrid(x,y);

Qx = [2.21 -2.21];
Qy = [-2.12 -2.21];
cosx =cos(Qx(1)*xx + Qx(2)*yy);
cosy =cos(Qy(1)*xx + Qy(2)*yy);
%%
%img_plot2(omega_map_mod);
img_plot2(fourier_transform2d(omega_map_mod.*cosx,'none','abs','ft'));
img_plot2(fourier_transform2d(omega_map_mod,'none','abs','ft'));
%%
fx = fourier_transform2d((omega_map_mod-0).*cosx,'none','complex','ft');

fy = fourier_transform2d((omega_map_mod-0).*cosy,'none','complex','ft');

%%
filter = Gaussian(1:200,1:200,3,[100,100],1);
%%
mx = fourier_transform2d(fx.*filter,'none','complex','ift');
my = fourier_transform2d(fy.*filter,'none','complex','ift');