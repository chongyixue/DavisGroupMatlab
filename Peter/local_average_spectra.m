function avespec_grad=local_average_spectra(data,topo,radius,posx,posy)
%% Inspired by Andrey's polar_average function this takes the polar average
%% of the conductance map around an arbitrary location (center specified by posx and
%% posy). Data is the map and radius determines the radius of the polar average in
%% pxl.Calculates the average spectra in slices (0,0+1,0+1+2,...,int all
%% radius), and plots them. And also in circles at certain radii.

map = data.map;
topograph=topo.map;
[nx ny nz] = size(map);

N = radius;
theta = linspace(2*pi*(360/2)/360,2*pi*(360/2)/360,100);
% R = 1:N;
R = 0:N;
% O = zeros(N,nz);
O = zeros(N+1,nz);

for i=1:nz
    for j=1:length(R)
        summe = 0;
        count = 0;
        for k=1:length(theta)
            x = posx+round(R(j)*cos(theta(k)));
            y = posy-round(R(j)*sin(theta(k)));
            if((x>=1)&&(x<=nx)&&(y<=ny)&&(y>=1))
              summe=summe+map(y,x,i);
              count = count + 1;
            end
        end
        O(j,i)=summe/count;
    end
end
% 
% avespec=sum(O,1)/size(O,2);
% figure;
% plot(data.e,avespec/max(avespec),'r-o')
% figure
hold on

for i=1:N+1
    avespec_grad=sum(O(1:i,:),1)/i;
%     plot(data.e,avespec_grad/max(avespec_grad)+i*0.2,'-o')
%     title(['x=' num2str(posx) ', y=' num2str(posy) ', circ. area avg., Radius ' num2str(0) ' to ' num2str(N) ', 0 = bottom graph' ],'fontsize',12,'fontweight','b')
end

hold off

% figure
hold on

for i=1:N+1
    
%     plot(data.e,O(i,:)/max(O(i,:))+i*0.2,'r-o')
%     title(['x=' num2str(posx) ', y=' num2str(posy) ', circumference avg., Radius ' num2str(0) ' to ' num2str(N) ', 0 = bottom graph' ],'fontsize',12,'fontweight','b')
end

hold off

% img_plot2(topograph)
% hold on
% rectangle('Position',[posx-N,posy-N,2*N,2*N],'Curvature',[1,1],'Linewidth',2,'Edgecolor','c')



end