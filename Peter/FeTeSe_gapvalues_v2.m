function gapvalues=FeTeSe_gapvalues_v2(spec, ev, offset)

le = length(ev);

for j = 1:le
    if ev(j) == 0+offset
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
%     figure, 
%     plot(iev,ispec,'k.-',ievd,ispecd,'r.-',ievdd,ispecdd,'b.-')
%     legend('spec','1st der.','2nd der.')
    
 %% Calculate the energies of the zero crossings to find the maxima and minima 
    %% of spectra and derivatives
    zcd = findzerocrossings(ispecd,ievd);
    zcdd = findzerocrossings(ispecdd,ievdd);
    zcddd = findzerocrossings(ispecddd,ievddd);
    %% Find all the maxima and determine the closest significant one to the chem. pot.
    [maxi,mini] = gapmap_maxima_minima(ispec,iev,zcd,ispecdd,ievdd);
    
    [maxid,minid] = gapmap_maxima_minima_mod(ispecd,ievd,zcdd,ispecddd,ievddd);    
    
    [sigmax, impmax] = gapmap_max_min_select(ispec,iev,ispecd,ievd,maxi,mini,maxid,minid);
    
    %% just for test included will have to be changed into the energy for the actual first maximum
%     [test1, test2] = max(ispecb);
%     beosm = ievb(test2);
%     [test1, test2] = max(ispeca);
%     aeosm = ieva(test2);
    
    
    %% Find all the possible positions for shoulders between the chemical potential
    %% and the first significant peak value; saved into bshoind below shoulder indices
    %% and ashoind - above shoulder indices
    
    [extind,sdmin,shoind] = gapmap_shoulder_prepare(ispec,iev,ispecdd,ievdd,zcddd,ispecdddd,ievdddd,sigmax);

    sigsho = gapmap_shoulder_select(ispec,iev,sdmin,extind,ispecdd,ievdd,shoind,sigmax);
    

    %% find the steepest slope between the gap and the coherence peaks below 
    %% "ssb" and above "ssa" the chemical potential
    if zlayer == le
        [ta,ssind] = min(ispecd);
        ss = ievd( ssind );
    else
        [ta,ssind] = max(ispecd);
        ss = ievd( ssind );
    end
%%    
    
if isempty(impmax)
    impbel = 0;
else
    impbel = sort(impmax);
end

allbel = sort([sigsho, sigmax]);
allbelpeaks = sort(sigmax);


%% write everything into a struct "gapvalues"
gapvalues.spec=spec;
gapvalues.ev=ev;
gapvalues.ss=ss;
gapvalues.ssind=ssind;

if zlayer == le
    gapvalues.bemu = allbel(end);
    gapvalues.bemupeaks = allbelpeaks(end);
    gapvalues.impbemu = impbel(end);
else
    gapvalues.bemupeaks = allbelpeaks(1);
    gapvalues.bemu = allbel(1);
    gapvalues.impbemu = impbel(1);
end

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
%     figure, 
%     plot(ievb,ispecb,'k.-',ievbd,ispecbd,'r.-',ievbdd,ispecbdd,'b.-',...
%         ievbddd,ispecbddd,'m.-',ievbdddd,ispecbdddd,'c.-')
%     legend('spec','1st der.','2nd der.','3rd der.','4th der.')
%     
%     figure, 
%     plot(ieva,ispeca,'k.-',ievad,ispecad,'r.-',ievadd,ispecadd,'b.-',...
%         ievaddd,ispecaddd,'m.-',ievadddd,ispecadddd,'c.-')
%     legend('spec','1st der.','2nd der.','3rd der.','4th der.')
%     
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
    
    [bmaxid,bminid] = gapmap_maxima_minima_mod(ispecbd,ievbd,zcbdd,ispecbddd,ievbddd);    
    [amaxid,aminid] = gapmap_maxima_minima_mod(ispecad,ievad,zcadd,ispecaddd,ievaddd);
    
    [sigmaxb, impmaxb] = gapmap_max_min_select(ispecb,ievb,ispecbd,ievbd,bmaxi,bmini,bmaxid,bminid);
    [sigmaxa, impmaxa] = gapmap_max_min_select(ispeca,ieva,ispecad,ievad,amaxi,amini,amaxid,aminid);
    
    %% just for test included will have to be changed into the energy for the actual first maximum
