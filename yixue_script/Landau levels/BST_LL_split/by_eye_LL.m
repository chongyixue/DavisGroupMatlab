% 2019-4-8  YXC

% 90407a00 point spectra (39,10)

x = [2,3,4,5,6];
y = [198.8,216.3,230,243.8,255];

x = [1,2,3,4];
y = [177.5,200,217.5,227.5];

x = [-2,-1,0,1,2,3,4,5,6,7,8,9]; % 90407a00 avg spec
y = [76.25,100,140,180,202.5,219,233.8,245,256.3,266,273.8,282.5];

xxx = sign(x).*sqrt(abs(x));
% x = [3,4,5,6,7,8,9];
% y = [219,233.8,245,256.3,266,273.8,282.5];

% figure,plot(x,y,'r.','MarkerSize',10)
% hold on
figure,plot(xxx,y,'k.','MarkerSize',10)
hold on

[p,gof] = polyfit(xxx,y,1);
polyval(p,0)

% q = polyfit(xxx,y,5);


xx = linspace(x(1),3,200);
yy = polyval(p,xx);
yyy = polyval(q,xx);
plot(xx,yy,'r')
% hold on
% plot(xx,yyy,'b')



