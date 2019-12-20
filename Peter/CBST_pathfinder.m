function [pathx, pathy, pathxind, pathyind] = CBST_pathfinder(data,sx,ex,sy,ey,roc)

map = data.map;
ds = data.r(2)-data.r(1);

cmap = map(sx:ex, sy:ey,:);
mcmap = mean(cmap,3);
figure, imagesc(mcmap)


[nx, ny, nz] = size(cmap);
rx = (0:1:nx-1)*ds;
ry = (0:1:ny-1)*ds;

figure, imagesc(ry, rx ,mcmap)

% current line (row or column depending on choice)

if strcmp(roc,'row')==1
    for i=1:length(rx)
        cl = squeeze(mcmap(i,:))';
        
        r = ry;
        
        cl = sgolayfilt(cl,3,11);
%         figure, plot(ry, cl)
%         test = 1;
%         [cld, rd]=numderivative(cl, r);
%         [cldd, rdd]=numderivative(cld, rd);

        % exp_lrntz = 'a*x + b*(d/2)^2/((x-c)^2+(d/2)^2)+e + f*(x-g)^2';
        [maxcl, maxicl] = max(cl);
%         guess = [mean(cld), maxcl, r(maxicl), length(r)/10, mean(cl), mean(cldd), length(r)/2];
%         low = [-inf, -inf, 1, 0, -inf, -inf, 1];
%         upp = [inf, inf, length(r), inf, inf, inf, length(r)];
%         r = r';
%         cl = cl';
%         [y_new, p,gof]=lorentzian2(cl,r,guess,low,upp);
%         figure, plot(r,cl,'ko',r,y_new,'r','LineWidth',2)
        figure, plot(r,cl,'ko','LineWidth',2)
        line([r(maxicl),r(maxicl)],[min(cl),max(cl)],'LineWidth',2,'Color','b');
        pathx(i) = rx(i);
        pathy(i) = r(maxicl);
        pathxind(i) = i;
        pathyind(i) = maxicl;
        test = 1;
        close all;
    end
elseif strcmp(roc,'col')==1
    for i=1:length(ry)
        cl = squeeze(mcmap(:,i))';
        
        r = rx;
        
        cl = sgolayfilt(cl,3,11);
%         figure, plot(rx, cl, rx, y)
%         test = 1;
%         [cld, rd]=numderivative(cl, r);
%         [cldd, rdd]=numderivative(cld, rd);

        % exp_lrntz = 'a*x + b*(d/2)^2/((x-c)^2+(d/2)^2)+e + f*(x-g)^2';
        [maxcl, maxicl] = max(cl);
%         guess = [mean(cld), maxcl, r(maxicl), length(r)/10, mean(cl), mean(cldd), length(r)/2];
%         low = [-inf, -inf, 1, 0, -inf, -inf, 1];
%         upp = [inf, inf, length(r), length(r), inf, inf, length(r)];
%         r = r';
%         cl = cl';
%         [y_new, p,gof]=lorentzian2(cl,r,guess,low,upp);
%         figure, plot(r,cl,'ko',r,y_new,'r','LineWidth',2)
        figure, plot(r,cl,'ko','LineWidth',2)
        line([r(maxicl),r(maxicl)],[min(cl),max(cl)],'LineWidth',2,'Color','b');
        pathx(i) = r(maxicl);
        pathy(i) = ry(i);
        pathxind(i) = maxicl;
        pathyind(i) = i;
        test = 1;
        close all;
    end
end


    

test = 1;

figure, imagesc(ry, rx ,mcmap)
hold on 


for i=1:length(pathx)
    
    line([pathy(i),pathy(i)],[pathx(i),pathx(i)],'Color','y','LineWidth',2,'Marker','+','MarkerSize',12);
            
end



hold off


% change_color_of_STM_maps(data.map(sx:nx,sy:ny),'no')
% 
% hold on 
% 
% 
% for i=1:length(pathx)
%     
%     line([pathyind(i),pathyind(i)],[pathxind(i),pathxind(i)],'Color','y','LineWidth',2,'Marker','+','MarkerSize',12);
%             
% end
% 
% 
% 
% hold off

if strcmp(roc,'row')==1
    for i=1:length(pathxind)
%         spec = squeeze(cmap(pathxind(i), pathyind(i), :));
%         figure, plot(data.e, spec)
        spec = squeeze(cmap(pathxind(i):pathxind(i), pathyind(i)-1:pathyind(i)+1, :));
        mspec(i,1:length(data.e)) = mean(spec);
        clear spec;
%         figure, plot(data.e, mspec)
        if i==1
            tpath(i) = 0;
        else
           tpath(i) = sqrt( (pathx(i)-pathx(i-1))^2 + (pathy(i)-pathy(i-1))^2 ); 
        end
        test = 1;
    end
elseif strcmp(roc,'col')==1
    for i=1:length(pathxind)
%         spec = squeeze(cmap(pathxind(i), pathyind(i), :));
%         figure, plot(data.e, spec)
        spec = squeeze(cmap(pathxind(i)-1:pathxind(i)+1, pathyind(i):pathyind(i), :));
        mspec(i,1:length(data.e)) = mean(spec);
        clear spec;
%         figure, plot(data.e, mspeccell{i})
        if i==1
            tpath(i) = 0;
        else
           tpath(i) = sqrt( (pathx(i)-pathx(i-1))^2 + (pathy(i)-pathy(i-1))^2 )+tpath(i-1); 
        end
        test = 1;
        
    end
end

en = data.e;

for i = 1 : length(pathxind)
    ospec = mspec(i,:);
    iev = linspace(data.e(1),data.e(end),length(data.e)*10);
    ispec = interp1(data.e,mspec(i,:),iev,'pchip');
    [ispecd, ievd]=numderivative(ispec, iev);
    [ispecdd, ievdd]=numderivative(ispecd, ievd);
    
    [mspecd, mevd]=numderivative(mspec(i,:), en);
    [mspecdd, mevdd]=numderivative(mspecd, mevd);
    %% normalize the spectra and their derivatives to bring them all onto
    %% the same scale, mostly useful for plotting and checking the code
    ispec = ispec/max(abs(ispec));
    ispecd = ispecd/max(abs(ispecd));
    ispecdd = ispecdd/max(abs(ispecdd));

    ospec = ospec/max(abs(ospec));
    mspecd = mspecd/max(abs(mspecd));
    mspecdd = mspecdd/max(abs(mspecdd));
            
    %% Calculate the energies of the zero crossings to find the maxima and minima 
    %% of spectra and derivatives
    zcd = findzerocrossings(ispecd,ievd);
    
    figure, plot(iev, ispec, 'k', ievd, ispecd, 'r')
    figure, plot(en, ospec, 'k', mevd, mspecd, 'r')
    test = 1;
end
figure, imagesc(data.e, tpath, mspec)
figure, surf(data.e, tpath, mspec)


% mspft = fft(mspeccell{1}');
% mspft = abs(fftshift(mspft));
% figure, plot(mspft)
% hold on
% for i=2:length(tpath)
%     mspft = fft(mspeccell{i}');
%     mspft = abs(fftshift(mspft));
%     plot(mspft)
% end
% hold off

x = 1:1:length(lcut);
xi = linspace(1,length(lcut),length(lcut1));
yi = interp1q(x',lcut,xi');

aspec = squeeze(mean(mean(cmap)));
figure, plot(data.e, aspec, data.e, mean(mspec))

end