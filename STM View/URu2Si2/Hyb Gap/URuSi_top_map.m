function [top top_index] = URuSi_top_map(data,ind1,ind2,varargin)
[nr nc nz] = size(data.map);

top = zeros(nr,nc);
top_index = zeros(nr,nc);
xtmp = data.e*1000;
for i = 1:nr
    i
    for j= 1:nc;
        ytmp = squeeze(squeeze(data.map(i,j,:)));         
        top(i,j) = URuSi_top_ind(xtmp,ytmp,ind1,ind2,varargin{1});
          top_index(i,j) = find(top(i,j) == xtmp);
    end
end
img_plot2(top);

end