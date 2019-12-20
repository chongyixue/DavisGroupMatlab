function mask = Gaussianmask(data, x1, y1, x2, y2, x3, y3, x4, y4, r)


N = length(data.r);

dc = floor(N/2)+1;

% x3 = 2*x1 - dc;
% y3 = 2*dc - y1;
% x4 = 2*dc - x2;
% y4 = 2*dc - y2;

[nx, ny, nz] = size(data.map);
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





end