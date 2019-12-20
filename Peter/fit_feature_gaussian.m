function ffeat = fit_feature_gaussian(dtmap,topo1c,data1,cox,coy)
% ffeat - struct containing data about the fit
% dtmap -   map that can be used for the vortex
% search, for the pristine sample they are not needed
% topo1c - topograph
% data1 - raw data struct 
% cox, coy - pixel cutoff for x and y direction of maps


% energy vector "ev", and number of energies "nel"
% ev = data1.e;
% nel = length(ev);

[nx, ny, ne] = size(dtmap);
dummap = zeros(nx, ny,ne);
% apply a possible crop to map 
dummap(1+cox:end-cox,1+coy:end-coy,:) = dtmap(1+cox:end-cox,1+coy:end-coy,:);

dtmap = dummap;
% get the physical dimensions of the map
[nx, ny, ne] = size(dtmap);

% filter the map with an averaging filter to get rid of noise spikes in the
% intensity, so that when you look for maximum intensity you find better
% candidates for features interested in, but use unfiltered data for fit
% h = fspecial('average',[3,3]);
% msmap = imfilter(dtmap,h,'replicate');

% cv = 7;
% for i=1:nx
%     for j=1:ny
%         if msmap(i,j,1) >= cv
%             msmap(i,j,1) = cv;
%         end
%     end
% end


msmap = dtmap;
msmapraw = msmap;

dtmap = msmap;




% plot the map used for the ffeat search
figure, img_plot4(dtmap);
figure, img_plot4(msmap);
% img_plot3(dtmap);
% img_plot3(msmap);
% Draw ROI, create binary ROI Mask
h = impoint;
setColor(h,'r');

% get the position coordinates of the drawn region of interest and save
% them into the cell structure pos
pos{1} = getPosition(h);
clear h;

% ask if you want to create more than one region of interest
button1 = 'Yes';

i=1;
featmask = [];
        
while strcmp(button1, 'Yes') == 1
    

    ip = pos{i};
    ix = round(ip(:,1));
    iy = round(ip(:,2));
    ffeat.ypos(i) = iy;
    ffeat.xpos(i) = ix;
    

%% Fit the vortices to two-dimensional Gaussians
    
    % crop the region around a possible ffeat, csize determines how big
    % the area will be, the if-else-structure finds the ccordinates 
    
%     csize = 8;
    csize = 41;
    if ffeat.xpos(i)-1 >= csize
        xmin=ffeat.xpos(i)-csize;
    else
        xmin=1;
    end
    if ny-ffeat.xpos(i) >=csize
        xmax=ffeat.xpos(i)+csize;
    else
        xmax=ny;
    end
    if ffeat.ypos(i)-1 >= csize
        ymin=ffeat.ypos(i)-csize;
    else
        ymin=1;
    end
    if nx-ffeat.ypos(i) >=csize
        ymax=ffeat.ypos(i)+csize;
    else
        ymax=nx;
    end
    
    
    % apply the crop to the ffeat search map
    data=dtmap(ymin:ymax,xmin:xmax,:);
    
    figure, img_plot4(data);
    
    clear xmin xmax ymin ymax
    
    prompt = {'Size in x','Size in y:'};
    dlg_title = 'Choose windowsize for fit';
    num_lines = 1;
    default_answer = {num2str(csize),num2str(csize)};
    answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
    
    cxsize = str2num(answer{1});
    cysize = str2num(answer{2});
    if ffeat.xpos(i)-1 >= cxsize
        xmin=ffeat.xpos(i)-cxsize;
    else
        xmin=1;
    end
    if ny-ffeat.xpos(i) >=cxsize
        xmax=ffeat.xpos(i)+cxsize;
    else
        xmax=ny;
    end
    if ffeat.ypos(i)-1 >= cysize
        ymin=ffeat.ypos(i)-cysize;
    else
        ymin=1;
    end
    if nx-ffeat.ypos(i) >=cysize
        ymax=ffeat.ypos(i)+cysize;
    else
        ymax=nx;
    end
    
    % apply the crop to the ffeat search map
    data=dtmap(ymin:ymax,xmin:xmax,:);
    
    figure, img_plot4(data);
    
    % fit the data to a 2-dim Gaussian
    [x,resnorm,residual]=complete_fit_2d_gaussian(data);
    
    % collect the fitresults and the corner coordinates of the box around
    % the ffeat in the cell fitresults
    fitresults{i}=[x;xmin;xmax;ymin;ymax];
    
    % calculate the x and y position with respect to the map
    fitx(i)=round(x(2))-1+xmin;
    fity(i)=round(x(4))-1+ymin;   
    
    % vsx, vsy - ffeat size x/y, sigma of gaussian in angstroem
    vsx(i) = x(3)* ( data1.r(2)-data1.r(1) );
    vsy(i) = x(5)* ( data1.r(2)-data1.r(1) );
    
    % subtract the finalfit from the ffeat search map to move on to the next one
    [X,Y]=meshgrid(1:1:ny,1:1:nx);
    xdata(:,:,1)=X;
    xdata(:,:,2)=Y;
    x = [x(1),fitx(i),x(3),fity(i),x(5),x(6),x(7)];
    finalfit=twodgauss(x,xdata);
