% 2019-9-20 YXC
% will take map, and certain spots (centered at each of x,y points,vicinitypix by vicinitypix area) and
% average spectra
% will also plot the average of each spot, and output the average of
% everything

function [spectra,energy]=points_average_spectra(map,xpoints,ypoints,vicinitypix,plotlayer)
pix=vicinitypix;
x=xpoints;
y=ypoints;
sub=map;
npoints = length(x);
energy = map.e*1000;
[~,~,layers] = size(sub.map);
specs = zeros(npoints,layers);

shiftup = 0.05;


for i = 1:npoints
    
    R = i;
    B = length(x)-i;
    G = 1;
    T = R+G+B;
    R = R/T;
    B = B/T;
    G = 1-R-B;
    
    color{i} = [R,G,B];

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
    %plot(x(n),y(n),'Marker', '.', 'MarkerSize', 40,'MarkerEdgeColor',color{n}, 'LineWidth', 3);
    plot(x(n),y(n),'Marker', '.', 'MarkerSize', 40,'MarkerEdgeColor',[0.6,0,0], 'LineWidth', 3);
    hold on
end
hold off

specsavg = mean(specs,1);
figure(55),plot(sub.e*1000,squeeze(specsavg),'color',[0,0,0.8])
spectra = specsavg;
end
