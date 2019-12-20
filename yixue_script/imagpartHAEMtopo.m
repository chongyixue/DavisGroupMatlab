


function imagn = imagpartHAEMtopo(cx,cy,topo)
comment = 'random';
[prft_data] = singleimpurityshiftcenter(topo, topo, [cx, cy], 50);
% [realft_data, imagft_data] = singleimpurityIMGmap(prft_data);

imagn = imag(prft_data.map);
data  = 0;
for i = 40:61
    for j = 40:61
        data = data + imagn(i,j);
    end
end




imagn = data;

%disp(imag)
end


