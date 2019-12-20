function FeSelinecuts(gapdata, seampdata, sephadata, feampdata, fephadata, topodata, cpos, radius, angle, avg_px)


gap_cut = line_cut_topo_angle(gapdata,gapdata.map(:,:,1),cpos,radius,angle,avg_px);

seamp_cut = line_cut_topo_angle(seampdata,seampdata.map(:,:,1),cpos,radius,angle,avg_px);

sepha_cut = line_cut_topo_angle(sephadata,sephadata.map(:,:,1),cpos,radius,angle,avg_px);

feamp_cut = line_cut_topo_angle(feampdata,feampdata.map(:,:,1),cpos,radius,angle,avg_px);

fepha_cut = line_cut_topo_angle(fephadata,fephadata.map(:,:,1),cpos,radius,angle,avg_px);

close all;

topo_cut = line_cut_topo_angle(topodata,topodata.map(:,:,1),cpos,radius,angle,avg_px);

%% Bogoliubov quaisparticle "gap"map <=> steepest slope
bgp = squeeze(gap_cut.cut(:, 3));
bgp = bgp / max(bgp);



r = topo_cut.r;
nr = ceil(length(r)/2);
rd = abs(r(1)-r(2));
k1 = linspace(0,pi/rd,nr);
k2 = linspace(-pi/rd,0,nr);
k = [k2,k1(2:end)];



bgpft = fft(bgp);
bgpft = fftshift(bgpft);

figure, plot(k,abs(bgpft))

%% Coherence peak gap map
gap = squeeze(gap_cut.cut(:,6));
gap = gap / max(gap);

figure, plot(r,topo_cut.cut' / max(abs(topo_cut.cut')),r,bgp,r,gap);

gapft = fft(gap);
gapft = fftshift(gapft);

figure, plot(k,abs(gapft))

%% Se-direction amplitude and phase oscillations at certain energies
%% { 1 = -4.08 meV, 4 = -3.06 meV, 7 = -2.04 meV, 10 = -1.02 meV,
%%  16 = 1.02 meV, 19 = 2.04 meV, 22 = 3.06 meV, 25 = 4.08 meV}

seamp1 = squeeze(seamp_cut.cut(:,1));
seamp1 = seamp1 / max(seamp1);

seamp4 = squeeze(seamp_cut.cut(:,4));
seamp4 = seamp4 / max(seamp4);

seamp7 = squeeze(seamp_cut.cut(:,7));
seamp7 = seamp7 / max(seamp7);

seamp10 = squeeze(seamp_cut.cut(:,10));
seamp10 = seamp10 / max(seamp10);

seamp16 = squeeze(seamp_cut.cut(:,16));
seamp16 = seamp16 / max(seamp16);

seamp19 = squeeze(seamp_cut.cut(:,19));
seamp19 = seamp19 / max(seamp19);

seamp22 = squeeze(seamp_cut.cut(:,22));
seamp22 = seamp22 / max(seamp22);

seamp25 = squeeze(seamp_cut.cut(:,25));
seamp25 = seamp25 / max(seamp25);

sepha1 = squeeze(sepha_cut.cut(:,1));
sepha1 = sepha1 / max(sepha1);

sepha4 = squeeze(sepha_cut.cut(:,4));
sepha4 = sepha4 / max(sepha4);

sepha7 = squeeze(sepha_cut.cut(:,7));
sepha7 = sepha7 / max(sepha7);

sepha10 = squeeze(sepha_cut.cut(:,10));
sepha10 = sepha10 / max(sepha10);

sepha16 = squeeze(sepha_cut.cut(:,16));
sepha16 = sepha16 / max(sepha16);

sepha19 = squeeze(sepha_cut.cut(:,19));
sepha19 = sepha19 / max(sepha19);

sepha22 = squeeze(sepha_cut.cut(:,22));
sepha22 = sepha22 / max(sepha22);

sepha25 = squeeze(sepha_cut.cut(:,25));
sepha25 = sepha25 / max(sepha25);


%% Fe-direction amplitude and phase oscillations at certain energies
%% { 1 = -4.08 meV, 4 = -3.06 meV, 7 = -2.04 meV, 10 = -1.02 meV,
%%  16 = 1.02 meV, 19 = 2.04 meV, 22 = 3.06 meV, 25 = 4.08 meV}

feamp1 = squeeze(feamp_cut.cut(:,1));
feamp1 = feamp1 / max(feamp1);

feamp4 = squeeze(feamp_cut.cut(:,4));
feamp4 = feamp4 / max(feamp4);

feamp7 = squeeze(feamp_cut.cut(:,7));
feamp7 = feamp7 / max(feamp7);

feamp10 = squeeze(feamp_cut.cut(:,10));
feamp10 = feamp10 / max(feamp10);

feamp16 = squeeze(feamp_cut.cut(:,16));
feamp16 = feamp16 / max(feamp16);

feamp19 = squeeze(feamp_cut.cut(:,19));
feamp19 = feamp19 / max(feamp19);

feamp22 = squeeze(feamp_cut.cut(:,22));
feamp22 = feamp22 / max(feamp22);

feamp25 = squeeze(feamp_cut.cut(:,25));
feamp25 = feamp25 / max(feamp25);

fepha1 = squeeze(fepha_cut.cut(:,1));
fepha1 = fepha1 / max(fepha1);

fepha4 = squeeze(fepha_cut.cut(:,4));
fepha4 = fepha4 / max(fepha4);

fepha7 = squeeze(fepha_cut.cut(:,7));
fepha7 = fepha7 / max(fepha7);

