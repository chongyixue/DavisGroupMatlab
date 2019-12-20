function [rawstruct, complstruct, ftpdata] = Hirschfeld_splusminus_FeSeTe(data, topodata, offset, cs1, cs2, cs3, cs4, cs5, cs6, cr)

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

cm2 = double(circlematrix([nx,ny],cr,cs2(2),cs2(1)));
pn2 = sum(sum(cm2));
cmr2 = repmat(cm2, 1, 1, zlayer);

cm3 = double(circlematrix([nx,ny],cr,cs3(2),cs3(1)));
pn3 = sum(sum(cm3));
cmr3 = repmat(cm3, 1, 1, zlayer);

cm4 = double(circlematrix([nx,ny],cr,cs4(2),cs4(1)));
pn4 = sum(sum(cm4));
cmr4 = repmat(cm4, 1, 1, zlayer);

cm5 = double(circlematrix([nx,ny],cr,cs5(2),cs5(1)));
pn5 = sum(sum(cm5));
cmr5 = repmat(cm5, 1, 1, zlayer);

cm6 = double(circlematrix([nx,ny],cr,cs6(2),cs6(1)));
pn6 = sum(sum(cm6));
cmr6 = repmat(cm6, 1, 1, zlayer);

%% calculate the fourier transforms
pdatas = polyn_subtract2(pdata,0);

mdatas = polyn_subtract2(mdata,0);

asymdatas = polyn_subtract2(asymdata,0);

symdatas = polyn_subtract2(symdata,0);

k = r_to_k_coord(data.r);

ftdata = data;
ftdata.r = k;
ftdata.map = fourier_transform2d_vb(map,'none','amplitude','ft');


ftpdata = pdata;
ftpdata.r = k;
ftpdata.map = fourier_transform2d_vb(pdatas.map,'none','amplitude','ft');
ftpdata.map = ftpdata.map .* (cmr1 + cmr2 + cmr3 + cmr4 + cmr5 + cmr6);

ftmdata = mdata;
ftmdata.r = k;
ftmdata.map = fourier_transform2d_vb(mdatas.map,'none','amplitude','ft');

ftasymdata = asymdata;
ftasymdata.r = k;
ftasymdata.map = fourier_transform2d_vb(asymdatas.map,'none','amplitude','ft');

ftsymdata = symdata;
ftsymdata.r = k;
ftsymdata.map = fourier_transform2d_vb(symdatas.map,'none','amplitude','ft');

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
real_fft_map = fourier_transform2d_vb(map,'none','real','ft');
imag_fft_map = fourier_transform2d_vb(map,'none','imaginary','ft');

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
srp2 = squeeze(sum ( sum ( symrealmap .* (cmr2) ) ) / pn2);
srp3 = squeeze(sum ( sum ( symrealmap .* (cmr3) ) ) / pn3);
srp4 = squeeze(sum ( sum ( symrealmap .* (cmr4) ) ) / pn4);
srp5 = squeeze(sum ( sum ( symrealmap .* (cmr5) ) ) / pn5);
srp6 = squeeze(sum ( sum ( symrealmap .* (cmr6) ) ) / pn6);

arp1 = squeeze(sum ( sum ( asymrealmap .* (cmr1) ) ) / pn1);
arp2 = squeeze(sum ( sum ( asymrealmap .* (cmr2) ) ) / pn2);
arp3 = squeeze(sum ( sum ( asymrealmap .* (cmr3) ) ) / pn3);
arp4 = squeeze(sum ( sum ( asymrealmap .* (cmr4) ) ) / pn4);
arp5 = squeeze(sum ( sum ( asymrealmap .* (cmr5) ) ) / pn5);
arp6 = squeeze(sum ( sum ( asymrealmap .* (cmr6) ) ) / pn6);

sip1 = squeeze(sum ( sum ( symimagmap .* (cmr1) ) ) / pn1);
sip2 = squeeze(sum ( sum ( symimagmap .* (cmr2) ) ) / pn2);
sip3 = squeeze(sum ( sum ( symimagmap .* (cmr3) ) ) / pn3);
sip4 = squeeze(sum ( sum ( symimagmap .* (cmr4) ) ) / pn4);
sip5 = squeeze(sum ( sum ( symimagmap .* (cmr5) ) ) / pn5);
sip6 = squeeze(sum ( sum ( symimagmap .* (cmr6) ) ) / pn6);

