%%%%%%%
% CODE DESCRIPTION: Symmetrizes a map along the horizontal and then across
% the diagonal.  This method is used in symmetrizing the fourier transform
% for dI/dV maps.
%   
% CODE HISTORY
%
% 080304 MHH Created


function new_map = symmetrize_map(map)
[sx,sy,sz] = size(map);

%symmetrize along horizontal
% for i=1:sx/2
%     new_map(i,:,:) = (map(i,:,:) + map(sx + 1 - i,:,:))/2;
%     new_map(sx + 1 -i,:,:) = new_map(i,:,:);
% end

for j=1:sy/2
    new_map(:,j,:) = (map(:,j,:) + map(:,sy + 1 - j,:))/2;
    new_map(:,sy + 1 -j,:) = new_map(:,j,:);
end
%symmetrize along diagonal
for k = 1:sz
    new_map(:,:,k) = (new_map(:,:,k) + new_map(:,:,k)')/2;
end
end
