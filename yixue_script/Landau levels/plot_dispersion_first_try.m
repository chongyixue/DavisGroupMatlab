% YXC 2019-2-25
% BST linear dispersion, LL

x = [-sqrt(1),0,sqrt(1),sqrt(2),sqrt(3),sqrt(4)];
y = [100,142.5,182.5,202.5,220,232.5];

p = polyfit(x,y,1);
gradient = p(1);
xx = [-1.5,2.3];
yy = p(2)+xx.*p(1);
ED = p(2);

figure,plot(x,y,'r.','MarkerSize',10)
hold on
plot(xx,yy,'b')
title(['Fit: E_n = ',num2str(gradient) ,' sqrt(n)     E_D = ',num2str(ED), ' mV'])
xlabel('sqrt(n)')
ylabel('E_n')