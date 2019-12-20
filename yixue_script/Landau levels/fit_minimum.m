% 2019-3-13 YXC
% BST fit minima

function peaks = fit_minimum(map,pixx,pixy,varargin)

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

mini = dip_checker(mini,iev,ispec);
peaks = mean(mini);


if plott == 1
    figure, plot(iev,ispec)
    hold on
    yrange = [min(0,min(ispec)), max(ispec)];
    hold on
    signal = signal/max(abs(signal));
    plot(energy,signal,'r.','MarkerSize',10)
    title("Normalized spectrum at ("+num2str(pixx)+" ,"+num2str(pixy)+") Fitted Ed = "+num2str(peaks)+" mV")
    check_bad_spectra(map,pixx,pixy)
    
    for k = 1:length(mini)
        plot([mini(k),mini(k)],yrange,'r')
        hold on
    end
    plot([peaks,peaks],yrange,'b')
end

% if check_bad_spectra(map,pixx,pixy,3.6)==0
%     peaks = 0;
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
