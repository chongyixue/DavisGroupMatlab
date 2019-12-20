function [spectra] = bin_sort_spectra(binval,data_source, map_target)
n_spectra = size(binval');
[sy sx sz] = size(map_target.map);
spectra = zeros(sz,n_spectra);
%new_map = zeros(sy,sx,n_spectra);

for n=1:n_spectra
    [tmpr tmpc] = find(data_source == binval(n));
    nspec = size(tmpr);    
    for i = 1:nspec(1)
        spectra(:,n) = spectra(:,n) + squeeze(squeeze(map_target.map(tmpr(i),tmpc(i),:)));
    end
    if nspec(1) > 0
        spectra(:,n) = spectra(:,n)/(nspec(1));
    end
    %tmp = (data_source == binval(n)) ;
    %new_map_g(:,:,n) = tmp.*data_source;
    %new_map_ct(:,:,n) = tmp.*ctmap;
end
figure; plot(spectra(:,1:7),'Linewidth',3)
end
    
