function new_map=polyn_subtract_no_struct(map,r,order)
[nr nc nz] = size(map);
w = ones(nr,nc);
new_map = zeros(nr,nc,nz);
for i = 1:nz
    p(i,:) = polyfitweighted2(r,r,map(:,:,i),order,w);
    new_map(:,:,i) = map(:,:,i) - polyval2(p(i,:),r,r);
end

end