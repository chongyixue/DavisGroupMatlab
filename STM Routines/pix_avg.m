function new_data = pix_avg(data)
[nr nc nz] = size(data.map);
new_map = zeros(nr/2, nc/2,nz);
for i=1:nr/2
    for j=1:nc/2
        ix = 2*i -1;
        jy = 2*j -1;
        new_map(i,j,:) = (data.map(ix,jy,:)+ data.map(ix+1,jy,:) + data.map(ix,jy+1,:) +...
                        data.map(ix+1,jy+1,:))/4;
    end
end
new_data = data;
new_data.map = new_map;
new_data.r = data.r(1:2:end);
end