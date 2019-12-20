% 2018-11-30 YXC
% Herman, Hulbina, Microscopic interpretation...Dynes...tunneling DOS 
% PRB 94, 144508(2016)

function [DOS1,DOS2] = Dynes_SC_DOS(Delta,Gamma)
% Gamma = 0.1;
% Delta = 0.2;

omega = linspace(-0.5,0.5,201);

i = (-1)^0.5;
up = omega+i*Gamma;
down = ((up).^2-Delta^2).^0.5;
DOS = abs(real(up./down));

figure,plot(omega,DOS,'b')
hold on
title(strcat('DOS1  Gamma=',num2str(Gamma),"  Delta=",num2str(Delta)))
hold off

%another version more accurate?
Delta2 = omega.*Delta/(omega+i*Gamma);
DOS2 = abs(real(omega./(omega.^2-Delta2.^2).^0.5));
figure, plot(omega,DOS2,'b')
hold on
title(strcat('DOS2  Gamma=',num2str(Gamma),"  Delta=",num2str(Delta)))
hold off