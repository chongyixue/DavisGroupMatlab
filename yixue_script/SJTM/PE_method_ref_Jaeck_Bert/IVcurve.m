function [V,I]=IVcurve(alpha,omega0,CJ,EJ,mK)

[P,omega] = P0_function(alpha,omega0,CJ,mK);

% figure,plot(omega,P)
% title("P")

hbar = 6.5821196*10^(-16); %eV*s

% omega is a symmetric list containing 0
pix = length(omega);
mid = (pix+1)/2;

% drop alternate
A = linspace(1,length(omega),length(omega));
A = mod(A,2);
middleval = A(mid);
dropindex = A ~= middleval;

P2 = P;
P2(dropindex) = [];
P3 = flip(P2);

I = (pi*EJ^2/hbar)*(P2-P3);
pix2 = length(P2);

drophalf = (length(omega)-pix2)/2;
V = omega(drophalf+1:drophalf+pix2);
    

end





