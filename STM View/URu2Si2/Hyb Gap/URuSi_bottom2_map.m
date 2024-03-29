function [bottom bottom_index] = URuSi_bottom2_map(data,ind1,ind2,bt,bt_index,box_width,avg_width)
[nr nc nz] = size(data.map);
a = box_width;
bottom = bt;
bottom_index = bt_index;
xtmp = data.e*1000;
img_plot2(bottom);

for i = 1:nr
    for j = 1:nc
        pt1 = max(1,i-a); pt2 = min(nr,i+a);
        pt3 = max(1,j-a); pt4 = min(nc,j+a);
        box = bottom(pt1:pt2,pt3:pt4);
        std_box = std(reshape(box,size(box,1)*size(box,2),1));
        if abs(mean(mean(box)) - bottom(i,j)) > 3.4*std_box
            hold on; plot(j,i,'rx')
           bottom(i,j) = mode(mode(box));
        end
    end
  
end




% for i = 1:nr
%     for j = 1:nc
%         pt1 = max(1,i-a); pt2 = min(nr,i+a);
%         pt3 = max(1,j-a); pt4 = min(nc,j+a);
%         box = bottom(pt1:pt2,pt3:pt4);
%         std_box = std(reshape(box,size(box,1)*size(box,2),1));
%         if abs(mean(mean(box)) - bottom(i,j)) > 3.2*std_box
%             hold on; plot(j,i,'rx')
%             ytmp = squeeze(squeeze(data.map(i,j,:)));
%             count = 1;
%             while abs(mean(mean(box)) - bottom(i,j)) > 3.2*std_box
%                 bottom(i,j) = URuSi_bottom_ind(xtmp,ytmp,ind1+count,ind2-count,avg_width);
%                 count = count + 1;
%                 if count > 3
%                     break;
%                 end
%             end
%         end
%     end
%   
% end
  img_plot2(bt-bottom); img_plot2(bottom);
end