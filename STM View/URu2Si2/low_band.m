function y = low_band(kx,ky)
t = 45;
mu = 3.17*t;
s = 0.06*t;
chi0 = -0.04*t;
chi1 = 0.012*t;
ef = -0.08*t;

y = (light_band(kx,ky) + f_band(kx,ky))/2 - sqrt(((light_band(kx,ky) - f_band(kx,ky))/2).^2 + s^2);
end