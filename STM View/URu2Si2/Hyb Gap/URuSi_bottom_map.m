function [bottom bottom_index] = URuSi_bottom_map(data,ind1,ind2,varargin)
[nr nc nz] = size(data.map);

bottom = zeros(nr,nc);
bottom_index = zeros(nr,nc);
xtmp = data.e*1000;
for i = 1:nr
    i
    for j= 1:nc;
        ytmp = squeeze(squeeze(data.map(i,j,:)));         
        bottom(i,j) = URuSi_bottom_ind(xtmp,ytmp,ind1,ind2,varargin{1});
          bottom_index(i,j) = find(bottom(i,j) == xtmp);
    end
end
img_plot2(bottom);

end