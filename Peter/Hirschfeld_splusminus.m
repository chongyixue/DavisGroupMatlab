function [pdata, mdata, asymdata, symdata, ftpdata, ftmdata, ftasymdata, ftsymdata, plusminusdata] = Hirschfeld_splusminus(data, topodata, offset, cs1, cs2, cs3, cs4, cr, radius)


map = data.map;
[nx, ny, nz] = size(map);

ev = data.e;

le = length(ev);

% Find out if the spectrum is both below and above the chemical potential
% or only positive or negative energies wrt to the chem. pot.
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

pmap = zeros(nx, ny, zlayer);
mmap = zeros(nx, ny, zlayer);

for i=1:zlayer
    pmap(:,:,i) = map(:,:,le+1-i) + map(:,:,i);
    mmap(:,:,i) = map(:,:,le+1-i) - map(:,:,i);
    me(i) = ev(i);
    pe(i) = ev(le+1-i);
end

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

%% calculate the fourier transforms
pdatas = polyn_subtract2(pdata,0);
pfft = fourier_transform2d_vb(pdatas.map,'none','amplitude','ft');

mdatas = polyn_subtract2(mdata,0);
mfft = fourier_transform2d_vb(mdatas.map,'none','amplitude','ft');

asymdatas = polyn_subtract2(asymdata,0);
asymfft = fourier_transform2d_vb(asymdatas.map,'none','amplitude','ft');

symdatas = polyn_subtract2(symdata,0);
symfft = fourier_transform2d_vb(symdatas.map,'none','amplitude','ft');

k0 = 2*pi/(nx*abs(data.r(1) - data.r(2)));
%k0=2*pi/(max(data.r)-min(data.r));
%k=linspace(-k0*nc/2,k0*nc/2,nc);
k = linspace(0,k0*nx/2,nx/2+1);
%% Changed 02/26/2014 Peter Sprau from end-1 to end for odd number of pixels
    k = [-1*k(end:-1:1) k(2:end-1)];
% k = [-1*k(end:-1:1) k(2:end)];

ftpdata = pdata;
ftpdata.r = k;
% ftpdata.map = pfft .* (cmr1+cmr2+cmr3+cmr4);
ftpdata.map = fourier_transform2d_vb(pdatas.map,'sine','amplitude','ft');

ftmdata = mdata;
ftmdata.r = k;
% ftmdata.map = mfft .* (cmr1+cmr2+cmr3+cmr4);
ftmdata.map = fourier_transform2d_vb(mdatas.map,'sine','amplitude','ft');

ftasymdata = asymdata;
ftasymdata.r = k;
% ftasymdata.map = asymfft .* (cmr1+cmr2+cmr3+cmr4);
ftasymdata.map = fourier_transform2d_vb(asymdatas.map,'sine','amplitude','ft');

ftsymdata = symdata;
ftsymdata.r = k;
% ftsymdata.map = symfft .* (cmr1+cmr2+cmr3+cmr4);
ftsymdata.map = fourier_transform2d_vb(symdatas.map,'sine','amplitude','ft');

plusminusdata = ftsymdata;
plusminusdata.map = ftsymdata.map - ftasymdata.map;
plusminusdata.var = 'sym. data - asym. data';
%%
% [O,R,lambda]=Hirschfeld_plusminus_expbkgsubtract(symfft,radius);

% bgs = 3;
% pfft=polyn_subtract_no_struct(pfft,k,bgs);
% mfft=polyn_subtract_no_struct(mfft,k,bgs);
% asymfft=polyn_subtract_no_struct(asymfft,k,bgs);
% symfft=polyn_subtract_no_struct(symfft,k,bgs);
% 
% ftpdata.map = pfft;
% ftmdata.map = mfft;
% ftasymdata.map = asymfft;
% ftsymdata.map = symfft;

%% calculate the individual average intensity for the individual q-vectors
%% inside the area defined through the circular masks
pib1 = squeeze(sum ( sum ( pfft .* (cmr1) ) ) / pn1);
pib2 = squeeze(sum ( sum ( pfft .* (cmr2) ) ) / pn2);
pib3 = squeeze(sum ( sum ( pfft .* (cmr3) ) ) / pn3);
pib4 = squeeze(sum ( sum ( pfft .* (cmr4) ) ) / pn4);

mib1 = squeeze(sum ( sum ( mfft .* (cmr1) ) ) / pn1);
mib2 = squeeze(sum ( sum ( mfft .* (cmr2) ) ) / pn2);
mib3 = squeeze(sum ( sum ( mfft .* (cmr3) ) ) / pn3);
mib4 = squeeze(sum ( sum ( mfft .* (cmr4) ) ) / pn4);