%     [test1, test2] = max(ispecb);
%     beosm = ievb(test2);
%     [test1, test2] = max(ispeca);
%     aeosm = ieva(test2);
    
    
    %% Find all the possible positions for shoulders between the chemical potential
    %% and the first significant peak value; saved into bshoind below shoulder indices
    %% and ashoind - above shoulder indices
    
    [bextind,bsdmin,bshoind] = gapmap_shoulder_prepare(ispecb,ievb,ispecbdd,ievbdd,zcbddd,ispecbdddd,ievbdddd,sigmaxb);
    [aextind,asdmin,ashoind] = gapmap_shoulder_prepare(ispeca,ieva,ispecadd,ievadd,zcaddd,ispecadddd,ievadddd,sigmaxa);

    sigshob = gapmap_shoulder_select(ispecb,ievb,bsdmin,bextind,ispecbdd,ievbdd,bshoind,sigmaxb);
    sigshoa = gapmap_shoulder_select(ispeca,ieva,asdmin,aextind,ispecadd,ievadd,ashoind,sigmaxa);
    
   



    %% find the steepest slope between the gap and the coherence peaks below 
    %% "ssb" and above "ssa" the chemical potential
    [ta,ssbind] = min(ispecbd);
    ssb = ievbd( ssbind );
    [ta,ssaind] = max(ispecad);
    ssa = ievad( ssaind );
    
    %%
%     imievbd = [];
%     imispecbd = [];
%     if ~isempty(sigmaxb)==1
%         dum1 = find(ievbd > max(sigmaxb));
%         
%         dum2 = ievbd(dum1(1):dum1(end));
%         spdum = ispecbd(dum1(1):dum1(end));
%         
%         imievbd = ievbd(dum1(1):dum1(end));
%         imispecbd = ispecbd(dum1(1):dum1(end));
%     end
%     if ~isempty(sigshob)==1
%         dum3 = find(dum2 > max(sigshob));
%         clear imievbd imispecbd;
%         imievbd = dum2(dum3(1):dum3(end));
%         imispecbd = spdum(dum3(1):dum3(end));
%     end
%     imievad = [];
%     imispecad = [];
%     if ~isempty(sigmaxa)==1
%         dum4 = find(ievad < min(sigmaxa));
%         dum5 = ievad(dum4(1):dum4(end));
%         imievad = ievad(dum4(1):dum4(end));
%         imispecad = ispecad(dum4(1):dum4(end));
%     end
%     if ~isempty(sigshoa)==1
%         dum6 = find(dum5 < min(sigshoa));
%         clear imievad imispecad;
%         imievad = dum5(dum6(1):dum6(end));
%         imispecad = ispecad(dum6(1):dum6(end));
%     end
%     
%     if ~isempty(imispecbd)==1
%         [tac,cssbind] = min(imispecbd);
%         cssb = imievbd( cssbind );
%     end
%     if ~isempty(imispecad)==1
%         [tac,cssaind] = max(imispecad);
%         cssa = imievad( cssaind );
%     end
%     %% plot 
% figure, plot(ievb,ispecb,'k.-')
%     for m=1:length(sigmaxb)
%             line([sigmaxb(m) sigmaxb(m)],[0 1],'LineWidth',2,'Color','r');
%     end
%     for m=1:length(sigshob)
%             line([sigshob(m) sigshob(m)],[0 1],'LineWidth',2,'Color','b');
%     end
%     line([ssb ssb],[0 1],'LineWidth',2,'Color','g');
%     if ~isempty(imispecbd)==1
%         line([cssb cssb],[0 1],'LineWidth',2,'Color','m');
%     end
%     
%     figure, plot(ieva,ispeca,'k.-')
%     for m=1:length(sigmaxa)
%             line([sigmaxa(m) sigmaxa(m)],[0 1],'LineWidth',2,'Color','r');
%     end
%     for m=1:length(sigshoa)
%             line([sigshoa(m) sigshoa(m)],[0 1],'LineWidth',2,'Color','b');
%     end
%     line([ssa ssa],[0 1],'LineWidth',2,'Color','g');
%     if ~isempty(imispecad)==1
%         line([cssa cssa],[0 1],'LineWidth',2,'Color','m');
%     end
%%
if isempty(impmaxb)
    impbel = 0;
else
    impbel = sort(impmaxb);
end

if isempty(impmaxa)
    impabo = 0;
else
    impabo = sort(impmaxa);
end

allbel = sort([sigshob, sigmaxb]);
allbelpeaks = sort(sigmaxb);
allabo = sort([sigshoa, sigmaxa]);
allabopeaks = sort(sigmaxa);

%% write everything into a struct "gapvalues"
gapvalues.spec=spec;
gapvalues.ev=ev;
gapvalues.ssb=ssb;
gapvalues.ssbind=ssbind;
gapvalues.ssa=ssa;
gapvalues.ssaind=ssaind;
gapvalues.bemu = allbel(end);
gapvalues.abmu = allabo(1);
gapvalues.bemupeaks = allbelpeaks(end);
gapvalues.abmupeaks = allabopeaks(1);
gapvalues.impbemu = impbel(end);
gapvalues.impabmu = impabo(1);


end



    
    
end