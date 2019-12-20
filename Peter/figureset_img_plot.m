function figureset_img_plot(image,varargin)


color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
% color_map = struct2cell(load([color_map_path 'Jet.mat']));
% color_map = struct2cell(load([color_map_path 'LogGrayWhite.mat']));
color_map = struct2cell(load([color_map_path 'Blue2.mat']));
color_map = color_map{1};

figure('Position',[150 150 350 350], 'NumberTitle','off');    
imagesc(image); shading flat; axis off; colormap(color_map);
set(gca,'Position', [0 0 1 1]);
axis equal;
% ax2 = gca;
% ax2.FontSize = 20;
% ax2.TickLength = [0.0 0.0];
% ax2.XTick = 'none';
% ax2.YTick = 'none';
% freezeColors;

end