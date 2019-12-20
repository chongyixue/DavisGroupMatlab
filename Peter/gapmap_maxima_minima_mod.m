function [maxind,minind] = gapmap_maxima_minima_mod(spec,en,enind,specdd,endd)
%gapmap_maxima_minima - uses the energy values where there is a zero
%crossing in the first derivative and the second derivative of the spectrum
%to determine the energy values of all maxima and minima. They will be
%returned in maxind and minind. The only difference to gapmap_maxima_minima
%is that the maxima aren't tested for being over a certain threshold value.
%So all maxima are found.
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

% Plot the spectrum and second derivative
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
        
        maxind(tc) = en(mmind(i)+dum5-2);
        % Plot a line for the maximum position
%         line([maxind(tc) maxind(tc)],[-1 1],'LineWidth',2,'Color','b');
        tc = tc+1;
    else
        % check in a +/- 1 point area if there is any smaller value
        [dum6,dum7]=min(spec(mmind(i)-1:mmind(i)+1));
        
        minind(t2c) = en(mmind(i)+dum7-2);
        % Plot a line for the minimum position
%         line([minind(t2c) minind(t2c)],[-1 1],'LineWidth',2,'Color','r');
        t2c = t2c+1;
    end       
end

end