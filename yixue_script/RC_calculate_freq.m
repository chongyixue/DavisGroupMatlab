function [freq,gain]=RC_calculate_freq(r1,r2,r3,C)

%unites of kOhm and nF
r1 = r1*1000;
r2 = r2*1000;
r3 = r3*1000;
C = C*10^(-9);

%Vin----R1-------------R3----------Vout
%            |            |
%            |            |
%            R2          ===
%            |            |
%           ground       ground

Rdown = r1*r2+r2*r3+r1*r3;
Rup = r1+r2;
freq = Rup/(Rdown*C);
gain = r2/(r1+r2);

end