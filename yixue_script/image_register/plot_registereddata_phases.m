% 2020-5-1 YXC
% say you have two registered maps to compare phases like rho and cdw
% give the coordinates of the Bragg peaks
% and other optional data
% to compute and plot stuff


function [rhocell,cdwcell,sig,output]=plot_registereddata_phases(rhomap,cdwmap,Braggs,varargin)

nx = size(rhomap.map,1);
center = ceil((nx+1)/2);
nperiod = sqrt(sum((Braggs(1,:)-center).^2));
periodsize = nx/nperiod;
nBrag = size(Braggs,1);

%% default values
nBraggs = size(Braggs,1);
directions = ones(1,nBraggs); % [1,1,1]
sig = periodsize/pi;
calculaterhocell = 1;
calculatecdwcell = 1;
phasecalculation = 1;
rowcol = [1,1];
plotthese = {};
header = strcat('Phase maps.......',rhomap.name,'.......',cdwmap.name);

pad = 1;
ksig = 3;
marksig = 0;
skipover = 0;
remove = 0.12; %for scatter and overlap count,by default only take center (1-remove)L^2
manualcrop = 0;
plotlimitsinput = [];
locklimitsinput = [];
scattersize = 1;
scatteralpha = 0.002; 
plotbound = [];
setlim = 1; %caxis limit follows the "remove" option
customdata = 0;
plotcircles = 0;
zoom = 0;

for j=1:length(varargin)
    if skipover ~=0
        skipover = skipover-1;
    else
        v = varargin{j};
        if iscell(v)
            v = v{1};
        end
        %         v
        switch v
            case 'sig'
                sig = varargin{j+1};
                skipover = 1;
            case 'map1phasecell'
                calculaterhocell = 0;
                rhocell = varargin{j+1};
                skipover = 1;
                
            case 'map2phasecell'
                calculatecdwcell = 0;
                cdwcell = varargin{j+1};
                skipover = 1;
                
            case 'ksigma'
                ksig = varargin{j+1};
                skipover = 1;
                
            case 'multiple'
                skipover = 1;
                rowcol = varargin{j+1}; % input row and column numbers [row, column]
                
            case 'plot'  % inputplot as such: ...,{'plotname','colormap'},{'plotname'},...
                skipover = rowcol(1)*rowcol(2);
                plotthese = cell(skipover,1);
                %                 {varargin{j+1:j+skipover}}
                colormapspecify = cell(1,skipover);
                for kk=1:skipover
                    plotthese{kk} = varargin{j+kk}{1};
                    if length(varargin{j+kk})>1
                        colormapspecify{kk} = varargin{j+kk}{2};
                    end
                end
                
                
                ttl = [];
                
            case 'title' % input as cell {'bla bla','more bla','',}
                ttl = varargin{j+1};
                skipover =1;
                
            case 'header'
                skipover = 1;
                header = varargin{j+1};
                
            case 'marksigma'
                skipover = 1;
                marksig = varargin{j+1};
                
            case 'remove'
                skipover = 1;
                remove = varargin{j+1};
                
            case 'padding'
                skipover = 1;
                pad = varargin{j+1};
                
            case 'directions'
                skipover = 1;
                directions = varargin{j+1};
                
            case 'nophase'
                skipover = 0;
                phasecalculation = 0;
                calculatecdwcell = 0;
                calculaterhocell = 0;
                
            case 'crop'
                skipover = 1;
                manualcrop = 1;
                % croparray input is {[],[],[],[x1,x2,y1,y2],[]...}
                croparray = varargin{j+1};
                
            case 'plotlimits'
                % input is 'plotlimits',[linref,min,max,linref2,min2,max2,...]
                skipover = 1;
                plotlimitsinput = varargin{j+1};
                
            case 'smallerlim' %1 or 0, defaul 1, colorbar max at smaller values according to 'remove'
                skipover = 1;
                setlim = varargin{j+1};
                
            case 'locklimits'
                % input as 'locklimits',[{[linref,linref,linref],[set2linref,set2linref]}]
                skipover = 1;
                locklimitsinput = varargin{j+1};
                
            case 'scattersize'
                skipover = 1;
                scattersize = varargin{j+1};
                
            case 'scatteralpha'
                skipover = 1;
                scatteralpha = varargin{j+1};
                
            case 'plotbound' %input as 'plotbound',[linref,linref,linref]
                skipover = 1;
                plotbound = varargin{j+1};
                
            case 'customdata' % 'customdata',{linref,{data,datatype,color},linref,{data,datatype}}
                customdata = 1;
                skipover = 1;
                customdatadata = varargin{j+1};
                
            case 'plotcircles' % 'plotcircles',{linref,{xpoitns,ypoints,color,size}} (color,size optional)
                skipover = 1;
                circles = varargin{j+1};
                plotcircles = 1;
                
            case 'zoom'
                skipover = 0;
                zoom = 1;
                
            otherwise
                st = num2str(varargin{j});
                fprintf(strcat('"',st,'" is not recognized as a property'));
                    
        end
        
    end
