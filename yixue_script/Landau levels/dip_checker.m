% 2019-3-13 YXC
% put constraints on returned dips

function mini = dip_checker(dips,iev,ispec)
% figure,plot(iev,ispec)
% hold on
% plot(peaks,0,'r.')

if isempty(dips) == 1
    mini = 0;
else
    
    minimum1 = 100;
    for k = 1:length(dips)
        signal = lookup(iev,ispec,dips(k));
        if signal < minimum1
            minimum1 = signal;
        end
    end
    
    % between 100 and 160mV contraint peak size to be < 0.6
    subset = constrained_subset(dips,80,200);
    minimum = 100;
    for k = 1:length(subset)
        signal = lookup(iev,ispec,subset(k));
        if signal >0.1 + minimum1
            dips = remove_value(dips,subset(k));
        elseif signal < minimum
            minimum = signal;
        end
    end
    
    dips2 = dips;
    
    % check for minimum value, keep ones that are within 0.005 away from each other
    for k = 1:length(dips)
        signal = lookup(iev,ispec,dips(k));
        if signal - 0.005 > minimum
            dips2 = remove_value(dips2,dips(k));
        end
        mini = dips2;
        if isempty(dips2) == 1
            mini = 0;
        end
    end
end
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
