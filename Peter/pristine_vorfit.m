function vortex = pristine_vorfit(dtmap,topo1c,vn,data1,cox,coy,field)
% vortex - struct containing data about the fit
% dtmap -   map that can be used for the vortex
% search, for the pristine sample they are not needed
% topo1c - topograph
% vn - number of vortices expected
% data1 - raw data struct 
% cox, coy - pixel cutoff for x and y direction of maps
% field - field at which vortices where acquired


vortex.field = field;

% energy vector "ev", and number of energies "nel"
ev = data1.e;
nel = length(ev);


% apply a possible crop to map 
dtmap = dtmap(1+cox:end-cox,1+coy:end-coy,:);


% get the physical dimensions of the map
[nx, ny, ne] = size(dtmap);

% filter the map with an averaging filter to get rid of noise spikes in the
% intensity, so that when you look for maximum intensity you find better
% candidates for vortices
h = fspecial('average',[9,9]);
msmap = imfilter(dtmap,h,'replicate');
msmapraw = msmap;

% plot the map used for the vortex search
figure, img_plot4(dtmap);
figure, img_plot4(msmap);

i=1;

while i <= vn
    
    % find the maximum intensity which will be used as a possible vortex
    % location. later it will be cut out, by subtracting the fit so the
    % next vortex can be found
    [mvy, mvindy] = max(msmap);
    [mvx, mvindx] = max(max(msmap));
    vortex.ypos(i) = mvindy(mvindx);
    vortex.xpos(i) = mvindx;
    

%% Fit the vortices to two-dimensional Gaussians
    
    % crop the region around a possible vortex, csize determines how big
    % the area will be, the if-else-structure finds the ccordinates 
    csize = 30;
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
    
    % fit the data to a 2-dim Gaussian
    [x,resnorm,residual]=complete_fit_2d_gaussian(data);
    
    % collect the fitresults and the corner coordinates of the box around
    % the vortex in the cell fitresults
    fitresults{i}=[x;xmin;xmax;ymin;ymax];
    
    % calculate the x and y position with respect to the map
    fitx(i)=round(x(2))-1+xmin;
    fity(i)=round(x(4))-1+ymin;   
    
    % vsx, vsy - vortex size x/y, sigma of gaussian in angstroem
    vsx(i) = x(3)* ( data1.r(2)-data1.r(1) );
    vsy(i) = x(5)* ( data1.r(2)-data1.r(1) );
    
    % subtract the finalfit from the vortex search map to move on to the next one
    [X,Y]=meshgrid(1:1:nx,1:1:ny);
    xdata(:,:,1)=X;
    xdata(:,:,2)=Y;
    x = [x(1),fitx(i),x(3),fity(i),x(5),x(6),x(7)];
    finalfit=twodgauss(x,xdata);

    msmap = msmap - finalfit;
    
    figure, img_plot4(msmapraw)
    figure, img_plot4(msmap)
    
    button2 = questdlg('Do you want to cancel this vortex fit?',...
            'Choose yes or no','Yes','No','Cancel','No');
        if strcmp(button2,'Yes')==1
        else
            i = i+1;
        end
    test = 1;
    close all;
end

%% Save the fit x- and y-coordinates
vortex.fitx = fitx;
vortex.fity = fity;
vortex.fitresults = fitresults;
vortex.vsx = vsx;
vortex.vsy = vsy;
% also calculate the mean and the stdev of the vortex size
vortex.mvsx = mean(vsx);
vortex.mvsy = mean(vsy);
vortex.svsx = std(vsx);
vortex.svsy = std(vsy);

img_plot3(topo1c)
hold on
for i=1:vn
    line([fitx(i),fitx(i)],[fity(i)-1,fity(i)+1],'Linewidth',2,'Color','r');
    line([fitx(i)-1,fitx(i)+1],[fity(i),fity(i)],'Linewidth',2, 'Color','r');
end
hold off

end