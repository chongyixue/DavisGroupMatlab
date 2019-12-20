%2018/8/16

function [] = add_FOV_square(Ax,Ay,size_nm,rotation)
%in Amstrongs
center = 1229.7;

fig = 33;
figure(fig),
%plot a square
x1=0;
x2=center*2;
y1=0;
y2=center*2;
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'b-', 'LineWidth', 3);
hold on;



%plot max FOV rotation
diag = sqrt(2)*1000;
angle = (45)*pi/180;
x1=center-diag*cos(angle);
x2=center+diag*sin(angle);
x3=center+diag*cos(angle);
x4=center-diag*sin(angle);
y1=center+diag*sin(angle);
y2=center+diag*cos(angle);
y3=center-diag*sin(angle);
y4=center-diag*cos(angle);
x = [x1, x2, x3, x4, x1];
y = [y1, y2, y3, y4, y1];
plot(x, y, 'b-', 'LineWidth', 3);
hold on;

%plot FOV with rotation
diag = sqrt(2)*size_nm*5;
angle = (45-rotation)*pi/180;
x1=Ax-diag*cos(angle);
x2=Ax+diag*sin(angle);
x3=Ax+diag*cos(angle);
x4=Ax-diag*sin(angle);
y1=Ay+diag*sin(angle);
y2=Ay+diag*cos(angle);
y3=Ay-diag*sin(angle);
y4=Ay-diag*cos(angle);


x = [x1, x2, x3, x4, x1];
y = [y1, y2, y3, y4, y1];
plot(x, y, 'r-', 'LineWidth', 3);
hold on;
