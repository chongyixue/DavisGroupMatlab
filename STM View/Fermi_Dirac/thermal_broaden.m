%%%%%%%
% CODE DESCRIPTION: Given a spectrum, y, with energy vector energy, in mV,
% produce a new vector y_t_b which is the thermally broadened y at
% temperature T.  The option 1 gives kT broadening while option 2 gives
% 3.5kT broading.
%   
% CODE HISTORY
%
% 121118 MHH
%
%%%%%%%
function broad_y = thermal_broaden(energy,y,T,option)
if option == 1
    A = 1;
else 
    A = 3.5;
end

broad_func = Fermi_Dirac_deriv(energy,A*T);
broad_y = conv(broad_func,y,'same');


end