% YXC 2019-2-25
% subtract background from single spectra (polynomial 5 deg)
% using minima + straight line part (roughly)

function [energy,newspec] = subtract_single_spectra_bck(map,energy,spectra)

signal = spectra;

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
[maxi,mini] = gapmap_maxima_minima(ispec,iev,zcd,ispecdd,ievdd);

% avp = get_energy_index(map,maxi);
mini2 = get_energy_index(map,mini*1000);
% avpw = diff(mini2)/2;

bckgnd_index = [1:mini2(1)-1,mini2,mini2(end)+1:length(energy)];
% bckgnd_index = [1:mini2(1)-5,mini2,mini2(end)+4:length(energy)];
bck_E = energy(bckgnd_index);
bck_sig =signal(bckgnd_index)';

% figure,
%  plot(bck_E,bck_sig,'r.','MarkerSize',10)
%  hold on

p = polyfit(bck_E,bck_sig,5);
xx = linspace(energy(1),energy(end),200);
yy = polyval(p,xx);
%  plot(xx,yy,'k')

newsig = signal - polyval(p,energy)';

newspec = newsig;





