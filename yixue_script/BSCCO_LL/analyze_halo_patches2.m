% 2019-9-20 YXC
% crop subtracted (G8-G0) map 150px centering 267,444 then put on workspace
% as sub


plotlayer = 18;
pix =5;

%% corners
x = [84,66,45,67,99];
y = [73,92,67,49,91];
%% center
% x = [26,47,67,46,64,83,65,81,102,97,117];
% y = [65,48,34,85,67,54,105,89,71,104,86];
% x = [64,83,81,102];
% y = [67,54,89,71];

%% edge
% x = [34,53,56,74,89,74,110];
% y = [76,101,59,81,98,45,81];

%% codes
npoints = length(x);
[~,~,layers] = size(sub.map);
clear specs
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
    %plot(x(n),y(n),'Marker', '.', 'MarkerSize', 40,'MarkerEdgeColor',color{n}, 'LineWidth', 3);
    plot(x(n),y(n),'Marker', '.', 'MarkerSize', 40,'MarkerEdgeColor',[0.6,0,0], 'LineWidth', 3);
    hold on
end
hold off

specsavg = mean(specs,1);
figure(55),plot(sub.e*1000,squeeze(specsavg),'color',[0,0,0.8])
hold on