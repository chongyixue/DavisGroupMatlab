syms a e0 l V q func;
kondo1 = (a*(q/2)^2 + e0 + l)/2 - (((a*(q/2)^2 + e0 - l)^2 + V^2)^0.5)/2;
kondo2 = (a*(q/2)^2 + e0 + l)/2 + (((a*(q/2)^2 + e0 - l)^2 + V^2)^0.5)/2;
func = 0;

for i =1:15
    digits(5);
    func = func + (subs(kondo1,q,sym(low_band(i,2),'d')) - sym(low_band(i,1),'d'))^2;
    %func = func + (subs(kondo2,q,low_band(i,2)) - low_band(i,1))^2;
end
for i =1:17
    func = func + (subs(kondo2,q,sym(high_band(i,2),'d')) - sym(high_band(i,1),'d'))^2;
    %func = func + (subs(kondo2,q,high_band(i,2)) - high_band(i,1))^2;
end
%%

g = @(vec) subs(func, 'a,e0,l,V', vec);
gg = @(p) g([p(1) p(2) p(3) p(4)]);
s = optimset('MaxFunEvals',3000,'MaxIter',3000,'TolFun',1e-5);
[xx2,fval] = fminunc(gg,[-40 10 1 -5],s);
%%
q=0.1:0.01:0.5;
y1 = kondo_l(q,xx2(1),xx2(2),xx2(3),xx2(4));
y2 = kondo_h(q,xx2(1),xx2(2),xx2(3),xx2(4));

figure; plot(low_band(:,2),low_band(:,1),'rx');
hold on; plot(high_band(:,2),high_band(:,1),'rx');
hold on; plot(q,y1,'b'); hold on; plot(q,y2,'b');
%%
k=0.0:0.001:0.5;
y1 = kondo_l(k,xx2(1),xx2(2),xx2(3),xx2(4));
y2 = kondo_h(k,xx2(1),xx2(2),xx2(3),xx2(4));
y3 = xx2(1)*k.^2 + xx2(2); % conduction band
figure; plot(low_band(:,2)/2,low_band(:,1),'rx');
hold on; plot(high_band(:,2)/2,high_band(:,1),'rx');
hold on; plot(k,y1,'b'); hold on; plot(k,y2,'b');
xlim([0.0 0.25])
hold on; plot(k,y3,'g');
hold on; plot(k,xx2(3),'k')
hold on; plot(k,kondo_l(0.0,xx2(1),xx2(2),xx2(3),xx2(4)));
%%
[dy1 dk] = num_der2(1,y1,k);
[dy3 dk] = num_der2(1,y3,k);
eff_mass_ratio = dy3./dy1;
figure; plot(k,eff_mass_ratio);
%%
%kondo_l(0.113,xx2(1),xx2(2),xx2(3),xx2(4))
kondo_l(0.164,xx2(1),xx2(2),xx2(3),xx2(4)) - kondo_h(0.164,xx2(1),xx2(2),xx2(3),xx2(4))
%%
figure; plot(k,dy1./dk)
