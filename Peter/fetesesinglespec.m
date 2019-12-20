function [llpos,llwidth,llampl] = fetesesinglespec(spec,energy,avp,avpw)

tic

ev = energy;

np = length(avp);

llpos = zeros(np);
llwidth = zeros(np);
llampl = zeros(np);
cbkg = zeros(np);
lbkg = zeros(np);


        for k=1:np
            sp = spec(avp(k)-avpw(k):avp(k)+avpw(k));
            en = ev(avp(k)-avpw(k):avp(k)+avpw(k))';
 
            % < 5 for linear background and < 7 for parabolic background
            if length(sp) < 5
                iev = linspace(en(1),en(end),5);
                sp = interp1(en,sp,iev,'pchip');
                sp = sp';
                en = iev';
            end

            slp = (sp(end)-sp(1))/(en(end) - en(1));
            bkg = slp * en;
%             sp = sp';
            spl = sp - bkg;
            spl = spl + abs(min(spl));
%             figure, plot(en,sp,'r',en,spl,'k','LineWidth',2);
            cm = sum(sp.*en)/sum(sp);
            [maxsp,maxind] = max(spl);
            cmc = sum(spl.*en)/sum(spl);
            [dum1,enind] = min(abs(maxsp/2 -spl ));
            fwhmsp = 2*abs(maxind - enind);

            guess = [slp, maxsp, cmc, fwhmsp, min(sp)];
            if slp < 0 
                low = [2*slp,     0,    cmc-2*(en(2)-en(1)),  0,      0];
                upp = [-slp, 2*maxsp, cmc+2*(en(2)-en(1)), abs(en(end)-en(1)), max(sp)];
            elseif slp > 0
                low = [-slp,     0,    cmc-2*(en(2)-en(1)),  0,      0];
                upp = [2*slp, 2*maxsp, cmc+2*(en(2)-en(1)), abs(en(end)-en(1)), max(sp)];
            elseif slp == 0
                low = [-inf,     0,    cmc-2*(en(2)-en(1)),  0,      0];
                upp = [inf, 2*maxsp, cmc+2*(en(2)-en(1)), abs(en(end)-en(1)), max(sp)];
            end
            
            [y_new, p,gof]=fesetelorentzian(sp,en,guess,low,upp);
            figure, plot(en,sp,'ko',en,y_new,'r','LineWidth',2)
%             line([cm,cm],[min(sp),max(sp)],'LineWidth',2,'Color','b');
%             line([cmc,cmc],[min(sp),max(sp)],'LineWidth',2,'Color','k');
%             line([p.c,p.c],[min(sp),max(sp)],'LineWidth',2,'Color','r');
%             llmap(i,j,k) = cm;
            llpos(k) = p.c;
            llwidth(k) = p.d;
            llampl(k) = p.b;
            cbkg(k) = p.e;
            lbkg(k) = p.a;
            clear sp en cm navp;
            close all;
        end
        
        'a*x + b*(d/2)^2/((x-c)^2+(d/2)^2)+e + f*(x-g)^2';
        figure, plot(ev,spec,'ko','LineWidth',2)
        hold on
        for k=1:np
            peak1=llampl(k).*(llwidth(k)/2).^2./((ev(avp(k)-avpw(k):avp(k)+avpw(k))-llpos(k)).^2+(llwidth(k)/2).^2)+cbkg(k)+lbkg(k).*ev(avp(k)-avpw(k):avp(k)+avpw(k));
            plot(ev(avp(k)-avpw(k):avp(k)+avpw(k)),peak1,'r','LineWidth',2)
        test = 1;
        end
    
        hold off


toc


end