function y = f_band(kx,ky)
t = 45;
mu = 3.17*t;
s = 0.06*t;
chi0 = -0.04*t;
chi1 = 0.012*t;
ef = -0.08*t;
y = -2*chi0*(cos(kx) + cos(ky)) - 4*chi1*cos(kx).*cos(ky) + ef;
end