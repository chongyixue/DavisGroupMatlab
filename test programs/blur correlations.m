n = 100;
data1 = DeltaNR;
data2 = OmegaNR;
corr_val = zeros(1,n);
for i = 1:n
    
    for j= 1:1
        corr_val(i)= ncorr2(blur(data1,70,i),blur(data2,70,i));
    end
end
figure; plot(corr_val)

clear i n data1 data2
%%
corr_val = zeros(1,99);
for i=1:99
    corr_val(i) = ncorr2(nem_img_GNR_escale_065,DeltaNR);
end
figure; plot(GNR_escale_gnorm.e*1000,corr_val);
clear i corr_val
%%
map = G_disp_mod.map;
for i=1:69
    tmp = map(:,:,i);
    tmp(A) = 0;
    map(:,:,i) = tmp;
end
clear i  tmp