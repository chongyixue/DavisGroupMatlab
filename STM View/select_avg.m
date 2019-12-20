function [x y] = select_avg(data,pts)
%img_plot2(data.map);
n = size(pts,1);
spct = 0;
for i = 1:n
 spct = spct +  squeeze(squeeze(data.map(pts(i,2),pts(i,1),:)));
end
spct = spct/n;
figure; plot(data.e*1000,spct);
% figure; img_plot2(data.map(:,:,1)); 
% hold on;
% for i = 1:n
%     plot(pts(i,2),pts(i,1),'r.'); hold on;
% end
end