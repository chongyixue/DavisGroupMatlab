function [res, res2, res3, apl, pha, ift3] = find_envelopes_gaussian_version(G,x1,y1,x2,y2,r)

% x3 = 133;
% y3 = 315;
% x4 = 315;
% y4 = 305;

% x3 = 134;
% y3 = 315;
% x4 = 314;
% y4 = 305;

% x3 = 112;
% y3 = 235;
% x4 = 234;
% y4 = 229;



fft = fourier_transform2d_vb(G,'none','complex','ft');
num_lrs = length(G.e);
N = length(G.r);


fft1 = fft;
fft2 = fft;
fft3 = fft;
dc = floor(N/2)+1;

x3 = 2*x1 - dc;
y3 = 2*dc - y1;
x4 = 2*dc - x2;
y4 = 2*dc - y2;

[nx, ny, nz] = size(fft.map);
[X,Y]=meshgrid(1:1:nx,1:1:ny,1);
xdata(:,:,1)=X;
xdata(:,:,2)=Y;

x01 = [1; x1; r; y1; r; 0; 0];

mask1=twodgauss(x01,xdata);
% figure, imagesc(mask1)
x02 = [1; x2; r; y2; r; 0; 0];

mask2=twodgauss(x02,xdata);

x03 = [1; x3; r; y3; r; 0; 0];

mask3=twodgauss(x03,xdata);

x04 = [1; x4; r; y4; r; 0; 0];

mask4=twodgauss(x04,xdata);




mask = mask1+mask2+mask3+mask4;
figure, imagesc(mask)

x1dc = x1-dc+1;
y1dc = y1-dc+1;
x2dc = x2-dc+1;
y2dc = y2-dc+1;

for i=1:num_lrs
 fft1.map(:,:,i) = fft1.map(:,:,i).*mask1;
 fft2.map(:,:,i) = fft2.map(:,:,i).*mask2;
 fft3.map(:,:,i) = fft3.map(:,:,i).*mask;
end


ift1 = fourier_transform2d_vb(fft1,'none','amplitude','ift');
ift2 = fourier_transform2d_vb(fft2,'none','amplitude','ift');
ift3 = fourier_transform2d_vb(fft3,'none','real','ift');
ift3.var = 'nematic';
% img_obj_viewer2(ift3);

res = ift1;
res2 = ift1;
res3 = ift1;
apl = ift1;
pha = ift1;

for i=1:num_lrs
 res.map(:,:,i) = (ift1.map(:,:,i)-ift2.map(:,:,i))./(ift1.map(:,:,i)+ift2.map(:,:,i));
 res2.map(:,:,i) = ift1.map(:,:,i);
 res3.map(:,:,i) = ift2.map(:,:,i);
 apl.map(:,:,i) =( (ift1.map(:,:,i)).^2 + (ift2.map(:,:,i)).^2 ).^1/2;
 pha.map(:,:,i) = atan(ift1.map(:,:,i) ./ ift2.map(:,:,i) );
end
res.var = 'order_parameter';
res2.var = 'order_parameter 1st component';
res3.var = 'order_parameter 2nd component';

% img_obj_viewer2(res);
% img_obj_viewer2(res2);
% img_obj_viewer2(res3);
% img_obj_viewer2(apl);
% img_obj_viewer2(pha);

% figure, imagesc(mask1)
% figure, imagesc(mask2)


%[X,Y] = meshgrid(1:N,1:N);

% Nrm1 = exp(-1i*2*pi/N*((x1dc-1)*(X-1)+(y1dc-1)*(Y-1)));
% Nrm2 = exp(-1i*2*pi/N*((x2dc-1)*(X-1)+(y2dc-1)*(Y-1)));
% 
% for i=1:num_lrs
%  ift1.map(:,:,i) = abs(ift1.map(:,:,i).*Nrm1);
%  ift2.map(:,:,i) = abs(ift2.map(:,:,i).*Nrm2);
% end


end