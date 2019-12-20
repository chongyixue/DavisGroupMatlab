function l_edge =  URuSi_neg_edge_map(data,top_ind,varargin)
[nr nc nz] = size(data.map);
l_edge = zeros(nr,nc);
l_edge_ind = ones(nr,nc);
x = data.e*1000;
if nargin <=2
    w = 0;
else     
    w = (varargin{1});   
end
for i = 1:nr
    i
    for j = 1:nc       
        y = squeeze(squeeze(data.map(i,j,:)));
        l_edge(i,j) = URuSi_neg_edge(x,y,top_ind(i,j),w);
    end
end
img_plot2(l_edge);
end