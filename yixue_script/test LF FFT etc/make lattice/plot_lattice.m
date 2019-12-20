
test = simulate_pseudo_tetragonal_lattice_kspace(100);
img_obj_viewer_yxc(test)
test = test.map;
figure (1),
imagesc(test)

% FFT = fourier_transform2d(test,'none','amplitude','fft');
% IFFT = fourier_transform2d(test,'none','amplitude','ifft');
FFT = abs(fft2(test));
IFFT = abs(ifft2(test));


figure(2),
imagesc(FFT)
figure(3),
imagesc(IFFT)

FFTFFT = abs(fft2(FFT));
figure(4),
imagesc(FFTFFT)

figure(5),
imagesc(abs(ifft2(FFTFFT)))


test2 = simulate_tetragonal_lattice(100);

img_obj_viewer_yxc(test2)
test2 = test2.map;
figure,
imagesc(test2)
figure,
imagesc(abs(fft2(test2)))
figure,
imagesc(abs(ifft2(test2)))

figure,
imagesc(abs(fft2(abs(ifft2(test2)))))
