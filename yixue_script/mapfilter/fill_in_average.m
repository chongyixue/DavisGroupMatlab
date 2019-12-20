% assuming one has a refmap - map with 0 for blank spectra and 1 otherwise
% fill in blank pixels with spectra from surrounding pixels

function [filledmap] = fill_in_average(refmap,datamap,radius)
pixels = length(datamap.map);
layers = size(datamap.map,3);

newname = 'fillin_';
filledmap = datamap;
filledmap.name(end+1:end+length(newname)) = newname;
filledmap.ops{end+1} = [newname];
filledmap.var = [filledmap.var 'fillin_'];


for x = 1:pixels
    for y = 1:pixels
        %look for empty cells
        if refmap.map(y,x,1) < 0.5
            filledmap.map(y,x,:) = average_pixels(x,y,datamap,refmap,radius);
        end
    end
end




end
                
                