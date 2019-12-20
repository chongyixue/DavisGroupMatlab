%%
[r c] = find(topo6 < -0.05);
img_plot2(topo6); hold on; plot(c,r,'r.');
%%
A = topo6 < -0.05;
B = gap_blur.map(A);
%%
img_plot(topo6);
n = size(S_th,1);
for i =1:n
    hold on; plot(S_th(i,1),S_th(i,2),'rx');
end
%%
spect = 0;
for i = 1:n
    spect = spect + squeeze(squeeze(G_crop.map(S_th(i,2),S_th(i,1),:)));
end
spect = spect/n;
figure; plot(G_crop.e*1000,spect);
%%
img_plot2(blur(gap_crop,2,2),Cmap.Sailing);caxis([4.5 10]); hold on; plot(c,r,'r.');
%%
img_plot2(topo3)
%%
A = topo3 < -0.025;
mean(mean(gap_crop(A)))
%%
n = 240;
trials = 5000;
count2 = zeros(trials,1);
for j = 1:trials
count = 0;
B = randi(150,n,2);
for i = 1:n
    count = count + gap_crop(B(i,1),B(i,2));
end
count2(j) = count/n;
end
histogram(count2,60)
std(count2)
mean(count2)
%%
th_gap = gap_crop(A);
histogram(th_gap,30)
