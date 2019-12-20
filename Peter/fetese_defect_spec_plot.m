function  fetese_defect_spec_plot(data,bdmap,sdmap)
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

ev = data.e*1000;
map = data.map;
[nx, ny, nel] = size(map);

%% damage track data
ndmap = ones(nx,ny,1) - (bdmap+sdmap);
figure, img_plot4(ndmap)
bdmask = repmat(bdmap,[1,1,nel]);
sdmask = repmat(sdmap,[1,1,nel]);
ndmask = repmat(ndmap,[1,1,nel]);


    
%% calculate the average spectrum and standard deviation for the damage track
%% locations in the 0 T and in field maps
bdspec = squeeze(sum(sum( map .* bdmask))) / sum(sum(bdmap));
sdspec = squeeze(sum(sum( map .* sdmask))) / sum(sum(sdmap));
ndspec = squeeze(sum(sum( map .* ndmask))) / sum(sum(ndmap));
  

%% plot the average spectrum with its standard deviation for the damage track
%% locations
figure; 
hold on
plot(ev,ndspec,'k.-',ev,bdspec,'r.-',ev,sdspec,'b.-','LineWidth',2,'MarkerSize',4)
legend('no defects', 'columnar defects', 'point defects');
xlabel('Energy [meV]');
ylabel('dI/dV [arb. u.]');
xlim([min([ev, ev]), max([ev, ev])]); 
hold off




end

