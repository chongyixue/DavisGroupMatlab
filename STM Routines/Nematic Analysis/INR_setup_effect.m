%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION: Using the locations of Cu atoms and the associated Ox
% and Oy atoms, the parameter INR is calculated.  This quantity describes the
% imbalance of charge (current at each bias) in between the x and y 
% direction for each copper atom.  The number px_avg defined number of pixels 
% around each Ox and Oy site to be averaged. px_avg = 0 means no averaging.
% Patch size defines the number of pixels around each Cu atoms to assign
% the value of INR(i).
%
% ALGORITHM: INR(i) = (abs(I(Ox(i))) - abs(I(Oy(i))))/sqrt((I(Ox(i)))^2 +
% (I(Oy(i)))^2)
%
% CODE HISTORY
%
% 100914 MHH Created

function new_map = INR_setup_effect(Cu_index,Ox_index, Oy_index,I_map,px_avg,patch_size)
[nr nc nz] = size(I_map.map);
new_map = I_map;
new_map.map = zeros(nr,nc,nz);
if px_avg > 1
    px_avg = 1;
end

p = patch_size;
for i = 1:size(Cu_index,1)
    p = patch_size;
    if (Oy_index(i,1) ~= 0 && Oy_index(i,2) ~= 0 && Ox_index(i,1) ~= 0 && Ox_index(i,2) ~= 0)
        for n = 1:nz
            Ix = mean(mean(I_map.map(Ox_index(i,1)-px_avg:Ox_index(i,1)+px_avg,...
                Ox_index(i,2)-px_avg:Ox_index(i,2)+px_avg,n))); 
            Iy = mean(mean(I_map.map(Oy_index(i,1)-px_avg:Oy_index(i,1)+px_avg,...
                Oy_index(i,2)-px_avg:Oy_index(i,2)+px_avg,n)));                        
        
            normalization = sqrt(Ix^2 + Iy^2);
            while (Cu_index(i,1) <= p  || Cu_index(i,2) <= p || Cu_index(i,1) > nr-p || Cu_index(i,2) > nr-p)
                p = p-1;
            end
            new_map.map(Cu_index(i,1)-p:Cu_index(i,1)+p,Cu_index(i,2)-p:Cu_index(i,2)+p,n) =...
                (abs(Ix) - abs(Iy))/normalization;
        end    
%             new_map(Cu_index(i,1),Cu_index(i,2),n) =...
%                 (abs(I_map.map(Ox_index(i,1),Ox_index(i,2),n)) - abs(I_map.map(Oy_index(i,1),Oy_index(i,2),n)))/...
%                 sqrt((I_map.map(Ox_index(i,1),Ox_index(i,2),n))^2 + (I_map.map(Oy_index(i,1),Oy_index(i,2),n))^2);
    end        
end
end

