%use this to filter a map off from bad pixels.

mapobject = obj_80822a00_G;
original = mapobject;

pixels = length(mapobject.map);
layers = size(mapobject.map,3);

clear ref;
clear refmap;
clear filledmap;

%add a reference variable to keep track of which pixels are deleted.
ref = mapobject.map(:,:,1);
ref(:,:,1) = 1; 

%now try filtering
ref = filter_functions(mapobject,'min',1,'max',40,'jump',20);

[test,count] = transfer_ref_map(ref,mapobject);
percentage_removed = count/(pixels*pixels)*100
img_obj_viewer_yxc(test)

refmap = mapobject;
for x = 1:pixels
    for y = 1:pixels
        if ref(x,y)==0
            refmap.map(y,x,1)=0;
        else
            refmap.map(y,x,1)=1;
        end
    end
end
refmap.name = 'filter';
img_obj_viewer_yxc(refmap)

    

residue = mapobject;
for x = 1:pixels
    for y = 1:pixels
        if ref(x,y)==1
            residue.map(y,x,:)=0;
        end
    end
end
residue.name = 'residue';
% img_obj_viewer_yxc(residue)

    
    
    
%now add in blank spaces with surrounding average
filledmap = fill_in_average(refmap,original,5);
img_obj_viewer_yxc(filledmap);

            
    
    
    
    