function filtered_map = pink_reduce(map,coord_x,coord_y,alpha,cut_off)

[sy,sx,sz] = size(map);

%make a grid for the filter
[X,Y] = meshgrid(coord_x,coord_x);

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
    filtered_map(:,:,k) = filter(:,:).*map(:,:,k);
end