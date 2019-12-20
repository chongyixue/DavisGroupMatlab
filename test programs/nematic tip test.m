%% inequivalent x-dir and y-dir amplitude
x = -1:0.01:1;
y = -1:0.01:1;
[X Y] = meshgrid(x,y);
%%
kx = 40; ky = 40;
z = abs(sin(kx*X)) + 1.5*abs(sin(ky*Y));
img_plot2(z); normxcorr(z,z);
%%
ft_z = fourier_tr2d(z,'none','sine','');
figure; mesh(ft_z); figure(gcf); shading flat;