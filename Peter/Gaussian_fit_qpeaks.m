function [mgt1, mgt2, mgt3, mgt4] = Gaussian_fit_qpeaks(data, x1, y1, x2, y2, x3, y3, x4, y4, r)

map = data.map;

[xb1,resnorm,residual]=complete_fit_2d_gaussian(map(y1-r : y1+r, x1 - r : x1+r, :));

[xb2,resnorm,residual]=complete_fit_2d_gaussian(map(y2-r : y2+r, x2 - r : x2+r, :));

[xb3,resnorm,residual]=complete_fit_2d_gaussian(map(y3-r : y3+r, x3 - r : x3+r, :));

[xb4,resnorm,residual]=complete_fit_2d_gaussian(map(y4-r : y4+r, x4 - r : x4+r, :));


mgt1 = xb1(1);

mgt2 = xb2(1);

mgt3 = xb3(1);

mgt4 = xb4(1);

end