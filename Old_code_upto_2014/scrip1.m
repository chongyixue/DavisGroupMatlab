figure;
c = colormap(jet(150));
for i=21:-1:11
    plot(cut1(84:128,i) + i*10,...
            'Color',[c(i*5,1) c(i*5,2) c(i*5,3)],...
            'LineWidth',2);
    hold on
end