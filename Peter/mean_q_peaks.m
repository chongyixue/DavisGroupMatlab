function [mgt1, mgt2, mgt3, mgt4] = mean_q_peaks(data, x1, y1, x2, y2, x3, y3, x4, y4)

map = data.map;




mgt1 = mean( [map(y1, x1, 1), map(y1+1, x1, 1), map(y1, x1+1, 1), map(y1+1, x1+1, 1)] );

mgt2 = mean( [map(y2, x2, 1), map(y2+1, x2, 1), map(y2, x2+1, 1), map(y2+1, x2+1, 1)] );

mgt3 = mean( [map(y3, x3, 1), map(y3+1, x3, 1), map(y3, x3+1, 1), map(y3+1, x3+1, 1)] );

mgt4 = mean( [map(y4, x4, 1), map(y4+1, x4, 1), map(y4, x4+1, 1), map(y4+1, x4+1, 1)] );

end