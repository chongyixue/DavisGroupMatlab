% 2019-7-31 YXC
% attempt to separate out Se vs Te contributions
% 90729a00 map

x1 = 57; x2 = 256; y1 = 57; y2 = 256;
map = obj_90729a00_G;
topo = obj_90729A00_T;

map.map = crop_img(map.map,y1,y2,x1,x2);
map.ave = squeeze(mean(mean(map.map)));
map.r = map.r(1:(x2-x1)+1);
map.var = [map.var '_crop'];
map.ops{end+1} = ['Crop:' num2str(x1) ' ,' num2str(y1) ':' num2str(x2) ' ,' num2str(y2)];
[nx,ny,nz] = size(map.map);
% img_obj_viewer_test(map);


topo.map = prep_topo_linewise(topo.topo1);
topo.map = crop_img(topo.map,y1,y2,x1,x2);
topo.r = topo.r(1:(x2-x1)+1);
topo.var = [topo.var '_crop'];
topo.ops{end+1} = ['Crop:' num2str(x1) ' ,' num2str(y1) ':' num2str(x2) ' ,' num2str(y2)];
% % img_obj_viewer_test(topo);

% [filtermap1,filtermap2,filter] = filter_threshold(map,topo,0);
% [fmap,f2map] = filter_many(map,topo,0);
% img_obj_viewer_test(filtermap1)
% img_obj_viewer_test(filtermap2)
% img_obj_viewer_test(filter)
low1 = -0.06;
high1 = -0.028;
low2 = 0.01;
high2 = 0.02;
[filter1,map1,filter2,map2]=filter_many(map,topo,low1,high2,low2,high2);
img_obj_viewer_test(map1)
img_obj_viewer_test(map2)
% n = 200;
% xlist = zeros(n);
% ylist = zeros(n);
% for i=1:n
%     xlist(i)=randi(n);
%     ylist(i)=randi(n);
% end
% 
% inc = 2/nz;
% r = 0;
% b = 1;
% figure()
% for layer = 21:nz
%     color = [r 0 b];
% %     figure()
%     for j = 1:n
%         plot(topo.map(xlist(j),ylist(j),1),map.map(xlist(j),ylist(j),layer),'Color',color,'Marker','.','MarkerSize',15);
%         hold on
%     end
%     hold on
%     r = r+inc;
%     b = b-inc;
% %     title(strcat(['Energy = ',num2str(map.e(layer)*1000),'mV']))
% end












