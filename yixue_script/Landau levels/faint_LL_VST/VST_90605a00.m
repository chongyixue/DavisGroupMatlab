% 2019-6-5 YXC
% faint LL looks like plateau
% crop this map from (11,1) to (74,64) then put on workspace as "map"

[nx,ny,nz] = size(map.map);
%nice point spect at (33,50)
[x,y] = plotspec(map,33,50);
hold on;
critical_energies = [0.12,0.13,0.17,0.21,0.255,0.27,0.295];
n = length(critical_energies);
signal = zeros(n,1);
for i = 1:n
    index = findindex(x,critical_energies(i));
    signal(i) = y(index);
end
spline_x = x;
spline_y = spline(critical_energies,signal,spline_x)';
plot(spline_x,spline_y,'r');
hold on
modified = y-spline_y;
plot(spline_x,modified*10,'k')
plot(critical_energies,signal,'rx')
legend(["original spectrum","spline fit at critical locations","(scaled)subtracted spectrum","critical locations"])

%normalize spline_y
mini = min(spline_y);
maxi = max(spline_y);
spline_y = (spline_y-mini)/(maxi-mini);
% spline_y = scale(spline_y,-3,1);
% figure,plot(spline_y)



newmap = map;
maxmap = max(map.map,[],3);
minmap = min(map.map(:,:,6:end),[],3);

testx = randi([1,nx]); 
testy = randi([1,ny]);
pointspec = squeeze(map.map(testy,testx,:));
sy = squeeze(scalearray(spline_y,minmap(testy,testx),maxmap(testy,testx)));
figure,plot(x,sy,'r');
hold on
plot(x,pointspec,'b')
plot(x,pointspec-sy,'k')
title(['point spectrum at (' num2str(testx) ', ' num2str(testy) ')']);


% splinemap = zeros(nx,ny,nz);
% for i = 1:nx
%     for j = 1:ny
%         splinemap(i,j,:)=scalearray(spline_y,minmap(i,j),maxmap(i,j));
%     end
% end
% 
% newmap.map = map.map - splinemap;
% 
% img_obj_viewer_test(newmap)


% plotspec(map,1,1);



function [x,y] = plotspec(map,xpix,ypix,varargin)
x = map.e;
y = squeeze(map.map(ypix,xpix,:));
if nargin<4
    figure,plot(x,y);
    hold on
    title(['point spectrum at (' num2str(xpix) ', ' num2str(ypix) ')']);
end
end

function index = findindex(array,val)
new = abs(array-val);
[~,index] = min(new);
end

function scaled = scalearray(array,min,max)
range = max-min;
scaled = array*range+min;
end

