function [p g] = fit_Gaussian1D(x,y,varargin)
qpi ='a*exp(-(x-b)^2/(2*c^2)) + d*x + e';

if size(varargin,2) < 1
    s = fitoptions('Method','NonlinearLeastSquares',...
        'Startpoint',[-1 -2 1 -0.005 1],...
        'Algorithm','Levenberg-Marquardt',...
        'TolX',1e-4,...
        'MaxIter',5000,...
        'MaxFunEvals', 5000);
else
    s = varargin{:};
end

f = fittype(qpi,'options',s);
[p,g] = fit(x',y,f);
%figure; plot(p); hold on; plot(x,y,'rx');
end

