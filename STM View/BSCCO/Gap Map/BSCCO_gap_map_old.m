function map = BSCCO_gap_map(data,slope_thr,fit_width,smooth_width,amp_thr,...
                                start_energy_ind,end_energy_ind,...
                                map_optn,dbl_pk_optn,dbl_pk_percent,pk_rng_optn,bad_px_optn)

[nr nc nz] = size(data.map);
%find the midpoint of spectra (different if there are even or odd number of
%points in the spectrum - only good when you have  +/- spectra.  
if (mod(nz,2) == 0)
    mid_point1 = floor(nz/2);
    mid_point2 = mid_point1 + 1;
else
    mid_point1 = find(data.e == 0) - 1;
    mid_point2 = mid_point1 + 2;
end

% split spectrum in two to find peaks separately
x1 = data.e(start_energy_ind:mid_point1)*1000;
x2 = data.e(mid_point2:end_energy_ind)*1000;

% map calculation options - NEGATIVE DELTA & POSITIVE DELTA
if map_optn(2) == 1 || map_optn(1) == 1 % yes to positive map
    map1 = data.map(:,:,start_energy_ind:mid_point1);
else
    map1 = zeros(nr,nc,nz);
end
if map_optn(3) == 1 || map_optn(1) == 1% yes to negative map
    map2 = data.map(:,:,mid_point2:end_energy_ind);
else
    map2 = zeros(nr,nc,nz);
end

% rearrange spectrum starting from -ve to +ve energies
if data.e(1) > data.e(end)
    x1 = x1(end:-1:1);
    map1 = map1(:,:,end:-1:1);
    x2 = x2(end:-1:1);
    map2 = map2(:,:,end:-1:1);
end

%initialize gap maps
gap_map1 = zeros(nr,nc);
gap_map2 = zeros(nr,nc);

% index the location of double peaks - potentially useful

count1 = 0; count2 = 0;
dp_index1 = [0 0]; dp_index2 = [0 0];

h = waitbar(0,'Please wait...','Name','Gap Map Progress');
for i = 1:nr    
    for j = 1:nc                     
        %find +ve edge
        y1 = squeeze(squeeze(map1(i,j,1:end)))'; 
        peaks1 = findpeaks_3(x1,y1,slope_thr,amp_thr,fit_width,smooth_width); 
        
        %find -ve edge
        y2 = squeeze(squeeze(map2(i,j,1:end)))';        
        peaks2 = findpeaks_3(x2,y2,slope_thr,amp_thr,fit_width,smooth_width);
        
        % pick out largest height peaks as the gap edge subject to other
        % contraints.  If equal height peaks are found, and dbl_peak
        % option is not selected then take the peak furthest away from 0V.
        gap_map1(i,j) =  max(peaks1(peaks1(:,3) == max(peaks1(:,3)),2));
        gap_map2(i,j) =  min(peaks2(peaks2(:,3) == max(peaks2(:,3)),2)); 
        
        % if no peak is found, then this option sets the gap value to value
        % at which the spectrum attains its maximum value
        if pk_rng_optn
            if peaks1(1,1) == 0 %no peak found
                gap_map1(i,j) = max(x1(y1 == max(y1)));                            
            end                
            if peaks2(1,1) == 0 %no peak found
                gap_map2(i,j) = max(x2(y2 == max(y2)));                            
            end                
        end
        
        %if the max height peaks is within 10% of the next highest peak,
        %then set the gap value to 0, the error value.
       
        if  dbl_pk_optn 
            if (size(peaks1,1) > 1)
                sort_peaks = sort(peaks1(:,3),'descend');
                if (((sort_peaks(1) - sort_peaks(2))/sort_peaks(1)) < dbl_pk_percent)
                    gap_map1(i,j) = 0;                    
                    count1 = count1 + 1;
                    dp_index1(count1,1) = i; dp_index1(count1,2) = j;
                end            
            end
            if (size(peaks2,1) > 1)
                sort_peaks = sort(peaks2(:,3),'descend');
                if (((sort_peaks(1) - sort_peaks(2))/sort_peaks(1)) < dbl_pk_percent)
                    gap_map2(i,j) = 0;
                    count2 = count2 + 1;
                    dp_index2(count2,1) = i; dp_index2(count2,2) = j;                
                end            
            end 
            
        end
    waitbar(i / nr,h,[num2str(i/nr*100) '%']);
    end
         
end
close(h) 

%if both +ve and -ve maps are generated make make sure the the double peak 
%rejection sets pixels in both maps to zeros where a double peak is found
%in either map
if (dbl_pk_optn && map_optn(2) && map_optn(3)) || (dbl_pk_optn && map_optn(1)) 
    for i = 1:count2
        gap_map1(dp_index2(i,1),dp_index2(i,2)) = 0;
    end
    for i = 1:count1
        gap_map2(dp_index1(i,1),dp_index1(i,2)) = 0;
    end
end

map{1} = gap_map1; map{2} = gap_map2; map{3} = 0;
% average map option
if map_optn(1) == 1
    gap_map_avg = (abs(gap_map1) + abs(gap_map2))/2;  
    map{3} = gap_map_avg;
end

%whatever maps are chosen, direct as the output
map = map(map_optn == 1);
% load_color
% img_plot2(gap_map1,Cmap.Defect1,'BSCCO Gap Map +ve');
% img_plot2(gap_map2,Cmap.Defect1,'BSCCO Gap Map -ve');

end
