%%%%%%%
% CODE DESCRIPTION: For conductance map data that has noise on the
% coherence peaks and very few other features, this gapmap routine fits a
% high degree polynomial to the spectra.  The reuslting fit is typically
% very good for the resonance peaks and can the resulting maxima in the fit
% can be used to extra the SC gap value
%   
% CODE HISTORY
% 080922 MHH  Created
% 
% INPUT: fdata - Conductance data set; 
% OUTPUT: new_data - new conductance data set which uses the fitted
% function as the data points; gmap - SC gap map

function [gmap new_data] = gapmap(fdata)
load_color;
[nr nc nz] = size(fdata.map);
new_data = fdata;
gmap = zeros(nr,nc);
%stat_map = zeros(sx,sy);
x = fdata.e;
mx = 76;
mn = 1;
x = fdata.e(mn:mx);
for i = 1:nr
    for j=1:nc
        y = squeeze(squeeze(fdata.map(i,j,mn:mx)));        
        [p,S] = polyfit(x',y,22);
        f = polyval(p,x,S);
        %residual = ((y-f'));
        %[h pr] = chi2gof(residual);
        %stat_map(i,j) = pr;
        %f = squeeze(squeeze(fdata.map(i,j,:)));        
        % new_data.map(i,j,:) = f';
        %[C1,I1] = max(f(1:floor(nz/2)));
        %[C2,I2] = max(f(ceil(nz/2):end));
        %gmap(i,j) = abs((x(I2+floor(nz/2)) - x(I1))/2);
        [C1,I1] = max(f(mn:mx));
        gmap(i,j) = x(I1);
    end
end
figure; pcolor(gmap); shading flat; colormap(Cmap.Defect1);
%figure; pcolor(stat_map); shading flat; colormap(jet);
end