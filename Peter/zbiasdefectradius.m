function [msdmapco,mbdmap,areas]=zbiasdefectradius(data, bdmap, sdmap, bhmap, radius)

piezo = data.r(2) - data.r(1);

radius = radius / (piezo);

ev = data.e;
map = data.map;

le = length(ev);

for j = 1:le
    if ev(j) == 0
        zlayer = j;
    end
end


zbmap = map(:,:,zlayer);
[nx,ny,nz] = size(zbmap);

opsmap = zeros(nx, ny, 1);

for i=1:nx
    for j=1:ny
        opsmap(i,j,1) = (mean(map(i,j,6:8))+mean(map(i,j,14:16)))/2 - mean(map(i,j,10:12));
    end
end

zbmap = opsmap;



msdmap = zeros(nx, ny, 1);
mbhmap = zeros(nx, ny, 1);
mbdmap = zeros(nx, ny, 1);




bdperimeter = bwboundaries(bdmap);
sdperimeter = bwboundaries(sdmap);
bhperimeter = bwboundaries(bhmap);

change_color_of_STM_maps(zbmap,'invert');

hold on

for i=1:length(sdperimeter)
    
    dum1 = sdperimeter{i};
    mx = mean(dum1(:,1));
    my = mean(dum1(:,2));
    cm=circlematrix([nx,ny],radius,mx,my);
    msdmap = msdmap + double(cm);
    
    w = 2*radius;
    h = w;
    x = mx - radius;
    y = my - radius;
    rectangle('position',[y,x,w,h],...
        'Curvature',[1,1],'EdgeColor','k','LineStyle','-','LineWidth',2);
    
    
end

for i=1:length(bdperimeter)
    
    dum1 = bdperimeter{i};
    for j=1:length(dum1)
        mx = mean(dum1(j,1));
        my = mean(dum1(j,2));
        cm=circlematrix([nx,ny],radius,mx,my);
        mbdmap = mbdmap + double(cm);

        w = 2*radius;
        h = w;
        x = mx - radius;
        y = my - radius;
        rectangle('position',[y,x,w,h],...
            'Curvature',[1,1],'EdgeColor','r','LineStyle','-','LineWidth',2);
    end
    
    
end


msdmap = im2bw(msdmap,0);
mbdmap = im2bw(mbdmap,0);

msdmapco = msdmap - mbdmap;
msdmapco = im2bw(msdmapco,0);


expectedpristine = opsmap .* (1-msdmap);
expectedpristine = expectedpristine .* (1-mbdmap);

epavgnummap=(1-msdmap + 1-mbdmap)/2;
epavgnummap = im2bw(epavgnummap);
figure, img_plot5(epavgnummap)
figure, img_plot4(expectedpristine);


n = 1000;
[histo.freq(1,1:n), histo.val(1,1:n)] = hist(reshape(expectedpristine(:,:,1),nx*ny,1),n);

dumind = 244;
histo.freq(dumind) = mean ([histo.freq(dumind-1),histo.freq(dumind+1)]);


x0 = [max(histo.freq),mean(histo.val),mean(histo.val)];
lb = [0,0,0];
ub = [5*max(histo.freq),10*mean(histo.val),10*mean(histo.val)];

options = optimset('Algorithm','trust-region-reflective',...  % according to MATLAB the only one that allows bounds
                   'TolX',1e-6,...
                   'MaxIter',10000,...
                   'MaxFunEvals',10000);

%% Fit to Gaussian

% xint=lsqcurvefit(@twodgauss,x0,xdata,zdata,lb,ub,options);
[x,resnorm,residual]=lsqcurvefit(@onedgauss,x0,histo.val(1,1:n),histo.freq(1,1:n),lb,ub,options);
finalfit=onedgauss(x,histo.val(1,1:n));
figure, plot(histo.val(1,1:n),histo.freq(1,1:n),histo.val(1,1:n),finalfit,'r','LineWidth',2);
test = 1;

epavgnum = sum(sum(expectedpristine)) / sum(sum(epavgnummap));

figure, plot(1,epavgnum,'ko',2,epavgnum,'ko',3,epavgnum,'k');
%% 10/31/14 : black holes seem to not suppress order parameter
% for i=1:length(bhperimeter)
%     
%     dum1 = bhperimeter{i};
%     mx = mean(dum1(:,1));
%     my = mean(dum1(:,2));
%     cm=circlematrix([nx,ny],radius,mx,my);
%     mbhmap = mbhmap + double(cm);
% 
%     w = 2*radius;
%     h = w;
%     x = mx - radius;
%     y = my - radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','y','LineStyle','-','LineWidth',2);
%     
% end
% 
% mbhmap = im2bw(mbhmap,0);

hold off



figure, img_plot5(bdmap)
figure, img_plot5(sdmap)
figure, img_plot5(msdmap)
figure, img_plot5(mbdmap)
figure, img_plot5(msdmapco)

areas.bigdefects = bwarea(bdmap);
areas.smalldefects = bwarea(sdmap);
areas.smalldefectscircles = bwarea(msdmap);
areas.bigdefectscircles = bwarea(mbdmap);





end

