% 2019-2-26 YXC
% put constraints on returned peaks

function maxi = peak_checker(peaks,iev,ispec)

% figure,plot(iev,ispec)
% hold on
% plot(peaks,0,'r.')

% between 100 and 160mV contraint peak size to be > 0.4
subset = constrained_subset(peaks,100,160);
for k = 1:length(subset)
    signal = lookup(iev,ispec,subset(k));
    if signal<0.4
        peaks = remove_value(peaks,subset(k));
    end
end
maxi = peaks;

end


function subset = constrained_subset(set,low,upp)
test = set<upp & set > low;
subset = set(test);
end

function signal = lookup(xlist,ylist,xtarget)
division = 0.5*(xlist(2)-xlist(1));
[~,index] = find(xlist>xtarget-division & xlist<xtarget+division);
signal = ylist(index);
end

function filtered = remove_value(list,value)
dummylist = abs(list-value);
[~,index] = min(dummylist);
filtered = [list(1:index-1),list(index+1:end)];
end
