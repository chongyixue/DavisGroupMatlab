function [param gof] = fano_fit3(x,y, varargin)
fano_line = 'a*((x - e)/g + q)^2/(1 + ((x - e)/g)^2) + b*x^2 + c*x + d';
if size(varargin,2) < 1
    s = fitoptions('Method','NonlinearLeastSquares',...
        'Startpoint',[0.95 0.0 -0.012 1.4 4.3 15 1.2],...
        'Algorithm','Levenberg-Marquardt',...
        'TolX',1e-4,...
        'MaxIter',5000,...
        'MaxFunEvals', 5000);
else
    s = varargin{:};
end

f = fittype(fano_line,'options',s);
[p,gof] = fit(x,y,f);
param = p;

% x2 = min(x):0.01:max(x);
% y2 = p.a*((x2 - p.e)/p.g + p.q).^2./(1 + ((x2 - p.e)/p.g).^2) + p.b*x2.^2 + p.c*x2 + p.d;
% figure;
% plot(x2,y2)
% hold on; plot(x,y,'rx');


%figure; plot(p);

%coeffvalues(p)
%confint(p)
% coeffnames
%predint
%  hold on; plot(x,y,'bx');
end
