function MNQ(map,bragg1,bragg2,filter_sz)
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
end