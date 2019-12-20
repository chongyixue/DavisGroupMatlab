function [i j r_edge] = URuSi_pos_edge_map(data,bottom_ind,varargin)
[nr nc nz] = size(data.map);
r_edge = zeros(nr,nc);
r_edge_ind = ones(nr,nc);
x = data.e*1000;
if nargin <=2
    w = 0;
else     
    w = (varargin{1});   
end
w
for i = 1:nr
    i
    for j = 1:nc       
        y = squeeze(squeeze(data.map(i,j,:)));
        r_edge(i,j) = URuSi_pos_edge(x,y,bottom_ind(i,j),w);
    end
end
img_plot2(r_edge);
end