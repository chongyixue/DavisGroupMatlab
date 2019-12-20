function gmap =FeTeSe_gapmap_v2(data, offset, antigap)
%% Extract the gap from a spectroscopic map for each 
%% individual pixel.
%% data is the struct containing the map
%% offset is a numeric value to correct an offset in the voltage during the 
%% measurement
%% antigap contains 6 or 4 energy values, 2 (or 1) pairs defining the positions of the 
%% coherence peaks in the average spectrum, and 1 that determines the energy 
%% region for the in-gap states. If the average LDOS inside the gap is higher 
%% than the average LDOS at the coherence peaks the gap-value at this location 
%% will be set to zero. This will prevent attempts of trying to determine a gap 
%% with not strong gap features in the tunnel spectrum.


%% From Matlab, different methods for interpolation: PCHIP vs SPLINE
        % pchip is local. The behavior of pchip on a particular subinterval
        % is determined by only four points, the two data points on either
        % side of that interval. pchip is unaware of the data farther away.
        % spline is global. The behavior of spline on a particular sub-
        % interval is determined by all of the data, although the sensiti-
        % vity to data far away is less than to nearby data. Both behaviors
        % have their advantages and disadvantages.

%% Get the significant data out of the data struct

% "map" is the spectroscopic map
% "ev" is the vector containing the energies of the spectra
% "asp" is the average spectrum of the map

% ensure that data always starts from the lowest value 
% if data.e(1)  > 0 && data.e(end) < 0
if data.e(1)  > data.e(end)
    ev = fliplr(data.e);
    ev = ev';
    asp = fliplr(data.ave)';
    map = flip(data.map,3);
else
    ev = data.e';
    asp = data.ave';
    map = data.map;
end

% correct for a bias offset if necessary
if isempty(offset)==1
else
    ev = ev + offset;
end 

