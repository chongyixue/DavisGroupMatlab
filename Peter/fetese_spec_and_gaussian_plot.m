function [damsig, damsigstd, vorsig, vorsigstd, spectra, specstd] = fetese_spec_and_gaussian_plot(fdamage, fvortices, nomagmap, magmap, topoal, difmap, data,field ,data2 )
% fetese_spec_and_gaussian_plot - takes the collected data of the damage
% tracks and vortices and computes the average spec for both in field and
% without field as well as their standard deviation; additionally it plots
% gaussians for the vortex and damage track positions



% possible colors
% Mac
% color_map_path = '/Users/petersprau/Documents/MATLAB/STM/MATLAB/STM View/Color Maps/';
% Windows
% color_map_path = 'C:\Users\Oliver\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map_path = 'C:\Users\Peter\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';

ev = data.e;
ev2 = data2.e;
nel2 = length(ev2);
[nx, ny, nel] = size(nomagmap);

%% damage track data
damsig = fdamage.msigmaall;

damsigstd = fdamage.stdsigall;

dampert = fdamage.perimeter;

dammask = fdamage.complmask;

dammaskmat = repmat(dammask,[1,1,nel]);
dammaskmat2 = repmat(dammask,[1,1,nel2]);

%% vortex data
vorsig = fvortices.msigmaall;

vorsigstd = fvortices.stdsigall;

vorpert = fvortices.perimeter;

vormask = fvortices.complmask;


vormaskmat = repmat(vormask,[1,1,nel]);
vormaskmat2 = repmat(vormask,[1,1,nel2]);

    
%% calculate the average spectrum and standard deviation for the damage track
%% locations in the 0 T and in field maps
damnomagspec = squeeze(sum(sum( nomagmap .* dammaskmat))) / sum(sum(dammask));
dammagspec = squeeze(sum(sum( magmap .* dammaskmat2))) / sum(sum(dammask));
  
img_plot3(nomagmap(:,:,1).*dammaskmat(:,:,1));

spectra.damnomagspec = damnomagspec;
spectra.dammagspec = dammagspec;

for m=1:nel
    cc = 1;
    for k=1:nx
        for l=1:ny
            if dammask(k,l)==1
                damnomagvec(cc) = nomagmap(k,l,m);
                cc = cc+1;
            end
        end
    end
    damnomagstd(m) =std(damnomagvec);
end

for m=1:nel2
    cc = 1;
    for k=1:nx
        for l=1:ny
            if dammask(k,l)==1
                dammagvec(cc) = magmap(k,l,m);
                cc = cc+1;
            end
        end
    end
    dammagstd(m) =std(dammagvec);
end

specstd.damnomagstd = damnomagstd;
specstd.dammagstd = dammagstd;

img_plot3(dammask);
%% plot the average spectrum with its standard deviation for the damage track
%% locations
figure; 
hold on
errorbar(ev,damnomagspec,damnomagstd,'k.-','LineWidth',2,'MarkerSize',4);
errorbar(ev2,dammagspec,dammagstd,'r.-','LineWidth',2,'MarkerSize',4);
title('Random Mask');
legend('ave. spec. 0 T',['ave. spec. ', num2str(field), ' T'],'Location','Northwest');
xlabel('Energy [meV]');
ylabel('dI/dV [arb. u.]');
xlim([min([ev, ev2]), max([ev, ev2])]); 
hold off
%% calculate the average spectrum and standard deviation for the vortices
%% locations in the 0 T and in field maps
vornomagspec = squeeze(sum(sum( nomagmap .* vormaskmat))) / sum(sum(vormask));
vormagspec = squeeze(sum(sum( magmap .* vormaskmat2))) / sum(sum(vormask));
  
spectra.vornomagspec = vornomagspec;
spectra.vormagspec = vormagspec;

for m=1:nel
    cc = 1;
    for k=1:nx
        for l=1:ny
            if vormask(k,l)==1
                vornomagvec(cc) = nomagmap(k,l,m);
                cc = cc+1;
            end
        end
    end
    vornomagstd(m) =std(vornomagvec);
