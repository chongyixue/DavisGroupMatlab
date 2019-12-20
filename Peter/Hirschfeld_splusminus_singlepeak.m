function [rawstruct, complstruct, ftpdata] = Hirschfeld_splusminus_singlepeak(data, topodata, offset, cs1, cr, pc)

% size of map
rawmap = data.map;
[nx, ny, nz] = size(rawmap);

% energies of map
ev = data.e;
le = length(ev);

% Find the energy layer corresponding to the chemical potential if the
% number of layers is odd, or corresponding to the layer closest to the
% chemical potential in the case of an even number of layers
if mod(le, 2) == 0
    zlayer = le - le/2;
else
    for j = 1:le
        if ev(j) == 0+offset
            zlayer = j;
        end
    end
    zlayer = zlayer - 1;
end

% subtract the average background from the map
new_data=polyn_subtract2(data,0);
map = new_data.map;


%% calculate the symmetrized and antisymmetrized conductance of the raw map
%% in real space
pmap = zeros(nx, ny, zlayer);
mmap = zeros(nx, ny, zlayer);

for i=1:zlayer
    pmap(:,:,i) = rawmap(:,:,le+1-i) + rawmap(:,:,i);
    mmap(:,:,i) = rawmap(:,:,le+1-i) - rawmap(:,:,i);
    me(i) = ev(i);
    pe(i) = ev(le+1-i);
end

%% create data structs that contain the data above chem. pot., below 
%% chem. pot., symmetrized and asymmetrized dI/dV

pdata = data;
mdata = data;
asymdata = data;
symdata = data;

if mod(le, 2) == 0
    pdata.map = flip( map(:,:,zlayer+1:le),3 );
else
    pdata.map = flip( map(:,:,zlayer+2:le),3 );
end
pdata.e = pe;
pdata.ave = squeeze(mean(mean(pdata.map)));
pdata.var = 'above chem. pot.';

mdata.map = map(:,:,1:zlayer);
mdata.e = me;
mdata.ave = squeeze(mean(mean(mdata.map)));
mdata.var = 'below chem. pot.';

asymdata.map = mmap;
asymdata.e = abs(me);
asymdata.ave = squeeze(mean(mean(asymdata.map)));
asymdata.var = 'asym. data';

symdata.map = pmap;
symdata.e = abs(me);
symdata.ave = squeeze(mean(mean(symdata.map)));
symdata.var = 'sym. data';

%% accumulate rawdata in one structure
rawstruct.rawdata = data;
rawstruct.acpdata = pdata;
rawstruct.bcpdata = mdata;
rawstruct.symdata = symdata;
rawstruct.asymdata = asymdata;


%%
%% create the masks that will be used to select only areas of maps with the 
%% relevant q-vectors inside
cm1 = double(circlematrix([nx,ny],cr,cs1(2),cs1(1)));
pn1 = sum(sum(cm1));
cmr1 = repmat(cm1, 1, 1, zlayer);


%% calculate the fourier transforms
pdatas = polyn_subtract2(pdata,0);

mdatas = polyn_subtract2(mdata,0);

asymdatas = polyn_subtract2(asymdata,0);

symdatas = polyn_subtract2(symdata,0);

k = r_to_k_coord(data.r);

ftdata = data;
ftdata.r = k;
ftdata.map = fourier_transform2d_vb(map,'sine','amplitude','ft');


ftpdata = pdata;
ftpdata.r = k;
ftpdata.map = fourier_transform2d_vb(pdatas.map,'sine','amplitude','ft');
ftpdata.map = ftpdata.map .* (cmr1);

ftmdata = mdata;
ftmdata.r = k;
ftmdata.map = fourier_transform2d_vb(mdatas.map,'sine','amplitude','ft');

ftasymdata = asymdata;
ftasymdata.r = k;
ftasymdata.map = fourier_transform2d_vb(asymdatas.map,'sine','amplitude','ft');

ftsymdata = symdata;
ftsymdata.r = k;
ftsymdata.map = fourier_transform2d_vb(symdatas.map,'sine','amplitude','ft');

plusminusdata = ftsymdata;
plusminusdata.map = ftsymdata.map - ftasymdata.map;
plusminusdata.var = 'sym. data - asym. data';


%% accumulate all FTS of rawdata in one structure
rawstruct.rawdata_ft = ftdata;
rawstruct.acpdata_ft = ftpdata;
rawstruct.bcpdata_ft = ftmdata;
rawstruct.symdata_ft = ftsymdata;
rawstruct.asymdata_ft = ftasymdata;
rawstruct.ampl_plusminus = plusminusdata;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% real part of FT used to produce the energy dependent line plot
real_fft_map = fourier_transform2d_vb(map,'sine','real','ft');
imag_fft_map = fourier_transform2d_vb(map,'sine','imaginary','ft');

%% calculate the symmetrized and antisymmetrized conductance of the real 
%% part of the FT map where the constant background has been subtracted in 
%% q space

symrealmap = zeros(nx, ny, zlayer);
asymrealmap = zeros(nx, ny, zlayer);
symimagmap = zeros(nx, ny, zlayer);
asymimagmap = zeros(nx, ny, zlayer);

