function [y1 x1] = num_der2(pwr,y0,varargin)
if size(varargin,2) ==0
    x0 = 1:length(y0);
elseif size(varargin,2) > 1
    fprintf('Too many input paramters')
    return;
else
    x0 = varargin{1};    
end
ytmp = y0; xtmp = x0;

if pwr ~= 1
    [ytmp xtmp] = num_der2(pwr-1,y0,x0);
end
n = length(y0);
y1 = zeros(1,n);
y1(1) = (ytmp(2) - ytmp(1))/(xtmp(2) - xtmp(1));
y1(n) = (ytmp(n) - ytmp(n-1))/(xtmp(n) - xtmp(n-1));
for j = 2:(n-1)
    y1(j) = (ytmp(j+1) - ytmp(j-1))./(xtmp(j+1) - xtmp(j-1));
end
x1 = xtmp;
return;
end