end

plotlimits = zeros(rowcol(1)*rowcol(2),3);
% plotlimits will be in the form
%  0  0  0  1    0  1
%  0  0  0  min  0  min
%  0  0  0  max  0  max
if isempty(plotlimitsinput)==0
    for ip = 1:length(plotlimitsinput)
        if mod(ip,3)==1
            ref = plotlimitsinput(ip:ip+2);
            ref = reshape(ref,[],3);
            plotlimits(ref(1),1) = 1;
            plotlimits(ref(1),2:3) = ref(2:3);
        end
    end
end

locklimits = zeros(rowcol(1)*rowcol(2),1);
% locklimits will end up being
% [0,0,1,1,0,1,2,2 ..] 0s are not locked, 1s are locked to other 1s, etc.
if isempty(locklimitsinput)==0
    lockindex = 1;
    for ip = 1:length(locklimitsinput)
        locklimits(locklimitsinput{ip}) = lockindex;
        lockindex = lockindex+1;
    end
end

plotboundsref = zeros(rowcol(1)*rowcol(2),1);
% [0,0,1,1,0,1,0,0 ..] plotbounds for the 1.
plotboundsref(plotbound)=1;
    
% circles = {xpoitns,ypoints,color,size} (color,size optional)
circleguide = cell(rowcol(1)*rowcol(2),4);
if plotcircles == 1
    
    for ic = 1:length(circles)
        if mod(ic,2)==1
            ind = circles{ic};
        else
            circlecell = circles{ic};
            circleguide{ind,1} = circlecell{1};
            circleguide{ind,2} = circlecell{2};
            circleguide{ind,3} = 'ro'; % default markercolor
            circleguide{ind,4} = 5;%default markersize
            for indrest = 3:length(circlecell)
                item = circlecell{indrest};
                if isstring(item)||ischar(item)
                    circleguide{ind,3} = item;
                else
                    circleguide{ind,4} = item;
                end
            end
        end
    
    end
end
% customdatadata = {linref,{data,datatype,color},linref,{data,datatype}}
if customdata == 1
    customdataguide = cell(rowcol(1)*rowcol(2),3);
    for ic = 1:length(customdatadata)
        if mod(ic,2)==1
            ind = customdatadata{ic};
        else
            customdatacell = customdatadata{ic};
            customdataguide{ind,1} = customdatacell{1};
            customdataguide{ind,2} = 1; %imagesc by default
            customdataguide{ind,3} = 'Blue1'; %default imagecs color
            for indrest = 2:length(customdatacell)
                item = customdatacell{indrest};
                if isstring(item)|| ischar(item) % the color
                    customdataguide{ind,3} = item;
                else
                    customdataguide{ind,2} = item; %datatype
                end
            end
        end
    end
end



%% initiate phasemaps ('phaserho3','phasecdw1','amprho2')

if calculatecdwcell == 1
    cdwcell = generatecells(cdwmap,Braggs,sig);
end
if calculaterhocell == 1
    rhocell = generatecells(rhomap,Braggs,sig);
end


