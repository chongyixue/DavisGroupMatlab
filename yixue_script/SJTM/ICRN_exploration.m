% 2019-12-17 YXC
% ICRN exploration with different sized Del1 and Del2


%% ICRN at 0 temperature
D1 = 7;
D2 = linspace(5,7,10);
C = zeros(length(D2),1);
for i=1:length(D2)
   d2 = D2(i);
   C(i) = ICRN(D1,d2);
end
% figure,plot(D2,C);

%% ICRN at finite temperature
T = linspace(0,0.5,50);
clear C;
C = tanh(D1./(2.*T.*(8.62*10^(-2)))).*pi*(D1/2);
figure,plot(T,C);


function C = ICRN(D1,D2)
K = ellipke(abs((D1-D2)/(D1+D2)));
C = 2*D1*D2*K/(D1+D2);
end







