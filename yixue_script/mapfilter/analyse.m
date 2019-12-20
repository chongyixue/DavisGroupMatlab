% original = obj_80822a00_G;
% energies = original.e;
% yval = original.map(32,92,:);
% figure()
% plot(energies(:),yval(:),'r-')


mapobject = obj_80925a00_G;

pixels = length(mapobject.map);
layers = size(mapobject.map,3);

% get histrogram at one energy layer
% X(energy,index) is the collection of all values at energy layer, where 
% energy goes from -ve to +ve
X = zeros(layers,pixels*pixels);
for x = 1:pixels
    for y = 1:pixels
        for lay = 1:layers
            X(lay,x*y) = mapobject.map(y,x,lay);
        end
    end
end
% this is the histogram of 5th layer with 100 bins
histogram(X(5,:),100);



%this gets the spectrum at one point
[energy,spec]=spectra(x_pix,y_pix,mapobject);
[energy,spec]=spectra(70,13,mapobject);
figure(),plot(energy,spec,'r-');

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
            while stop == 0
                for lay = 1:length(tempenergy)
                    temp = abs(tempspec(lay));
                    if or(temp < 0.01, temp > 100)
                        ref(x,y) = 0;
                        stop = 1;
                    end
                    stop = 1;
                end
            end
        end
    end
end
                
newmap = mapobject;
for x = 1:pixels
    for y = 1:pixels
        if ref(x,y)==0
            newmap.map(y,x,:)=0;
        end
    end
end
img_obj_viewer_yxc(newmap)

refmap = mapobject;
for x = 1:pixels
    for y = 1:pixels
        if ref(x,y)==0
            refmap.map(y,x,1)=0;
        end
    end
end
img_obj_viewer_yxc(refmap)

    
    
    
    
    
    
    
    
    
    
    