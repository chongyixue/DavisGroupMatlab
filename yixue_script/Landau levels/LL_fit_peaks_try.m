% YXC 2019-2-25 
% BST fit single dispersion LL

x = [-sqrt(1),0,sqrt(1),sqrt(2),sqrt(3),sqrt(4)];

% map = invert_map(obj_90225a00_G);
map = map3;
energy = map.e.*1000;
signal = map.ave;


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

avp = get_energy_index(map,maxi);
mini2 = get_energy_index(map,mini);
avpw = diff(mini2)/2;
clear x;clear y;clear y_new;
start = mini2(2);
stop = mini2(3);
x = energy(start:stop)';
y = signal(start:stop);
figure,plot(x,y,'k');
hold on
[y_new,p,gof] = lorentzian3(y,x);
plot(x,y_new,'r')
hold on

for iter = 1:10
    guess = [p.a,p.b,p.c,p.d,p.e,p.f,p.g];
    for k = 1:7
        if guess(k)<0
            low(k) = guess(k)*1.2;
            high(k) = guess(k)*0.8;
        else
            low(k) = guess(k)*0.8;
            high(k) = guess(k)*1.2;
        end
    end
    
    [y_new,p,gof] = lorentzian3(y,x,guess,low,high);
    p
    plot(x,y_new,'b')
    hold on
end
