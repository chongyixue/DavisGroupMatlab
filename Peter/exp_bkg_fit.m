function [y_new, p, gof]=exp_bkg_fit(y,range,guess,e)
% range is [left right]
x = range; x = x';
%init_guess = [a_g -1 1 d_g ];
%exp_bkgn = 'a*exp(b*x^c) + d';
%init_guess = [700 x0 5 140];
exp_decay = 'a*exp(-(x-c)/b)';
% low = guess*0.00001;
% low(end)=0;
% upp = guess*100000;
low = [0, 0, 0];
upp = [inf, inf, range(end)];

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
figure(70), plot(x,y,'.k',x,y_new,'-r');
title([num2str(e) 'mV ' 'single peak']);
pause(0.5);
% close all
end