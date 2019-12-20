function T = fttestlattice2(s,x1,y1,phi1,x2,y2,phi2,co)

T = zeros(s,s,1);
x1 = round(x1 * cos(phi1)/co);
y1 = round(y1 * cos(phi2)/co);
x2 = round(x2 * cos(phi1)/co);
y2 = round(y2 * sin(phi2)/co);
a = co;

li = floor(s/2);
for b= -li:li
    for c= -li:li
            x3 = round(s/2)+1 + b * x1 + c * x2;
            y3 = round(s/2)+1 + b * y1 + c * y2;
            if x3 <=s && y3 <=s && x3 >0 && y3 >0
                T(y3, x3) = 1;
%                 [X,Y]=meshgrid(1:1:s,1:1:s);
%                 xdata(:,:,1)=X;
%                 xdata(:,:,2)=Y;
%                 x = [1, y3, a/5, x3, a/5, 0, 0];
%                 F = twodgauss(x,xdata);
%                 T = T+F;
            end
    end
end
figure, imagesc(T)
axis image;

end