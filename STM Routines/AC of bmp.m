%%
I2 = im2double(I); 
I3 = rgb2gray(I2);
%this produces an image with values from 0..1 with 1 being white
%%
%invert colors
%I4 = 1 - I3;
A1 = xcorr2(I4);
%%
hbar = 1e-34;
E = 0.005;
alpha = 6.24150974e18;
me = 9.1e-31;

k = sqrt(2*me*E/alpha)/(hbar);
