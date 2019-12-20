function [O,R]=cbst_polar_average(data,angle,ave,radius,posx,posy)
%% Inspired by Andrey's polar_average function this takes the polar average
%% of the conductance map around a vortex (center specified by posx and
%% posy). "Angle" is the start value, e.g. 0, and "ave" is the average
%% value for the angle (how far it goes, e.g. 360 is all the way around).
%% Data is the map and radius determines the radius of the polar average in
%% pxl."isize" is the image size (75nm e.g., 750 Angstroem, etc).
load_color;

if isstruct(data)==1
    map = data.map;
else
    map = data;
end

[nx ny nz] = size(map);

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

figure, semilogy(R,O(:,1),'.-')
if nz >= 2
    hold on

    for i=2:nz
    semilogy(R,O(:,i),'.-')
    test = 1;
    end

    hold off
end






end