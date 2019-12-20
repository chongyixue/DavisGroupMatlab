function [y_new, p,gof]=FeTeSe_gapmap_fit(y,range,guess,low,upp)
% range is [left right]
x = range; x = x';
y=y';
lrntz = 'a*(b/2)^2/((x-c)^2+(b/2)^2)+d*x+e';
% low = [guess(1:2)*0.5 x(1) guess(4)*0.5];
% upp = [guess(1:2)*1.5 x(end) guess(4)*1.5];

% changed algorithm to trust-region instead of levenberg-marquardt, because
% Matlab created ouput saying that lower and upper bounds were only
% accepted / only work with for the trust-region algorithm
s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[guess],...
    'Algorithm','trust-region',...
    'TolX',1e-6,...
    'MaxIter',10000,...
    'MaxFunEvals', 10000,...
    'Lower',low,...
    'Upper',upp);

f = fittype(lrntz,'options',s);
[p,gof] = fit(x,y,f);

y_new = feval(p,x);
figure, plot(x,y,'.k',x,y_new,'-r','linewidth',2);
pause(3);
end