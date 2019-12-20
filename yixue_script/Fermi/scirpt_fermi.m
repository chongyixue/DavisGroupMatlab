
E = 200*10^-6;
x = linspace(1,100,1000);
expo = exp(E.*x);
f1 = expo/(expo+1).^2;
f2 = 1./(8*x);
figure,plot(x,f1);
hold on
%plot(x,f2);
%figure,plot(x,f2)

