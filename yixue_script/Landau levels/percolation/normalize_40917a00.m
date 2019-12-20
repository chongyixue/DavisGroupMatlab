% 2019-4-16 YXC

map = obj_90417a00_G;

for x = 1:128
    for y = 1:128
        data = squeeze(map.map(x,y,:));
%         data = data(16:end); % remove first few points that overloaded
        maxi = max(data);
        mini = min(data);
        map.map(x,y,:) = (map.map(x,y,:)-mini)./(maxi-mini);
    end
end
map.name = '90417a00_normalized';
img_obj_viewer_yxc(map)

% 0th LL spatial: layer 65 to layer 82
% layer = e2lay(137.54);
% layerdata = map.map(:,:,layer);
% layerdata = flip(layerdata,1);
% figure, contour(layerdata,[1 0.5])
% figure, contour(layerdata)


map2 = map;
% map2.map = map.map(:,:,65:82);
% map2.e = map.e(65:82);
% for x = 1:128
%     for y = 1:128
%         data = squeeze(map2.map(x,y,:));
% %         data = data(16:end); % remove first few points that overloaded
%         maxi = max(data);
%         mini = min(data);
%         map2.map(x,y,:) = (map2.map(x,y,:)-mini)./(maxi-mini);
%     end
% end
% img_obj_viewer_yxc(map2)
% 
% layer = e2lay(135.85)-64;
% layerdata = flip(map2.map(:,:,layer),1);
% figure,contour(layerdata)
% figure,contour(layerdata,[1 0.7])


function lay = e2lay(energy)
layers = 131;
start = 80;
fin = 190;
div = (fin-start)/(layers-1);
lay = round((energy-start)/div)+1;
end