%% phases related stuff
if phasecalculation == 1
    %% shift phase of amp and rho so that colorplot is nicer
    
    for ib=1:size(Braggs,1)
        if directions(ib)~=0
            rhophase = rhocell{1,ib}.map;
            cdwphase = cdwcell{1,ib}.map;
            [newrhophase,newcdwphase,phaseshift] = optimize_phase(rhophase,cdwphase);
            %     figure,imagesc(newcdwphase)
            %     figure,imagesc(cdwcell{1,ib}.map)
            rhocell{1,ib}.map = newrhophase;
            cdwcell{1,ib}.map = newcdwphase;
            rhocell{2,ib}.map = mod(rhocell{2,ib}.map-phaseshift,2*pi) ;
            cdwcell{2,ib}.map = mod(cdwcell{2,ib}.map-phaseshift,2*pi);
        end
    end
    
    
    

end


%% initiate data for filtered map in all and individual directions ('rho1','rho4','cdw2'...)
IFTexist_tracker = zeros(2,nBrag+1);

rhofiltered = zeros(nBrag+1,nx,nx);
cdwfiltered = zeros(nBrag+1,nx,nx);




%% initiate data for bwplot
% figure,imagesc(squeeze(rhofiltered(1,:,:)));
bwrho = (atan2(0,rhofiltered))/(pi/2)-1;
bwcdw = (atan2(0,cdwfiltered))/(pi/2)-1;


%% Making a figure and plotting it
if rowcol(1)*rowcol(2)<length(plotthese)
    rowcol(1) = ceil(plotthese/2);
    rowcol(2) = 2;
end
nhor = rowcol(1);nvert = rowcol(2);
% fillratio = 0.76;
fillratio = 0.95;
output = cell(1,nhor*nvert); % output plot data as cells

height = 700;
width = height*nhor/nvert;
if width>1400
    width = 1400;
    height = width*nvert/nhor;
end
box = width/nhor; gap = box*(1-fillratio)/2;


h1 = figure(...
    'Units','characters',...
    'Color',[1 1 1],...%'MenuBar','none',...
    'Name',header,...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[50 10 width height],...
    'Resize','off',...
    'Visible','on');

axesplot = cell(nhor,nvert);
labels = cell(nhor,nvert);

