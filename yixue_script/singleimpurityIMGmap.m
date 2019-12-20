function [realft_data, imagft_data] = singleimpurityIMGmap(prft_data)

% prft_data - phase resolved, complex, fourier transform for a single 
% impurity whose origin is at the center in order to give meaning to real
% and imaginary part



% energies of map
ev = prft_data.e;
le = length(ev);

complexft = prft_data.map;



[nx, ny, nz] = size(complexft);




complexft = prft_data.map;


realft = zeros(nx, ny, nz);
imagft = zeros(nx, ny, nz);

for i=1:nz
   realft(:,:,i) = real(complexft(:,:,i));
   imagft(:,:,i) = imag(complexft(:,:,i));
end

realft_data = prft_data;
realft_data.map = realft;

imagft_data = prft_data;
imagft_data.map = imagft;





end