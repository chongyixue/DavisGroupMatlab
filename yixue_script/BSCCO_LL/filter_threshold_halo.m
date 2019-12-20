% 2019-9-17 YXC
% function to produce map based topo value

function filteredmap = filter_threshold_halo(originalmap,layer,threshold,plusORminus)

filteredmap = originalmap;
if plusORminus<0
    filter = originalmap.map(:,:,layer)<=threshold;
else
    filter=originalmap.map(:,:,layer)>=threshold;
end 
% figure,imagesc(filter)
filteredmap.map = originalmap.map.*filter;
% img_obj_viewer_test(filteredmap);
filteredmap.ave=squeeze(sum(filteredmap.map,1:2)/sum(sum(filter)));

img_obj_viewer_test(filteredmap);
n=sum(sum(filter))

end