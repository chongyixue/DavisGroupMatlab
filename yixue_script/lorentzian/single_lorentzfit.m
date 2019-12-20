% 2019-6-10 YXC
% en: energy array in V
% spec: spectrum
% startmV and endmV picks out peak

function [yfit,p,err] = single_lorentzfit(en,spec,startmV,endmV)
% yfit = a+b*X+ P1./((X - P2).^2 + P3) + p4
% p  = [P1,P2,P3,P4,a,b]

start = find_index(en,startmV);
endd = find_index(en,endmV);
x = en(start:endd);
y = spec(start:endd);

addpoints = 10;
xx = linspace(x(1),x(end),length(x)*addpoints);
yy = spline(x,y,xx);


grad = (yy(end)-yy(1))/(xx(end)-xx(1));
inter = yy(1)-grad*xx(1);

y0 = linspace(yy(1),yy(end),length(yy));
yy = yy-y0;

[yfit,p,~,res] = lorentzfit(xx,yy);
err = rms(res);
p(5) = inter;
p(6) = grad;


end

function index =  find_index(en,mV)
mV = mV/1000;
[~,index] = min(abs(en-mV));
end
