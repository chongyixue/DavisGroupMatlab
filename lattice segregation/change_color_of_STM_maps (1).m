function change_color_of_STM_maps(hrestopo,invstring)


% possible colors
% Mac
% color_map_path = '/Users/petersprau/Documents/MATLAB/STM/MATLAB/STM View/Color Maps/';
% Windows
% color_map_path = 'C:\Users\Oliver\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
% color_map_path = 'C:\Users\Peter\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map_path = 'C:\Users\pspra\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';


[nx, ny, nz] = size(hrestopo);
%%
% generate a histogram for difmap.  Will be used for setting
% color axis limit.  
n = 1000;
tmp_layer = reshape(hrestopo,nx*ny,1);
tmp_std = std(tmp_layer);
% pick a common number of bins based on the largest spread of values in
% one of the layers
n1 = abs((max(tmp_layer) - min(tmp_layer)))/(2*tmp_std)*1000;
n = max(n,floor(n1));    

clear tmp_layer n1 tmp_std;

[histo.freq(1,1:n), histo.val(1,1:n)] = hist(reshape(hrestopo(:,:,1),nx*ny,1),n);

histo.size = [nx ny 1];

%get the initial color map
color_map = struct2cell(load([color_map_path 'Blue1.mat']));
% color_map = color_map{1};
%initialize color limit values for each layer in caxis
caxis_val = zeros(1,2);

caxis_val(1,1) = min(histo.val(1,:)); % min value for each layer
if isnan(caxis_val(1,1))
    caxis_val(1,1) = 0;
end
caxis_val(1,2) = max(histo.val(1,:)); % max value for each layer
if isnan(caxis_val(1,2))
    caxis_val(1,2) = 0;
end

%Create the plot
fh = img_plot3(hrestopo);
ah = gca;

% imagesc((difmap(:,:,1)));
% colormap(color_map); axis off; axis equal; shading flat;
caxis([caxis_val(1,1) caxis_val(1,2)])

%update the UserData in the figure object to store caxis information
set(fh,'UserData',caxis_val);
%%
palette_sel_dialogue(fh,color_map);  

data_histogram_dialogue(1,histo,fh,ah);



%%
keyboard

if strcmp(invstring,'invert')
    c_map = get(fh,'Colormap');
    inv_cmap = c_map(end:-1:1,:);
    set(fh,'Colormap',inv_cmap);
end

end