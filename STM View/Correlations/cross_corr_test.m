%%
figure;

for i = 1:73
    cor_fun(i) = corr2(T_crop_dt,squeeze(G_crop(:,:,i)));
end
plot(energy,cor_fun);

