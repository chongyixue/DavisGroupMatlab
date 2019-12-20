% 2019-8-1 YXC

function filtermatrix = filter_matrix(topo,low,high)

filter = (topo.map>low).*(topo.map<high);

%smooth out filter
dat = topo;
dat.map = filter;
dat = polyn_subtract(dat,0);
dat = gauss_blur_image(dat,6,3);
filter = dat.map;

maxx = max(max(filter));
minn = min(min(filter));
filter = (filter-minn)/(maxx-minn);

filtermatrix = filter;

end








