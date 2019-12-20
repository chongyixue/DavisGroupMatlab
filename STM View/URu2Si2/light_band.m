function y = light_band(kx,ky)
t = 45;
mu = 3.17*t;
s = 0.06*t;
chi0 = -0.04*t;
chi1 = 0.012*t;
ef = -0.08*t;
y = 2*t*(cos(kx) + cos(ky)) - mu;
end