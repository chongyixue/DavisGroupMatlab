function hf_band_test

t = 45;
mu = 3.17*t;
s = 0.1*t;
chi0 = -0.04*t;
chi1 = 0.012*t;
ef = -0.08*t;
kx =  -pi:0.003:pi;
ky = kx;

[KX KY] = meshgrid(kx,ky);
s = KY./sqrt(KX.^2 + KY.^2);
figure; mesh(KX,KY,s);
%s = cos(KX + KY);
%figure; plot(kx,ky);

%l_band = 2*t*(cos(KX) + cos(KY)) - mu;
%l_band = -20*(KX.^2 + KY.^2) + 100;
%f_band = -2*chi0*(cos(KX) + cos(KY)) - 4*chi1*cos(KX).*cos(KY) + ef;
%f_band = 1.0;
%figure; mesh(KX,KY,l_band);
%figure; mesh(KX,KY,f_band);

% 
%ylow = (l_band + f_band)/2 - sqrt(((l_band - f_band)/2).^2 + s^2);
%yup = (l_band + f_band)/2 + sqrt(((l_band - f_band)/2).^2 + s^2);


% make fs
% nrk=140;
% k=linspace(-1,1,nrk)*pi;
% [ky,kx]=ndgrid(k,k');
% t1a=.1;
% t1b=t1a;
% t2=6;
% t3=-3;
% ek=t1a*cos(kx)+t1b*cos(ky)+t2*cos(kx).*cos(ky)+t3;

%figure; contour(ek,[0 0],'k')
%figure; contour(l_band,'k');
%figure; contour(f_band,'k');
%figure; contour(s,[0,0],'k');
%figure; contour(ylow,[0,0],'k');
%figure; contour(yup,[0,0],'k');

end