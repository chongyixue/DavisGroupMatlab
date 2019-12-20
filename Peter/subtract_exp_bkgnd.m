function [y_new, diff, p] = subtract_exp_bkgnd(x,y)
t = 1:length(y); t = t';
x=x';
yo= y;
y = y(x);
a_g=(y(3)+y(4))/2;
d_g = (y(end)+y(end-1))/2;
init_guess = [a_g -1 1 d_g ];
exp_bkgn = 'a*exp(b*x^c) + d';
%init_guess = [a_g -1 d_g ];
%exp_bkgn = 'a*exp(b*x) + d';


s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[init_guess],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-6,...
    'MaxIter',10000,...
    'MaxFunEvals', 10000);

f = fittype(exp_bkgn,'options',s);

[p,gof] = fit(x,y,f);
y_new = feval(p,x);
diff = feval(p,t);
diff = yo-diff;
p
end

