
%ctmap_test = ctmap(161:end,:);
%data1 = real(ctmap_test) - mean(mean(real(ctmap_test)));
%data2 = abs(gmap_crop) - mean(mean(abs(gmap_crop)));

data1 = real(t27a) - mean(mean(real(t27a)));
data2 = real(t29a) - mean(mean(real(t29a)));
%data1 = gmap_crop - mean(mean(gmap_crop));
%data2 = data1;

f1 = fft2(data1);
f2 = fft2(data2);

unnorm = fftshift(ifft2((((f2.*conj(f1))))));
norm = real(ifft2(f1.*conj(f1))).*real(ifft2(f2.*conj(f2)));

data = unnorm/sqrt(norm(1,1));
figure; pcolor(data); shading interp; colormap(gray)
hold on; plot(200,75,'ro')
%%
data1 = ctmap_crop - mean(mean(ctmap_crop));
data2 = gmap_crop - mean(mean(gmap_crop));

