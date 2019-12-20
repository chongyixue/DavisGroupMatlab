% 2018-10-10
% YXC
% find out if random map with white noise to gap and spectra
% when do invert peaks and IFFT will yield anything

fakemap = inverse_FT;
pixels = size(fakemap.map,2);
fakemap.name = 'FAKE';
layers = size(fakemap.map,3);

for x=1:pixels
    for y=1:pixels
        fakemap.map(y,x,:) = fake_gap(0.2,0.005,layers,'no plot');
    end
end

img_obj_viewer_test(fakemap)
        
      