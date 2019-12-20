
mapobject = obj_80830a00_G;
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
%iteration = 0;
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
                    if or(temp*temp2 < 0.01, temp > 200)
                        ref(x,y) = 0;
                        stop = 1;
                    end
                    stop = 1;
                    %this one checks for consequtively small values in next
                    %iteration
                    if temp<0.07
                        temp2 = temp;
                    else
                        temp2 = 1;
                    end
                end
            end
        end
    end
end
                
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
percentage_removed = count/(pixels*pixels)*100
%new_data.var = [new_data.var '_' direction '_' type];
newmap.var = [newmap.var '_filter'];
%new_data.ops{end+1} = ['Fourier Transform: ' type ' - ' window ' window - ' direction ' direction' ];
newmap.ops{end+1} = ['Filter_'];
img_obj_viewer_yxc(newmap)

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

            
    
    
    
    