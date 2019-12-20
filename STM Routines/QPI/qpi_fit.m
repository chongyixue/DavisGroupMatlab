function [p gof] = qpi_fit(q,linecut,energy) 

% 1-LORENTZIAN FIT
qpi = 'a*exp(b*x^1 + c) + d*0.5*e/((x-f)^2 + (0.5*e)^2) + z';
%'Startpoint',[300 -15  5 60  0.4 0.2 200],...

% 2-LORENTZIAN FIT with exp background
%qpi = 'a*exp(b*x^1 + c) + d*0.5*e/((x-f)^2 + (0.5*e)^2) + g*0.5*h/((x-k)^2 + (0.5*h)^2)+ z';
% 'Startpoint',[300 -15  5 60  0.1 0.2 50  0.4 0.2 200],...

% 2-LORENTZIAN FIT with lin background
%qpi = 'a*x^1 + d*0.5*e/((x-f)^2 + (0.5*e)^2) + g*0.5*h/((x-k)^2 + (0.5*h)^2)+ z';
%'Startpoint',[-10 60  0.4 0.2 60  0.3 0.2 200],...

% 3-LORENTZIAN FIT with exp background
%qpi = 'a*exp(b*x^1 + c) + d*0.5*e/((x-f)^2 + (0.5*e)^2) + g*0.5*h/((x-k)^2 + (0.5*h)^2)+ l*0.5*m/((x-n)^2 + (0.5*m)^2) + z';
%'Startpoint',[300 -15  5 60  0.1 0.2 50  0.2 0.6 50 0.5 0.2 200],...

% 2-GAUSSIAN FIT
%qpi = 'a*exp(b*x^1 + c) + d*exp(-(x-f)^2/(2*e^2)) + g*exp(-(x-k)^2/(2*h^2)) + z';
%'Startpoint',[300 -0.1  5 60  0.1 -0.8 60  0.3 0.2 -2000],...
lbnd = 8;
hbnd = 0;
lyr = 1;
x = q(lbnd:end-hbnd);
y = linecut(lbnd:end-hbnd,lyr);

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[300 -4  1 7  0.2 0.8 33],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-6,...
    'MaxIter',10000,...
    'MaxFunEvals', 10000);
f = fittype(qpi,'options',s);
[p,gof] = fit(x,y,f);
param = p;

x2 = min(x):0.001:max(x);
% 1-LORENTZIAN with exp background
y2 = p.a.*exp(p.b*x2.^1 + p.c) + p.d.*0.5*p.e./((x2-p.f).^2 + (0.5*p.e).^2) + p.z;

% 2-LORENTIZIAN with exp background
%y2 = p.a.*exp(p.b*x2.^1 + p.c) + p.d.*0.5*p.e./((x2-p.f).^2 + (0.5*p.e).^2)+ p.g.*0.5*p.h./((x2-p.k).^2 + (0.5*p.h).^2) + p.z;

% 2-LORENTZIAN w/ lin background
%y2 = p.a*x2 + p.d.*0.5*p.e./((x2-p.f).^2 + (0.5*p.e).^2)+ p.g.*0.5*p.h./((x2-p.k).^2 + (0.5*p.h).^2) + p.z;

% 2-GAUSSIAN
%y2 = p.a.*exp(p.b*x2.^1 + p.c) + p.d.*exp(-(x2-p.f).^2/(2*p.e.^2)) + p.g.*exp(-(x2-p.k).^2/(2*p.h.^2)) + p.z;

% 3-LORENTZIAN with exp background
%y2 = p.a.*exp(p.b*x2.^1 + p.c) + p.d.*0.5*p.e./((x2-p.f).^2 + (0.5*p.e).^2)+ p.g.*0.5*p.h./((x2-p.k).^2 + (0.5*p.h).^2) +...
%    p.l.*0.5*p.m./((x2-p.n).^2 + (0.5*p.m).^2) + p.z;

figure;
plot(x2,y2)
 xlabel('q (A^{-1})','fontsize',14,'fontweight','b');
 ylabel('PSD','fontsize',14,'fontweight','b');hold on;
plot(x,y,'rx')
hold on;
plot ([p.f p.f], [min(y2) max(y2)]);
%  hold on;
%  plot (p.k,min(y2):1:max(y2));
%  hold on;
%  plot(p.n,min(y2):1:max(y2));

tit = ['E = ' num2str(1000*energy(lyr)) 'meV    lyr=' num2str(lyr) '   ' 'lbnd=' num2str(lbnd) '   ' 'hbnd=' num2str(hbnd)] 
title(tit,'fontsize',14,'fontweight','b');
gof
p

end