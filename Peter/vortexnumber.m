function nv = vortexnumber(field, a, b)
% Calculates the number of vortices in an rectangular area a*b in a given 
% field, where a and b are to be given in nanometer, and the field in Tesla.

% flux quantum fq in Weber, Weber = Tesla * meter^2
fq = 2.067833758 * 10^(-15);

area = a*b*10^(-18);

nv = field * area / fq;

end