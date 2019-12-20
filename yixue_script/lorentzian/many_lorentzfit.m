% 2019-6-11 YXC fit many Lorentzian using assign_peakrange to cutup spectra
% 7 outputs

function [peakenergy,enn,yfit,p,err,auto_startmV,auto_endmV] = many_lorentzfit(en,spec,background,varargin)
% output for p is a matrix where each row represents each fitted peak
% and each column: parameter P(1) to P(7)
% such that p(3,6) is the P(6) parameter of the 3rd peak fitted

fit = 1;
if nargin>3
    plott = 1;
else
    plott = 0;
end

maxx = max(spec);
minn = min(spec);

if background == 0
    background = linspace(0,0,length(en));
elseif background == 1
    %splinefit 3 points
    [~,middle] = min(spec);
    if middle == 1
        [~,middle] = min(spec(10:end-10));
        middle = middle + 9;
    end
    last = length(spec);
    if or(middle == last,middle == 1)
        middle = round(last/2);
    end
    background = spline([en(1),en(middle),en(end)],[spec(1),spec(middle),spec(end)],en);
elseif background == 2
    %splinefit minima plus a few points
    fit = 0;
    [startmV,endmV] = assign_peakrange(en,spec);
    indexlist = add_index(en,[startmV,endmV],[1,2,3,length(en)]);
    background = spline(en(indexlist),spec(indexlist),en);
    if plott == 0
        [peakenergy,enn,yfit,p,err,auto_startmV,auto_endmV] = many_lorentzfit(en,spec,background);
    else
        [peakenergy,enn,yfit,p,err,auto_startmV,auto_endmV] = many_lorentzfit(en,spec,background,'plot');
    end
end

if fit~=0
    
    spec = spec-background;
    
    enn = linspace(en(1),en(end),4000);
    div = enn(2)-enn(1);
    specc = spline(en,spec,enn);
    ref = diff(specc)/(div*100);
    ref = ref/max(ref);
    
    %plotting the diff
%     if plott == 1
% %         figure,plot(en,spec);
% %         hold on
% %         plot(enn,specc);
% %         plot(enn(2:end),ref);
%     end

    if plott == 1
        figure,
        plot(en,spec+background,'r.');
        hold on
    end
    
    [auto_startmV,auto_endmV] = assign_peakrange(en,spec);
    p = zeros(length(auto_endmV),6);
    err = auto_endmV';
    for ii = 1:length(auto_endmV)
        
        startmV = auto_startmV(ii);
        endmV = auto_endmV(ii);
        [~,pp,errr] = single_lorentzfit(en,spec,startmV,endmV);
        if plott == 1
%             plot(en,spec+background,'r.');
%             hold on
            plot(en,background,'k');
            hold on
            plot([pp(2), pp(2)],[minn,maxx],'m--');
            hold on
        end
        enn = linspace(startmV/1000,endmV/1000,200);
        yfit = pp(5)+enn.*pp(6)+pp(1)./(pp(3)+(enn-pp(2)).^2)+pp(4);
        if plott == 1
            bkgnd = spline(en,background,enn);
            plot(enn,yfit+bkgnd,'b');
            hold on
            plot(enn,bkgnd,'k');
            hold on
        end
        p(ii,:) = pp;
        peakenergy(ii) = pp(2)*1000;
        err(ii) = errr;
    end
end

end
function index = en_index(en,energy_mV)
new = abs(en*1000-energy_mV);
[~,index] = min(new);
end

function index_list = add_index(en,energylist,index_list)
addlist = energylist;
for i = 1:length(energylist)
    addlist(i) = en_index(en,energylist(i));
end
index_list = [index_list,addlist];
index_list = remove_duplicate(sort(index_list));
end

function newlist = remove_duplicate(lst)
newlist = lst;
len = length(lst);
for i = 1:len-1
    index = len+1-i;
    if lst(index)==lst(index-1)
        newlist(index) = [];
    end
end
end



