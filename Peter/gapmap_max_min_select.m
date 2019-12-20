function [sigmax,impmax] = gapmap_max_min_select(spec,ev,specd,evd,maxi,mini,maxid,minid)
%gapmap_max_min_select - takes the maxima determined by
%gapmap_maxima_minima, and selects out the ones that are most significant.
%For that it uses empirical criteria: the difference between the maximum
%rising and falling slope closest to the maximum position, the standard
%deviation of the values of the spectrum in the range between the closest
%maximum falling and rising slope, and the difference between the maximum
%and the closest minima at higher and lower energies nearby. And the area 
%under the peak compared to the area under a straight line from the point
%of the maximum falling and rising slope. For that three empirical values were
%chosen as threshold; if two of the three are above threshold the maximum
%is deemed significant.
% sigmax - array with energy values of significant maxima
% spec - spectrum
% ev - energy values of spectrum
% specd - first derivative of spectrum
% evd - energy values of first derivative
% maxi - energy values of maxima in spectrum
% mini - energy values of minima in spectrum
% maxid - energy values of maxima in first derivative of spectrum
% minid - energy values of minima in first derivative of spectrum
% dum# - dummy variables that are used

% number of maxima to be tested
lmax = length(maxi);

% counter variables
tc = 1;
t2c = 1;
i = 1;
imptc = 1;

% create empty array for sigmax
impmax = [];
sigmax = [];
% figure, plot(ev,spec,'k.-',evd,specd,'m.-')

% sort the maxima so that search for significant maxima gets started at the
% values closest to chemical pot.
if mean(ev) < 0
    maxi = sort(maxi,'descend');
else
    maxi = sort(maxi,'ascend');
end

% oam - overall maximum, oamind - overall maximum index
[oam, oamind] = max(spec);
% eoam - energy of overall maximum
eoam = ev(oamind);
%%
% need to change eoam based on the average spectrum
%%

while t2c <= lmax
    
% for i=1:lmax
    
    %% Find position of closest maximally rising slope
    % dum1 contains the difference between the maximum positions of the
    % first derivative of the spectrum, and dum 2 restricts it to the
    % maxima to the left of the maximum of the spectrum
    dum1 = maxid - maxi(i);
    dum2 = find(dum1 < 0 );
    
    % now find the energy value of this closest maximum falling slope
    % value as well as the slope value, if there is no maximum to the left
    % use the first value of the slope
    if isempty(dum2) == 1
        maxsl(tc) = specd(1);
        dum4 = evd(1);
        dum4ind = 1;
    else
        [dum3, clmaxs(tc)] = min(abs(maxid(dum2(1):dum2(end)) - maxi(i)));
    
        dum4 = maxid(clmaxs(tc));
    
        dum4ind = find(dum4 == evd);
        maxsl(tc) = specd(dum4ind);
    end
        
    %% Find position of closest maximally falling slope
    % the same as for the maximum rising slope only now the falling slope
    % has to be to the right of the maximum of the spectrum
    dum5 = minid - maxi(i);
    dum6 = find(dum5 > 0 );
    
    % again find the energy value and the value of the slope, and if there
    % is no minimum to the right take the last value of the slope
    if isempty(dum6)==1
        minsl(tc) = specd(end);
        dum8 = evd(end);
        dum8ind = length(evd);
    else
        [dum7, clmins(tc)] = min(abs(minid(dum6(1):dum6(end)) - maxi(i)));
    
        dum8 = minid(dum6(1)-1+clmins(tc));
    
        dum8ind = find(dum8 == evd);
    
        minsl(tc) = specd(dum8ind);
    end
    %% Calculate the value for the three criteria used in determining
    %% whether a maximum is significant or not
    % sld - slope difference, maximally rising - falling slope
    sld(tc) = maxsl(tc) - minsl(tc);
