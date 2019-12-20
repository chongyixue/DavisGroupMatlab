function new_data = pink_reduce2(data,alpha,cut_off)

[sy,sx,sz] = size(data.map);

%make a grid for the filter
[X,Y] = meshgrid(data.r,data.r);

%assign grid values as displacement values i.e. absolute f value from (0,0)
%pink noise is 1/f, so filter should be just f
filter = sqrt(X.^2 + Y.^2);

%find grid points which are above cutoff
[r c v] = find(filter > cut_off);

%apply cutoff condition
for i=1:length(r)
    filter(r(i),c(i)) = 1;
end

for k=1:sz
    new_map(:,:,k) = filter(:,:).*data.map(:,:,k);
end
new_data = data;
new_data.map = new_map;
end