% 2020-5-22 YXC
% plot all available colormaps


X = meshgrid(linspace(1,256,256),1);
% figure(65);imagesc(X);
allmaps = setcolor(65,'Blue1','noplot');
total = size(allmaps,1);

width = 500;
height = 700;

h1 = figure(...
    'Units','characters',...
    'Color',[1 1 1],...
    'Name','all colors',...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[50 10 width height],...
    'Resize','off',...
    'Visible','on');

small = height/total;

for i=1:total
    axesplot = axes(...
            'Parent',h1,...
            'Units','pixels',...
            'Position',[5 small*(i-1) width*0.8 small]);
    imagesc(axesplot,X);
    setcolor(axesplot,allmaps(i).name);
    axis off

    uicontrol(...
        'Style','text',...
        'Parent',h1,...
        'Units','pixels',...
        'Position',[5+width*0.8 small*(i-1) width*0.2-5 small],...
        'String',allmaps(i).name(1:end-4),'BackgroundColor',[0.8 0.8 0.8],...
        'FontSize',10);
end






function total = setcolor(ax,col,varargin)
% color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map_path = fullfile(fileparts(mfilename('fullpath')),'..','..','\STM View\Color Maps\');

total = dir([color_map_path '/*.mat']);
if nargin==2
    color_map = struct2cell(load([color_map_path col]));
    color_map = color_map{1};
    colormap(ax,color_map);
end
end