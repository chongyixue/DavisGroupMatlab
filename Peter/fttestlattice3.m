function F = fttestlattice3(s,x)

% T = zeros(s,s,1);

ampl = x(1);
wvl = x(2);
cx = x(3);
cy = x(4);

[X,Y]=meshgrid(1:1:s,1:1:s);
xdata(:,:,1)=X;
xdata(:,:,2)=Y;
F = twodsphwave(x,xdata);
F(cx,cy,1) = x(1);
% F(cx,cy,1) = mean(mean(F(cx-1:cx+1,cy-1:cy+1,1)));
% li = floor(s/2);
% for b= -li:li
%     for c= -li:li
%             x3 = round(s/2)+1 + b * x1 + c * x2;
%             y3 = round(s/2)+1 + b * y1 + c * y2;
%             if x3 <=s && y3 <=s && x3 >0 && y3 >0
%                 T(y3, x3) = 1;
%                 [X,Y]=meshgrid(1:1:s,1:1:s);
%                 xdata(:,:,1)=X;
%                 xdata(:,:,2)=Y;
%                 x = [1, y3, a/5, x3, a/5, 0, 0];
%                 F = twodgauss(x,xdata);
%                 T = T+F;
%             end
%     end
% end
figure, imagesc(F)
axis image;

end