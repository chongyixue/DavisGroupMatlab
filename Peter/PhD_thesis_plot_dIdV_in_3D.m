color_map_path = 'C:\Users\pspra\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
% color_map = struct2cell(load([color_map_path 'Jet.mat']));
% color_map = struct2cell(load([color_map_path 'LogGrayWhite.mat']));
color_map = struct2cell(load([color_map_path 'Blue2.mat']));
color_map = color_map{1};

%%

% -100 mV
figure('Position',[150 150 350 350], 'NumberTitle','off'); 
surf(obj_60504A00_G_noise_subtracted.map(:,:,1))
shading interp; axis off; colormap(color_map);
set(gca,'Position', [0.0 0.0 1 1]);
view(70,75);

%%
% % average dI/dV
% figure, plot(obj_50820A00_G.e*1000, obj_50820A00_G.ave,'k.-')
% 
% % topograph
% figure('Position',[150 150 350 350], 'NumberTitle','off');    
% imagesc(obj_50820A00_T.map.'); shading flat; axis off; colormap(color_map);
% set(gca,'Position', [0 0 1 1]);
% axis equal;
% 
% 
% % -100 mV
% figure('Position',[150 150 350 350], 'NumberTitle','off'); 
% surf(obj_50820A00_G_noise_subtracted.map(:,:,1))
% shading interp; axis off; colormap(color_map);
% set(gca,'Position', [0.075 0.075 1 1]);
% view(70,75);
% 
% % -75 mV
% figure('Position',[150 150 350 350], 'NumberTitle','off'); 
% surf(obj_50820A00_G_noise_subtracted.map(:,:,6))
% shading interp; axis off; colormap(color_map);
% set(gca,'Position', [0.075 0.075 1 1]);
% view(70,75);
% 
% % -50 mV
% figure('Position',[150 150 350 350], 'NumberTitle','off'); 
% surf(obj_50820A00_G_noise_subtracted.map(:,:,11))
% shading interp; axis off; colormap(color_map);
% set(gca,'Position', [0.075 0.075 1 1]);
% view(70,75);
% 
% % -25 mV
% figure('Position',[150 150 350 350], 'NumberTitle','off'); 
% surf(obj_50820A00_G_noise_subtracted.map(:,:,16))
% shading interp; axis off; colormap(color_map);
% set(gca,'Position', [0.075 0.075 1 1]);
% view(70,75);