%     
%     line([maxi(i) maxi(i)],[-1 1],'LineWidth',2,'Color','g');
%     line([dum4 dum4],[-1 1],'LineWidth',2,'Color','b');
%     line([dum8 dum8],[-1 1],'LineWidth',2,'Color','r');

    % psd - peak standard deviation (std). std of the energy values around
    % the peak, higher if the peak is pronounced, not if flat
    psd(tc) = std(spec(dum4ind : dum8ind));
    
    % calculate the difference in area between a straight line from the two
    % slope points and the actual spectrum between the two slope points
    Q1 = trapz([ev(dum4ind), ev(dum8ind)],[spec(dum4ind), spec(dum8ind)]);
    Q2 = trapz(ev(dum4ind:dum8ind),spec(dum4ind:dum8ind));
    aread(tc) = (Q2-Q1)/Q2;
    
    %% calculate the position of the minimum (at lower and higher 
    %% energies) closest to the maximum currently analyzed, and find 
    %% the maximum and minimum value
    if isempty(mini)==1
        dummy0 = find(ev <= maxi(i));
        dummy1 = find(ev > maxi(i));
        % mispvl/h - minimum spectral peak value lower/higher
        mispvl(tc) = min(spec(dummy0(1):dummy0(end)));
        mispvh(tc) = min(spec(dummy1(1):dummy1(end)));
    else
        % if there is no minimum at lower or higher energies, take the
        % first and the last value of the spectrum respectively
        % mispvl/h - minimum spectral peak value lower/higher
        dummy0 = find(mini <= maxi(i));
        if isempty(dummy0)==1
            mispvl(tc) = spec(1);
        else
            [dummy2,clminl(tc)]=min(abs(mini(dummy0(1):dummy0(end)) - maxi(i)));
            mispvl(tc) = spec( find(mini(clminl(tc)) == ev));
        end
        
        dummy1 = find(mini > maxi(i));
        if isempty(dummy1)==1
            mispvh(tc) = spec(end);
        else
            [dummy3,clminh(tc)]=min(abs(mini(dummy1(1):dummy1(end)) - maxi(i)));
            mispvh(tc) = spec( find(mini(length(dummy0)+clminh(tc)) == ev));
        end
        
    end
    
    % maspv - maximum spectral peak value
    maspv(tc) = spec( find(maxi(i) == ev));

    % mamid - maximum-minimum difference, for the maximum and the closest
    % and smallest minimum either at higher or lower energies. Should be
    % useful for peaks that are exactly at the gap
    mamid(tc) = maspv(tc) - min( [mispvl(tc), mispvh(tc)]);
    
    %% Determine if at least two of the three criteria are above threshold,
    %% the threshold values were chosen empirically, based on testing the
    %% function on spectra
    if aread(tc) >= 0.1
        dum10 = 1;
    else
        dum10 = 0;
    end

    if sld(tc) >= 0.2
        dum11 = 1;
    else
        dum11 = 0;
    end
    
    if mamid(tc) >= 0.1
        dum12 = 1;
    else
        dum12 = 0;
    end
    
    if psd(tc) >= 0.009
        dum13 = 1;
    else
        dum13 = 0;
    end

    
    % mon - maximum or not, sum of the three criteria, if three of the four
    % are above threshold write the maximum into the array sigmax
    mon(tc) = dum10 + dum11 + dum12 + dum13;
    
    % also test if it's a coherence peak or a peak due to a pair-breaking
    % impurity
    
    if abs(maxi(i)) < abs(eoam)
        % minbet = minimum between overall maximum and peak to be tested
        eoamind = find(ev == eoam);
        cmaxind = find(ev == maxi(i));
        [minbet,minbetind]=min(spec(eoamind:cmaxind));
%         if abs(minbet - min( [mispvl(tc), mispvh(tc)]) ) < 0.2
        if minbet < 0.3
            if mon(tc) >= 3 
                impmax(imptc) = maxi(i);
                imptc = imptc + 1;
            end
        else
            if mon(tc) >=3
                sigmax(t2c) = maxi(i);
                t2c = lmax+1;
            end
        end
    else
        if mon(tc) >=3
            sigmax(t2c) = maxi(i);
            t2c = lmax+1;
        end
    end
        
%     if mon(tc) >=3
%         sigmax(t2c) = maxi(i);
%         t2c = lmax+1;
%     end
    
    tc = tc+1;
    i = i+1;
    if tc > lmax
        t2c = lmax+1;
    end
end




% Reduce tc by 1 since it had been increased one more for the last maximum
tc = tc-1;
imptc = imptc -1;
% Plot the maxima that have been deemed significant, actually there should
% be only one, the one closest to the chem. pot.. That way time will be
% saved.
% figure, plot(ev,spec,'k.-',evd,specd,'m.-')
% for i=1:tc
%     if mon(i) >=3
%         line([maxi(i) maxi(i)],[-1 1],'LineWidth',2,'Color','g');
%     end
% end
% for i=1:imptc
%     if mon(i) >=3
%         line([maxi(i) maxi(i)],[-1 1],'LineWidth',2,'Color','k');
%     end
% end
% test = 1;

% If no significant maximum has been found find the maximum value of the
% spectrum and use it (reasons might be that it has just a very broad
% maximum or only a shoulder instead of a clear peak in which case it
% should be found by the shoulder search algorithm).
if isempty(sigmax)==1
    sigmax =ev(find(max(spec)));
end


end