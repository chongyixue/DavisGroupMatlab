function F = Lorentzian_peak(gg,x)

F = gg(1)/((x-gg(2)).^2+gg(3)^2);