function gmap =FeTeSe_gapmap_v3(data, offset, antigap)



map = data.map;
[nx,ny,nz] = size(map);

wn = 25;
hms = round(nx/wn);
cc = 1;

for i=1:hms
    for j=1:hms
        if i*wn <= nx && j*wn <= ny
            map1 = map((i-1)*wn+1:i*wn,(j-1)*wn+1:j*wn,:);
        elseif i*wn <=nx && j*wn > ny
            map1 = map((i-1)*wn+1:i*wn,(j-1)*wn+1:ny,:);
        elseif i*wn > nx && j*wn <= ny
            map1 = map((i-1)*wn+1:nx,(j-1)*wn+1:j*wn,:);
        else
            map1 = map((i-1)*wn+1:nx,(j-1)*wn+1:ny,:);
        end
        data.map = map1;
        datacell{cc} = data;
        cc = cc+1;
    end
end

parfor i=1:cc-1
    gmap1 =FeTeSe_gapmap_v2(datacell{i}, offset, antigap);
    mapcell{i} = gmap1;
end

cc = 1;
for i=1:hms
    for j=1:hms
        if i*wn <= nx && j*wn <= ny
            gmap((i-1)*wn+1:i*wn,(j-1)*wn+1:j*wn,:) = mapcell{cc};
        elseif i*wn <=nx && j*wn > ny
            gmap((i-1)*wn+1:i*wn,(j-1)*wn+1:ny,:) = mapcell{cc};
        elseif i*wn > nx && j*wn <= ny
            gmap((i-1)*wn+1:nx,(j-1)*wn+1:j*wn,:) = mapcell{cc};
        else
            gmap((i-1)*wn+1:nx,(j-1)*wn+1:ny,:) = mapcell{cc};
        end
        cc = cc+1;
    end
end

%% how to extract statistics
% tmp_layer = reshape(gmap(:,:,3),nx*ny,1);
% tmp_std = std(tmp_layer);
%%


end