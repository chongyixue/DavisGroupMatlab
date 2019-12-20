function [llmap,llwmap,llamap,cbkg,lbkg,qbkg,qbkgc, llarea] = Landaulevelmap(data,avp,avpw,avpw2)

tic

map = data.map;
ev = data.e * 1000;
[nx,ny,nz] = size(map);
np = length(avp);
llmap = zeros(nx,ny,np);
llwmap = zeros(nx,ny,np);
llamap = zeros(nx,ny,np);
cbkg = zeros(nx,ny,np);
lbkg = zeros(nx,ny,np);
qbkg = zeros(nx,ny,np);
qbkgc = zeros(nx,ny,np);
llarea = zeros(nx, ny, np);
erop = cell(length(avp));



%%

for i=1:nx
    for j=1:ny
        
        %generate random spectra out of the map FOR TESTING PURPOSES
%         rn = floor(nx*(random('unif', 0, 1, 1, 2)))+1;
%         spec = squeeze(map(rn(1), rn(2), :));
%% if one specific pixel needs to be tested
% i=38;
% j=5;
%%



        spec = squeeze(map(i,j,:));
        
        for k=1:np
            
            %% if one specific peak  needs to tested
%             k=5;
            
%             if k==7
%                 test = 1;
%             end
            %%
            dummy(1) = avp(k)-avpw2(k);
            dummy(2) = avp(k)+avpw2(k);
            if dummy(1) < 1
                dummy(1) = 1;
            end
            if dummy(2) > length(ev)
                dummy(2) = length(ev);
            end
            en = ev(dummy(1) : dummy(2));
            sp = spec(dummy(1) : dummy(2));
            clear dummy
            
                           
%             sp = spec(avp(k)-avpw(k):avp(k)+avpw(k));
%             en = ev(avp(k)-avpw(k):avp(k)+avpw(k));
            %%
                iev = linspace(en(1),en(end),length(en)*10);
                ispec = interp1(en,sp,iev,'pchip');
                ispec = sgolayfilt(ispec,1,17);
    
                [ispecd, ievd]=numderivative(ispec, iev);
                [ispecdd, ievdd]=numderivative(ispecd, ievd);

                %% normalize the spectra and their derivatives to bring them all onto
                %% the same scale, mostly useful for plotting and checking the code
                ispec = ispec/max(abs(ispec));
                ispecd = ispecd/max(abs(ispecd));
                ispecdd = ispecdd/max(abs(ispecdd));

                
             %% Calculate the energies of the zero crossings to find the maxima and minima 
                %% of spectra and derivatives
                zcd = findzerocrossings(ispecd,ievd);

