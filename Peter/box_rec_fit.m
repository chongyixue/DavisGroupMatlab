function [y_new, p, gof]=box_rec_fit(y,range,guess,e)
% range is [left right]
x = range; x = x';
%init_guess = [a_g -1 1 d_g ];
%exp_bkgn = 'a*exp(b*x^c) + d';
%init_guess = [700 x0 5 140];
exp_decay = 'a ./ (1 + exp( -b * (x - c))) + d ./ (1 + exp( -f * (x - g)))';
low = [-inf, 0, min(x), -inf, 0, min(x)];
upp = [inf, inf, max(x), inf, inf, max(x)];

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[guess],...
    'Algorithm','Trust-Region',...
    'TolX',1e-6,...
    'MaxIter',10000,...
    'MaxFunEvals', 10000,...
    'Lower',low,...
    'Upper',upp);

f = fittype(exp_decay,'options',s);
[p,gof,output] = fit(x,y,f);
%p
y_new = feval(p,x);
figure, plot(x,y,'.k',x,y_new,'-r');
title([num2str(e) 'mV ' 'single peak']);
pause(0.5);
% close all
end