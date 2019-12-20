function ffeat = fetese_chechspec(dtmap,topo1c,data1,cox,coy,nfmap, magmap)
% ffeat - struct containing data about the fit
% dtmap -   map that can be used for the vortex
% search, for the pristine sample they are not needed
% topo1c - topograph
% data1 - raw data struct 
% cox, coy - pixel cutoff for x and y direction of maps


% energy vector "ev", and number of energies "nel"
ev = data1.e;
nel = length(ev);

[nx, ny, ne] = size(dtmap);
dummap = zeros(nx, ny,ne);
% apply a possible crop to map 
dummap(1+cox:end-cox,1+coy:end-coy,:) = dtmap(1+cox:end-cox,1+coy:end-coy,:);

dtmap = dummap;
% get the physical dimensions of the map
[nx, ny, ne] = size(dtmap);



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
    
    k=0;
    while 
    cm(:,:,i)=circlematrix([nx,ny],k,ix,iy);
    dum0 = double(cm(:,:,i));
    dum0r = repmat(dum0,1,1,ne);
    magmap .* dum0r;
    nfmap .* dum0r;
    
    end

    
    fmask{i} = dum0;
    fperimeter{i} = bwboundaries(dum0);
    i = i+1;
    
    
    
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