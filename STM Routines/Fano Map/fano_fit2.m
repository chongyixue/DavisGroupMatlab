function [param, gof] = fano_fit2(x,y,ftoptn)
fano_line = 'a*((x - e)/g + q)^2/(1 + ((x - e)/g)^2) + b*x + c';

if isnan(y)
    p.a = nan; p.b = nan; p.c = nan; p.e = nan; p.g = nan; p.q = nan;
    param = p;
    g.sse = nan; g.rsquare = nan; g.dfe = nan; g.adjrsquare = nan; g.rmse = nan;
    gof = g;
    return;
end

% s = fitoptions('Method','NonlinearLeastSquares',...
%     'Startpoint',init_guess,...
%     'Algorithm','Levenberg-Marquardt',...
%     'TolX',1e-5,...
%     'MaxIter',2000,...
%     'MaxFunEvals', 5000);

f = fittype(fano_line,'options',ftoptn);
[p,gof] = fit(x,y,f);
param = p;

% x2 = min(x):0.01:max(x);
% y2 = p.a*((x2 - p.e)/p.g + p.q).^2./(1 + ((x2 - p.e)/p.g).^2) + p.b*x2 + p.c;
% figure;
% plot(x2,y2)
% hold on; plot(x,y,'rx');
end
