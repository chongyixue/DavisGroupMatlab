% Use alternate peak finding algorithm + polynomial fit to calculate gap value
function gap_val = calc_gapval1(x1,y1,dbl_pk_optn,dbl_pk_percent,pk_rng_optn,...
                                   slope_thr,amp_thr,smooth_width,fit_width) 
    %peaks1 = [];
    %mx = max(y1); mx = mx(1);
    %y1 = smooth(y1);    
    peaks1 = findpeaks_4(x1,y1,slope_thr,amp_thr,smooth_width,fit_width); 
    %peaks1(:,1) = b; peaks1(:,2) = a;
    % pick out largest height peaks as the gap edge subject to other
    % contraints.  If equal height peaks are found, and dbl_peak
    % option is not selected then take the peak furthest away from 0V.          
    gap_val =  max(peaks1(peaks1(:,2) == max(peaks1(:,2)),1));

    % if no peak is found, then this option sets the gap value to value
    % at which the spectrum attains its maximum value
    if pk_rng_optn
        if peaks1(1,1) == 0 %no peak found
            gap_val = max(x1(y1 == max(y1)));                            
        end                            
    end

    %if the max height peaks is within 10% of the next highest peak,
    %then set the gap value to 0, the error value.

    if  dbl_pk_optn 
        if (size(peaks1,1) > 1)
            sort_peaks = sort(peaks1(:,2),'descend');
            if (((sort_peaks(1) - sort_peaks(2))/sort_peaks(1)) < dbl_pk_percent)
                gap_val = 0;                    
               % count1 = count1 + 1;
               % dp_index1(count1,1) = i; dp_index1(count1,2) = j;
            end            
        end
    end
    %figure; plot(y1); hold on; plot([gap_val gap_val],[0 1.6]);
    if gap_val~= 0
        w = 3; %fit group width
        xx = x1(max(gap_val-w,1):min(gap_val+w,length(x1)));
        yy = y1(max(gap_val-w,1):min(gap_val+w,length(x1)));
        [coef]=polyfit(xx,(yy)',4);  % Fit parabola to log10 of sub-group         
        diffr = mean(diff(xx));          
        x_fine = xx(1):diffr/10:xx(end);           
        f = polyval(coef,x_fine);
        PeakX = mean(x_fine(f == max(f))); % Compute peak position and height of fitted parabola
        PeakY = max(max(f));       
        gap_val = PeakX;
        %gap_val = x1(gap_val);
        %figure; plot(x1,y1,'x'); hold on; plot([gap_val gap_val],[0 1.6]);
        %hold on; plot(x_fine,f,'r');
    end
    
end