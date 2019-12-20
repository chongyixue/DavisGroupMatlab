%%%%%%%
% CODE DESCRIPTION: The function assigns an average gap value to the Cu
% sites based on the only gap values of the four associated oxygen sites.
% The function uses the full gap map.  If the gap value on any of the
% oxygen sites is zero, that unit cell is skipped.  If the average option
% is chosen, then the average gap value is based not only on the individual 
% oxygen sites but a one unit radius set of pixels centered at each oxygen 
% site.  As such, each pixel in that set must have a non-zero associated
% gap
%   
% CODE HISTORY
% 101018 MHH  Created
% 
% INPUT: 
% OUTPUT:

function Cu_gap_map = Cu_site_gap_map(gap_map,Cu_index,Ox_index1,Ox_index2,Oy_index1,Oy_index2,avg_option)
[nr nc] = size(gap_map);
% set the radius for pixel averaging.
n = avg_option;
chk_sum = (2*n+1)^2;
Cu_gap_map = zeros(nr,nc);
for i=1:length(Cu_index)
    % only consider Cu sites which have all 4 associated oxygen sites
    if (Ox_index1(i,1)~=0 && Ox_index2(i,1) ~=0 && Oy_index1(i,1) ~= 0 && Oy_index2(i,1)~=0)
        % only consider pixels which don't have 0 value - the error code
%         if (gap_map(Ox_index1(i,1),Ox_index1(i,2)) ~=0 &&...
%             gap_map(Ox_index2(i,1),Ox_index2(i,2)) ~=0 &&...
%             gap_map(Oy_index1(i,1),Oy_index1(i,2)) ~=0 &&...
%             gap_map(Oy_index2(i,1),Oy_index2(i,2)) ~=0)
          if (sum(sum(gap_map(Ox_index1(i,1)-n:Ox_index1(i,1)+n,Ox_index1(i,2)-n:Ox_index1(i,2)+n) ~=0)) == chk_sum &&...
              sum(sum(gap_map(Ox_index2(i,1)-n:Ox_index2(i,1)+n,Ox_index2(i,2)-n:Ox_index2(i,2)+n) ~=0)) == chk_sum &&...
              sum(sum(gap_map(Oy_index1(i,1)-n:Oy_index1(i,1)+n,Oy_index1(i,2)-n:Oy_index1(i,2)+n) ~=0)) == chk_sum &&...
              sum(sum(gap_map(Oy_index2(i,1)-n:Oy_index2(i,1)+n,Oy_index2(i,2)-n:Oy_index2(i,2)+n) ~=0)) == chk_sum)
        
             Cu_gap_map(Cu_index(i,1),Cu_index(i,2)) = ...
                (mean(mean(gap_map(Ox_index1(i,1)-n:Ox_index1(i,1)+n,Ox_index1(i,2)-n:Ox_index1(i,2)+n))) + ...
                 mean(mean(gap_map(Ox_index2(i,1)-n:Ox_index2(i,1)+n,Ox_index2(i,2)-n:Ox_index2(i,2)+n))) + ...
                 mean(mean(gap_map(Oy_index1(i,1)-n:Oy_index1(i,1)+n,Oy_index1(i,2)-n:Oy_index1(i,2)+n))) + ...
                 mean(mean(gap_map(Oy_index2(i,1)-n:Oy_index2(i,1)+n,Oy_index2(i,2)-n:Oy_index2(i,2)+n))))/4;
%               Cu_gap_map(Cu_index(i,1),Cu_index(i,2)) = ...                
%                 (gap_map(Ox_index1(i,1),Ox_index1(i,2)) + gap_map(Ox_index2(i,1),Ox_index2(i,2)) + ...
%                 gap_map(Oy_index1(i,1),Oy_index1(i,2)) + gap_map(Oy_index2(i,1),Oy_index2(i,2)))/4;
          end
    end
    
end
load_color;
sgn = sign(sum(sum(Cu_gap_map)));
if sgn>0
    clmap = Cmap.Defect1;
else
    clmap = Cmap.Defect4;
end
img_plot2(Cu_gap_map,clmap,['Copper Gap Map with ' num2str(avg_option) ' pixel averaging']);

end

