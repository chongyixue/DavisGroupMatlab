function [y_new, p,gof]=lorentzian3(y,range,varargin)
% range is [left right]
% x = range(1):range(2); x = x';
x = range;
%init_guess = [a_g -1 1 d_g ];
%exp_bkgn = 'a*exp(b*x^c) + d';
%init_guess = [700 x0 5 140];

if nargin>2
    guess = varargin{1};
    low = varargin{2};
    upp = varargin{3};
    
    s = fitoptions('Method','NonlinearLeastSquares',...
        'Startpoint',[guess],...
        'Algorithm','trust-region',...
        'TolX',1e-6,...
        'MaxIter',100000,...
        'MaxFunEvals', 100000,...
        'Lower',low,...
        'Upper',upp);
else
    % changed algorithm to trust-region instead of levenberg-marquardt, because
    % Matlab created ouput saying that lower and upper bounds were only
    % accepted / only work with for the trust-region algorithm
    s = fitoptions('Method','NonlinearLeastSquares',...
        'Algorithm','trust-region',...
        'TolX',1e-6,...
        'MaxIter',100000,...
        'MaxFunEvals', 100000)
    
end

exp_lrntz = 'a*x + b*(d/2)^2/((x-c)^2+(d/2)^2)+e + f*(x-g)^2';
% low=guess*0.5;
% upp=guess*1.5;
% % introduce variable upper and lower bounds
% low = [guess(1:2)*0.8 guess(3:4)*0.5 1 guess(6)*0.5];
% upp = [guess(1:2)*1.2 guess(3:4)*1.5 8 guess(6)*1.5];




% s = fitoptions('Method','NonlinearLeastSquares',...
%     'Startpoint',[guess],...
%     'Algorithm','trust-region',...
%     'TolX',1e-6,...
%     'MaxIter',100000,...
%     'MaxFunEvals', 100000,...
%     'Lower',low,...
%     'Upper',upp);
   
   
f = fittype(exp_lrntz,'options',s);
[p,gof] = fit(x,y,f);
%p
% gg = coeffvalues(p);
% for i=1:length(x)
%     peak1(i)=gg(1)*x(i)+gg(2)*(gg(4)/2)^2/((x(i)-gg(3))^2+(gg(4)/2)^2);
% end
y_new = feval(p,x);
% figure, plot(x,y,'.k',x,y_new,'-r',x,peak1,'-b','linewidth',2);
% pause(0.5);
end