function T = fttestlattice(s,a,phi)

T = zeros(s,s,1);
x1 = a;
x2 = round(a * cos(phi*pi/180));
y2 = round(a * sin(phi*pi/180));

li = floor(s/2);
for b= -li:li
    for c= -li:li
            x3 = round(s/2)+1 + b * x1 + c * x2;
            y3 = round(s/2)+1 + c * y2;
            if x3 <=s && y3 <=s && x3 >0 && y3 >0
%                 T(y3, x3) = 1;
                [X,Y]=meshgrid(1:1:s,1:1:s);
                xdata(:,:,1)=X;
                xdata(:,:,2)=Y;
                x = [1, y3, a/5, x3, a/5, 0, 0];
                F = twodgauss(x,xdata);
                T = T+F;
            end
    end
end
figure, imagesc(T)
axis image;

end