%                 figure, plot(iev, ispec, 'k-', en, sp, 'ro')
                %% check if it is a faulty pixel due to spectrum overload
                if std(sp) < 10^-2
                
                    llmap(i,j,k) = 0;
                    llwmap(i,j,k) = 0;
                    llamap(i,j,k) = 0;
                    cbkg(i,j,k) = 0;
                    lbkg(i,j,k) = 0;
                    qbkg(i,j,k) = 0;
                    qbkgc(i,j,k) = 0;
                    llarea(i, j, k) = 0;
                
                else
                    %% Find all the maxima and minima
                    [maxi,mini] = gapmap_maxima_minima(ispec,iev,zcd,ispecdd,ievdd);

                    if length(mini) == 2
                       [dum0,bp]=min(abs(mini(1)-en));

                       [dum0,ep]=min(abs(mini(2)-en));

                       ul = mean(en) + (en(2)-en(1));
                       ll = mean(en) - (en(2)-en(1));

                       cru = (en(bp) - ul)/abs(en(bp) - ul)+(en(ep) - ul)/abs(en(ep) - ul);
                       crl = (en(bp) - ll)/abs(en(bp) - ll)+(en(ep) - ll)/abs(en(ep) - ll);

    %                    if en(bp) > mean(en) && en(ep) > mean(en)
                        if cru == -2 || crl == 2 || isnan(cru)==1 || isnan(crl)==1
                           [dum0,mp]=min(abs(mini(1)-en));

                        if length(maxi) >= 1
                            for m=1:length(maxi)
                                maxid(m) = find(iev == maxi(m));
                            end

                             [dum0,dum0ind] = min(abs(maxi-mean(en))./(ispec(maxid)-min(ispec)));
    %                         if maxi(dum0ind) - en(mp) > 0
                                [dum1,dum1ind]=min(abs(maxi(dum0ind)-en));
                                bp = dum1ind - abs(dum1ind-mp);
                                ep = dum1ind + abs(dum1ind-mp);
    %                             ep = mp + 2* abs(mp-round(length(en)/2));
    %                         else
    %                             ep = mp;
    %                             bp = mp - 2* abs(mp-round(length(en)/2));
    %                         end
                        else
                            if mean(en) - en(mp) > 0
                                bp = mp;
                                ep = mp + 2* abs(mp-round(length(en)/2));
                            else
                                ep = mp;
                                bp = mp - 2* abs(mp-round(length(en)/2));
                            end
                        end


                        if ep < bp
                           imep = bp;
                           bp = ep;
                           ep = imep;
                       end

                        tbp = avp(k)-avpw(k)+bp-1;
                        tep = avp(k)-avpw(k)+ep-1;

                        if tbp > 1
                            tbp = tbp-1;
                        elseif tbp < 1
                            tbp = 1;
                        end
                        if tep < length(ev)
                            tep = tep+1;
                        elseif tep > length(ev)
                            tep = length(ev);
                        end

                           nen = ev(tbp:tep);
                           nsp = spec(tbp:tep);

    %                     nen = en(bp:ep);
    %                     nsp = sp(bp:ep);
    %                    figure, plot(nen,nsp)
                       else
                            tbp = avp(k)-avpw(k)+bp-1;
                            tep = avp(k)-avpw(k)+ep-1;

                            if tbp > 1
                                tbp = tbp-1;
                            elseif tbp < 1
                                tbp = 1;
                            end
                            if tep < length(ev)
                                tep = tep+1;
                            elseif tep > length(ev)
                                tep = length(ev);
                            end

                           nen = ev(tbp:tep);
                           nsp = spec(tbp:tep);

        %                    figure, plot(nen,nsp)
%%                      05/04/2016 taken out because can cause crashes
%                            if length(nen) < length(ev(avp(k)-avpw2(k):avp(k)+avpw2(k))) && i > 1 && j > 1
%                                if ~isempty(erop{k})
%                                     dummy =   erop{k};
%                                     tbp = dummy(1);
%                                     tep = dummy(2);
%                                     nen = ev(tbp:tep);
%                                     nsp = spec(tbp:tep);
%                                     clear dummy
%                                else
%                                     nen = ev(avp(k)-avpw2(k):avp(k)+avpw2(k));
%                                     nsp = spec(avp(k)-avpw2(k):avp(k)+avpw2(k));
%                                end
%                            end
                           
                           
                           
                           
%%                           
                        end
                        
                       if length(nen) < length(ev(avp(k)-avpw2(k):avp(k)+avpw2(k))) 
                           
                                dummy(1) = round( mean([tbp, tep]) ) - avpw2(k);
                                dummy(2) = round( mean([tbp, tep]) ) + avpw2(k);
                                if dummy(1) < 1
                                    dummy(1) = 1;
                                end
                                if dummy(2) > length(ev)
                                    dummy(2) = length(ev);
                                end
                                nen = ev(dummy(1) : dummy(2));
                                nsp = spec(dummy(1) : dummy(2));
                                clear dummy
                                
                       end
                       test=1;



                    elseif length(mini) == 0
                        %% 05/04/2016 if-structure taken out because it causes crashes
