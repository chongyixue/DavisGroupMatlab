function [real_prft_data1, imag_prft_data1, real_prft_data2, imag_prft_data2] = simulate_charge_prft_analysis(data1, data2)

[nx, ny, nz] = size(data1.map);


x = linspace(0,pi,nx);
y = linspace(0,pi,ny);
z = sin(x)'*sin(y);

for k=1:nz
    filtmap1(:,:,k) = data1.map(:,:,k).*z';
    filtmap1(:,:,k) = ifftshift( filtmap1(:,:,k) );
    
    filtmap2(:,:,k) = data2.map(:,:,k).*z';
    filtmap2(:,:,k) = ifftshift( filtmap2(:,:,k) );
end

%% calculate the Fourier Transform of the cropped, shifted, and windowed data

for k = 1 : nz
    fftc_map1(:,:,k) = fourier_transform2d_vb(filtmap1(:,:,k),'none','complex','ft');
    
    fftc_map2(:,:,k) = fourier_transform2d_vb(filtmap2(:,:,k),'none','complex','ft');
end


q = r_to_k_coord(data1.r);

% prft = phase resolved fourier transform

real_prft_data1 = data1;
imag_prft_data1 = data1;

real_prft_data2 = data2;
imag_prft_data2 = data2;

real_prft_data1.map = real(fftc_map1);
real_prft_data1.r = q;
imag_prft_data1.map = imag(fftc_map1);
imag_prft_data1.r = q;


real_prft_data2.map = real(fftc_map2);
real_prft_data2.r = q;
imag_prft_data2.map = imag(fftc_map2);
imag_prft_data2.r = q;


end