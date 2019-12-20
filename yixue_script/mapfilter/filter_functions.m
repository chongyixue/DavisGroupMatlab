%filter function simplifies the code for filtermap.m. 
%Yi Xue Chong 2018-08-30

function [ref,hell] = filter_functions(mapobject,varargin)
%varargin other properties
hell = varargin;

% make varargin properties into dictionary
keySet = {};
valueSet = [];
n_prop = 0;
if mod(length(hell),2)==0
    keySet = {};
    for p=1:length(hell)
        if mod(p,2)==1
            n_prop = n_prop + 1;
            keySet{n_prop} = hell{p};
        else 
            valueSet(n_prop) = hell{p};
        end
    end
end
properties = containers.Map(keySet,valueSet)
    
    %now assign properties to values
    if isKey(properties,'min')==1
        lowerBound = properties('min');
    else
        lowerBound = 0
    end
        
    if isKey(properties,'max')==1
        upperBound = properties('max');
    else
        upperBound = 100
    end
    
    if isKey(properties,'jump')==1
        jump = abs(properties('jump'));
    else
        jump = 200;
    end
    
    if isKey(properties,'min2')==1
        compoundmin = properties('min2');
    else
        compoundmin = 0.01;
    end
    
    if isKey(properties,'max2')==1
        compoundmax = properties('max2');
    else
        compoundmax = 200;
    end
    
    


%add a reference variable to keep track of which pixels are deleted.
ref = mapobject.map(:,:,1);
ref(:,:,1) = 1; 

pixels = length(mapobject.map);
% layers = size(mapobject.map,3);


for x=1:pixels
    for y = 1:pixels
        %don't need to check if already ignoring the pixel
        if ref(x,y) ~= 0
            %iteration = iteration +1
            [tempenergy,tempspec] = spectra(x,y,mapobject);
            %insert selection criteria here
            stop = 0;
            temp2 = 1;
            while stop == 0
                for lay = 1:length(tempenergy)
                    temp = abs(tempspec(lay));
                    if lay == 1
                        change = 0;
                    else
                        change = abs(temp-temp3);
                    end
                    
                    if change>jump || temp<lowerBound || temp*temp2 < compoundmin || temp >upperBound ||temp*temp2>compoundmax
                        ref(x,y) = 0;
                        stop = 1;
                    end
                    stop = 1;
                    %this one checks for consequtively small values in next
                    %iteration
                    temp3 = temp;
                    if temp<0.07 || temp> 100
                        temp2 = temp;
                    else
                        temp2 = 1;
                    end
                end
            end
        end
    end
end

end
