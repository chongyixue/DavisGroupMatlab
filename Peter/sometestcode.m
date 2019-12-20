


[X,Y]=meshgrid(1:1:100,1:1:100);
            xdata(:,:,1)=X;
            xdata(:,:,2)=Y;
            
% [xx,yy] = ndgrid((1:100),(1:100));
% xdata(:,:,1) = xx;
% xdata(:,:,2) = yy;
x = [10, 8, 24];
F = twodbump(x,xdata);
figure, imagesc(F)