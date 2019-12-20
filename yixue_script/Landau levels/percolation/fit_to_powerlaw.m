% 2019-4-15 YXC polyfit percolation

% x1 y1 data set is before Ec, x2 y2 after Ec
y1 = circ_binary(2:8)*10000;
y2 = circ_binary(11:18)*10000;
x1 = en(2:8);
x2 = en(11:18);


logy1 = log(y1);
logy2 = log(y2);

Ec = 0.1405;

logx1 = log(Ec-x1);
logx2 = log(x2-Ec);

figure,
plot(logx1,logy1,'k.')
hold on
plot(logx2,logy2,'b.')

p1 = polyfit(logx1,logy1,1);
p2 = polyfit(logx2,logy2,1);

xx1 = linspace(-8,-4.5,2);
yy1 = polyval(p1,xx1);
plot(xx1,yy1,'k')

xx2 = linspace(-8,-4.5,2);
yy2 = polyval(p2,xx2);
plot(xx2,yy2,'b')


enn1 = linspace(0.134,0.14,100);
cond1 = exp(p1(2)).*(abs(enn1-Ec).^p1(1));
figure,plot(en,circ_binary*10000,'b.','MarkerSize',10)
hold on
plot(enn1,cond1,'k')

enn2 = linspace(0.143,0.15,100);
cond2 = exp(p2(2)).*(abs(enn2-Ec).^p2(1));
plot(enn2,cond2,'k')
plot(x1,y1,'k.','MarkerSize',10)
plot(x2,y2,'k.','MarkerSize',10)





