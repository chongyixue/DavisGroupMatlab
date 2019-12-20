function enind = findzerocrossings(data,en)
% findzerocrossings - finds the energy values enind at which a spectrum or
% a derivative of a spectrum crosses zero which can then be used to find
% maxima, minima and shoulders in a spectrum. - 06/09/2014 Peter Sprau
% data - spectrum or derivative of spectrum
% en - corresponding energy values
% enind - energy values of zero crossings in data


% because you cannot divide 0 by 0 without getting NaN-values I set dummy
% variable dum1 to the minimum of the spectrum/1000 or 10^-6, and add this
% to the data / spectrum
dum1 = min(abs(data));
if dum1 == 0
    dum1 = 1/1000;
end
dum1 = dum1/1000;
data = data+dum1;

% divide each data point by its absolute value, creating a vector full of
% ones and minus ones
ndata = data./abs(data);

% calculate the absolute value of the sum of adjacent energy points. If
% there is a zero crossing it will go from +1 to -1 or the other way round,
% and so the locations in the vector where a zero appears are the locations
% of zero crossings, otherwise it is 2
difdata = abs(ndata(2:end) + ndata(1:end-1));


% calculate the length of the vector difdata and its sum
ld = length(difdata);
sd = sum(difdata);
zcind = find(difdata==0);

% if there are any zero crossings in the data the sum sd will be less than
% ld*2 because of zeros in difdata

if sd < ld*2
    for i=1:length(zcind)
            enind(i) = (en(zcind(i)+1) + en(zcind(i)))/2;
    end
else
    enind = [];
end

% % if there are any zero crossings in the data the sum sd will be less than
% % ld*2 because of zeros in difdata, the number of zero crossings is
% % ld*2-sd/2, and since min only ever gives the first minimum, to find all
% % we loop through difdata using a for-loop
% if sd < ld*2
%     for i=1:(ld*2-sd)/2
%         if i==1
%             [dummy, zcind(i)] = min(difdata);
%             enind(i) = (en(zcind(i)+1) + en(zcind(i)))/2;
%         else
%             dumdif = difdata(zcind(i-1)+1:end);
%             [dummy, dind] = min(dumdif);
%             zcind(i) = dind + zcind(i-1);
%             % enind contains the energy values where the zero crossings
%             % occur, averaged over the two values where the data goes from
%             % a positive to a negative value or the other way around
%             enind(i) = (en(zcind(i)+1) + en(zcind(i)))/2;
%         end
%     end
% end

end