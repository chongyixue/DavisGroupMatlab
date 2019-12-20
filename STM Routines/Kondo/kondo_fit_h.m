function [param, gof] = kondo_fit_h(x,y)
kondo_line = '(a*x.^2 + e0 + l)/2 + (((a*x.^2 + e0 - l).^2 + V^2).^0.5)/2';

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[1 20 1 10],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-6,...
    'MaxIter',3000,...
    'MaxFunEvals', 3000);

f = fittype(kondo_line,'options',s);
[p,gof] = fit(x,y,f);
param = p;
x2 = min(x):0.01:max(x);
y2 = (p.a*x2.^2 + p.e0 + p.l)/2 + (((p.a*x2.^2 + p.e0 - p.l).^2 + p.V^2).^0.5)/2;
figure; plot(x,y,'rx'); hold on


x3 = x2; y3 = p.a*x3.^2 + p.e0;
plot(x2,y2,'b');
hold on; plot(x3,y3,'g')
[dy3 dx3] = num_der2(1,y3,x3);

[dy2 dx2] = num_der2(1,y2,x2);

figure; plot(x3,dy2./dy2);
dy2./dy3