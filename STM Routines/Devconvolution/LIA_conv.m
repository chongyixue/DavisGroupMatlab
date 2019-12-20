function conv_data = LIA_conv(energy,spectra,VA,dir)
n = length(energy);
spc = abs(energy(1) - energy(2));
conv_data = zeros(1,n);
for i = 1:n
  yres = r_func(energy,VA,energy(i));
  area = sum(spc*yres);
  conv_data(i) = sum(yres.*spectra)*spc/area;
end

end
function y = r_func(x,VA,x0)
    y = double(x > -VA+x0 & x < VA+x0);
end