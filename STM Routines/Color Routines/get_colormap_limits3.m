%%%%%%%
% CODE DESCRIPTION:  Resets the color map min and max values based user
% input.  Either a the lower/upper percentage of points can used as
% threshold or the lower/upper range of values.
%
% CODE HISTORY
%  
%  080101 MPA  project started
%  080123 MHH  Documentation and slight modifications to variable names
%
%
%%%%%%%

function [mini,maxi]=get_colormap_limits3(r_map,lower,upper,str)

%get limits for colormap to apply to a 2-D map
% 'r' : percentage of range above/below which color map is set to max/min
% 'h' :percentage of points above/below which color map is set to max/min

%[sy sx sz]=size(dmap);

%plane = reshape(data.map,sx*sy*sz,1);
plane = r_map;
mi=min(plane); ma=max(plane);
d=(ma-mi)/600;

% if map has no color contrast then do nothing
if d==0
    mini=mi;
    maxi=ma;
    return
end

% if percentage of points is used to set colormap thresholds
if str=='h'
   %plane=sort(plane);
   nr=length(plane);
   
   indmin=ceil(nr*lower);
   if indmin==0; 
       indmin=1; 
   end
   mini=plane(indmin);   
   
   indmax=ceil((1-upper)*nr);
   if indmax==0; 
       indmax=1; 
   end
   maxi=plane(indmax);
   
   k=0;
   while maxi==mini  % cheat to get the two numbers different!
      k=k+1;          
      maxi=plane(ceil(nr-upper*nr)+k);
   end
elseif str=='r'
    mini=mi+lower*(ma-mi);
    maxi=ma-upper*(ma-mi);
else
    str='choose r or h'        
end
end