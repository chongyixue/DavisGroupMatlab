function [O,R,lambda]=Hirschfeld_plusminus_expbkgsubtract(map,radius)
%% Inspired by Andrey's polar_average function this takes the polar average
%% of the conductance map around a vortex (center specified by posx and
%% posy). "Angle" is the start value, e.g. 0, and "ave" is the average
%% value for the angle (how far it goes, e.g. 360 is all the way around).
%% Data is the map and radius determines the radius of the polar average in
%% pxl."isize" is the image size (75nm e.g., 750 Angstroem, etc) and "pxl" is
%% the image size in pxl. It is used to calculate "lambda" the coherence
%% length from the fit.

load_color;

% if isstruct(data)==1
%     map = data.map;
% else
%     map = data;
% end

[nx ny nz] = size(map);
angle = 0;
ave = 360;
posx = nx/2; 
posy = ny/2;

N = radius;
theta = linspace(2*pi*(angle-ave/2)/360,2*pi*(angle+ave/2)/360,100);
% R = 1:N;
R = 0:N;
% O = zeros(N,nz);
O = zeros(N+1,nz);

for i=1:nz
    for j=1:length(R)
        sum = 0;
        count = 0;
        for k=1:length(theta)
            x = posx+round(R(j)*cos(theta(k)));
            y = posy-round(R(j)*sin(theta(k)));
            if((x>=1)&&(x<=nx)&&(y<=ny)&&(y>=1))
              sum=sum+map(y,x,i);
              count = count + 1;
            end
        end
        O(j,i)=sum/count;
    end
end

figure
hold on

for i=1:nz
plot(R,O(:,i),'.')
end

hold off
% 
%zlayer = zero energy layer
% for i = 1:nz
%     guess=[max(O(2:end,i)), 10, 0.01];
%     figure, plot(R(2:end),O(2:end,i),'.')
%     [y_new, p]=exp_bkg_fit(O(2:end,i),R(2:end),guess,0);
% end


for i = 1:nz
    guess=[max(O(4:end,i)), 10, 0.01,0.01];
    figure, plot(R(4:end),O(4:end,i),'.')
    [y_new, p]=coherence_fit(O(4:end,i),R(4:end),guess,0);
end
% figure;
% semilogy(R,O(:,zlayer),'.')


%% Fit with exponential to get the coherence length
guess=[1, 5, 0.01,O(end,zlayer)];

[y_new, p]=coherence_fit(O(:,zlayer),R,guess,0)
coeffvals = coeffvalues(p)
ci = confint(p)


% figure;
img_plot2(map(:,:,zlayer),Cmap.Blue2)
hold on
rectangle('Position',[posx-N,posy-N,2*N,2*N],'Curvature',[1,1],'Linewidth',2,'Edgecolor','r')


end