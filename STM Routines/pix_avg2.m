function new_data = pix_avg2(data)

if isstruct(data) % check if data is a full data structure
    [nr,nc,nz]=size(data.map);
    img = data.map;    
else % single data image
    [nr,nc,nz] = size(data);
    img = data;    
end
new_img = zeros(nr/2, nc/2,nz);
for i=1:nr/2
    for j=1:nc/2
        ix = 2*i -1;
        jy = 2*j -1;
        new_img(i,j,:) = (img(ix,jy,:)+ img(ix+1,jy,:) + img(ix,jy+1,:) +...
                        img(ix+1,jy+1,:))/4;
    end
end

if isstruct(data) % check if data is a full data structure
   new_data = data;
    new_data.map = new_img;
    new_data.r = data.r(1:2:end);   
else % single data image   
    new_data = new_img;
end

end