% "evstr" is the energy vector converted to an array of characters, perhaps
% needed for plotting data
evstr = num2str(ev');


% get the dimensions of the map: "nx" and "ny" being the spatial size in
% pixel; "nz" the number of energy layers
[nx, ny, nz]=size(map);

%% Create empty matrices for the gapmap, antigapmap and pair-breaking impuritymap
% "gmap" is an empty matrix which will be filled consecutively
gmap=zeros(nx,ny,1);
% impmap is the impurity map containing the energy of the pair breaking
% impurities inside the gap
impmap=zeros(nx,ny,1);
% antigapmap is basically a measure of suppression of coherence peaks and
% increase of in-gap states <=> ~ roughly the suppression of the
% superconducting order parameter
antigapmap = zeros(nx, ny, 1);


%% Calculate the gap of the average spectrum
% agv = average gap values
agv = FeTeSe_gapvalues_v2_ave(asp, ev, offset);


%% Start time measurement to get an idea how long it will take
tic 

%% Iniate arrays to store all computed gapmap values used to calculate histograms
% c = 1;
% 
% % cpbs (cpas) = coherence peaks below (above) the chemical potential with an attempt to
% % fit shoulders
% valarra.cpbs = zeros(nx * ny,1);
% valarra.cpas = zeros(nx * ny,1);
% % cpb (cpa) = coherence peaks below (above) the chemical potential
% valarra.cpb = zeros(nx * ny,1);
% valarra.cpa = zeros(nx * ny,1);
% % mean values of cpb+cpa and cpbs+cpas, respectively
% valarra.cpmean = zeros(nx * ny,1);
% valarra.cpmeans = zeros(nx * ny,1);
% % ssb (ssa) = steepest slope below (above) the chemical potential, plus the
% % mean value
% valarra.ssb = zeros(nx * ny,1);
% valarra.ssa = zeros(nx * ny,1);
% valarra.ssmean = zeros(nx * ny,1);

% initiatilze the maps corresponding to the arrays
ssbmap = zeros(nx, ny,1);
ssamap = zeros(nx, ny,1);
ssmmap = zeros(nx, ny,1);

cpbsmap = zeros(nx,ny,1);
cpasmap = zeros(nx,ny,1);
cpmsmap = zeros(nx,ny,1);

cpbmap = zeros(nx,ny,1);
cpamap = zeros(nx,ny,1);
cpmmap = zeros(nx,ny,1);

%% test 
% cc = 1;
% for i=1:100
%     for j=1:100
%         
%         %generate random spectra out of the map FOR TESTING PURPOSES
%         rn = floor(nx*(random('unif', 0, 1, 1, 2)))+1;
%         sp(1:nz) = map(rn(1), rn(2), :);
%         
%         if length(antigap) == 4
%             antigapmap(i,j,1) = mean(sp(antigap(3):antigap(4))) - mean(sp(antigap(1):antigap(2)));
%         elseif length(antigap) == 6
%             antigapmap(i,j,1) = (mean(sp(antigap(3):antigap(4))) + mean(sp(antigap(5):antigap(6)))) /2 - mean(sp(antigap(1):antigap(2)));
%         end
%         
%         % testlayer used to check plot
%         testlayer(i,j,1) = map(i,j,1);
%         
%         if antigapmap(i,j,1) < 0
%         else
%             if cc == 1
%                 shostatold = [];
%                 shostat=FeTeSe_gapvalues_initialize(sp, ev, shostatold);
%                 cc = cc+1;
%             else
%                 if length(shostat.angle) > 1000000
%                 else
%                     shostat=FeTeSe_gapvalues_initialize(sp, ev, shostat);
%                 end
%             end
%         end
% %% End of time measurement for one full cycle of determining the gap value for one pixel
% %% close all figures currently open
% toc        
%         close all;
%     end
% end


%% Two for loops to go through the map, pixel by pixel
for i=1:nx
    for j=1:ny
        
        %generate random spectra out of the map FOR TESTING PURPOSES
%         rn = floor(nx*(random('unif', 0, 1, 1, 2)))+1;
%         sp(1:nz) = map(rn(1), rn(2), :);
        
        % load the spectrum of the coordinate (i,j)
        sp(1:nz) = map(i,j,:);
        %% compare to the smoothed spectrum, comment out if you don't want
        %% to use the smoothed spectrum
        figure, plot(ev,sp,'ko-','LineWidth',2);
        hold on
        % pn = order of polynomial used for smoothing
        pn = 3;
        % np = number of points used in smoothing operation, has to be odd,
        % and bigger than pn
        np = round(length(sp)/5);
        if mod(np,2)==0
            np = np+1;
        end
        sp = sgolayfilt(sp,pn,np);
        plot(ev,sp,'r.-','LineWidth',2);
        hold off
        lstring = {'raw';'smoothed'};
        legend(lstring);
        %% calculate the 'antigapmap'
        
        if length(antigap) == 4
            antigapmap(i,j,1) = (mean(sp(antigap(3):antigap(4))) -...
                mean(sp(antigap(1):antigap(2)))) / mean(sp);
        elseif length(antigap) == 6
            antigapmap(i,j,1) = ((mean(sp(antigap(3):antigap(4))) ...
                + mean(sp(antigap(5):antigap(6)))) /2 -...
                mean(sp(antigap(1):antigap(2)))) / mean(sp);
        end
        
        % testlayer used to check plot
        testlayer(i,j,1) = map(i,j,1);
        %% if the antigapmap has a negative pixel value, or is zero, it's generally not
        %% possible to define a reasonable value for the superconducting gap;
        %% assign zeros to all the values
        if antigapmap(i,j,1) <= 0
%             valarra.cpb(c) = 0;
            cpbmap(i,j,1) = 0;
        
%             valarra.cpa(c) = 0;
            cpamap(i,j,1) = 0;

%             valarra.cpmean(c) = 0;
            cpmmap(i,j,1) = 0;
            
%             valarra.cpbs(c) = 0;
            cpbsmap(i,j,1) = 0;
        
%             valarra.cpas(c) = 0;
            cpasmap(i,j,1) = 0;

%             valarra.cpsmean(c) = 0;
            cpmsmap(i,j,1) = 0;

%             valarra.ssb(c) = 0;
            ssbmap(i,j,1) = 0;
        
%             valarra.ssa(c) = 0;
            ssamap(i,j,1) = 0;
        
%             valarra.ssmean(c) = 0;
            ssmmap(i,j,1) = 0;
            
            
%             valarra.impb(c) = 0;
%             valarra.impa(c) = 0;
%             valarra.impmean(c) = 0;
            
            impmap(i,j,1) = 0;
            impmap(i,j,2) = 0;
            impmap(i,j,3) = 0;
        else
            % calculate the gapvalues 
            gapvalues=FeTeSe_gapvalues_v2(sp, ev, offset);
            
%             valarra.cpbs(c) = gapvalues.bemu;
            cpbsmap(i,j,1) = gapvalues.bemu;
        
%             valarra.cpas(c) = gapvalues.abmu;
            cpasmap(i,j,1) = gapvalues.abmu;

%             valarra.cpsmean(c) = mean(abs([gapvalues.bemu,gapvalues.abmu]));
            cpmsmap(i,j,1) = mean(abs([gapvalues.bemu,gapvalues.abmu]));
            
%             valarra.cpb(c) = gapvalues.bemupeaks;
            cpbmap(i,j,1) = gapvalues.bemupeaks;
        
%             valarra.cpa(c) = gapvalues.abmupeaks;
            cpamap(i,j,1) = gapvalues.abmupeaks;

%             valarra.cpmean(c) = mean(abs([gapvalues.bemupeaks,gapvalues.abmupeaks]));
            cpmmap(i,j,1) = mean(abs([gapvalues.bemupeaks,gapvalues.abmupeaks]));

%             valarra.ssb(c) = gapvalues.ssb;
            ssbmap(i,j,1) = gapvalues.ssb;
        
%             valarra.ssa(c) = gapvalues.ssa;
            ssamap(i,j,1) = gapvalues.ssa;
        
%             valarra.ssmean(c) = mean(abs([gapvalues.ssb,gapvalues.ssa]));
            ssmmap(i,j,1) = mean(abs([gapvalues.ssb,gapvalues.ssa]));


            %% 
%             valarra.impb(c) = gapvalues.impbemu;
%             valarra.impa(c) = gapvalues.impabmu;
%             valarra.impmean(c) = mean(abs([gapvalues.impbemu,gapvalues.impabmu]));
            
            impmap(i,j,1) = gapvalues.impbemu;
            impmap(i,j,2) = gapvalues.impabmu;
            impmap(i,j,3) = mean(abs([gapvalues.impbemu,gapvalues.impabmu]));
        end
%% End of time measurement for one full cycle of determining the gap value for one pixel
%% close all figures currently open
toc        
        close all;
%         c = c+1;
    end
end

%% Measure the total duration of creating the gapmap
toc

%% Write all the different maps into one big 3-d matrix
gmap(:,:,1) = ssamap;
gmap(:,:,2) = ssbmap;
gmap(:,:,3) = ssmmap;
gmap(:,:,4) = cpamap;
gmap(:,:,5) = cpbmap;
gmap(:,:,6) = cpmmap;
gmap(:,:,7) = cpasmap;
gmap(:,:,8) = cpbsmap;
gmap(:,:,9) = cpmsmap;
gmap(:,:,10) = antigapmap;
gmap(:,:,11) = impmap(:,:,1);
gmap(:,:,12) = impmap(:,:,2);
gmap(:,:,13) = impmap(:,:,3);


figure, img_plot4(gmap(:,:,3));
figure, img_plot4(gmap(:,:,6));
figure, img_plot4(gmap(:,:,9));
figure, img_plot4(impmap(:,:,3));
figure, img_plot4(antigapmap);


end
