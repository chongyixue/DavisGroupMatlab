function [y_new, p]=fit_to_lorentzian(y,range,guess)
% range is [left right]
x = range(1):range(2); x = x';
%init_guess = [a_g -1 1 d_g ];
%exp_bkgn = 'a*exp(b*x^c) + d';
x0 = (range(1)+range(2))/2;
%init_guess = [700 x0 5 140];
lrntz = 'a/((x-b)^2+c^2)+d';


s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[guess],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-6,...
    'MaxIter',10000,...
    'MaxFunEvals', 10000);

f = fittype(lrntz,'options',s);

y1 = y(range(1):range(2));
[p,gof] = fit(x,y1,f);
y_new = feval(p,x);
%p
end
