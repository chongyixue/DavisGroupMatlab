function [theta,I_avg,area] = polar_intensity_circ(data_mat,r,width,avg_ang);
%INPUT
%data_mat: map in matrix form
%r: radius of circle in px (integer)
%width: thickness of circular contour to integrate in px (integer)
%avg_ang: average angle in degrees to integrate over for smoothing

%OUTPUT
%theta: returns angle vector of same size as I_avg for plotting
%I_avg: average intensity for circular contour specified for avg_angle
%area: shows what area has been integrated
num = 200;% number of pixels in 0-45 degrees
[ni,~,nk] = size(data_mat);
area = zeros(ni,ni,nk);
th = linspace(0,pi/2,num);
cpx = floor((ni+1)/2); %central px
I = zeros(nk,num);
width = round(width/2);
area = data_mat;
Imax = max(max(max(data_mat)));
for w = -width:width
    x = cpx + round(r*cos(th) + w); 
    y = cpx - round(r*sin(th) + w);
    for kk = 1:nk
        for ii = 1:num
            I(kk,ii) = data_mat(x(ii),y(ii),kk);
            area(x(ii),y(ii),kk) = Imax;
        end
    end
end

I2 = repmat(I,[1,6]);
I_avg = zeros(nk,4*num);
avg_px = round(avg_ang*num/90);
for kk=1:nk
    for n=1:4*num
         I_avg(kk,n)= mean(I2(kk,num+n-avg_px:num+n+avg_px));
    end
end
theta = linspace(0,360,4*num);