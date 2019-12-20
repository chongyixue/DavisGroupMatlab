function [extind,minind,shoind] = gapmap_shoulder_prepare(spec,en,sdsp,sden,enind,fdsp,fden,eosm)
% gapmap_shoulder_prepare - finds all maxima and minima in the second
% derivative of the spectrum, and returns all extrema in one array as well
% as all minima in one array.
% eosm = energy of significant maximum used for cutoff in shoulders to test

% number of elements in the energy values where there is a zero crossing in
% the third derivative
% aenind = find(enind < eosm);
% le = length(aenind);
% enind = enind(aenind(1):aenind(end));
le = length(enind);
% counter variables
tc = 1;
t2c = 1;
t3c = 1;

% figure, plot(en,spec,'c.-',sden,sdsp,'k.-',fden,fdsp,'m.-')

% preallocate the two variables ddind and mmind, mmind is used for the energy
% values of maxima and minima, and ddind is used for the energy values of
% the maxima and minima position in the second derivative (so will be used
% to determine whether it's a maxima or minima)
mmind = zeros(le,1);
ddind = zeros(le,1);

% create empty arrays for indices of maxima and minima
maxind = [];
minind = [];
extind = [];
shoind = [];

for i=1:le
    % calculate the absolute value of the difference between the extrema value and the energy
    % values of the spectrum and its second derivative, the minimum of this
    % will give the energy position of the extrema in the spectrum and
    % second derivative
    dum1 = abs(sden - enind(i));
    dum2 = abs(fden - enind(i));
    [dum3, mmind(i)] = min(dum1);
    [dum3, ddind(i)] = min(dum2);
    % determine if the extremum is a maximum or minimum, and save the
    % corresponding energy value into maxind and minind
    if (ddind(i)+1) > length(fdsp)
        ddind(i) = length(fdsp)-1;
    end
    if fdsp(ddind(i)+1) < 0 
        % check in a +/- 1 point area if there is any bigger value
        [dum4,dum5]=max(sdsp(mmind(i)-1:mmind(i)+1));
        
        
        maxind(tc) = sden(mmind(i)+dum5-2);
%         line([maxind(tc) maxind(tc)],[-1 1],'LineWidth',2,'Color','b');
        tc = tc+1;
    else
        % check in a +/- 1 point area if there is any smaller value
        [dum6,dum7]=min(sdsp(mmind(i)-1:mmind(i)+1));
        
        minind(t2c) = sden(mmind(i)+dum7-2);
%         line([minind(t2c) minind(t2c)],[-1 1],'LineWidth',2,'Color','r');
        t2c = t2c+1;
        
        
        shouldind = find(minind(t2c-1) == en);
%         if spec(shouldind)>=0.1 && spec(shouldind) < 1
        if spec(shouldind)>=0.1 && abs(minind(t2c-1)) < abs(eosm) && spec(shouldind) < 1
            shoind(t3c) = minind(t2c-1);
%             line([shoind(t3c) shoind(t3c)],[-1 1],'LineWidth',2,'Color','c','Marker','p');
            t3c = t3c+1;
        end
        
    end       
end


extind = [maxind, minind];
extind = sort(extind);
test =1;






end