%scatter plot of points to guide powerpoint presentation of x-y locations
%on map
%2 March 2017

%change the x,y pixel coordinates
x=[27,26,55,44,58,21];
y=[30,8,27,28,8,38];

L=length(x);

figure()


img_plot4(obj_70228A00_G.map(:,:,41));
hold on;

plot(1,1,'r+');
%plot([x(1) y(1)],'r','filled')
hold on;
%(1,1) and (64,64) is to guide the box size
plot(64,64,'k','filled')
hold on;
plot(1,1,'k','filled')
axis square;
axis off;



%scatter(x,-y,'r','filled')
%hold on;
%(1,1) and (64,64) is to guide the box size
%scatter(64,-64,'k','filled')
%hold on;
%scatter(1,-1,'k','filled')
%axis square;
%axis off;