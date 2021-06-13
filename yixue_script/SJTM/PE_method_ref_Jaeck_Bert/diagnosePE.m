% 2019-12-23 YXC
% diagnose P0_function-seems to depend on omega spacing a lot

% alpha = 0.76;
% omega0 = 80*10^(-6); % in eV
% CJ = 7*10^(-15); % in Farad
% EJ = 50*10^(-6);
% 
% [P,omega] = P0_function(alpha,omega0*10,CJ,300);
% figure,plot(omega,P,'b')
% hold on
% [P,omega] = P0_function(alpha,omega0,CJ,300);
% plot(omega,P,'r')



% alpha = 0.76;
% omega0 = 80*10^(-6); % in eV
% CJ = 2*10^(-15); % in Farad
% EJ = 1*10^(-9);
% x0 = [alpha,omega0,CJ,EJ,0,0];
% 
% x = x0;
% I = IVcurve_replot(en,x(1),x(2),x(3),x(4),300)';
% figure,plot(en,I,'ro')
% hold on
% 
% 
% % x: 1 - alpha; 2 - omega0; 3 - CJ,x; 4 - EJ ; 5-offset_I ; 6-offset_V
% F = @(x,en)IVcurve_replot(en-x(6),x(1),x(2),x(3),x(4),300)+x(5)';
% y0 = I;
% 
% x0 = [1,10^(-6),10^(-15),10^(-9),0,0];
% [x,~,~,~,~] = lsqcurvefit(F,x0,en',y0);
% 
% y = IVcurve_replot(en,x(1),x(2),x(3),x(4),300);
% plot(en,y)






%% test fitting with an arbitrary function
en = linspace(-10,10,100);
F = @(x,en)dummyquad(x(1),x(2),x(3),en);

x0 = [2,3,9];
y0 = dummyquad(2.2,3.1,-4.23,en)+rand(1,100)*13;

[x,~,~,~,~] = lsqcurvefit(F,x0,en,y0);

y = dummyquad(x(1),x(2),x(3),en);

figure,plot(en,y0,'ro')
hold on
plot(en,y)



function y = dummyquad(a,b,c,x)
y = a.*x.^2+b.*x+c;
end

