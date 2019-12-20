function top = URuSi_top_ind(x,y,ind1,ind2,varargin)
if nargin <=4
    ysm = y;
else 
    w = (varargin{1});
    ysm = boxcar_avg(y,w);  
end

if isempty(ysm) 
   top = [];
    return;
end


ysm = ysm(ind1:ind2); xsm = x(ind1:ind2);
tmp = xsm(ysm == max(ysm)); 

top = tmp(1);
%sum(sum(xsm(1:5) == top)
if sum(sum(xsm(1:5) == top)) > 0 || sum(sum(xsm(end-5:end) == top)) > 0
    %display('here');
    [pks loc] = findpeaks(ysm);
    tmp = xsm(loc);
    if ~isempty(tmp) 
        tmp = tmp(end);
        top = tmp;
    end
end

%figure;plot(x,y); hold on; plot(xsm,ysm,'r'); hold on; plot([top top],get(gca,'ylim'));

end