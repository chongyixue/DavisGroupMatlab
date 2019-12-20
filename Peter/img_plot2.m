function img_plot2(image,varargin)
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
    title = '';
end
    
figure('Position',[150 150 350 350],'Name',title,'NumberTitle','off');
imagesc(image); shading flat; axis off; colormap(color);
set(gca,'Position', [0 0 1 1]);
axis equal;
end