end

for m=1:nel2
    cc = 1;
    for k=1:nx
        for l=1:ny
            if vormask(k,l)==1
                vormagvec(cc) = magmap(k,l,m);
                cc = cc+1;
            end
        end
    end
    vormagstd(m) =std(vormagvec);
end

specstd.vornomagstd = vornomagstd;
specstd.vormagstd = vormagstd;

img_plot3(vormask);
%% plot the average spectrum with its standard deviation for the vortices
%% locations
figure; 
hold on
errorbar(ev,vornomagspec,vornomagstd,'k.-','LineWidth',2,'MarkerSize',4);
errorbar(ev2,vormagspec,vormagstd,'r.-','LineWidth',2,'MarkerSize',4);
title('Vortices');
legend('ave. spec. 0 T',['ave. spec. ', num2str(field), ' T'],'Location','Northwest');xlabel('Energy [meV]');
ylabel('dI/dV [arb. u.]');
xlim([min([ev, ev2]), max([ev, ev2])]); 
hold off


%% calculate a mask that contains every pixel where no damage track or vortex
%% has been located
nofeatmask = dammask + vormask;

for i=1:nx
    for j=1:ny
        if nofeatmask(i,j,1) > 0
            nofeatmask(i,j,1) = 0;
        else
            nofeatmask(i,j,1) = 1;
        end
    end
end

nofeatmaskmat = repmat(nofeatmask,[1,1,nel]);
nofeatmaskmat2 = repmat(nofeatmask,[1,1,nel2]);
img_plot3(nofeatmask);
%% calculate the average spectrum and standard deviation for the map without
%% vortices or damage track locations in the 0 T and in field maps

nofeatnomagspec = squeeze(sum(sum( nomagmap .* nofeatmaskmat))) / sum(sum(nofeatmask));
nofeatmagspec = squeeze(sum(sum( magmap .* nofeatmaskmat2))) / sum(sum(nofeatmask));
  
spectra.nofeatnomagspec = nofeatnomagspec;
spectra.nofeatmagspec = nofeatmagspec;

for m=1:nel
    cc = 1;
    for k=1:nx
        for l=1:ny
            if nofeatmask(k,l)==1
                nofeatnomagvec(cc) = nomagmap(k,l,m);
                cc = cc+1;
            end
        end
    end
    nofeatnomagstd(m) =std(nofeatnomagvec);
end
    
for m=1:nel2
    cc = 1;
    for k=1:nx
        for l=1:ny
            if nofeatmask(k,l)==1
                nofeatmagvec(cc) = magmap(k,l,m);
                cc = cc+1;
            end
        end
    end
    nofeatmagstd(m) =std(nofeatmagvec);
end
           
specstd.nofeatnomagstd = nofeatnomagstd;
specstd.nofeatmagstd = nofeatmagstd;


%% plot the average spectrum with its standard deviation without vortices
%% or damage track locations
figure; 
hold on
errorbar(ev,nofeatnomagspec,nofeatnomagstd,'k.-','LineWidth',2,'MarkerSize',4);
errorbar(ev2,nofeatmagspec,nofeatmagstd,'r.-','LineWidth',2,'MarkerSize',4);
title('Without damage tracks and vortices');
legend('ave. spec. 0 T',['ave. spec. ', num2str(field), ' T'],'Location','Northwest');xlabel('Energy [meV]');
ylabel('dI/dV [arb. u.]');
xlim([min([ev, ev2]), max([ev, ev2])]); 
hold off


%% plot the average spectra of damage tracks, vortices, and without vortices
%% and damage track locations in one plot without standard deviations with field
%% and without field applied
figure; 
plot(ev,damnomagspec,'r.-',ev, vornomagspec,'b.-',ev,nofeatnomagspec,'k.-',...
'LineWidth',2,'MarkerSize',4);
title('Average spectra 0 T');
legend('ave. spec. dam. tracks','ave. spec. vortices','ave. spec. of rest','Location','Northwest');
xlabel('Energy [meV]');
ylabel('dI/dV [arb. u.]');
xlim([min(ev), max(ev)]); 

