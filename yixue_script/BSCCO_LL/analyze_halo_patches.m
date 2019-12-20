% 2019-9-20 YXC
% crop subtracted (G8-G0) map 150px centering 267,444 then put on workspace
% as sub


plotlayer = 18;
pix =5;
x = [26,47,67,46,64,83,65,81,102,97,117];
y = [65,48,34,85,67,54,105,89,71,104,86];

npoints = length(x);
[~,~,layers] = size(sub.map);

specs = zeros(npoints,layers);

shiftup = 0.05;

special = 33;

for i = 1:npoints
    
    R = i;
    B = length(x)-i;
    G = 1;
    T = R+G+B;
    R = R/T;
    B = B/T;
    G = 1-R-B;
    
    color{i} = [R,G,B];
    if i==special 
        color{i}=[0,0,0];
    end

    xx = x(i);
    yy = y(i);
    small = crop_center_dialogue_noplot(sub,xx,yy,pix);
    avg = squeeze(average_spectrum_map(small));
    specs(i,:) = avg;
    figure(33),plot(sub.e*1000,avg+shiftup*(i-1),'color',color{i})
    hold on
end
xlabel("mV")

figureset_img_plot(sub.map(:,:,plotlayer));
hold on
for n=1:length(x)
    plot(x(n),y(n),'Marker', '.', 'MarkerSize', 15,'MarkerEdgeColor',color{n}, 'LineWidth', 3);
    hold on
end
hold off

specsavg = mean(specs,1);
figure,plot(sub.e*1000,squeeze(specsavg))