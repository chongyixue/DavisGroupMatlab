figure()
center = 100;
x1=0;
x2=center*2;
y1=0;
y2=center*2;
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'b-', 'LineWidth', 1);
hold on;

plot(136,103,'r.')
plot(67,99,'r.')
plot(105,179,'r.')
plot(97,23,'r.')