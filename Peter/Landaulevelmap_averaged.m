function [llmap,llwmap,llamap,cbkg,lbkg,qbkg,qbkgc, llarea] = Landaulevelmap_averaged(data,avpmap,avpw,avpw2)

tic

map = data.map;
ev = data.e * 1000;
[nx,ny,nz] = size(map);
np = length(avpw);
llmap = zeros(nx,ny,np);
llwmap = zeros(nx,ny,np);
llamap = zeros(nx,ny,np);
cbkg = zeros(nx,ny,np);
lbkg = zeros(nx,ny,np);
qbkg = zeros(nx,ny,np);
qbkgc = zeros(nx,ny,np);
llarea = zeros(nx, ny, np);



%%

for i=1:nx
    for j=1:ny
        
        %generate random spectra out of the map FOR TESTING PURPOSES
%         rn = floor(nx*(random('unif', 0, 1, 1, 2)))+1;
%           i = rn(1);
%           j = rn(2);
%         spec = squeeze(map(i, j, :));
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
            
            
            avp(k) = squeeze(avpmap(i,j,k));
            
            [dum0,avp(k)]=min(abs(avp(k)-ev));
            
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

                    %%
                    % < 5 for linear background and < 7 for parabolic background
                    if length(sp) < 7
                        iev = linspace(en(1),en(end),7);
                        sp = interp1(en,sp,iev,'pchip');
                        sp = sp';
                        en = iev';
                    else
                        en = en';
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
%                     figure, plot(en,sp,'ko',en,y_new,'r','LineWidth',2)
%                     line([cm,cm],[min(sp),max(sp)],'LineWidth',2,'Color','b');
%                     line([cmc,cmc],[min(sp),max(sp)],'LineWidth',2,'Color','c');
%                     line([ffm,ffm],[min(sp),max(sp)],'LineWidth',2,'Color','r');
%                     line([p.c,p.c],[min(sp),max(sp)],'LineWidth',2,'Color','k');
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
%                         figure, plot(en, solopeak,'ro-','LineWidth',2)
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