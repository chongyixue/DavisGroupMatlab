%%%%%%%
% CODE DESCRIPTION: Given a 2-D map, bin_map creates a new 2-D image which
% replaces the full range of data values with their binned ones.  The
% function uses the maximum and minimum values of the original data as well as the
% the user input for the number of bins to generate a set of bin values.  
% The new map only contains these bine values. 
%   
% CODE HISTORY
% 080701 MHH  Created
% 101015 MHH  Modified for STM_View
% 
% INPUT: data - 2D data set; nbin - the number of bins; min/max_range set
% the values in the map to bin.  All values outside this range are
% discarded
% OUTPUT: new_data - the binned 2D map; binval  - a list of the bin values
% contained in the map

function [new_data binval] = bin_map(data,nbin,min_range,max_range)
format long;
[nr nc nz] = size(data);
new_data = zeros(nr,nc,nz);
%maxval = high; minval = low;
maxval = min(max(max(max(data))),max_range);
minval = max(min(min(min(data))),min_range);

%from max and min values of data matrix (possibly 3D matrix) calculate bin
%size

if nbin==1
    new_data(:,:,:) = mean(mean(mean(data)));
    figure; imagesc(new_data);
    return;
else
    bin_size = ((maxval - minval)/(nbin));
    bins = minval + (0:nbin)*bin_size;
    binval = minval +((0:nbin-1) + 0.5)*bin_size;
end
    
for k = 1:nz
    % if map value is negative take close lower integer in magnitude
    for i=1:nbin-1
        tmp = (data(:,:,k) >= bins(i) & data(:,:,k) < bins(i+1));
        new_data(tmp) = binval(i);       
    end
     tmp = (data(:,:,k) >= bins(nbin) & data(:,:,k) <= bins(nbin+1));
     new_data(tmp) = binval(nbin);
end
load_color;
figure; 
subplot(1,2,1);imagesc(new_data); shading interp;colormap(Cmap.Defect1); 
subplot(1,2,2);histogram(new_data,nbin);
end