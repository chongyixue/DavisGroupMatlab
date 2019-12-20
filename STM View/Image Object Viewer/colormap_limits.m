%%%%%%%
% CODE DESCRIPTION:  Resets the color map min and max values based user
% input.  A lower/upper percentage of points can used as threshold 
%
% CODE HISTORY
%  
%  080101 MPA  project started
%  080123 MHH  Documentation and slight modifications to variable names
%  100921 MHH  Modified for use with STM_View
%%%%%%%%

function [min_val,max_val] = colormap_limits(histo_val,histo_freq,nr,nc,lower,upper)

%get limits for colormap to apply to a 2-D map

mi=min(histo_val); ma=max(histo_val);
d=(ma-mi)/600;

% if map has no color contrast then do nothing
if d==0
    mini=mi;
    maxi=ma;
    return;
end
%cumulative sum of histogram
n_sum = cumsum(histo_freq)/(nr*nc);

lower_ind = find(n_sum <=lower);
if ~isempty(lower_ind)
    min_val = histo_val(lower_ind(end));
else
    min_val = histo_val(1);
end

upper_ind = find(n_sum >= 1-upper);
if ~isempty(upper_ind)
    max_val = histo_val(upper_ind(1));
else
    max_val = histo_val(end);
end

end