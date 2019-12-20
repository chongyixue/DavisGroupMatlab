% 2018/09/04
% varargin is for renaming newmap
function [newmap,count] = transfer_ref_map(ref,mapobject,varargin)

pixels = length(mapobject.map);
%layers = size(mapobject.map,3);
newmap = mapobject;

count = 0;
for x = 1:pixels
    for y = 1:pixels
        if ref(x,y)==0
            newmap.map(y,x,:)=0;
            count = count+1;
        end
    end
end

variable = '_filtered_';

%new_data.var = [new_data.var '_' direction '_' type];
newmap.var = [newmap.var variable];
%new_data.ops{end+1} = ['Fourier Transform: ' type ' - ' window ' window - ' direction ' direction' ];
newmap.ops{end+1} = [variable];



