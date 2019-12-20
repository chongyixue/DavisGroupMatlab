
image = obj_70228A00_G.map(:,:,41);
load_color


color_map_path = 'C:\Users\YiXue\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map = struct2cell(load([color_map_path 'Blue1.mat']));
color_map = color_map{1};

%color = Cmap.Defect1;

figure()
imagesc(image); shading flat; axis image; colormap(color_map);