% plotthese
% ttl
[nx1,nx2] = bounds
linreflookup = cell(nhor*nvert,1);%so that we can convert linref to iH and iV easily later.
for iH = 1:nhor
    for iV = 1:nvert
        linref = (iV-1)*nhor+iH;
        linreflookup{linref} = [iH,iV];
        left = (iH-1)*box+gap;
        bottom = (nvert-iV)*box+box*(1-fillratio)/2;
        siz = box*fillratio;
        
        
        % smaller size for scatter and histogram
        shrink = 0.7;
        siz2 = siz*shrink;
        gap2 = (siz-siz2)/2;
        left2 = left+gap2;
        bottom2 = bottom+gap2;
        siz = siz2;
        
        
        axesplot{iH,iV} = axes(...
            'Parent',h1,...
            'Units','pixels',...
            'Position',[left bottom siz siz]);
        
        
        %% plotguide options  * means any char,specific length - non-specific length n=number 1,2 3...
        % scatter1 scatter2 scatter3  [sca-n]
        %scatter for phase+Qr between rho and cdw
        % scat*n---, scattern---; --- can be amp,loc
        % generalize scatter plot to other variables too
        % amprho1 amprho2 amprho3 ampcdw1 ampcdw2 ampcdw3 [amp-rho-n] [amp-cdw-n]
        %phase of cdw or pdw
        % phaserho1 phaserho2... (or pharho3)   [pha-rho-n] [pha-cdw-n]
        %phase +Qr of cdw or pdw
        % locrho1 loccdw2 ... [loc-rho-n] [loc-cdw-n]
        % locrhos loccdws for RMS sum of loc in for all 3 directions
        % amplitude of phase of pdw or cdw
        % bwrho1 bwcdw2 ... [bw-rho-n] [bw-cdw-n]
        % squarewave (phase of ifft of Braggs +Q and -Q)
        % bwcmp2  [bw*-n]
        % plot product of squarewave of rho and cdw, phase diff summed
        % rhoift2 cdwift3
        
        % rhoraw  cdwraw
        
        % ftcdw or ftrho
        
        % dephas**rho or dephas**cdw
        
        % phd-    (stands for phase difference=pdw-cdw)
        % phdimg1 - image of bragg1 phase diff
        % phdhis2 -histogram of Bragg2 phase diff
        
        % custom 
        
        plotguide = plotthese{linref};
        if isempty(ttl)
            plottitle = [];
        else
            plottitle = ttl{linref};
        end
        
        
        datatype =1; % imagesc. 0=scatter
        col = 'Rainbow';
        ampplot = 0;
        phaseplot = 0;
        if strcmp(plotguide(1,1:3),'sca')
            % scatter plot
            datatype = 0;
            
            if ~isnan(str2double(plotguide(1,end)))
                % sca**1 or scatter2 , scatter3 scatter plot
                % (phase+Qr)
                
                peaknumber = str2double(plotguide(1,end));
                [rhopoints,chargepoints,lim] = initiatescatter(2,peaknumber);
            else
                peakref = str2double(plotguide(1,end-3));
                % now seperate whether it is lock-in phase or lockinamp
                choice = plotguide(1,end-2:end);
                [rhopoints,chargepoints,lim] = initiatescatter(choice,peakref);
            end
            
            data = [reshape(chargepoints,[],1),reshape(rhopoints,[],1)]';
            
            
        elseif strcmp(plotguide(1,1:3),'phd')
            peakref = str2double(plotguide(1,end));
            phaserho = rhocell{1,peakref}.map;
            phasecdw = cdwcell{1,peakref}.map;
            df = mod(phaserho-phasecdw,2*pi);
            data = df;
            
            
            if strcmp(plotguide(4:6),'img')
                ampplot = 1;
                data = data/(2*pi);
            elseif strcmp(plotguide(4:6),'his')
                data = removeedges(data);
                datatype = 4; %histogram type
            end
            
            
            
        elseif strcmp(plotguide(1,1:3),'amp')
            ampplot = 1;
            % amplitude plot
            if strcmp(plotguide(1,4:6),'rho')
                data = rhocell{1,str2double(plotguide(1,end))};
            else
                data = cdwcell{1,str2double(plotguide(1,end))};
            end
            data = data.map/(2*pi);
            
        elseif strcmp(plotguide(1,1:3),'dep') % only for hex for now
            ampplot = 1;
            if strcmp(plotguide(end-2:end),'cdw')
                data = cdwcell{1,1}.map;
                data = data + cdwcell{1,2}.map;
                data = data + cdwcell{1,3}.map;
                
            else
                data = rhocell{1,1}.map;
                data = data + rhocell{1,2}.map;
                data = data + rhocell{1,3}.map;
            end
            data = data/(2*pi);
            data = mod(data,1);
            
        elseif strcmp(plotguide(1,1:3),'pha')
            phaseplot = 1;
            % phase plot
            if strcmp(plotguide(1,end-3:end-1),'rho')
                data = rhocell{2,str2double(plotguide(1,end))};
            else
                data = cdwcell{2,str2double(plotguide(1,end))};
            end
            data = data.map/(2*pi);
            
        elseif strcmp(plotguide(1,1:3),'rho')
            col = 'Parula';
            if strcmp(plotguide(1,4:6),'raw')
                data = rhomap;
            else
                % inverse FT for rho
                peaknumber = str2double(plotguide(1,end));
                calculateIFT(1,peaknumber)
                data = rhofiltered(str2double(plotguide(1,end)),:,:);
            end
        elseif strcmp(plotguide(1,1:3),'cdw')
            col = 'Copper';
            if strcmp(plotguide(1,4:6),'raw')
                data = cdwmap;
            else
                % inverse FT for cdw
                peaknumber = str2double(plotguide(1,end));
                calculateIFT(2,peaknumber)
                data = cdwfiltered(peaknumber,:,:);
            end
            
        elseif strcmp(plotguide(1,1:2),'ft')
            if strcmp(plotguide(1,end-2:end),'cdw')
                col = 'Copper';
                data = cdwmap;
            elseif strcmp(plotguide(1,end-2:end),'rho')
                col = 'Parula';
                data = rhomap;
            end
            
            data = polyn_subtract(data,0,'noplot');
            data = fourier_transform2d(data,'sine','amplitude','ft');
            datatype = 3;
            
        elseif strcmp(plotguide(1,1:3),'loc')
            col = 'Autumn';
            if strcmp(plotguide(1,end-3:end-1),'rho')
                if strcmp(plotguide(1,end),'s')
                    data = sqrt(rhocell{3,1}.map.^2+rhocell{3,2}.map.^2+rhocell{3,3}.map.^2); 
                else
                    data = rhocell{3,str2double(plotguide(1,end))};
                end
            else
                if strcmp(plotguide(1,end),'s')
                    data = sqrt(cdwcell{3,1}.map.^2+cdwcell{3,2}.map.^2+cdwcell{3,3}.map.^2);
                else
                    data = cdwcell{3,str2double(plotguide(1,end))};
                end
            end
