function shostat=FeTeSe_gapvalues_initialize(spec, ev, shostatold)

le = length(ev);

for j = 1:le
    if ev(j) == 0
        zlayer = j;
    end
end

if zlayer==1 || zlayer == le
    %% calculate the numerical derivatives, add a "d" for every derivative
    %% taken, so "specd" is the first derivative, "specdd" the second, and so
    %% on...
    iev = linspace(ev(1),ev(le),le*10);
    ispec = interp1(ev,spec,iev,'pchip');
    
    [ispecd, ievd]=numderivative(ispec, iev);
    [ispecdd, ievdd]=numderivative(ispecd, ievd);
    [ispecddd, ievddd]=numderivative(ispecd, ievd);
    [ispecdddd, ievdddd]=numderivative(ispecd, ievd);
    %% normalize the spectra and their derivatives to bring them all onto
    %% the same scale, mostly useful for plotting and checking for errors in code
    ispec = ispec/max(abs(ispec));
    ispecd = ispecd/max(abs(ispecd));
    ispecdd = ispecdd/max(abs(ispecdd));

    %% plot the spectrum and the derivatives
    figure, 
    plot(iev,ispec,'k.-',ievd,ispecd,'r.-',ievdd,ispecdd,'b.-')
    legend('spec','1st der.','2nd der.')
else
    ievb = linspace(ev(1),ev(zlayer),zlayer*10);
    ispecb = interp1(ev(1:zlayer),spec(1:zlayer),ievb,'pchip');
    ieva = linspace(ev(zlayer),ev(end),(le-zlayer+1)*10);
    ispeca = interp1(ev(zlayer:end),spec(zlayer:end),ieva,'pchip');
    
    specb = spec(1:zlayer);
    evb = ev(1:zlayer);
    speca = spec(zlayer:end);
    eva = ev(zlayer:end);
    %% calculate the numerical derivatives, add a "d" for every derivative
    %% taken, so "specd" is the first derivative, "specdd" the second, and so
    %% on...
    [ispecbd, ievbd]=numderivative(ispecb, ievb);
    [ispecbdd, ievbdd]=numderivative(ispecbd, ievbd);
    [ispecbddd, ievbddd]=numderivative(ispecbdd, ievbdd);
    [ispecbdddd, ievbdddd]=numderivative(ispecbddd, ievbddd);
    
    [ispecad, ievad]=numderivative(ispeca, ieva);
    [ispecadd, ievadd]=numderivative(ispecad, ievad);
    [ispecaddd, ievaddd]=numderivative(ispecadd, ievadd);
    [ispecadddd, ievadddd]=numderivative(ispecaddd, ievaddd);
    %% normalize the spectra and their derivatives to bring them all onto
    %% the same scale, mostly useful for plotting and checking for errors in code
    ispecb = ispecb/max(abs(ispecb));
    ispecbd = ispecbd/max(abs(ispecbd));
    ispecbdd = ispecbdd/max(abs(ispecbdd));
    ispecbddd = ispecbddd/max(abs(ispecbddd));
    ispecbdddd = ispecbdddd/max(abs(ispecbdddd));
    
    ispeca = ispeca/max(abs(ispeca));
    ispecad = ispecad/max(abs(ispecad));
    ispecadd = ispecadd/max(abs(ispecadd));
    ispecaddd = ispecaddd/max(abs(ispecaddd));
    ispecadddd = ispecadddd/max(abs(ispecadddd));
    
    %% plot the spectrum and the derivatives
    figure, 
    plot(ievb,ispecb,'k.-',ievbd,ispecbd,'r.-',ievbdd,ispecbdd,'b.-',...
        ievbddd,ispecbddd,'m.-',ievbdddd,ispecbdddd,'c.-')
    legend('spec','1st der.','2nd der.','3rd der.','4th der.')
    
    figure, 
    plot(ieva,ispeca,'k.-',ievad,ispecad,'r.-',ievadd,ispecadd,'b.-',...
        ievaddd,ispecaddd,'m.-',ievadddd,ispecadddd,'c.-')
    legend('spec','1st der.','2nd der.','3rd der.','4th der.')
    
    %% Calculate the energies of the zero crossings to find the maxima and minima 
    %% of spectra and derivatives
    zcbd = findzerocrossings(ispecbd,ievbd);
    zcbdd = findzerocrossings(ispecbdd,ievbdd);

    zcad = findzerocrossings(ispecad,ievad);
    zcadd = findzerocrossings(ispecadd,ievadd);
    
    zcbddd = findzerocrossings(ispecbddd,ievbddd);
    zcaddd = findzerocrossings(ispecaddd,ievaddd);
    %% Find all the maxima and determine the closest significant one to the chem. pot.
    [bmaxi,bmini] = gapmap_maxima_minima(ispecb,ievb,zcbd,ispecbdd,ievbdd);
    [amaxi,amini] = gapmap_maxima_minima(ispeca,ieva,zcad,ispecadd,ievadd);
    
    close all
    
    [bmaxid,bminid] = gapmap_maxima_minima_mod(ispecbd,ievbd,zcbdd,ispecbddd,ievbddd);    
    [amaxid,aminid] = gapmap_maxima_minima_mod(ispecad,ievad,zcadd,ispecaddd,ievaddd);
    
    close all
    
    [sigmaxb, impmaxb] = gapmap_max_min_select(ispecb,ievb,ispecbd,ievbd,bmaxi,bmini,bmaxid,bminid);
    [sigmaxa, impmaxa] = gapmap_max_min_select(ispeca,ieva,ispecad,ievad,amaxi,amini,amaxid,aminid);
    
    close all
    
    %% Find all the possible positions for shoulders between the chemical potential
    %% and the first significant peak value; saved into bshoind below shoulder indices
    %% and ashoind - above shoulder indices
    
    [bextind,bsdmin,bshoind] = gapmap_shoulder_prepare_init(ispecb,ievb,ispecbdd,ievbdd,zcbddd,ispecbdddd,ievbdddd,sigmaxb);
    [aextind,asdmin,ashoind] = gapmap_shoulder_prepare_init(ispeca,ieva,ispecadd,ievadd,zcaddd,ispecadddd,ievadddd,sigmaxa);

    close all
    
    shostat = gapmap_shoulder_initialize(ispecb,ievb,bsdmin,bextind,ispecbdd,ievbdd,bshoind,shostatold);
    shostat = gapmap_shoulder_initialize(ispeca,ieva,asdmin,aextind,ispecadd,ievadd,ashoind,shostat);
    
    close all

end

    
    
end