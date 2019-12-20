% 2018-10-18 
% splinefit spectra then compare betweeen B and non-B field

% for point speactra
% [B20,e1] = read_pointspectra3('81016a08');%30mV range
[B20,e1] = read_pointspectra3('81016a05');%30mV range
diff1 = e1(2)-e1(1);
length1 = e1(end)-e1(1);
pp1 = spline(e1,B20);


% map = obj_80919a00_G;
map = obj_80918a00_G;
energy = squeeze(map.e).*1000;
diff2 = energy(2)-energy(1);
length2 = energy(end)-energy(1);
avg = map.ave;
pp2 = spline(energy,avg);

smaller_range = energy;
spline_x = linspace(smaller_range(1),smaller_range(end),1001);
spline_y1 = ppval(pp1,spline_x);
spline_y2 = ppval(pp2,spline_x);



figure(),
plot(spline_x,spline_y1,'r');
hold on
plot(spline_x,spline_y2-11,'b');