%             setlim = 1; 
            

            
            
        elseif strcmp(plotguide(1,1:2),'bw') %black and whitephase
            datatype = 1;
            col = 'Blue1';
            if strcmp(plotguide(1,end-3:end-1),'rho')==1
                data = bwrho(str2double(plotguide(1,end)),:,:);
                
            elseif strcmp(plotguide(1,end-3:end-1),'cdw')==1
                data = bwcdw(str2double(plotguide(1,end)),:,:);
            else
                datatype = 2;
                dir = str2double(plotguide(1,end));
                data1 = squeeze(bwcdw(dir,:,:));
                data2 = squeeze(bwrho(dir,:,:));
                
                data1 = removeedges(data1);
                data2 = removeedges(data2);
                
                data = data1.*data2;
                data = sum(sum(data))/(size(data,1)^2);
                
            end
            
        elseif strcmp(plotguide(1,1:3),'cus')
            data = customdataguide{linref,1};
            datatype = customdataguide{linref,2};
            col = customdataguide{linref,3};
            
        elseif strcmp(plotguide(1,1:3),'non')
            datatype = 404;
            
        else
            fprintf(strcat('"',plotguide(1,:),'" is not recognized as one of the available plots'));
            datatype = 404;
            data = [];
        end
        
        %% prepare data for plotting
        if isstruct(data)
            data = data.map;
        end

        
        %% plotting data
        if ~isempty(colormapspecify{linref})
            col = colormapspecify{linref};
        end
        if datatype == 1 %imagesc
