function pcolor2(data,clmap)
figure;pcolor(data);  set(gca,'Position',[0 0 1 1]);
shading flat; colormap(clmap); axis off; axis equal;
end