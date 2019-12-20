function cm=circlematrix(imageSize,r,x,y)

ci = [x, y, r];     % center and radius of circle ([c_row, c_col, r])
[xx,yy] = ndgrid((1:imageSize(1))-ci(1),(1:imageSize(2))-ci(2));
cm = uint8((xx.^2 + yy.^2)<=ci(3)^2);


end