%             if size(plotguide,1)>1
%                 col = plotguide{2};
%             end
            if size(data,1)==1
                data = squeeze(data);
            end
            imagesc(axesplot{iH,iV},data);
            %             colormap(axesplot{iH,iV},hsv);
            setcolor(axesplot{iH,iV},col)
            colorbar            
            
            % set reasonable caxis limit (histogram)
            if setlim == 1
                maxlim = max(max(data(nx1:nx2,nx1:nx2)));
                minlim = min(min(data(nx1:nx2,nx1:nx2)));
                caxis([minlim,maxlim])
            end
            
            % set for phase-0 to 2pi only
            if ampplot==1 || phaseplot ==1
                caxis([0 1]);
                colorbar(axesplot{iH,iV},'Ticks',linspace(0,1,7),...
                    'TickLabelInterpreter','tex',...
                    'TickLabels',{'\fontsize{10} 0','\fontsize{10} \pi/3',...
                    '\fontsize{10} 2\pi/3','\fontsize{10}\pi',...
                    '\fontsize{10} 4\pi/3','\fontsize{10} 5\pi/3',...
                    '\fontsize{10} 2\pi'});
                
                %                 if max(max(data))<2*pi*0.98 %give some leeway
                %                     setcolor(axesplot{iH,iV},'Jet');
                %                     colorbar;
                %                 end
            end

            axis square
            axis off
            
            if linref == marksig
                hold on
                [circx,circy]=coord_circ(sig,[size(data,1)/3,size(data,1)/3]);
                plot(axesplot{iH,iV},circx,circy,'k');
            end
            
            if zoom == 1
                xlim([nx1 nx2]);
                ylim([nx1 nx2]);
            end   
            
        elseif datatype == 0 %scatter plot
            
            scatter1 = scatter(axesplot{iH,iV},data(1,:),data(2,:));
            scatter1.MarkerFaceAlpha = scatteralpha;
            scatter1.MarkerFaceColor = 'r';
            scatter1.MarkerEdgeAlpha = 0;
            %             scatter1.SizeData = 40;
            scatter1.SizeData = scattersize;
            xlabel("charge")
            ylabel("pair")
            
            if isempty(lim)==0
                xticks(lim{1})
                xticklabels(lim{2})
                yticks(lim{1})
                yticklabels(lim{2})
            end
            set(axesplot{iH,iV},'Position',[left2,bottom2,siz2,siz2]);
            %             xlim([0,2*pi]);
            %             ylim([0, 2*pi]);
        elseif datatype == 2 % blackwhite inphase check
            axesplot{iH,iV}.Visible = 'off';
            data = abs((data-1)/2);
            str = strcat('phase difference =',num2str(data),' times 2 pi');
            
            labels{iH,iV}.String = str;
            
            imagesc(axesplot{iH,iV},data1.*data2);colorbar;
            axis off
            axis square
            
            if zoom == 1
                xlim([nx1 nx2]);
                ylim([nx1 nx2]);
            end      
            
            
            
        elseif datatype == 3 % ftrho or ftcdw with circles
            Q = sqrt(sum((Braggs(1,:)-center).^2));
            
            x1 = round(center-1.5*Q);
            x2 = 2*center-x1;
            y1 = x1;y2 = x2;
            if manualcrop == 1
                croppoints = croparray{linref};
                x1 = croppoints(3); %imagesc inverts matrix index
                x2 = croppoints(4); % and img_obj_viewer works on imagesc
                y1 = croppoints(1);
                y2 = croppoints(2);
            end
            if size(plotguide,1)>1
                col = plotguide{2};
            end
            if size(data,1)==1
                data = squeeze(data);
            end
            imagesc(axesplot{iH,iV},data);
            setcolor(axesplot{iH,iV},col)
            axis square
            axis off
            
            hold on
            
            refwindow = zeros(size(data));
            integrated_val = zeros(3,1);
            for icirc = 1:3
                px = Braggs(icirc,1);
                py = Braggs(icirc,2);
                [circx,circy]=coord_circ(ksig,[px,py]);
                plot(axesplot{iH,iV},circx,circy,'r');
                
                circwindow = circle_mask(nx,px,py,ksig);
                integrated_val(icirc) = sum(sum(circwindow.*data));
%                 round(px+ksig)
%                 size(data,1)
                refwindow(max(1,round(px-ksig)):min(round(px+ksig),size(data,1))...
                    ,max(1,round(py-ksig)):min(round(py+ksig),size(data,1))) = 1;
            end
            
            xlim([x1,x2]);
            ylim([y1,y2]);
            
            refwindow = refwindow.*data;
            maxlim = max(max(refwindow));
            caxis([0 maxlim])
            
            for icirc = 1:3
                text(Braggs(icirc,1),Braggs(icirc,2)-1.5*ksig,...
                    num2str(integrated_val(icirc),3),'Color','red','FontSize',13)
            end        
            
        elseif datatype == 4 % histogram type (refined for angle)
            data = reshape(data,1,[]);
            histogram(axesplot{iH,iV},data,100);
            
            set(axesplot{iH,iV},'Position',[left2,bottom2,siz2,siz2]);
            xticks(linspace(0,2*pi,7));
            xticklabels({'0','\pi/3','2\pi/3','\pi','4\pi/3','5\pi/3','2\pi'});
            xlim([0,2*pi])
            
        elseif datatype == 5 % raw histogram type
            data = reshape(data,1,[]);
            histogram(axesplot{iH,iV},data,100);
            xlim([min(data) max(data)])
            set(axesplot{iH,iV},'Position',[left2,bottom2,siz2,siz2]);

            
        elseif datatype == 404 % do not plot anything type
            set(axesplot{iH,iV},'Visible','off');
            
        end
        title(plottitle)
        uistack(axesplot{iH,iV},'top');
        output{1,linref} = data;
        
        %% plotbounds if asked
        if plotboundsref(linref)~=0
            
            hold on
            plot(axesplot{iH,iV},[nx1,nx2,nx2,nx1,nx1],[nx1,nx1,nx2,nx2,nx1],'k','LineWidth',2);
            plot(axesplot{iH,iV},[nx1,nx2,nx2,nx1,nx1],[nx1,nx1,nx2,nx2,nx1],'w','LineWidth',1);
            
        end
        
    end
