function [bkgmapfit,bkgmapint] = subtractbkgquick(data,avp,avpw)

tic

map = data.map;
[nx, ny, nz] = size(map);
bkgmapfit = zeros(nx,ny,nz);
bkgmapint = zeros(nx,ny,nz);
ev = data.e*1000;
ev = ev';
b = cat(1,ev(1:10),ev(18:66),ev(72),ev(82:96),...
    ev(110:114),ev(124:125),ev(132:133),ev(136));

for i=1:nx
    for j=1:ny
        avspec = squeeze(map(i,j,:));
        
        
%         for k=1:length(avp)
%             sp = avspec(avp(k)-avpw(k):avp(k)+avpw(k));
%             sp = sp + abs(min(sp));
%             [dum0,maxi] = max(sp);
%             navp = avp(k) - avpw(k) + maxi;
%             
%             sp = avspec(navp-avpw(k):navp+avpw(k));
%             sp = sp + abs(min(sp));
%             en = ev(navp-avpw(k):navp+avpw(k));
%             cm = sum(sp.*en)/sum(sp);
%             [dum1,dumind(k)] = min(abs(cm-en));
%             dumind(k) = dumind(k)+navp-avpw(k);
%             if k==1
%                 a = avspec(1:dumind(k)-avpw(k)-1);
%                 b = ev(1:dumind(k)-avpw(k)-1);
%             elseif k > 1 && k < length(avp) 
%                 a = cat(1,a,avspec(dumind(k-1)+avpw(k-1)+1 : dumind(k)-avpw(k)-1));
%                 b = cat(1,b,ev(dumind(k-1)+avpw(k-1)+1 : dumind(k)-avpw(k)-1));
%             elseif k == length(avp)
%                 a = cat(1,a,avspec(dumind(k-1)+avpw(k-1)+1 : dumind(k)-avpw(k)-1),...
%                     avspec(dumind(k)+avpw(k)+1 : end));
%                 b = cat(1,b,ev(dumind(k-1)+avpw(k-1)+1 : dumind(k)-avpw(k)-1),...
%                     ev(dumind(k)+avpw(k)+1 : end));
%             end
%         end
        
        
        aave = cat(1,avspec(1:9),avspec(48:66),...
            avspec(72),avspec(82:96),avspec(110:114),...
            avspec(124:125),avspec(132:133),avspec(136));
        bave = cat(1,ev(1:9),ev(48:66),ev(72),ev(82:96),...
        ev(110:114),ev(124:125),ev(132:133),ev(136));
%         figure, plot(bave,aave,'ko',b,a,'r+','LineWidth',2);
%         ag = sgolayfilt(a,0,15);

        ag = smooth(aave,5);
%         figure, plot(bave,aave,'k',bave,ag,'r');
        aint = interp1(bave,aave,ev,'linear','extrap');
        
        [aintd, evd]=numderivative(aint', ev');
        [aintdd, evdd]=numderivative(aintd, evd);
        [aintddd, evddd]=numderivative(aintdd, evdd);
        [aintdddd, evdddd]=numderivative(aintddd, evddd);
        [aintddddd, evddddd]=numderivative(aintdddd, evdddd);
        [aintdddddd, evdddddd]=numderivative(aintddddd, evddddd);
        
        g1 = mean(aint);
        g2 = mean(aintd);
        g3 = mean(aintdd);
        g4 = mean(aintddd);
        g5 = mean(aintdddd);
        g6 = mean(aintddddd);
        g7 = mean(aintdddddd);
        
        guess = [g1,g2,g3,0,0,g1,0,g4,0];
        low = [-inf,-inf,-inf,-inf,-inf,-inf,-inf,-inf,-inf];
        upp = [inf,inf,inf,inf,inf,inf,inf,inf,inf];
        

        [y_new, p,gof]=polynom4(aint,ev,guess,low,upp,ev);
        
%         figure, plot(ev,avspec,'ko',ev,aint,'r',ev,y_new,'b');
%         figure, plot(ev, avspec-aint,'r',ev,avspec-y_new,'b');
        test = 1;
        bkgmapfit(i,j,:) = avspec - y_new;
        bkgmapint(i,j,:) = avspec - aint;
    end
end


toc







end