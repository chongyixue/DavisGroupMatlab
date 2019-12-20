function con_data = LIA_conv2(energy,spectra,VA,dir)
spc = abs(energy(1) - energy(2));
n = length(energy);
%con_data = zeros(1,n);

res = res_func(dir*energy,VA,0);
con_data = conv(res,spectra,'same')/3.85;
nlong = length(con_data);
mid = floor(nlong/2);

%con_data = con_data(mid-floor(n/2)+1:mid+floor(n/2)+1);

%figure; plot(energy,spectra); 
%hold on; plot(energy,con_data,'r');
end