%                         if ~isempty(erop{k})
%                            dummy =   erop{k};
%                            tbp = dummy(1);
%                            tep = dummy(2);
%                            nen = ev(tbp:tep);
%                            nsp = spec(tbp:tep);
%                            clear dummy
%                         else
                       if length(maxi) >= 1

                            for m=1:length(maxi)
                                maxid(m) = find(iev == maxi(m));
                            end

                             [dum0,dum0ind] = min(abs(maxi-mean(en))./(ispec(maxid)-min(ispec)));
    %                         
                                [dum1,dum1ind]=min(abs(maxi(dum0ind)-en));
                                bp = dum1ind - avpw2(k);
                                ep = dum1ind + avpw2(k);
                                dummy(1) = avp(k)-avpw(k)+bp-1;
                                dummy(2) = avp(k)-avpw(k)+ep-1;
    %                         
                       else
                       
                            dummy(1) = avp(k)-avpw2(k);
                            dummy(2) = avp(k)+avpw2(k);
                       end
                            if dummy(1) < 1
                                dummy(1) = 1;
                            end
                            if dummy(2) > length(ev)
                                dummy(2) = length(ev);
                            end

                            nen = ev(dummy(1):dummy(2));
                            nsp = spec(dummy(1):dummy(2));

                            tbp = dummy(1);
                            tep = dummy(2);
                            clear dummy;

                    elseif length(mini) == 1
                        [dum0,mp]=min(abs(mini(1)-en));

                        if length(maxi) >= 1

                            for m=1:length(maxi)
                                maxid(m) = find(iev == maxi(m));
                            end

                             [dum0,dum0ind] = min(abs(maxi-mean(en))./(ispec(maxid)-min(ispec)));
    %                         if maxi(dum0ind) - en(mp) > 0
                                [dum1,dum1ind]=min(abs(maxi(dum0ind)-en));
                                bp = dum1ind - abs(dum1ind-mp);
                                ep = dum1ind + abs(dum1ind-mp);
    %                             ep = mp + 2* abs(mp-round(length(en)/2));
    %                         else
    %                             ep = mp;
    %                             bp = mp - 2* abs(mp-round(length(en)/2));
    %                         end
                        else
                            if mean(en) - en(mp) > 0
                                bp = mp;
                                ep = mp + 2* abs(mp-round(length(en)/2));
                            else
                                ep = mp;
                                bp = mp - 2* abs(mp-round(length(en)/2));
                            end
                        end


                        if ep < bp
                           imep = bp;
                           bp = ep;
                           ep = imep;
                       end

                        tbp = avp(k)-avpw(k)+bp-1;
                        tep = avp(k)-avpw(k)+ep-1;

                        if tbp > 1
                            tbp = tbp-1;
                        elseif tbp < 1
                            tbp = 1;
                        end
                        if tep < length(ev)
                            tep = tep+1;
                        elseif tep > length(ev)
                            tep = length(ev);
                        end

                           nen = ev(tbp:tep);
                           nsp = spec(tbp:tep);

                           if length(nen) < length(ev(avp(k)-avpw2(k):avp(k)+avpw2(k))) 
                           
                                dummy(1) = round( mean([tbp, tep]) ) - avpw2(k);
                                dummy(2) = round( mean([tbp, tep]) ) + avpw2(k);
                                if dummy(1) < 1
                                    dummy(1) = 1;
                                end
                                if dummy(2) > length(ev)
                                    dummy(2) = length(ev);
                                end
                                nen = ev(dummy(1) : dummy(2));
                                nsp = spec(dummy(1) : dummy(2));
                                clear dummy
                                
                            end
                           
    %                     nen = en(bp:ep);
    %                     nsp = sp(bp:ep);

                    elseif length(mini) > 2


                        for q=1 : length(mini)
                            ims(q) = find(ievdd == mini(q));

                        end

    %                     if i==1 && j==16 && k==3
    %                         test=1;
    %                     end
                        [dummy1,dummy2] = max(ispecdd(ims));
                        ispecdd(ims(dummy2)) = ispecdd(ims(dummy2)) - dummy1;
                        [dummy3,dummy4] = max(ispecdd(ims));

                        clear ims;

                        [dum0,bp]=min(abs(mini(dummy2)-en));
    %                    i
    %                    j
    %                    k
                       [dum0,ep]=min(abs(mini(dummy4)-en));

                       clear dummy1 dummy2 dummy3 dummy4;
                       if ep < bp
                           imep = bp;
                           bp = ep;
                           ep = imep;
                       end

                       ul = mean(en) + (en(2)-en(1));
                       ll = mean(en) - (en(2)-en(1));

                       cru = (en(bp) - ul)/abs(en(bp) - ul)+(en(ep) - ul)/abs(en(ep) - ul);
                       crl = (en(bp) - ll)/abs(en(bp) - ll)+(en(ep) - ll)/abs(en(ep) - ll);

                       test =1;
    %                    if en(bp) > mean(en) && en(ep) > mean(en)
                        if cru == -2 || crl == 2 || isnan(cru)==1 || isnan(crl)==1
                           [dum0,mp]=min(abs(mini(1)-en));

                        if length(maxi) >= 1

                               for m=1:length(maxi)
                                maxid(m) = find(iev == maxi(m));
                               end

                            [dum0,dum0ind] = min(abs(maxi-mean(en))./(ispec(maxid)-min(ispec)));
        %                         if maxi(dum0ind) - en(mp) > 0
                                    [dum1,dum1ind]=min(abs(maxi(dum0ind)-en));
                                    bp = dum1ind - abs(dum1ind-mp);
                                    ep = dum1ind + abs(dum1ind-mp);
        %                             ep = mp + 2* abs(mp-round(length(en)/2));
        %                         else
        %                             ep = mp;
        %                             bp = mp - 2* abs(mp-round(length(en)/2));
        %                         end
                            else
                                if mean(en) - en(mp) > 0
                                    bp = mp;
                                    ep = mp + 2* abs(mp-round(length(en)/2));
                                else
                                    ep = mp;
                                    bp = mp - 2* abs(mp-round(length(en)/2));
                                end
                            end


                            if ep < bp
                               imep = bp;
                               bp = ep;
                               ep = imep;
                           end

                            tbp = avp(k)-avpw(k)+bp-1;
                            tep = avp(k)-avpw(k)+ep-1;

                            if tbp > 1
                                tbp = tbp-1;
                            elseif tbp < 1
                                tbp = 1;
                            end
                            if tep < length(ev)
                                tep = tep+1;
                            elseif tep > length(ev)
                                tep = length(ev);
                            end

                               nen = ev(tbp:tep);
                               nsp = spec(tbp:tep);
                       else

                            tbp = avp(k)-avpw(k)+bp-1;
                            tep = avp(k)-avpw(k)+ep-1;

                            if tbp > 1
                                tbp = tbp-1;
                            elseif tbp < 1
                                tbp = 1;
                            end
                            if tep < length(ev)
                                tep = tep+1;
                            elseif tep > length(ev)
                                tep = length(ev);
                            end

                           nen = ev(tbp:tep);
                           nsp = spec(tbp:tep);

                           %% 05/04/2016 taken out because it can can cause crashes for the averaged data
