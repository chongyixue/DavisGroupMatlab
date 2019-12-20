[X,Y] = meshgrid(-2000:16:2000, -2000:16:2000);  
Z = zeros(length(X),length(Y));
Ztemp  = zeros(length(X),length(Y));
k = 0.04;
a = 50;
b = 50;
x0 = 0;
y0 = 0;
s = 1/2000;
%s = 0;
%for x0 = -a:a:a
%    for y0 = -b:b:b
        r = sqrt((k*(X)+x0).^2 + (k*(Y)+y0).^2);
        Ztemp = (bessel(0,sqrt((k*(X)).^2 + (k*(Y)).^2)));
        %ztemp(i,j) = exp(-(r^2)*s);        
        Z = Z + (abs((Ztemp)));
 %   end
%end

    figure; surf(Z); shading flat;