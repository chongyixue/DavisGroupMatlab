%%%%%%%
% CODE DESCRIPTION: Calculation of the 2D normalized cross correlation of
% two equally sized maps
%   
% INPUT: The function accepts two matrices representing the data sets
% OUTPUT:
%
% CODE HISTORY
% 080618 MHH Created

function corr_data = normxcorr1d(data1,data2)
f1 = fft(data1-mean(data1));
f2 = fft(data2-mean(data2));

unnorm = fftshift(ifft((((f2.*conj(f1))))));
norm = real(ifft(f1.*conj(f1))).*real(ifft(f2.*conj(f2)));

corr_data = unnorm/sqrt(norm(1,1));
 img_plot2(corr_data,'gray'); colormap(gray); 
% [x y] = find (corr_data == max(max(corr_data)))
% hold on;
% plot(y,x,'bo');
% hold on; plot(64.5,45,'rx');
% x
% y
end