fepha10 = squeeze(fepha_cut.cut(:,10));
fepha10 = fepha10 / max(fepha10);

fepha16 = squeeze(fepha_cut.cut(:,16));
fepha16 = fepha16 / max(fepha16);

fepha19 = squeeze(fepha_cut.cut(:,19));
fepha19 = fepha19 / max(fepha19);

fepha22 = squeeze(fepha_cut.cut(:,22));
fepha22 = fepha22 / max(fepha22);

fepha25 = squeeze(fepha_cut.cut(:,25));
fepha25 = fepha25 / max(fepha25);

%% plot the cuts, rvec contains the distance information

rvec = topo_cut.r;

figure; plot(rvec, bgp, rvec, gap, rvec,seamp1, rvec, sepha1, rvec, feamp1, rvec, fepha1 , 'LineWidth',3);
xlabel('r [Angstroem]','fontsize',16,'fontweight','b')
ylabel('Normalized to respective maximum','fontsize',16,'fontweight','b')
title('Cut for amplitude and phase at -4.08 meV','fontsize',20,'fontweight','b')
legend('BQPI <=> ssgap', 'SC-gap', 'Se-Se-ampl.', 'Se-Se-phase', 'Fe-Fe-ampl.', 'Fe-Fe-phase');

figure; plot(rvec, bgp, rvec, gap, rvec,seamp4, rvec, sepha4, rvec, feamp4, rvec, fepha4 , 'LineWidth',3);
xlabel('r [Angstroem]','fontsize',16,'fontweight','b')
ylabel('Normalized to respective maximum','fontsize',16,'fontweight','b')
title('Cut for amplitude and phase at -3.06 meV','fontsize',20,'fontweight','b')
legend('BQPI <=> ssgap', 'SC-gap', 'Se-Se-ampl.', 'Se-Se-phase', 'Fe-Fe-ampl.', 'Fe-Fe-phase');

figure; plot(rvec, bgp, rvec, gap, rvec,seamp7, rvec, sepha7, rvec, feamp7, rvec, fepha7 , 'LineWidth',3);
xlabel('r [Angstroem]','fontsize',16,'fontweight','b')
ylabel('Normalized to respective maximum','fontsize',16,'fontweight','b')
title('Cut for amplitude and phase at -2.04 meV','fontsize',20,'fontweight','b')
legend('BQPI <=> ssgap', 'SC-gap', 'Se-Se-ampl.', 'Se-Se-phase', 'Fe-Fe-ampl.', 'Fe-Fe-phase');

figure; plot(rvec, bgp, rvec, gap, rvec,seamp10, rvec, sepha10, rvec, feamp10, rvec, fepha10 , 'LineWidth',3);
xlabel('r [Angstroem]','fontsize',16,'fontweight','b')
ylabel('Normalized to respective maximum','fontsize',16,'fontweight','b')
title('Cut for amplitude and phase at -1.02 meV','fontsize',20,'fontweight','b')
legend('BQPI <=> ssgap', 'SC-gap', 'Se-Se-ampl.', 'Se-Se-phase', 'Fe-Fe-ampl.', 'Fe-Fe-phase');

figure; plot(rvec, bgp, rvec, gap, rvec,seamp16, rvec, sepha16, rvec, feamp16, rvec, fepha16 , 'LineWidth',3);
xlabel('r [Angstroem]','fontsize',16,'fontweight','b')
ylabel('Normalized to respective maximum','fontsize',16,'fontweight','b')
title('Cut for amplitude and phase at 1.02 meV','fontsize',20,'fontweight','b')
legend('BQPI <=> ssgap', 'SC-gap', 'Se-Se-ampl.', 'Se-Se-phase', 'Fe-Fe-ampl.', 'Fe-Fe-phase');

figure; plot(rvec, bgp, rvec, gap, rvec,seamp19, rvec, sepha19, rvec, feamp19, rvec, fepha19 , 'LineWidth',3);
xlabel('r [Angstroem]','fontsize',16,'fontweight','b')
ylabel('Normalized to respective maximum','fontsize',16,'fontweight','b')
title('Cut for amplitude and phase at 2.04 meV','fontsize',20,'fontweight','b')
legend('BQPI <=> ssgap', 'SC-gap', 'Se-Se-ampl.', 'Se-Se-phase', 'Fe-Fe-ampl.', 'Fe-Fe-phase');

figure; plot(rvec, bgp, rvec, gap, rvec,seamp22, rvec, sepha22, rvec, feamp22, rvec, fepha22 , 'LineWidth',3);
xlabel('r [Angstroem]','fontsize',16,'fontweight','b')
ylabel('Normalized to respective maximum','fontsize',16,'fontweight','b')
title('Cut for amplitude and phase at 3.06 meV','fontsize',20,'fontweight','b')
legend('BQPI <=> ssgap', 'SC-gap', 'Se-Se-ampl.', 'Se-Se-phase', 'Fe-Fe-ampl.', 'Fe-Fe-phase');

figure; plot(rvec, bgp, rvec, gap, rvec,seamp25, rvec, sepha25, rvec, feamp25, rvec, fepha25 , 'LineWidth',3);
xlabel('r [Angstroem]','fontsize',16,'fontweight','b')
ylabel('Normalized to respective maximum','fontsize',16,'fontweight','b')
title('Cut for amplitude and phase at 4.08 meV','fontsize',20,'fontweight','b')
legend('BQPI <=> ssgap', 'SC-gap', 'Se-Se-ampl.', 'Se-Se-phase', 'Fe-Fe-ampl.', 'Fe-Fe-phase');

end