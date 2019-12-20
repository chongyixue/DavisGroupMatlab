%2018-08-20 Yi Xue Chong
%get spectra from map at a specific pixel

function [energy,spec]=spectra(x_pix,y_pix,mapobject)

energy = mapobject.e(:);
spec   = mapobject.map(y_pix,x_pix,:);
spec = spec(:);
%figure(), plot(energy,spec,'b-')
end