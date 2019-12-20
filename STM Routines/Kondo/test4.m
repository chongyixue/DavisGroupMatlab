syms a b e0 l V k func;
% NOTE  that instead of 4V^2 only V^2 is used. So remember to divide fitted
% V value by 2 to get actual hybridization strength
kondo1 = (a*(k)^3 + b*k + e0 + l)/2 - (((a*(k)^3 + b*k + e0 - l)^2 + V^2)^0.5)/2;
kondo2 = (a*(k)^3 + b*k + e0 + l)/2 + (((a*(k)^3 + b*k + e0 - l)^2 + V^2)^0.5)/2;

func = 0;

for i =1:15
    digits(5);
    func = func + (subs(kondo1,k,sym(low_band(i,2)/2,'d')) - sym(low_band(i,1),'d'))^2;
end
for i =1:35
    digits(5);
    func = func + (subs(kondo2,k,sym(high_band(i,2)/2,'d')) - sym(high_band(i,1),'d'))^2;
end

%%
g = @(vec) subs(func, 'a,b,e0,l,V', vec);
gg = @(p) g([p(1) p(2) p(3) p(4) p(5)]);
s = optimset('MaxFunEvals',3000,'MaxIter',3000,'TolFun',1e-4);
[xx2,fval] = fminunc(gg,[-800 -10 10 0.75 3],s);
%%
%xx2(1) = -230; xx2(2) = 25; xx2(3) = 2; xx2(4) = 8;
k=0.0:0.01:0.3;
y1 = kondo_l2(k,xx2(1),xx2(2),xx2(3),xx2(4), xx2(5));
y2 = kondo_h2(k,xx2(1),xx2(2),xx2(3),xx2(4), xx2(5));

figure; plot(low_band(:,2)/2,low_band(:,1),'rx');
hold on; plot(high_band(:,2)/2,high_band(:,1),'rx');
hold on; plot(k,y1,'b'); hold on; plot(k,y2,'b');
%%
figure;
k=0.0:0.001:0.3;
y1 = kondo_l2(k,xx2(1),xx2(2),xx2(3),xx2(4),xx2(5));
y2 = kondo_h2(k,xx2(1),xx2(2),xx2(3),xx2(4),xx2(5));
y3 = xx2(1)*k.^2 + xx2(2)*k + xx2(3); % conduction band
plot(k,y1,'b'); hold on; plot(k,y2,'b');
hold on; plot(high_band(:,2)/2,high_band(:,1),'rx');
hold on; plot(low_band(:,2)/2,low_band(:,1),'rx');
xlim([0.1 0.3])
hold on; plot(k,y3,'g');
hold on; plot(k,xx2(4),'k')
hold on; plot(k,kondo_l2(0.0,xx2(1),xx2(2),xx2(3),xx2(4),xx2(5)));
%%
[dy1 dk] = num_der2(1,y1,k);
[dy3 dk] = num_der2(1,y3,k);
eff_mass_ratio = dy3./dy1;
figure; plot(k,dy1)
%figure; plot(k,eff_mass_ratio);
%% Determining Effective mass in terms of bare electron mass
hbar = 6.5822*10^(-13); %in unit of meVs
kf = 0.126255; %in units of 2pi/a0
a0 = 4.21*10^(-10); %in meters
k_conv = 2*pi/a0; %conv from normalized to meters^-1
E_conv = 1.602*10^(-22); %converts from meV to Joules
dEdk = 22; %in units eV/(2pi/a0);
m = hbar^2*kf*k_conv/(dEdk/k_conv)*E_conv; %in units of kilograms
m_bare = 9.1095*10^(-31); %in kilograms
m/m_bare

%%
kondo_l(0.126255,xx2(1),xx2(2),xx2(3),xx2(4))
%kondo_l(0.164,xx2(1),xx2(2),xx2(3),xx2(4)) - kondo_h(0.164,xx2(1),xx2(2),xx2(3),xx2(4))
%%
figure; plot(k,dy1./dk)
