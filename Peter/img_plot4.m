function img_plot4(image,varargin)
in_len = length(varargin);
load_color

if in_len == 1 && ~isempty(varargin{1})
    color = varargin{1};
    title = '';
elseif in_len == 2 && ~isempty(varargin{1}) && ~isempty(varargin{2})
    color = varargin{1};
    title = varargin{2};
elseif isempty(varargin)
    color = Cmap.Defect1;
%     color = terrain(256);
    
    title = '';
end
    
imagesc(image); shading flat; axis image; colormap(color);
% freezeColors;

end