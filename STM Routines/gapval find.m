%%
[x y] = find(T.map < -0.025);
figure; pcolor(T.map); shading flat; colormap(cmap.Blue2)
hold on; plot(y,x,'rx')
%%
mean = 0;
for i = 1:length(y)
        mean = mean + egap_1(x(i),y(i));
end
mean = mean/length(y)
%%
mean_spect = 0;
for i = 1:length(y)
        mean_spect = mean_spect + squeeze(squeeze(G.map(x(i),y(i),:)));
end
mean_spect = mean_spect/length(y);
figure; plot(G.e, mean_spect);
%%
figure; 
for i = 1:length(y)
    plot(G.e, squeeze(squeeze(G.map(x(i),y(i),:))));
    hold on;
    ginput
end