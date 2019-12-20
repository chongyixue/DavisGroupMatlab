map = rahul;

bad_percentage = length(bad_x)*100/(pixels*pixels);
x = round(rand*length(bad_x));
[~,~,~,leftgap,rightgap] = spline_fit(map,bad_x(x),bad_y(x),1,0.15);
average_gap = (rightgap-leftgap)/2;

