% 2019-10-1 YXC

function dfdt = fermi_distribution_dfdt(E_mV,T_K)
T = T_K;
E = E_mV;
k = 8.617333262*10^(-2); %in meV/K 
dfdt = exp(E./(k.*T'))./(k.*T'.*(exp(E./(k.*T'))+1).^2);
end