aip1 = squeeze(sum ( sum ( asymimagmap .* (cmr1) ) ) / pn1);
aip2 = squeeze(sum ( sum ( asymimagmap .* (cmr2) ) ) / pn2);
aip3 = squeeze(sum ( sum ( asymimagmap .* (cmr3) ) ) / pn3);
aip4 = squeeze(sum ( sum ( asymimagmap .* (cmr4) ) ) / pn4);
aip5 = squeeze(sum ( sum ( asymimagmap .* (cmr5) ) ) / pn5);
aip6 = squeeze(sum ( sum ( asymimagmap .* (cmr6) ) ) / pn6);

%% plot the ratios as a function of energy
pe = pe*1000;

figure, plot(pe, srp1,'r-o', pe, srp2, 'b-s', pe, srp3, 'c-d', pe, srp4, 'm-+',...
     pe, srp5, 'g-*', pe, srp6, 'y-x', 'LineWidth', 2, 'MarkerSize', 15);
title('Symmetrized real part of FT of conductance');
legend('q1', 'q2', 'q3', 'q4', 'q5', 'q6')
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on



figure, plot(pe, arp1,'r-o', pe, arp2, 'b-s', pe, arp3, 'c-d', pe, arp4, 'm-+',...
     pe, arp5, 'g-*', pe, arp6, 'y-x','LineWidth', 2, 'MarkerSize', 15);
title('Anti-symmetrized real part of FT of conductance');
legend('q1', 'q2', 'q3', 'q4', 'q5', 'q6')
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on


figure, plot(pe, sip1,'r-o', pe, sip2, 'b-s', pe, sip3, 'c-d', pe, sip4, 'm-+',...
     pe, sip5, 'g-*', pe, sip6, 'y-x','LineWidth', 2, 'MarkerSize', 15);
title('Symmetrized imaginary part of FT of conductance');
legend('q1', 'q2', 'q3', 'q4', 'q5', 'q6')
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on


figure, plot(pe, aip1,'r-o', pe, aip2, 'b-s', pe, aip3, 'c-d', pe, aip4, 'm-+',...
     pe, aip5, 'g-*', pe, aip6, 'y-x','LineWidth', 2, 'MarkerSize', 15);
title('Anti-symmetrized imaginary part of FT of conductance');
legend('q1', 'q2', 'q3', 'q4', 'q5', 'q6')
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
rectangle('Position',[cs1(1)-cr,cs1(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','r')
rectangle('Position',[cs2(1)-cr,cs2(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','b')
rectangle('Position',[cs3(1)-cr,cs3(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','c')
rectangle('Position',[cs4(1)-cr,cs4(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','m')
rectangle('Position',[cs5(1)-cr,cs5(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','g')
rectangle('Position',[cs6(1)-cr,cs6(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','y')
% plot(cs1(1), cs1(2),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r');
% plot(cs2(1), cs2(2),'Marker', 's', 'MarkerSize', p,'MarkerEdgeColor','b','MarkerFaceColor','b');
% plot(cs3(1), cs3(2),'Marker', 'd', 'MarkerSize', p,'MarkerEdgeColor','c','MarkerFaceColor','c');
% plot(cs4(1), cs4(2),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','m','MarkerFaceColor','m');
% plot(cs5(1), cs5(2),'Marker', '*', 'MarkerSize', p,'MarkerEdgeColor','g','MarkerFaceColor','g');
% plot(cs6(1), cs6(2),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y');
hold off

change_color_of_STM_maps(plusminusdata.map(:,:,zlayer),'ninvert')
hold on
rectangle('Position',[cs1(1)-cr,cs1(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','r')
rectangle('Position',[cs2(1)-cr,cs2(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','b')
rectangle('Position',[cs3(1)-cr,cs3(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','c')
rectangle('Position',[cs4(1)-cr,cs4(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','m')
rectangle('Position',[cs5(1)-cr,cs5(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','g')
rectangle('Position',[cs6(1)-cr,cs6(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','y')
% plot(cs1(1), cs1(2),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r');
% plot(cs2(1), cs2(2),'Marker', 's', 'MarkerSize', p,'MarkerEdgeColor','b','MarkerFaceColor','b');
% plot(cs3(1), cs3(2),'Marker', 'd', 'MarkerSize', p,'MarkerEdgeColor','c','MarkerFaceColor','c');
% plot(cs4(1), cs4(2),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','m','MarkerFaceColor','m');
% plot(cs5(1), cs5(2),'Marker', '*', 'MarkerSize', p,'MarkerEdgeColor','g','MarkerFaceColor','g');
% plot(cs6(1), cs6(2),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y');
hold off

end