function [y1 x1] = num_der2b(pwr,y0,varargin)
%check that there is an input for the independent variable, if not make one
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
    [ytmp xtmp] = num_der2b(pwr-1,y0,x0);
end
n = length(ytmp);
%every derivative power reduces the size of the input vector by 2 since the
%derivative at the endpoint is not well defined.
y1 = zeros(1,n-2);
for j = 2:(n-1)
    y1(j-1) = (ytmp(j+1) - ytmp(j-1))/(xtmp(j+1) - xtmp(j-1));
end
x1 = xtmp(2:end-1);
return;
end