%     img_plot3(finalfit);
   
    %%
    
    button2 = questdlg('Do you want to cancel this ffeat fit?',...
            'Choose yes or no','Yes','No','Cancel','No');
        if strcmp(button2,'Yes')==1
        else
            msmap = msmap - finalfit;
    
           %% 
            cm(:,:,i) = uint8(twodgauss(x,xdata) >= x(1)/exp(1) + x(6));
            dum0 = double(cm(:,:,i));
%             img_plot3(dum0);
            fmask{i} = dum0;
            fperimeter{i} = bwboundaries(dum0);
            
            i = i+1;
        end
    
    
    button1 = questdlg('Do you want to add another region?',...
            'Choose yes or no','Yes','No','Cancel','No');

    if strcmp(button1,'Yes')
        
        figure,
        subplot(1,2,1)
        img_plot4(msmapraw)
        subplot(1,2,2)
        img_plot4(msmap)
        
        % black and white
%         figure,img_plot5(msmap)
%         figure,img_plot5(msmapraw)
        
        h = impoint;
        setColor(h,'r');
        
        l = i;
        if strcmp(button2,'Yes')==1
%             l = length(pos);
%             i = l;
            pos{l} = getPosition(h);
        else
%             l = length(pos);
%             l = l+1;
%             i = l;
            pos{l} = getPosition(h);
        end
    end
    
    test = 1;
    close all;
end

%% Save the fit x- and y-coordinates
nof = length(fperimeter);

ffeat.pos = pos;
ffeat.fitx = fitx;
ffeat.fity = fity;
ffeat.fitresults = fitresults;
ffeat.sigmax = vsx;
ffeat.sigmay = vsy;
ffeat.sigmaall = [vsx,vsy];
% also calculate the mean and the stdev of the ffeat size
ffeat.msigmax = mean(vsx);
ffeat.msigmay = mean(vsy);
ffeat.msigmaall = mean(ffeat.sigmaall);
ffeat.stdsigx = std(vsx);
ffeat.stdsigy = std(vsy);
ffeat.stdsigall = std(ffeat.sigmaall);
ffeat.fmask = fmask;
ffeat.perimeter = fperimeter;

img_plot3(topo1c)
hold on
for i=1:nof
    
    
    %%
    
    dum1 = fperimeter{i};
    dum2 = dum1{1};
    xxx = dum2(:,2);
    yyy = dum2(:,1);
    plot(xxx,yyy,'-','Color','r','LineWidth',2);
    % line is needed to close the region
    line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','r','LineStyle','-','LineWidth',2);
    
    dum3 = fmask{i};
    if i == 1
        complmask = dum3;
    else
        complmask = complmask + dum3;
    end
%     line([fitx(i),fitx(i)],[fity(i)-1,fity(i)+1],'Linewidth',2,'Color','m');
%     line([fitx(i)-1,fitx(i)+1],[fity(i),fity(i)],'Linewidth',2, 'Color','m');
end
hold off

[nx, ny, ne] = size(complmask);
for i=1:nx
    for j=1:ny
        if complmask(i,j,1) > 0
            complmask(i,j,1) = 1;
        end
    end
end

ffeat.complmask = complmask;
img_plot3(complmask);
img_plot3(msmap);
end