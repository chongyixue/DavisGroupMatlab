% from a smoothed out spectra(from map)
% get the average gap value

function [averagegap,positive_peak,zero] = gapsize_smoothgap(map,px,py,Nsmooth)

linespec = map;
y_smooth = running_average(linespec,px,py,Nsmooth,0);

points = length(y_smooth);
point1 = round(points/4);
midpoint = round(points/2);
point2 = midpoint - point1;
point3 = midpoint + point1;
point4 = points-point1;


% figure,plot(linespec.e*1000,y_smooth+shiftup,'-k','LineWidth',0.1)
% hold on
% plot(linespec.e*1000,y,'-b','LineWidth',0.1)
% %*1000 to make it mV, -line, k black
% xlabel('bias (mV)');
% ylabel('dI/dV (nS)');
% str = strcat('spectrum at (',int2str(px),',',int2str(py),')');
% title(str);


%check for maximum at positive side
start = midpoint;
finish = point4;
[~, maxpos_ref] = max(y_smooth(start:finish));
maxpos = maxpos_ref + start -1;
positive_peak = linespec.e(maxpos)*1000;

%check for maximum at negative side
start = point1;
finish = midpoint;
[~, maxpos_ref] = max(y_smooth(start:finish));
maxpos = maxpos_ref + start -1;
negative_peak = linespec.e(maxpos)*1000;

%check for minimum 
start = point2;
finish = point3;
[~, minpos_ref] = min(y_smooth(start:finish));
minpos = minpos_ref + start -1;
zero = linespec.e(minpos)*1000;

averagegap = (positive_peak-negative_peak)/2;