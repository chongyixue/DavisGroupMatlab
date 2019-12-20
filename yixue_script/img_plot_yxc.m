function img_plot_yxc(image,varargin)
in_len = length(varargin);
load_color

if in_len == 1 && ~isempty(varargin{1})
    color = varargin{1};
    title = '';
elseif in_len == 2 && ~isempty(varargin{1}) && ~isempty(varargin{2})
    color = varargin{1};
    title = varargin{2};
elseif isempty(varargin)
 %   color = Cmap.Defect0;
    color_map_path = 'C:\Users\YiXue\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
    color = struct2cell(load([color_map_path 'Blue1.mat']));
    color = color{1};
%     color = terrain(256);
    
    title = '';
end
    
imagesc(image); shading flat; axis image; colormap(color);
% freezeColors;

end