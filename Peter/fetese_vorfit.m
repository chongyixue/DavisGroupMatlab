function fetese_vorfit(map1c,map2c,dmap,dtmap,topo1c,topo2c,vn,data1,cox,coy)
% map1c, map2c - are the corrected / aligned maps
% dmap, dtmap -  difference maps that can be used for the vortex
% search, for the pristine sample they are not needed
% topo1c, topo2c - topographs that have been aligned; for the pristine
% sample that's not needed so you can just use the same raw topograph
% vn - number of vortices expected
% data1 - raw data struct 
% cox, coy - pixel cutoff for x and y direction of maps, since alignement
% always seems to have the biggest problems there; once again not needed
% for pristine samples, so set it to zero in that case


test1 = dmap;

% create the difference map used in vortex search out of the two input
% difference maps (might not work best), probably only use one
dtmap = abs(sum(dtmap(:,:,1:10),3))+abs(sum(dmap(:,:,1:10),3));

% energy vector "ev", and number of energies "nel"
ev = data1.e;
nel = length(ev);

% cohlen = 40 / ( data1.r(2)-data1.r(1) );
% cohlen = round(cohlen);

% apply a possible crop to maps 
dtmap = dtmap(1+cox:end-cox,1+coy:end-coy,:);
map1c = map1c(1+cox:end-cox,1+coy:end-coy,:);
map2c = map2c(1+cox:end-cox,1+coy:end-coy,:);

% get the physical dimensions of the map
[nx, ny, ne] = size(dtmap);

% filter the map with an averaging filter to get rid of noise spikes in the
% intensity, so that when you look for maximum intensity you find better
% candidates for vortices
h = fspecial('average',[3,3]);
msmap = imfilter(dtmap,h,'replicate');

% plot the map used for the vortex search
figure, img_plot4(dtmap);

for i=1:vn
    
    [mvy, mvindy] = max(msmap);
    [mvx, mvindx] = max(max(msmap));
    vortex.ypos(i) = mvindy(mvindx);
    vortex.xpos(i) = mvindx;
    

%% Fit the vortices to two-dimensional Gaussians
    
    % crop the region around a possible vortex, csize determines how big
    % the area will be, the if-else-structure finds the ccordinates 
    csize = 15;
    if vortex.xpos(i)-1 >= csize
        xmin=vortex.xpos(i)-csize;
    else
        xmin=1;
    end
    if nx-vortex.xpos(i) >=csize
        xmax=vortex.xpos(i)+csize;
    else
        xmax=nx;
    end
    if vortex.ypos(i)-1 >= csize
        ymin=vortex.ypos(i)-csize;
    else
        ymin=1;
    end
    if ny-vortex.ypos(i) >=csize
        ymax=vortex.ypos(i)+csize;
    else
        ymax=ny;
    end
    
    % apply the crop to the vortex search map
    data=dtmap(ymin:ymax,xmin:xmax,:);
    
    % plots the data (zero bias part of map)
%     img_plot3(data);
    
    % fit the data to a 2-dim Gaussian
    [x,resnorm,residual]=complete_fit_2d_gaussian(data);
    
    % collect the fitresults and the corner coordinates of the box around
    % the vortex in the cell fitresults
    fitresults{i}=[x;xmin;xmax;ymin;ymax];
    
    % calculate the x and y position with respect to the map
    fitx(i)=round(x(2))-1+xmin;
    fity(i)=round(x(4))-1+ymin;
    
    
    
    %%
    [X,Y]=meshgrid(1:1:nx,1:1:ny);
    xdata(:,:,1)=X;
    xdata(:,:,2)=Y;
    x = [x(1),fitx(i),x(3),fity(i),x(5),x(6),x(7)];
    finalfit=twodgauss(x,xdata);
    
%     figure, img_plot4(finalfit)
    cm(:,:,i) = uint8(twodgauss(x,xdata)>=x(1)/exp(1));
    dummy = double(cm(:,:,i));
    
    %%
    B = bwboundaries(dummy);
    BB = B{1};
    xxx = BB(:,2);
    yyy = BB(:,1);
    
    img_plot3(finalfit)
    hold on
    plot(xxx,yyy,'-','Color','r','LineWidth',2);
    % line is needed to close the region
    line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','r','LineStyle','-','LineWidth',2);
    hold off
    
    img_plot3(topo1c)
    hold on
    plot(xxx,yyy,'-','Color','r','LineWidth',2);
    % line is needed to close the region
    line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','r','LineStyle','-','LineWidth',2);
    hold off
    %%
    maskmat = repmat(dummy,1,1,nel);
    
    nomagspec = squeeze(sum(sum( map1c .* maskmat))) / sum(sum(dummy));
    magspec = squeeze(sum(sum( map2c .* maskmat))) / sum(sum(dummy));
    
    cc = 1;
    for m=1:nel
        for k=1:nx
            for l=1:ny
                if maskmat(k,l)==1
                    datvec1(cc) = map1c(k,l,m);
                    datvec2(cc) = map2c(k,l,m);
                    cc = cc+1;
                end
            end
        end
        datstd1(m) =std(datvec1);
        datstd2(m) =std(datvec1);
    end
    
    
%     figure, plot(ev,nomagspec,'bo-',ev,magspec,'ro-','LineWidth',2,'MarkerSize',4);
    
    figure, errorbar(ev,nomagspec,datstd1,'bo-');
    hold on
            errorbar(ev,magspec,datstd2,'ro-');
    hold off
            
    legend('0T','2T');
    
    %%
    
    
    
    
    dtmap=dtmap - finalfit;
%     figure, img_plot4(dtmap);
    
    if resnorm > 1000
        if i > 1
            i = i-1;
        else
            i =1;
        end
    end
    
    
    
    
    
    test = 1;
    
end

%% Save the fit x- and y-coordinates
vortex.fitx=fitx;
vortex.fity=fity;
vortex.fitresults=fitresults;

img_plot3(topo1c)
hold on
for i=1:vn
    line([fitx(i),fitx(i)],[fity(i)-1,fity(i)+1],'Linewidth',2,'Color','y');
    line([fitx(i)-1,fitx(i)+1],[fity(i),fity(i)],'Linewidth',2, 'Color','y');
end
hold off

end