end

%% final adjustment of plotlimits

% manual histogram adjustment
for iH = 1:nhor
    for iV = 1:nvert
        linref = (iV-1)*nhor+iH;
        if plotlimits(linref,1)==1
            ax = axesplot{iH,iV};
            caxis(ax,plotlimits(linref,2:3));
        end
        
    end
end

% if user prompted locking of histograms.
setstolock = max(locklimits);    
if setlim == 1
    nxlow = nx1;nxhigh = nx2;
else
    nxlow = 1;nxhigh = nx;
end
for iL = 1:setstolock
    % for every iteration of sets, lock their caxis limits
    lockindex = find(locklimits==iL);
    lockref = zeros(length(lockindex),3);% lockref(n,:) = [linref min max];
    for jL = 1:length(lockindex)
        linref = lockindex(jL);
        lockref(jL,1) = linref;
        lockref(jL,2) = min(min(output{linref}(nxlow:nxhigh,nxlow:nxhigh)));
        lockref(jL,3) = max(max(output{linref}(nxlow:nxhigh,nxlow:nxhigh)));
    end
    setmin = min(lockref(:,2));
    setmax = max(lockref(:,3));
    
    % set all other sets that are not in consideration to zero
    plotlimits2 = zeros(size(plotlimits));
    plotlimits2(lockindex,:) = plotlimits(lockindex,:);
    if sum(plotlimits(lockindex,1))~=0 %user already specified one of the limits
        linref = find(plotlimits2~=0);
        linref = linref(1);
        setmin = plotlimits(linref,2);
        setmax = plotlimits(linref,3);

    end
    
    for jL = 1:length(lockindex)
        linref = lockindex(jL);
        index2D = linreflookup{linref};
        iH = index2D(1);iV = index2D(2);
        caxis(axesplot{iH,iV},[setmin setmax]);
    end

end

% add circles around some pixels if asked for
% circleguide is a cell, ...{linref,n}.. 
% n: 1,2,3,4: xpoints,ypoints,color,markersize
for iH = 1:nhor
    for iV = 1:nvert
        linref = (iV-1)*nhor+iH;
        if ~isempty(circleguide{linref,1})
            xpoints = circleguide{linref,1};
            ypoints = circleguide{linref,2};
            color = circleguide{linref,3};
            markersize = circleguide{linref,4};
            hold(axesplot{iH,iV},'On')
            plot(axesplot{iH,iV},xpoints,ypoints,color,'MarkerSize',markersize);
        end
        
    end
end




%% functions

    function data = removeedges(data)
        [nx1,nx2] = bounds;
%         nx1 = ceil(nx*remove/2);
%         nx2 = nx-nx1+1;
        data = data(nx1:nx2,nx1:nx2);
    end

    function [nxlo,nxhi] = bounds
        nxlo = ceil(nx*remove/2);
        
        if nxlo < 1
            nxlo = 1;
        end
        nxhi = nx-nxlo+1;
    end

    % this one is to calculate IFT, and only do so if not done before.
    function calculateIFT(rho_or_cdw,peaknumber)
        if IFTexist_tracker(rho_or_cdw,peaknumber)==0
            iBB = peaknumber;
            if iBB>nBrag
                allbragstr = '';
                for kkk = 1:nBrag
                    allbragstr = strcat(allbragstr,',',num2str(Braggs(kkk,1)),',',num2str(Braggs(kkk,2)));
                end
                
                if rho_or_cdw == 1
                    eval(strcat('rhof =inversemask_FTpeak_function(rhomap,ksig',allbragstr,');'));
                    rhofiltered(iBB,:,:) = rhof.map;
                else
                    eval(strcat('cdwf =inversemask_FTpeak_function(cdwmap,ksig',allbragstr,');'));
                    cdwfiltered(iBB,:,:) = cdwf.map;
                end
            else
                if rho_or_cdw ==1
                    rhof = inversemask_FTpeak_function(rhomap,ksig,Braggs(iBB,1),Braggs(iBB,2));
                    rhofiltered(iBB,:,:)= rhof.map;
                else
                    cdwf = inversemask_FTpeak_function(cdwmap,ksig,Braggs(iBB,1),Braggs(iBB,2));
                    cdwfiltered(iBB,:,:)= cdwf.map;
                end
            end
            IFTexist_tracker(rho_or_cdw,peaknumber)=1;
        end
        
    end


    function [rhopoints,chargepoints,lim] = initiatescatter(choice,peaknumber)
        
        isang = 1;
        if isnumeric(choice)
            choiceindex = choice;
        elseif strcmp(choice(1:3),'amp')
            choiceindex = 1;
        elseif strcmp(choice(1:3),'pha')
            choiceindex = 2;
        elseif strcmp(choice(1:3),'loc')
            choiceindex = 3;
            isang = 0;
        else
            choiceindex = 2;
        end
        
        [nxlo,nxhi] = bounds;