%                            if length(nen) < length(ev(avp(k)-avpw2(k):avp(k)+avpw2(k))) && i > 1 && j > 1
%                                if ~isempty(erop{k})
%                                     dummy =   erop{k};
%                                     tbp = dummy(1);
%                                     tep = dummy(2);
%                                     nen = ev(tbp:tep);
%                                     nsp = spec(tbp:tep);
%                                else
%                                    nen = ev(avp(k)-avpw2(k):avp(k)+avpw2(k));
%                                     nsp = spec(avp(k)-avpw2(k):avp(k)+avpw2(k));
%                                end
%                            end
                           if length(nen) < length(ev(avp(k)-avpw2(k):avp(k)+avpw2(k))) 
                           
                                dummy(1) = round( mean([tbp, tep]) ) - avpw2(k);
                                dummy(2) = round( mean([tbp, tep]) ) + avpw2(k);
                                if dummy(1) < 1
                                    dummy(1) = 1;
                                end
                                if dummy(2) > length(ev)
                                    dummy(2) = length(ev);
                                end
                                nen = ev(dummy(1) : dummy(2));
                                nsp = spec(dummy(1) : dummy(2));
                                clear dummy
                                
                          end
                           
                           
                           
                           end
        %                    nen = en(bp:ep);
        %                    nsp = sp(bp:ep);

                    end

    %                 tbp = avp(k)-avpw(k)+bp;
    %                 tep = avp(k)-avpw(k)+ep;
                    erop{k} = [tbp,tep];
                    clear maxid mini maxi;

