%%
f2 = fftshift(fft2(poly_detrend(t2,1,1,0)));
f3 = fftshift(fft2(poly_detrend(t3,1,1,0)));
%%
z1 = Gaussian(1:127,1:256,9,[63 128],1);
z2 = Gaussian(1:127,1:256,8,[63 128],1);
f2_filt = z1.*f2 - z2.*f2;
f3_filt = z1.*f3 - z2.*f3;
y2_filt = (ifft2(ifftshift(f2_filt)));
figure; pcolor(real(y2_filt)); colormap(bone); shading interp

y3_filt =(ifft2(ifftshift(f3_filt)));
figure; pcolor(real(y3_filt)); colormap(bone); shading interp
%%
ncc2 = normxcorr(real(y2_filt),real(y3_filt));

%%
figure; pcolor(t3_comp(54:end,17:end)); shading interp; colormap(bone);
figure; pcolor(t2_comp(1:end-53,1:end-16)); shading interp; colormap(bone);
%%
figure; pcolor(t3(54:end,17:end)); shading interp; colormap(bone);
figure; pcolor(t2(1:end-53,1:end-16)); shading interp; colormap(bone);
%%
fz = fftshift(fft2(poly_detrend(z,1,1,0)));
figure; pcolor(abs(fz)); shading flat; colormap(Defect1); axis equal; 
%%
filt = Gaussian(1:200,1:200,50,[100 100],1);
fz_filt = filt.*fz;
figure; pcolor(abs(fz_filt)); shading flat; colormap(Defect1); axis equal;
%%
z_filt = ifft2(ifftshift(fz_filt));
figure; pcolor(abs(z_filt)); shading flat; colormap(Blue2); axis equal;