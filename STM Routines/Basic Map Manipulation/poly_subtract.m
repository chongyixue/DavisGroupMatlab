new_data = G;
[sx sy sz] =size(G.map);

xy=nan(sx*sy,2);
    for j=1:sx
        xy((j-1)*sy+1:j*sy,1)=1:sy;
        xy((j-1)*sy+1:j*sy,2)=j;
    end

zero_layer = reshape(new_data.map(:,:,37),128*128,1);
po=polyfitn(xy,zero_layer,...
     'constant, x, y');%, x*y, x*x, y*y, x*x*x, y*y*y'); %x*x, y*y, x*x*y, x*y*y
for i = 1:81
    temp = reshape(new_data.map(:,:,i),sx*sy,1);
    temp = temp - polyvaln(po,xy);     
    new_data.map(:,:,i) = reshape(temp,sy,sx);        
end