function E = Fermi_Dirac_deriv_FWHM(T)
% chemical potential = 0;
% energy in meV
k = 8.617333262*10^(-2); %in meV/K 

kT = k.*T;
% kT = T2E_calc(T);
E = kT.*log(3+sqrt(8));
end