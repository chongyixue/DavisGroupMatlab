function img_plot(image,varargin)
load_color
if isempty(varargin)
    color = Cmap.Blue2;
else
    color = varargin{1};
end

figure('Position',[150 150 350 350]);
pcolor(image); shading flat; axis off; colormap(color);
set(gca,'Position', [0 0 1 1]);
axis equal;
end

