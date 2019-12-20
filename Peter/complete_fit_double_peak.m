function [y_new, p]=complete_fit_double_peak(y,range,guess,e)
% range is [left right]
x = range(1):range(2); x = x';
%init_guess = [a_g -1 1 d_g ];
%exp_bkgn = 'a*exp(b*x^c) + d';
%init_guess = [700 x0 5 140];

exp_lrntz = 'a*exp(-b*x) + c/((x-d)^2+e^2)+f/((x-g)^2+h^2)+k';
%exp_lrntz = 'a*exp(-b*x)+c';
%exp_lrntz = 'a*exp(-b*x) + c/((x-d)^2+e^2)+f';
low = guess*0.25;
upp = guess*4;
% low = guess*0.5;
% upp = guess*1.5;

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[guess],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-6,...
    'MaxIter',10000,...
    'MaxFunEvals', 10000,...
    'Lower',low,...
    'Upper',upp);

f = fittype(exp_lrntz,'options',s);
[p,gof] = fit(x,y,f);
%p
c = coeffvalues(p);
peak1 = c(4);
peak2 = c(7);
y_new = feval(p,x);
figure(70), plot(x,y,'.k',x,y_new,'-r');
title([num2str(e) 'mV ' 'double peak']);
pause(0.5);
end