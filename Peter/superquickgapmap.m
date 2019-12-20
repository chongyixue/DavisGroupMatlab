function [gapmapave, gapmapa, gapmapb, ssmapave, dosmapave] = superquickgapmap(data)

ev = data.e;
map = data.map;

le = length(ev);

for j = 1:le
    if ev(j) == 0
        zlayer = j;
    end
end


evb = ev(1:zlayer);
eva = ev(zlayer:end);


ievb = linspace(ev(1),ev(zlayer),zlayer*10);
ieva = linspace(ev(zlayer),ev(end),(le-zlayer+1)*10);

[nx,ny,nz] = size(map);

%maximum peak
gapmapb = zeros(nx, ny, 1);
gapmapa = zeros(nx, ny, 1);
gapmapave = zeros(nx, ny, 1);

% maximum slope
ssmapb = zeros(nx, ny, 1);
ssmapa = zeros(nx, ny, 1);
ssmapave = zeros(nx, ny, 1);

% certain value of ldos
dosmapb = zeros(nx, ny, 1);
dosmapa = zeros(nx, ny, 1);
dosmapave = zeros(nx, ny, 1);

for i=1:nx
    for j=1:ny
        specb = squeeze(map(i,j,1:zlayer));
        speca = squeeze(map(i,j,zlayer:end));
        ispecb = interp1(ev(1:zlayer),specb,ievb,'pchip');
        ispeca = interp1(ev(zlayer:end),speca,ieva,'pchip');
        
        [ispecbd, ievbd]=numderivative(ispecb, ievb);
        [ispecbdd, ievbdd]=numderivative(ispecbd, ievbd);
        [ispecbddd, ievbddd]=numderivative(ispecbdd, ievbdd);
        [ispecbdddd, ievbdddd]=numderivative(ispecbddd, ievbddd);
    
        [ispecad, ievad]=numderivative(ispeca, ieva);
        [ispecadd, ievadd]=numderivative(ispecad, ievad);
        [ispecaddd, ievaddd]=numderivative(ispecadd, ievadd);
        [ispecadddd, ievadddd]=numderivative(ispecaddd, ievaddd);
        
        [dum1, dum1ind] = max(speca);
        [dum2, dum2ind] = max(specb);
        
        [dum3, dum3ind] = max(ispecad);
        [dum4, dum4ind] = min(ispecbd);
        
        [dum5, dum5ind] = min( abs(speca - 1) );
        [dum6, dum6ind] = min( abs(specb - 1) );
        
        gapmapb(i,j,1) = abs(evb(dum2ind));
        gapmapa(i,j,1) = abs(eva(dum1ind));
        gapmapave(i,j,1) = (gapmapb(i,j,1) + gapmapa(i,j,1))/2;
        
        ssmapb(i,j,1) = abs(ievbd(dum4ind));
        ssmapa(i,j,1) = abs(ievad(dum3ind));
        ssmapave(i,j,1) = (ssmapb(i,j,1) + ssmapa(i,j,1))/2;
        
        dosmapb(i,j,1) = abs(evb(dum6ind));
        dosmapa(i,j,1) = abs(eva(dum5ind));
        dosmapave(i,j,1) = (dosmapb(i,j,1) + dosmapa(i,j,1))/2;
        
        
    end
end

figure, img_plot4(gapmapb(:,:,1))
figure, img_plot4(gapmapa(:,:,1))
figure, img_plot4(gapmapave(:,:,1))

figure, img_plot4(ssmapb(:,:,1))
figure, img_plot4(ssmapa(:,:,1))
figure, img_plot4(ssmapave(:,:,1))

figure, img_plot4(dosmapb(:,:,1))
figure, img_plot4(dosmapa(:,:,1))
figure, img_plot4(dosmapave(:,:,1))


end