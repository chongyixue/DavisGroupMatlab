function rm=ringmatrix(imageSize,r,x,y,r2)

ci = [x, y, r];     % center and radius of circle ([c_row, c_col, r])
[xx,yy] = ndgrid((1:imageSize(1))-ci(1),(1:imageSize(1))-ci(2));
cm1 = uint8((xx.^2 + yy.^2)<=ci(3)^2);
cm2 = uint8((xx.^2 + yy.^2)<=r2^2);
rm = cm2-cm1;

end