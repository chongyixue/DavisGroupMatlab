% script to plot a few point spectra in the same plot from a map.
% Early November 2017
% Yi Xue Chong


map2 = obj_90220A00_G;
% map2 = obj_71107a00_G;
topo = map2;
topo.map = map2.map(:,:,18);
% topo.map = LLmap.map(:,:,1);
% topo = obj_71108A00_T;
%
% xpoints = {50,50,50,50,50,50,50,50,50,50,50,50,50,50};
% ypoints = {85,80,75,70,65,60,55,50,45,40,35,30,25,20};
% xpoints = {40,40,40,40,40,40,40,40,40,40,40,40,40,40};
% ypoints = {2,4,6,8,10,12,15,18,20,25};
% xpoints = {50};
% ypoints = {85};
% for nn=1:21;
%     xpoints{nn}=nn+78;
%     ypoints{nn}=nn+69;
% end
clear xpoints;
clear ypoints;

startx = 30;starty=136;
endx = 133; endy=44;
npoints = 41;

divx = (endx-startx)/(npoints-1);
divy = (endy-starty)/(npoints-1);

for nn=1:npoints
%     ypoints{nn}=92-nn*3;
%     xpoints{nn}=72;
%     ypoints{nn}=60-nn*4;
%     ypoints{nn}=12;
    xpoints{nn} = round(startx + divx*(nn-1));
    ypoints{nn} = round(starty + divy*(nn-1));
end
clear xpoints;
clear ypoints;
xpoints{1} = 97;xpoints{2}=10;
ypoints{1} = 74;ypoints{2}=133;

shiftup = 0.01;

    map2.e = map2.e(1:end);
clear color;

for n=1:length(xpoints)
    
    xpix = xpoints{n};
    ypix = ypoints{n};
    
    R = n;
    B = length(xpoints)-n;
    G = 1;
    T = R+G+B;
    R = R/T;
    B = B/T;
    G = 1-R-B;
    color{n} = [R,G,B];
    
    %xpix and ypix are switched.
    y = squeeze(map2.map(ypix,xpix,:));
    %     y2 = squeeze(map2.map(ypix,xpix,:));

    y = y(1:end);
    
    figure(67),plot(map2.e*1000,y+n*shiftup,'-k','color',color{n});hold on;
    %     figure(66),plot(map.e*1000,y2+n*shiftup+0.1,'-k','color','black');hold on;
    %     figure(66),plot(map.e*1000,y+n*shiftup-2,'-k','color','red');hold on;
    %     figure(99),plot(map.e*1000,gradient(y)+n*shiftup,'-k','color',color{n});hold on;
    %     figure(66),plot(map.e*1000,gradient(gradient(y)),'-k','color','black');
    hold on
    %     append(leg, strcat('pixel',num2str(xpix),',',num2str(ypix)))
    
    %     figure(67),
    %     plot(xpix,ypix,'Marker', 'x', 'MarkerSize', 10,'MarkerEdgeColor','r','MarkerFaceColor',color{n}, 'LineWidth', 3);
    %     hold on
    
end

figure(67),
xlabel('bias(mV)');
ylabel('dI/dV(nS)');
hold off

figureset_img_plot(topo.map);
hold on
for n=1:length(xpoints)
    plot(xpoints{n},ypoints{n},'Marker', '.', 'MarkerSize', 15,'MarkerEdgeColor',color{n}, 'LineWidth', 3);
    hold on
end
hold off