%         nxlo = ceil(nx*remove/2);
%         nxhi = nx-nxlo+1;
%         nxsmall = nxhi-nxlo+1;
        % chargepoints = zeros(nBrag,nxsmall*nxsmall);
        % rhopoints = zeros(nBrag,nxsmall*nxsmall);
        
        % for iBrag=1:nBrag
        iBrag = peaknumber;
        %     if directions(iBrag)~=0
        
        cdwtemp = cdwcell{choiceindex,iBrag}.map(nxlo:nxhi,nxlo:nxhi);
        rhotemp = rhocell{choiceindex,iBrag}.map(nxlo:nxhi,nxlo:nxhi);
        
        chargepoints  = reshape(cdwtemp,1,[]);
        rhopoints  = reshape(rhotemp,1,[]);
        
        if isang == 1
            chargepoints = chargepoints/(2*pi);
            rhopoints = rhopoints/(2*pi);
            lim{1} = linspace(0,1,7);
            lim{2} = {'0','\pi/3','2\pi/3','\pi','4\pi/3','5\pi/3','2\pi'};
            if max(chargepoints)<0.4
                lim = [];
            end
        else
            lim = [];
        end
    end

    function [newphase1,newphase2,phaseshift] = optimize_phase(phase1,phase2)
        tolerance = 0.00005*2*pi;
        p = size(phase1,1);
        phase = zeros(1,2*p^2);
        phase(1:p^2) = reshape(phase1,1,p^2);
        phase(p^2+1:end)=reshape(phase2,1,p^2);
        
        phase = sort(phase);
        
        phasecirc = circshift(phase,1);
        phasecirc(1) = phasecirc(1)-2*pi;
        diff = phase-phasecirc;
        [tol,index] = max(diff);
        %         tol
        if tol>tolerance
            phaseshift = phase(index);
        else
            phaseshift = min(phase1(1,1),phase2(1,1));
        end
        
        newphase1 = mod(phase1-phaseshift,2*pi);
        newphase2 = mod(phase2-phaseshift,2*pi);
        
        
    end

    function phasecell=generatecells(map,Braggs,sig)
        phasecell = cell(3,size(Braggs,1));%first index --amp and phase and LockedinAmp, second: 3 Bragg peaks
        for i=1:size(Braggs,1)
            if directions(i)~=0
                Bragx = Braggs(i,1);
                Bragy = Braggs(i,2);
                [amp,phase,lockedinAmp] = gen_phase_map_paper_function(map,Bragx,Bragy,'sig',sig,...
                    'phasename',strcat('Brag',num2str(i),'_phase_'),...
                    'ampname',strcat('Brag',num2str(i),'_amp_'),...
                    'padding',pad);
                phasecell{1,i}=amp;
                phasecell{2,i}=phase;
                phasecell{3,i}=lockedinAmp;
            end
        end
    end


    function setcolor(ax,col)
        color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
        color_map = struct2cell(load([color_map_path col]));
        color_map = color_map{1};
        colormap(ax,color_map);
    end


    function [x,y] = coord_circ(r,center)
        points = 100;
        
        theta = linspace(0,2*pi,points);
        x = r*cos(theta)+center(1);
        y = r*sin(theta)+center(2);
        
        x(end+1) = x(1);
        y(end+1) = y(1);
        
    end

end