figure; 
plot(ev2,dammagspec,'r.-',ev2, vormagspec,'b.-',ev2,nofeatmagspec,'k.-',...
'LineWidth',2,'MarkerSize',4);
title(['Average spectra ', num2str(field), ' T']);
legend('ave. spec. dam. tracks','ave. spec. vortices','ave. spec. of rest','Location','Northwest');
xlabel('Energy [meV]');
ylabel('dI/dV [arb. u.]');
xlim([min(ev2), max(ev2)]); 
%% plot the aligned topo and the Gaussians for the damage tracks and vortices 
img_plot3(topoal)

hold on

for i=1:length(fdamage.fitx)

    dum1 = dampert{i};
    dum2 = dum1{1};
    xxx = dum2(:,2);
    yyy = dum2(:,1);
    plot(xxx,yyy,'-','Color','r','LineWidth',2);
    % line is needed to close the region
    line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','r','LineStyle','-','LineWidth',2);
    

end

for i=1:length(fvortices.fitx)

    dum1 = vorpert{i};
    dum2 = dum1{1};
    xxx = dum2(:,2);
    yyy = dum2(:,1);
    plot(xxx,yyy,'-','Color','b','LineWidth',2);
    % line is needed to close the region
    line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','b','LineStyle','-','LineWidth',2);
    

end

hold off


%% plot the difference map of no field and in-field measurement and the Gaussians
%% for the damage tracks and vortices 

%%
% generate a histogram for difmap.  Will be used for setting
% color axis limit.  
n = 1000;
tmp_layer = reshape(difmap(:,:,1),nx*ny,1);
tmp_std = std(tmp_layer);
% pick a common number of bins based on the largest spread of values in
% one of the layers
n1 = abs((max(tmp_layer) - min(tmp_layer)))/(2*tmp_std)*1000;
n = max(n,floor(n1));    

clear tmp_layer n1 tmp_std;

[histo.freq(1,1:n), histo.val(1,1:n)] = hist(reshape(difmap(:,:,1),nx*ny,1),n);

histo.size = [nx ny 1];

%get the initial color map
color_map = struct2cell(load([color_map_path 'Blue1.mat']));
% color_map = color_map{1};
%initialize color limit values for each layer in caxis
caxis_val = zeros(1,2);

caxis_val(1,1) = min(histo.val(1,:)); % min value for each layer
if isnan(caxis_val(1,1))
    caxis_val(1,1) = 0;
end
caxis_val(1,2) = max(histo.val(1,:)); % max value for each layer
if isnan(caxis_val(1,2))
    caxis_val(1,2) = 0;
end

h = fspecial('average',[3,3]);
msmap = imfilter(difmap,h,'replicate');
%Create the plot
fh = img_plot3(msmap);
ah = gca;

% imagesc((difmap(:,:,1)));
% colormap(color_map); axis off; axis equal; shading flat;
caxis([caxis_val(1,1) caxis_val(1,2)])

%update the UserData in the figure object to store caxis information
set(fh,'UserData',caxis_val);
%%
palette_sel_dialogue(fh,color_map);  

data_histogram_dialogue(1,histo,fh,ah);



%%
keyboard
%%
hold on

for i=1:length(fdamage.fitx)

    dum1 = dampert{i};
    dum2 = dum1{1};
    xxx = dum2(:,2);
    yyy = dum2(:,1);
    plot(xxx,yyy,'-','Color','r','LineWidth',2);
    % line is needed to close the region
    line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','r','LineStyle','-','LineWidth',2);
    

end

for i=1:length(fvortices.fitx)

    dum1 = vorpert{i};
    dum2 = dum1{1};
    xxx = dum2(:,2);
    yyy = dum2(:,1);
    plot(xxx,yyy,'-','Color','b','LineWidth',2);
    % line is needed to close the region
    line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','b','LineStyle','-','LineWidth',2);
    

end

hold off



end

