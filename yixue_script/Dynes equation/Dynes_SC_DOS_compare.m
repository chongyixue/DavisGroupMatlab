% 2018-11-30 YXC
% Herman, Hulbina, Microscopic interpretation...Dynes...tunneling DOS 
% PRB 94, 144508(2016)
% compare with real spectra
% input model in the form of [avg,energy]

function [DOS,DOS2] = Dynes_SC_DOS_compare(Delta,Gamma,varargin)
% Gamma = 0.1;
% Delta = 0.2;

omega = linspace(-0.5,0.5,201);


up = omega+1i*Gamma;
down = ((up).^2-Delta^2).^0.5;
DOS = abs(real(up./down));
max1 = max(DOS);
DOS = DOS./max1;

% figure,plot(omega,DOS,'b')
% hold on
% title(strcat('DOS1  Gamma=',num2str(Gamma),"  Delta=",num2str(Delta)))
% hold off

%another version more accurate?
Delta2 = omega.*Delta/(omega+1i*Gamma);
DOS2 = abs(real(omega./(omega.^2-Delta2.^2).^0.5));
max2 = max(DOS2);
DOS2 = DOS2./max2;
% figure, plot(omega,DOS2,'b')
% hold on
% title(strcat('DOS2  Gamma=',num2str(Gamma),"  Delta=",num2str(Delta)))
% hold off

if nargin>2
    model = varargin{1};
    avg = model(:,1);
    energy = model(:,2);
    maxval = max(avg);
    avg = avg./maxval;
%     figure,plot(energy,avg)
    figure, plot(energy,avg,'r'); hold on;
    plot(omega,DOS,'k');
%     plot(omega,DOS2,'b');
    title(strcat('Gamma=',num2str(Gamma),"  Delta=",num2str(Delta)));
    hold off
end
    
    