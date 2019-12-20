function [maxind,minind] = gapmap_maxima_minima(spec,en,enind,specdd,endd)
%gapmap_maxima_minima - uses the energy values where there is a zero
%crossing in the first derivative and the second derivative of the spectrum
%to determine the energy values of all maxima and minima. They will be
%returned in maxind and minind. Since the spectra are all normalized to
%their maximum value all maxima that are below 0.1 are filtered in order to
%reduce the number of maxima to be tested and save time while computing the
%gapmap.
% maxind - energy values of maxima of spectrum
% minind - energy values of minima of spectrum
% spec - STM spectrum
% en - corresponding energy values
% enind - energy values of zero crossings in derivative of spectrum
% specdd - second derivative of spectrum
% endd - energy values of second derivative

% number of elements in the energy values where there is a zero crossing in
% the first derivative
le = length(enind);

% counter variables
tc = 1;
t2c = 1;

% plot the spectrum in case you want to check visually on the accuracy of
% code - comment out once you are ok with how well it works
% figure, plot(en,spec,'k.-',endd,specdd,'m.-')

% preallocate the two variables ddind and mmind, mmind is used for the energy
% values of maxima and minima, and ddind is used for the energy values of
% the maxima and minima position in the second derivative (so will be used
% to determine whether it's a maxima or minima)
mmind = zeros(le,1);
ddind = zeros(le,1);

% create empty arrays for indices of maxima and minima
maxind = [];
minind = [];

for i=1:le
    % calculate the absolute value of the difference between the extrema value and the energy
    % values of the spectrum and its second derivative, the minimum of this
    % will give the energy position of the extrema in the spectrum and
    % second derivative
    dum1 = abs(en - enind(i));
    dum2 = abs(endd - enind(i));
    [dum3, mmind(i)] = min(dum1);
    [dum3, ddind(i)] = min(dum2);
    % determine if the extremum is a maximum or minimum, and save the
    % corresponding energy value into maxind and minind
    if (ddind(i)+1) > length(specdd)
        ddind(i) = length(specdd)-1;
    end
    if specdd(ddind(i)+1) < 0 
        % check in a +/- 1 point area if there is any bigger value
        [dum4,dum5]=max(spec(mmind(i)-1:mmind(i)+1));
        
        % check if maximum is over the threshold value
        if dum4 >= 0.1
            maxind(tc) = en(mmind(i)+dum5-2);
            % Plot a line where the maximum is
%             line([maxind(tc) maxind(tc)],[-1 1],'LineWidth',2,'Color','b');
            tc = tc+1;
        end
    else
        % check in a +/- 1 point area if there is any smaller value
        [dum6,dum7]=min(spec(mmind(i)-1:mmind(i)+1));
        
        minind(t2c) = en(mmind(i)+dum7-2);
        % Plot a line where the minimum is
%         line([minind(t2c) minind(t2c)],[-1 1],'LineWidth',2,'Color','r');
        t2c = t2c+1;
    end       
end

end