%                     figure, plot(en,sp,'ko',nen,nsp,'r','LineWidth',2);
                    test=1;

                    sp = nsp;
                    en = nen';
        %%

    %             iev = linspace(en(1),en(end),length(en)*10);
    %             ispec = interp1(en,sp,iev,'pchip');
    %     
    %             [ispecd, ievd]=numderivative(ispec, iev);
    %             [ispecdd, ievdd]=numderivative(ispecd, ievd);
    %             zcd = findzerocrossings(ispecd,ievd);
    %             
    %             if isempty(zcd)==1
    %                 [dum0,dum0ind]=min(abs(ispecd));
    %                 pmp = ievd(dum0ind);
    %             end
    %             [dum1,dum1ind] = min(abs(pmp-ievdd));
    %             if ispecdd(dum1ind) < 0
    %                 [dum2,maxi] =  min(abs(pmp-ievdd));
    %             end

    %             sp = sp + abs(min(sp));

    %% rough alignment
    %             slp = (sp(end)-sp(1))/(en(end) - en(1));
    %             [ispecd, ievd]=numderivative(sp',en');
    %             slp = mean(ispecd);
    %             bkg = slp * en;
    %             spl = sp' - bkg;
    % %             figure, plot(en,sp,'r',en,spl,'k','LineWidth',2);
    %             
    %             [dum0,maxi] = max(spl);
    %             navp = avp(k) - avpw(k) + maxi;
    %             
    %             
    %             stpt = navp-avpw(k);
    %             if stpt < 1
    %                 stpt = 1;
    %             end
    %             edpt = navp+avpw(k);
    %             if edpt > nz
    %                 edpt = nz;
    %             end
    %             
    %             sp = spec(stpt:edpt);
    %             sp = sp + abs(min(sp));
    %             en = ev(stpt:edpt)';
                %%
                % < 5 for linear background and < 7 for parabolic background
                if length(sp) < 7
                    iev = linspace(en(1),en(end),7);
                    sp = interp1(en,sp,iev,'pchip');
                    sp = sp';
                    en = iev';
                end

                slp = (sp(end)-sp(1))/(en(end) - en(1));
                bkg = slp * en;
                spl = sp - bkg;
                spl = spl + abs(min(spl));
    %             figure, plot(en,sp,'r',en,spl,'k','LineWidth',2);
                cm = sum(sp.*en)/sum(sp);
                [maxsp,maxind] = max(spl);
                cmc = sum(spl.*en)/sum(spl);
                [dum1,enind] = min(abs(maxsp/2 -spl ));
                fwhmsp = 2*abs(maxind - enind);

                guess = [slp, maxsp, cmc, fwhmsp, min(sp),0.1*maxsp,cmc];
                if slp < 0 
                    dumlow = 2*slp; 
                    dumup = -slp;
                    low = [dumlow,     0,    cmc-2*(en(2)-en(1)),  0,      min(sp), 0.5*dumlow, 0];
                    upp = [dumup, 2*maxsp, cmc+2*(en(2)-en(1)), abs(en(end)-en(1)), max(sp), 0.5*dumup, en(end)];
                elseif slp > 0
                    dumlow = -slp; 
                    dumup = 2*slp;
                    low = [dumlow,     0,    cmc-2*(en(2)-en(1)),  0,      min(sp), 0.5*dumlow, 0];
                    upp = [dumup, 2*maxsp, cmc+2*(en(2)-en(1)), abs(en(end)-en(1)), max(sp), 0.5*dumup, en(end)];
                elseif abs(slp) == 0
                     
                    low = [-1000,     0,    cmc-2*(en(2)-en(1)),  0,      min(sp), -500, 0];
                    upp = [1000, 2*maxsp, cmc+2*(en(2)-en(1)), abs(en(end)-en(1)), max(sp), 500, en(end)];
                end

                if ~isempty(find((low-upp)==0)) || ~isempty(find((upp-low)<=5*10^-8))
                    llmap(i,j,k) = 0;
                    llwmap(i,j,k) = 0;
                    llamap(i,j,k) = 0;
                    cbkg(i,j,k) = 0;
                    lbkg(i,j,k) = 0;
                    qbkg(i,j,k) = 0;
                    qbkgc(i,j,k) = 0;
                    llarea(i, j, k) = 0;
                else
                    i
                    j
                    k
                    slp
                   
                    toc
                    [y_new, p,gof]=lorentzian2(sp,en,guess,low,upp);
