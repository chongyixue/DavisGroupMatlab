function [dN E_int] = hf_bands_2d
%angle given in radians
% 
t = 45;
mu = 3.17*t;
s = 0.1*t;
chi0 = -0.04*t;
chi1 = 0.012*t;
ef = -0.08*t;
kx =  -pi:0.003:pi;
ky = kx;

[KX KY] = meshgrid(kx,ky);
%figure; plot(kx,ky);

%l_band = 2*t*(cos(KX) + cos(KY)) - mu;
l_band = -20*(KX.^2 + KY.^2) + 100;
%f_band = -2*chi0*(cos(KX) + cos(KY)) - 0*chi1*cos(KX).*cos(KY) + ef;
f_band = 1.0;
%figure; mesh(KX,KY,l_band);
%figure; mesh(KX,KY,f_band);

% 
ylow = (l_band + f_band)/2 - sqrt(((l_band - f_band)/2).^2 + s^2);
yup = (l_band + f_band)/2 + sqrt(((l_band - f_band)/2).^2 + s^2);

%ylow_lin = ylow(floor(length(kx)/2),:);
%yup_lin = yup(floor(length(kx)/2),:);
%l_band_lin = l_band(floor(length(kx)/2),:);
%f_band_lin = f_band(floor(length(kx)/2),:);
%k_lin = kx;

%figure; plot(k_lin/pi,ylow_lin);
%hold on; plot(k_lin/pi,yup_lin);
%hold on; plot(k_lin/pi,l_band_lin);
%hold on; plot(k_lin/pi,f_band_lin);
% %figure; mesh(KX,KY,ylow); hold on;  mesh(KX,KY,yup);
% 
E_start = -10;
E_end = 15;
delta_E = 0.005;

E_int = E_start:delta_E:E_end;
%dN = zeros(length(E_int) - 1);
for i = 1:length(E_int)-1
   % dN(i) = sum(sum(ylow >= E_int(i) & ylow < E_int(i+1)));
    %    dN(i) =  sum(sum(yup >= E_int(i) & yup < E_int(i+1)));
    dN(i) = sum(sum(ylow >= E_int(i) & ylow < E_int(i+1))) +...
         sum(sum(yup >= E_int(i) & yup < E_int(i+1)));
     dN2(i) = sum(sum(l_band >= E_int(i) & l_band < E_int(i+1)));
end

dN = dN/delta_E;
dN2 = dN2/delta_E;
figure; plot(E_int(1:end-1),dN); hold on; plot(E_int(1:end-1),dN2,'r');