asymib1 = squeeze(sum ( sum ( asymfft .* (cmr1) ) ) / pn1);
asymib2 = squeeze(sum ( sum ( asymfft .* (cmr2) ) ) / pn2);
asymib3 = squeeze(sum ( sum ( asymfft .* (cmr3) ) ) / pn3);
asymib4 = squeeze(sum ( sum ( asymfft .* (cmr4) ) ) / pn4);

symib1 = squeeze(sum ( sum ( symfft .* (cmr1) ) ) / pn1);
symib2 = squeeze(sum ( sum ( symfft .* (cmr2) ) ) / pn2);
symib3 = squeeze(sum ( sum ( symfft .* (cmr3) ) ) / pn3);
symib4 = squeeze(sum ( sum ( symfft .* (cmr4) ) ) / pn4);

%% define ratios without mixing symmetrized and assymmetrized conductance

pr2a2b = pib1 ./ pib2;
pr3a3b = pib3 ./ pib4;
pr2a3 = 2*pib1 ./ (pib3+pib4);
pr2b3 = 2*pib2 ./ (pib3+pib4);

mr2a2b = mib1 ./ mib2;
mr3a3b = mib3 ./ mib4;
mr2a3 = 2*mib1 ./ (mib3+mib4);
mr2b3 = 2*mib2 ./ (mib3+mib4);

asyr2a2b = asymib1 ./ asymib2;
asyr3a3b = asymib3 ./ asymib4;
asyr2a3 = 2*asymib1 ./ (asymib3+asymib4);
asyr2b3 = 2*asymib2 ./ (asymib3+asymib4);

syr2a2b = symib1 ./ symib2;
syr3a3b = symib3 ./ symib4;
syr2a3 = 2*symib1 ./ (symib3+symib4);
syr2b3 = 2*symib2 ./ (symib3+symib4);

%% define ratios without mixing symmetrized and assymmetrized conductance

r2ad = symib1 ./ asymib1;
r2bd = symib2 ./ asymib2;
r3d = (symib3 + symib4) ./ (asymib3 + asymib4);

%% plot the ratios as a function of energy
pe = pe*1000;

figure, plot(pe, pr2a2b,'-o', pe, pr3a3b, '-o', pe, pr2a3, '-o', pe, pr2b3, '-o',...
     'LineWidth', 2);
title(' E > \mu');
legend('R_{2a,2b}', 'R_{3a,3b}', 'R_{2a,3}', 'R_{2b,3}')
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('Integrated intensity ratios');

figure, plot(pe, mr2a2b,'-o', pe, mr3a3b, '-o', pe, mr2a3, '-o', pe, mr2b3, '-o',...
     'LineWidth', 2);
title(' E < \mu');
legend('R_{2a,2b}', 'R_{3a,3b}', 'R_{2a,3}', 'R_{2b,3}')
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('Integrated intensity ratios');

figure, plot(pe, syr2a2b,'-o', pe, syr3a3b, '-o', pe, syr2a3, '-o', pe, syr2b3, '-o',...
     'LineWidth', 2);
title(' \delta^+');
legend('R_{2a,2b}', 'R_{3a,3b}', 'R_{2a,3}', 'R_{2b,3}')
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('Integrated intensity ratios');

figure, plot(pe, asyr2a2b,'-o', pe, asyr3a3b, '-o', pe, asyr2a3, '-o', pe, asyr2b3, '-o',...
     'LineWidth', 2);
title(' \delta^-');
legend('R_{2a,2b}', 'R_{3a,3b}', 'R_{2a,3}', 'R_{2b,3}')
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('Integrated intensity ratios');

figure, plot(pe, r2ad,'-o', pe, r2bd, '-o', pe, r3d, '-o', ...
     'LineWidth', 2);
title(' \delta^{+-}');
legend('R_{2a,\delta^{+-}}', 'R_{2b,\delta^{+-}}', 'R_{3,\delta^{+-}}')
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('Integrated intensity ratios');

%% plot the locations of the vectors in the fft of both the topograph and 
%% a layer of the asymmetrized FT{dI/dV}


% figure; imagesc(map(:,:,zlayer))
change_color_of_STM_maps(asymfft(:,:,length(pe)),'ninvert')
hold on
rectangle('Position',[cs1(1)-cr,cs1(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','r')
rectangle('Position',[cs2(1)-cr,cs2(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','b')
rectangle('Position',[cs3(1)-cr,cs3(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor',[245/256,197/256,44/256])
rectangle('Position',[cs4(1)-cr,cs4(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','m')
hold off

change_color_of_STM_maps(topodata.map,'ninvert')
hold on
rectangle('Position',[cs1(1)-cr,cs1(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','r')
rectangle('Position',[cs2(1)-cr,cs2(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','b')
rectangle('Position',[cs3(1)-cr,cs3(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor',[245/256,197/256,44/256])
rectangle('Position',[cs4(1)-cr,cs4(2)-cr,2*cr,2*cr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','m')
hold off

end