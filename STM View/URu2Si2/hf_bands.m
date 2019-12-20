function [k ylow yup l_band] = hf_bands(angle)
%angle given in radians
% 
t = 45;
mu = 3.17*t;
s = 0.095*t;
chi0 = -0.04*t;
chi1 = 0.012*t;
ef = -0.08*t;



% %lower band
% t = 37;
% mu = 3.10*t;
% s = 0.075*t;
% chi0 = -0.06*t;
% chi1 = 0.011*t;
% ef = -0.16*t;

%upper band
% t = 49;
% mu = 3.17*t;
% s = 0.06*t;
% chi0 = -0.04*t;
% chi1 = 0.012*t;
% ef = -0.08*t;

x =  0:0.01:10;
%kx = -2*pi:0.01:2*pi;
%kx = kx/pi;
kx = x/pi;
%ky = kx/cos(angle);
ky = kx*tan(angle);
%figure; plot(kx,ky);

l_band = 2*t*(cos(kx) + cos(ky)) - mu;
f_band = -2*chi0*(cos(kx) + cos(ky)) - 4*chi1*cos(kx).*cos(ky) + ef;
%f_band = ef;
k = sqrt(kx.^2 + ky.^2);

%figure; plot(k,l_band); hold on; plot(k,f_band,'r');

ylow = (l_band + f_band)/2 - sqrt(((l_band - f_band)/2).^2 + s^2);
yup = (l_band + f_band)/2 + sqrt(((l_band - f_band)/2).^2 + s^2);
figure; plot(k/pi,ylow,'r'); 
hold on; plot([0 1], [0 0]);
hold on; plot(k/pi,yup,'b'); hold on; plot(k/pi,l_band); hold on; plot(k/pi,f_band);
hold on; plot([0 1], [0 0]);
xlim([0 1]); ylim([-5 10]);
%hold on; plot([0 1], [-3.38 -3.38]);
%hold on; plot([0 1], [3.82 3.82]);