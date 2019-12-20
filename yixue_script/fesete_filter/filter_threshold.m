% 2019-7-31 YXC
% function to produce map based topo value

function [filtermap1,filtermap2,filter] = filter_threshold(map,topo,value)
[nx,ny,nz] = size(map.map);
temp = zeros(nx,ny,nz);


filter1 = filter_matrix(topo,-10,value);
filter2 = 1-filter1;

f1 = temp;
for k = 1:nz
   f1(:,:,k) = filter1;
end
f2 = 1-f1;

av1 = map.map.*f1/(sum(sum(filter1)));
av1 = sum(av1,1);
av1 = sum(av1,2);

av2 = map.map.*f2/(sum(sum(filter2)));
av2 = sum(av2,1);
av2 = sum(av2,2);

f1map = map; f2map = map;
f1map.map = map.map.*f1+(1-f1).*av1;
f2map.map = map.map.*f2+(1-f2).*av2;
% img_obj_viewer_test(f1map)
f1map.ave = squeeze(av1);
f2map.ave = squeeze(av2);
figure,plot(map.e*1000,squeeze(squeeze(av1)),'r')
hold on
plot(map.e*1000,squeeze(squeeze(av2)),'b')
% plot(map.e*1000,squeeze(squeeze(av1-av2))*100,'k')

filter1topo = topo;
filter1topo.map = filter1;
% img_obj_viewer_test(filter1topo)

filtermap1 = f1map;
filtermap2 = f2map;
filter = filter1topo;
filtermap1.name = strcat([map.name,'>',num2str(value)]);
filtermap2.name = strcat([map.name,'<',num2str(value)]);
filter.name = strcat([map.name,'>',num2str(value)]);
end