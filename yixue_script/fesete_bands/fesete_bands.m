% 2019-6-25 YXC
% band structure from  Observation of topological superconductivity on the surface of an iron-based superconductor
% 2018 paper

fesete_scaled = fesete_dispersion;

% t ranges from 12 to 25 mV depending on bands. let's assume they are all
% 19mV
fesete_scaled(:,1:4) = fesete_scaled(:,1:4)*19*2;

k = fesete_scaled(:,5);
band1 = fesete_scaled(:,1);
band2 = fesete_scaled(:,2);
band3 = fesete_scaled(:,3);
band4 = fesete_scaled(:,4);

figure,plot(band2)
% 248 is Gamma point, 1 is M point, 401(=end) is Z point
