function [y1 x1] = num_der(pwr,y0,varargin)
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
    [ytmp xtmp] = num_der(pwr-1,y0,x0);
end
 y1 = diff(ytmp)./diff(xtmp);
 dx = diff(xtmp);
 x1 = xtmp(1:end-1) + dx/2;
 return;
end
