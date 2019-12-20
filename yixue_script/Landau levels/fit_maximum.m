% 2019-3-19 YXC
% BST fit maxima

function peaks = fit_maximum(map,pixx,pixy,varargin)

if nargin>3
    plott = 0;
else
    plott = 1;
end


energy = map.e.*1000;
signal = squeeze(map.map(pixy,pixx,:));

clear iev; clear ispec; 
iev = linspace(energy(1),energy(end),length(energy)*10);
ispec = interp1(energy,signal,iev,'pchip');
ispec = sgolayfilt(ispec,1,17);



[ispecd, ievd]=numderivative(ispec, iev);
[ispecdd, ievdd]=numderivative(ispecd, ievd);
zcd = findzerocrossings(ispecd,ievd);
% normalize the spectra and their derivatives to bring them all onto
% the same scale, mostly useful for plotting and checking the code
ispec = ispec/max(abs(ispec));
ispecd = ispecd/max(abs(ispecd));
ispecdd = ispecdd/max(abs(ispecdd));
%find all maxima and minima
[~,mini] = gapmap_maxima_minima2(ispec,iev,zcd,ispecdd,ievdd);

% mini = dip_checker(mini,iev,ispec);
Edguess = 140;
[indexleft,indexright] = leftright_index(mini,Edguess);

% or(indexleft < 1,indexright>length(mini))
if isempty(mini)==1
    indexleft = matching_index(iev,130);
    indexright = matching_index(iev,150);
    minileft = iev(indexleft);
    miniright = iev(indexright);
else
    minileft = mini(indexleft);
    miniright = mini(indexright);
    indexleft = matching_index(iev,mini(indexleft));
    indexright = matching_index(iev,mini(indexright));
end

[~,peaks_ind] = max(ispec(indexleft:indexright));
peaks = iev(peaks_ind+indexleft-1);

if plott == 1
    figure, plot(iev,ispec)
    hold on
    yrange = [min(0,min(ispec)), max(ispec)];
    
    plot([minileft,minileft],yrange,'r')
    plot([miniright,miniright],yrange,'r')
    hold on
    plot([peaks,peaks],yrange,'b')
end

end

function [indexleft,indexright] = leftright_index(list,value)
index = matching_index(list,value);
if value-list(index)>0
    indexleft = index;
    indexright = index+1;
else
    indexleft = index-1;
    indexright = index;
end
end
    
function index = matching_index(list,value)
[~,index] = min(abs(list-value));
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
