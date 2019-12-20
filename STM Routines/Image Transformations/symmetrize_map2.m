%%%%%%%
% CODE DESCRIPTION: Symmetrizes a map along the horizontal and then across
% the diagonal.  This method is used in symmetrizing the fourier transform
% for dI/dV maps.
%   
% INPUT: Standard STM data structure
%
% CODE HISTORY
%
% 080304 MHH Created


function new_data = symmetrize_map2(data)
[sx,sy,sz] = size(data.map);
new_data = data;
new_map = zeros(sx, sy, sz);
%symmetrize along horizontal
% for i=1:sx/2
%     new_map(i,:,:) = (data.map(i,:,:) + data.map(sx + 1 - i,:,:))/2;
%     new_map(sx + 1 -i,:,:) = new_map(i,:,:);
% end
 for j=1:sy/2
     new_map(:,j,:) = (data.map(:,j,:) + data.map(:,sy + 1 - j,:))/2;
     new_map(:,sy + 1 -j,:) = new_map(:,j,:);
 end
%symmetrize along diagonal
for k = 1:sz
  new_map(:,:,k) = (new_map(:,:,k) + new_map(:,:,k)')/2;
end
new_data.map = new_map;
end
