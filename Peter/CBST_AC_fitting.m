function [sig1, sig2, x] = CBST_AC_fitting(data, acc)

map = data.map;

x = acc(2);
y = acc(1);

accl = [map(x-1, y-1, 1), map(x-1, y, 1), map(x-1, y+1, 1),...
    map(x, y-1, 1), map(x, y+1, 1), map(x, y, 1),...
    map(x+1, y-1, 1), map(x+1, y, 1), map(x+1, y+1, 1)];

figure, imagesc(map);

map(x, y, 1) = squeeze(mean(accl));

figure, imagesc(map);

test = 1;

[x,resnorm,residual]=complete_fit_2d_gaussian(map);

sig1 = x(3)*(data.r(2)-data.r(1));
sig2 = x(5)*(data.r(2)-data.r(1));



end