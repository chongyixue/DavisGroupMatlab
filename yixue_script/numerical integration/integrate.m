% 2018-9-12

r = 4;

fun1 = @(x,theta) r.^2+x.^2-2.*r.*x.*cos(theta);
fun2 = @(x,theta) 2.*r.*x.*cos(theta);
fun3 = @(x,theta) cos(theta);
fun4 = @(x,theta) r.^2+x.^2-2.*r.*x.*fun3(x,theta);

fun = @(x,theta) x./((fun4(x,theta)).^1.5);
value = integral2(fun,0,r,0,pi);