for i=1:zlayer
    symrealmap(:,:,i) = real_fft_map(:,:,le+1-i) + real_fft_map(:,:,i);
    asymrealmap(:,:,i) = real_fft_map(:,:,le+1-i) - real_fft_map(:,:,i);
    symimagmap(:,:,i) = imag_fft_map(:,:,le+1-i) + imag_fft_map(:,:,i);
    asymimagmap(:,:,i) = imag_fft_map(:,:,le+1-i) - imag_fft_map(:,:,i);
end

ftsymrealdata = symdata;
ftsymrealdata.r = k;
ftsymrealdata.map = symrealmap;

ftasymrealdata = symdata;
ftasymrealdata.r = k;
ftasymrealdata.map = asymrealmap;

ftsymimagdata = symdata;
ftsymimagdata.r = k;
ftsymimagdata.map = symimagmap;

ftasymimagdata = symdata;
ftasymimagdata.r = k;
ftasymimagdata.map = asymimagmap;

ftrealdata_pm = symdata;
ftrealdata_pm.r = k;
ftrealdata_pm.map = abs(symrealmap)-abs(asymrealmap);
ftrealdata_pm.var = 'sym. data - asym. data - real';

ftimagdata_pm = symdata;
ftimagdata_pm.r = k;
ftimagdata_pm.map = abs(symimagmap)-abs(asymimagmap);
ftimagdata_pm.var = 'sym. data - asym. data - imag';

complstruct.ftsymrealdata = ftsymrealdata;
complstruct.ftasymrealdata = ftasymrealdata;
complstruct.ftsymimagdata = ftsymimagdata;
complstruct.ftasymimagdata = ftasymimagdata;
complstruct.ftrealdata_pm = ftrealdata_pm;
complstruct.ftimagdata_pm = ftimagdata_pm;

%% calculate the individual average intensity for the individual q-vectors
%% inside the area defined through the circular masks
srp1 = squeeze(sum ( sum ( symrealmap .* (cmr1) ) ) / pn1);

arp1 = squeeze(sum ( sum ( asymrealmap .* (cmr1) ) ) / pn1);

sip1 = squeeze(sum ( sum ( symimagmap .* (cmr1) ) ) / pn1);

aip1 = squeeze(sum ( sum ( asymimagmap .* (cmr1) ) ) / pn1);


%% plot the ratios as a function of energy
pe = abs(pe)*1000;

figure, plot(pe, srp1,'r-o','color',pc, 'LineWidth', 2, 'MarkerSize', 15);
title('Symmetrized real part of FT of conductance');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on


figure, plot(pe, arp1,'r-o','color',pc, 'LineWidth', 2, 'MarkerSize', 15);
title('Anti-symmetrized real part of FT of conductance');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

figure, plot(pe, sip1,'r-o','color',pc, 'LineWidth', 2, 'MarkerSize', 15);
title('Symmetrized imaginary part of FT of conductance');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

figure, plot(pe, aip1,'r-o','color',pc, 'LineWidth', 2, 'MarkerSize', 15);
title('Anti-symmetrized imaginary part of FT of conductance');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on


%% plot the locations of the vectors in the fft of the topograph 

% change_color_of_STM_maps(asymfft(:,:,length(pe)),'ninvert')
% hold on
% rectangle('Position',[cs1(1)-cr,cs1(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','r')
% rectangle('Position',[cs2(1)-cr,cs2(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','b')
% rectangle('Position',[cs3(1)-cr,cs3(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','c')
% rectangle('Position',[cs4(1)-cr,cs4(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','m')
% hold off


topo_fft = fourier_transform2d_vb(topodata.map,'sine','amplitude','ft');
p = 10;
change_color_of_STM_maps(topo_fft,'ninvert')
hold on
rectangle('Position',[cs1(1)-cr,cs1(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor',pc)
% plot(cs1(1), cs1(2),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r');
% plot(cs2(1), cs2(2),'Marker', 's', 'MarkerSize', p,'MarkerEdgeColor','b','MarkerFaceColor','b');
% plot(cs3(1), cs3(2),'Marker', 'd', 'MarkerSize', p,'MarkerEdgeColor','c','MarkerFaceColor','c');
% plot(cs4(1), cs4(2),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','m','MarkerFaceColor','m');
% plot(cs5(1), cs5(2),'Marker', '*', 'MarkerSize', p,'MarkerEdgeColor','g','MarkerFaceColor','g');
% plot(cs6(1), cs6(2),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y');
hold off

change_color_of_STM_maps(plusminusdata.map(:,:,zlayer),'ninvert')
hold on
rectangle('Position',[cs1(1)-cr,cs1(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor',pc)
% plot(cs1(1), cs1(2),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r');
% plot(cs2(1), cs2(2),'Marker', 's', 'MarkerSize', p,'MarkerEdgeColor','b','MarkerFaceColor','b');
% plot(cs3(1), cs3(2),'Marker', 'd', 'MarkerSize', p,'MarkerEdgeColor','c','MarkerFaceColor','c');
% plot(cs4(1), cs4(2),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','m','MarkerFaceColor','m');
% plot(cs5(1), cs5(2),'Marker', '*', 'MarkerSize', p,'MarkerEdgeColor','g','MarkerFaceColor','g');
% plot(cs6(1), cs6(2),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y');
hold off

end