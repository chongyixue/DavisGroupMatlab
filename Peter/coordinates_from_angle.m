function [out1, out2] = coordinates_from_angle(in1, in2, angle, middle)

angle = angle * pi / 180
x = in1(1)-middle;
y = in1(2)-middle;

out1(1) = round((x*cos(angle)-y*sin(angle))+middle);
out1(2) = round((x*sin(angle)+y*cos(angle))+middle);

x = in2(1)-middle;
y = in2(2)-middle;

out2(1) = round((x*cos(angle)-y*sin(angle))+middle);
out2(2) = round((x*sin(angle)+y*cos(angle))+middle);




end