% 2019-2-26 YXC
% BST fit single LL function (just selecting peak after background
% subtract)

function peaks = fit_single_spectrum(map,pixx,pixy,varargin)

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
[maxi,~] = gapmap_maxima_minima2(ispec,iev,zcd,ispecdd,ievdd);

maxi = peak_checker(maxi,iev,ispec);
peaks = maxi;

if plott == 1
    figure, plot(iev,ispec)
    hold on
    yrange = [min(ispec), max(ispec)];
    
    for k = 1:length(maxi)
        plot([maxi(k),maxi(k)],yrange,'r')
        hold on
    end
    
end

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
