% 2019-6-10 YXC 
% given en and spec, assign list of startmV and endmV
% for LL

function [startmV,endmV] = assign_peakrange(en,spec,varargin)
startmV = [88,138,173,196,211];
endmV = [100,157,196,211,226];

% en_div = en(2)-en(1);

N = 1000;
enn = linspace(en(1),en(end),N);
specc = spline(en,spec,enn);

% enn_div = enn(2)-enn(1);

ref = diff(specc);
ref = ref/max(ref);

depth = 0;
trigger = 0.1;
if nargin>2
    for k = 1:length(varargin)
%         k
%         varargin{k}
        if isnumeric(varargin{k})==0
            figure,
            plot(enn,specc,'r.')
            hold on
            plot(enn(2:end),ref,'b')
        else
            trigger = varargin{k};
            depth = trigger(2);
            trigger = trigger(1);
        end
    end
        
end

state = -2;
LL = 1;
start_i = 0;
for i = 1:length(ref)
    if state == -2
        if ref(i)<trigger
            state = -1;
        end
    end
    if state == -1
        if ref(i)>trigger
            start_i = i;
            state = 0;
        end
    elseif state == 0
        if ref(i)< -trigger
            state = 1;
        end
    elseif state == 1
        if ref(i) > -trigger
            start_index = bring_backward(ref,start_i);
            startmV(LL) = enn(start_index)*1000;
            end_index = bring_forward(ref,i);
            endmV(LL) = enn(end_index)*1000;
            LL = LL + 1;
            state = -1;
        end
    end
end
% startmV
startmV(LL:end) = [];
endmV(LL:end) = [];
% startmV
% endmV
%now check that we have at least 4 data points for each peak

len = length(startmV);
for i = 1:len
    index = len+1-i;
    if find_index(en,endmV(index))-find_index(en,startmV(index)) <= 3
        startmV(index) = [];
        endmV(index) = [];
    end
end

if depth>500
    startmV = [en(1),en(7),en(10)]*1000;
    endmV = [en(3),en(10),en(14)]*1000;
end



%if empty set, lower trigger
if length(startmV)<2
    trigger = trigger/2;
    depth = depth+1;
    [startmV,endmV] = assign_peakrange(en,spec,[trigger,depth]);
end
end
function index =  find_index(en,mV)
mV = mV/1000;
[~,index] = min(abs(en-mV));
end

function index = bring_backward(ref,startindex)
stop = 0;
index = startindex;
while stop == 0
    index = index-1;
    if or(index<2,ref(index)<0)
        stop = 1;
    end
end
end
function index = bring_forward(ref,endindex)
stop2 = 0;
index = endindex;
while stop2 == 0
    index = index+1;
    if index+1>length(ref)
        stop2 = 1;
    elseif ref(index)>0
        stop2 = 1;
    end
end

end

