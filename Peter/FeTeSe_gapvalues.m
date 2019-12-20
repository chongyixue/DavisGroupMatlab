function gapvalues=FeTeSe_gapvalues(spec, egy)



%% calculate the numerical derivatives, add a "d" for every derivative
%% taken, so "specd" is the first derivative, "specdd" the second, and so
%% on...
[specd, egyd]=numderivative(spec, egy);
[specdd, egydd]=numderivative(specd, egyd);
[specddd, egyddd]=numderivative(specdd, egydd);
%% normalize the spectra and their derivatives to bring them all onto
%% the same scale
spec = spec/max(abs(spec));
specd = specd/max(abs(specd));
specdd = specdd/max(abs(specdd));
specddd = specddd/max(abs(specddd));
%% plot the spectrum and the derivatives
% figure, 
% plot(egy,spec,'k.-',egyd,specd,'r.-',egydd,specdd,'b.-',...
%     egyddd,specddd,'g.-')
%% find the maxima and minima of the average sepctrum, the first and second
%% derivative. "sel" determines how sensitive the algorithm is to picking
%% up extrema; the smaller the value of "sel" the more sensitive is the
%% peakfinder algorithm.
sel=(max(spec)-min(spec))/10;
[maxloc] = peakfinder(spec, sel, 0, 1);
[minloc] = peakfinder(spec, sel, 1, -1);

sel=(max(specd)-min(specd))/10;
[maxlocd] = peakfinder(specd, sel, 0, 1);
[minlocd] = peakfinder(specd, sel, 1, -1);

sel=(max(specdd)-min(specdd))/10;
[maxlocdd] = peakfinder(specdd, sel, 0, 1);
[minlocdd] = peakfinder(specdd, sel, 1, -1);
%% find the central minimum of the spectrum: "cmspec", and its index
%% cmind
im = abs( minloc - round(length(egy)/2) );
[minimum, minind] = min(im);
cmind = minloc(minind);
cmspec = egy( cmind );
clear im minimum minind;
%% find the coherence peak below "cpb" and above "cpa" 
%% the chemical potential
im = abs( maxloc - cmind );
[minimum, minind] = min(im);
im(minind) = length(egy);
[minimum2, minind2] = min(im);
if maxloc(minind) < maxloc(minind2)
        cpbind = maxloc(minind);
        cpb = egy(cpbind);
        cpaind = maxloc(minind2);
        cpa = egy(cpaind);
else
        cpbind = maxloc(minind2);
        cpb = egy(cpbind);
        cpaind = maxloc(minind);
        cpa = egy(cpaind);
end
clear im minimum minind minimum2 minind2;
%% find the steepest slope between the gap and the coherence peaks below 
%% "ssb" and above "ssa" the chemical potential
im = abs( maxlocd - cmind );
[minimum, minind] = min(im);
im2 = abs( minlocd - cmind );
[minimum2, minind2] = min(im2);
ssbind = minlocd(minind2);
ssb = egyd( ssbind );
ssaind = maxlocd(minind);
ssa = egyd( ssaind );
clear im im2 minimum minind minimum2 minind2;


%% write everything into a struct "gapvalues"
gapvalues.spec=spec;
gapvalues.egy=egy;
gapvalues.specd=specd;
gapvalues.egyd=egyd;
gapvalues.specdd=specdd;
gapvalues.egydd=egydd;
gapvalues.specddd=specddd;
gapvalues.egyddd=egyddd;
gapvalues.cmind=cmind;
gapvalues.cmspec=cmspec;
gapvalues.cpb=cpb;
gapvalues.cpbind=cpbind;
gapvalues.cpa=cpa;
gapvalues.cpaind=cpaind;
gapvalues.ssb=ssb;
gapvalues.ssbind=ssbind;
gapvalues.ssa=ssa;
gapvalues.ssaind=ssaind;
    
    
end