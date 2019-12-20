%scatter plot of points to guide powerpoint presentation of x-y locations
%on map
%13 June 2017

%change the x,y pixel coordinates
x=[27,26,55,44,58,21];
y=[30,8,27,28,8,38];

L=length(x);

figure()

%here the last input should be the layer corresponding to 0 bias
img_plot_yxc(obj_70228A00_G.map(:,:,41));

hold on;
n=1;
for n=1:L 
    plot(x(n),y(n),'r+');
    hold on;
    n=n+1;
end 
n=1;
for n=1:L 
    spectrumplot(obj_70228A00_G,x(n),y(n),1)
    n=n+1;
end 

