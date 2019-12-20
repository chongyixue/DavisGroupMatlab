function PS_fa_peaks(data)

map = data.map;
ev= (data.e);
[nx, ny, nz] = size(map);

%generate random spectra out of the map
rn = floor(nx*(random('unif', 0, 1, 1, 2)));
spec(1:nz) = map(rn(1), rn(2), :);

[specd, evd]=numderivative(spec, ev);
[specdd, evdd]=numderivative(specd, evd);
[specddd, evddd]=numderivative(specdd, evdd);


figure, plot(ev, data.ave/max(data.ave),ev, spec/max(spec), evd, specd/max(specd), evdd,...
    specdd/max(specdd), evddd, specddd/max(specddd),'LineWidth',2)
legend('avespec','spec', 'specd', 'specdd', 'specdd');
sel=(max(spec)-min(spec))/10;
[maxloc] = peakfinder(spec, sel, 0, 1);
[minloc] = peakfinder(spec, sel, 1, -1);












end