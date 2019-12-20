function [param, gof] = fano_fit(x,y)
fano_line = 'a*((x - e)/g + q)^2/(1 + ((x - e)/g)^2) + b*x + c';

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[3.421 -0.01773 2.104 1.169 11.08 0.7708],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-5,...
    'MaxIter',5000,...
    'MaxFunEvals', 5000);

f = fittype(fano_line,'options',s);
[p,gof] = fit(x,y,f);
param = p;

x2 = min(x):0.01:max(x);
y2 = p.a*((x2 - p.e)/p.g + p.q).^2./(1 + ((x2 - p.e)/p.g).^2) + p.b*x2 + p.c;
figure;
plot(x2,y2)
hold on; plot(x,y,'rx');
end
