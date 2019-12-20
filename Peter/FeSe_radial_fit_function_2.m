function [y_new, p,gof, ci]=FeSe_radial_fit_function_2(y,range,guess,low,upp)
% range is [left right]
% x = range(1):range(2); x = x';
x = range; 
exp_gaussian = 'a + b*(x-c) + h * exp( - ((x-k)^2 ) / (2*l^2) )';
% low=guess*0.5;
% upp=guess*1.5;
% % introduce variable upper and lower bounds
% low = [guess(1:2)*0.8 guess(3:4)*0.5 1 guess(6)*0.5];
% upp = [guess(1:2)*1.2 guess(3:4)*1.5 8 guess(6)*1.5];

% changed algorithm to trust-region instead of levenberg-marquardt, because
% Matlab created ouput saying that lower and upper bounds were only
% accepted / only work with for the trust-region algorithm
s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[guess],...
    'Algorithm','trust-region',...
    'TolX',1e-6,...
    'MaxIter',100000,...
    'MaxFunEvals', 100000,...
    'Lower',low,...
    'Upper',upp);

f = fittype(exp_gaussian,'options',s);
[p,gof] = fit(x,y,f);
%p
gg = coeffvalues(p);
ci = confint(p,0.99);
% for i=1:length(x)
%     peak1(i)=gg(5)*(gg(6)/2)^2/((x(i)-gg(7))^2+(gg(6)/2)^2);
% end
% for i=1:length(x)
%     peak1(i)=gg(4)*(gg(5)/2)^2/((x(i)-gg(6))^2+(gg(5)/2)^2);
% end

y_new = feval(p,x);
figure, plot(x,y,'.k',x,y_new,'-b','linewidth',2);
legend('data','fit');
% figure, plot(x,peak1,'-b','linewidth',2);
% pause(0.5);
end