%                 figure, plot(en,sp,'ko',en,y_new,'r','LineWidth',2)
%                 line([cm,cm],[min(sp),max(sp)],'LineWidth',2,'Color','b');
%                 line([cmc,cmc],[min(sp),max(sp)],'LineWidth',2,'Color','k');
%                 line([p.c,p.c],[min(sp),max(sp)],'LineWidth',2,'Color','r');
    %             llmap(i,j,k) = cmc;
    %% use first fit to refine energy range for peak and fit again
    ffm = p.c;
                
                    [dum1,dum1ind]=min(abs(p.c - ev));
                                
                       %% not sure if I should use avpw2 or avpw > avpw2
                    dummy(1) = dum1ind - avpw(k);
                    dummy(2) = dum1ind + avpw(k);

                    if dummy(1) < 1
                       dummy(1) = 1;
                    end
                    if dummy(2) > length(ev)
                       dummy(2) = length(ev);
                    end

                    nen = ev(dummy(1):dummy(2));
                    nsp = spec(dummy(1):dummy(2));
                    sp = nsp;
                    en = nen';
                    
                    clear dummy;
                            
                    if length(sp) < 7
                        iev = linspace(en(1),en(end),7);
                        sp = interp1(en,sp,iev,'pchip');
                        sp = sp';
                        en = iev';
                    end
                    
                guess = [p.a, p.b, p.c, p.d, p.e, p.f, p.g];
                [y_new, p,gof]=lorentzian2(sp,en,guess,low,upp);
%                 figure, plot(en,sp,'ko',en,y_new,'r','LineWidth',2)
%                 line([cm,cm],[min(sp),max(sp)],'LineWidth',2,'Color','b');
%                 line([cmc,cmc],[min(sp),max(sp)],'LineWidth',2,'Color','c');
%                 line([ffm,ffm],[min(sp),max(sp)],'LineWidth',2,'Color','r');
%                 line([p.c,p.c],[min(sp),max(sp)],'LineWidth',2,'Color','k');
    %%
                    llmap(i,j,k) = p.c;
                    llwmap(i,j,k) = p.d;
                    llamap(i,j,k) = p.b;
                    cbkg(i,j,k) = p.e;
                    lbkg(i,j,k) = p.a;
                    qbkg(i,j,k) = p.f;
                    qbkgc(i,j,k) = p.g;

                    %%
                    for dk=1:length(en)
                        solopeak(dk)=p.b*(p.d/2)^2/((en(dk)-p.c)^2+(p.d/2)^2);
                    end
                    solopeak = solopeak';
%                     figure, plot(en, solopeak,'ro-','LineWidth',2)
                    llarea(i,j,k) = trapz(en,solopeak);
                    clear solopeak;
                    test = 1;
                    %%

                end
                clear sp en cm navp slp;
                close all;
                end
        end  
    end
end


toc


end