function [spectra] = bin_sort_spectra(binval,bin_img,data)
n_spectra = size(binval');
[nr nc nz] = size(data.map);
spectra = zeros(nz,n_spectra);
%new_map = zeros(sy,sx,n_spectra);

for n=1:n_spectra
    [tmpr tmpc] = find(bin_img == binval(n));
    nspec = size(tmpr);    
    for i = 1:nspec(1)
        spectra(:,n) = spectra(:,n) + squeeze(squeeze(data.map(tmpr(i),tmpc(i),:)));
    end
    if nspec(1) > 0
        spectra(:,n) = spectra(:,n)/(nspec(1));
    end
    %tmp = (data_source == binval(n)) ;
    %new_map_g(:,:,n) = tmp.*data_source;
    %new_map_ct(:,:,n) = tmp.*ctmap;
end
figure; plot(data.e*1000,spectra(:,1:n_spectra),'Linewidth',2)
end
    
