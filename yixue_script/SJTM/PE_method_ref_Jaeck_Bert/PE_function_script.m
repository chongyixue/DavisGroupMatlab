% 2019-12-18 YXC
% script for P(E) function

alpha = 0.76;
omega0 = 80*10^(-6); % in eV
CJ = 2*10^(-15); % in Farad
EJ = 1*10^(-9);

EJ = 10^(-9);

% [P,omega] = P0_function(alpha,omega0,CJ);
% [P1,~] = P0_function(alpha,omega0,CJ*2);

% figure,plot(omega,P,'b')
% hold on
% plot(omega,P1,'r') 
% legend("CJ","2 x CJ")

% [V0,I0] = IVcurve(alpha,omega0,CJ,EJ);
% V = linspace(-0.0001,0.0001,100);
% I = IVcurve_replot(V,alpha,omega0,CJ,EJ);
% figure,plot(V,I)



% 
% [P,omega] = P0_function(alpha,omega0,CJ);
% [P1,~] = P0_function(2*alpha,omega0,CJ);
% 
% figure,plot(omega,P,'b')
% hold on
% plot(omega,P1,'r') 
% legend("alpha","2 x alpha")


%% look at map
% open 20191210_JSTS_map on image 1210_018_-2mV 1.5nA Nb tip on NbSe2 at
% 0.3K001.3ds and call it JSTStwo
map = obj_JSTStwo_I;
scaleitup = 10^12;
map.map = map.map(:,:,2:end);
map.ave = map.ave(2:end).*scaleitup;
map.e = map.e(2:end);
[~,~,layers] = size(map.map);
% img_obj_viewer_test(map)

map.map = map.map.*scaleitup;

%% try fitting one spectrum (av spec)
en = map.e;
specave = flip(squeeze(map.ave))';

xx = randi(150);yy=randi(150);
spec = flip(squeeze(map.map(xx,yy,:)))';

% en2 = linspace(en(1),en(end),201);
% spec2 = spline(en,spec,en2);
% spec2 = fitfunction(en2,alpha,omega0,CJ,EJ,0,0);

%% original fit
% % x: 1 - alpha; 2 - omega0; 3 - CJ,x; 4 - EJ ; 5-offset_I ; 6-offset_V
% % F = @(x,en)(IVcurve_replot(en-x(6),x(1),x(2),x(3),x(4),300)+x(5));
% F = @(x,en)fitfunction(en,x(1),x(2),x(3),x(4),x(5),x(6));
% x0 = [alpha,omega0,CJ*0.9,EJ,0,0];
% %% fit
% [x,a,b,c,d] = lsqcurvefit(F,x0,en2,spec2);
% alpha = x(1)
% omega0 = x(2)
% CJ = x(3)
% EJ = x(4)
% offset_I = x(5)
% offset_V = x(6)

%% fit with toolbox
a = alpha;b=omega0;c=CJ;d=EJ;e=0;f=0;
% PEfunction = 'fitfunction(x,a,b,c,d,e,f)';
PEfunction = 'IVcurve_replot(x-f,a,b,c,d,300)+e';
s = fitoptions('Method','NonlinearLeastSquares',...
        'Startpoint',[a b c d e f],...
        'Algorithm','Levenberg-Marquardt',...
        'TolX',1e-4,...
        'MaxIter',5000,...
        'MaxFunEvals', 5000);
F = fittype(PEfunction,'options',s);
spectofit = spec;
p = fit(en',spectofit',F);
x = [a,b,c,d,e,f];
alpha = x(1)
omega0 = x(2)
CJ = x(3)
EJ = x(4)
offset_I = x(5)
offset_V = x(6)

%% evaluate fit 
I = fitfunction(en,x(1),x(2),x(3),x(4),x(5),x(6));
figure,plot(en,spectofit,'ro')
hold on
plot(en,I,'b')
title(['spectrum at (',num2str(xx),',',num2str(yy),')']);
plot(en,specave,'k--');

function y = fitfunction(en,a,b,c,d,e,f)
y = IVcurve_replot(en-f,a,b,c,d,300)+e;
end
% 
% figure,plot(en,spec,'ro')
% hold on
% plot(en,IVcurve_replot(en,x0(1),x0(2),x0(3),x0(4),300))

%% manual adjustment
% alpha = 0.76;
% omega0 = 80*10^(-6); % in eV
% CJ = 7*10^(-15); % in Farad
% EJ = 50*10^(-6);
% x = [alpha,omega0,CJ,EJ,0,0];
% I = IVcurve_replot(en-x(6),x(1),x(2),x(3),x(4));
% figure,plot(en,I)
% title(num2str(log(CJ)/log(10)))

% figure,plot(en,spec,'ro');
% hold on
% plot(en,I,'b')
% xlabel("eV")
% ylabel("I")

% enlimit = 200*10^(-6);
% en = linspace(-enlimit,enlimit,201);
% I = IVcurve_replot(en-x(6),x(1),x(2),x(3),x(4),300);
% 
% figure,plot(en,I)
% title(num2str(log(CJ)/log(10)))

%% diagnose (in IVcurve_replot the bad values alpha...are saved
% 
% [P,omega] = P0_function(alpha,omega0,CJ);
% figure,plot(P,omega)



