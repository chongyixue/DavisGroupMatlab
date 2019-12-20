function [gmapn, minmapn, gmapp, minmapp]=FeTeSe_test_(data)

map = data.map;
en = data.e;
asp = data.ave';
% get the dimensions of the map: "nx" and "ny" being the spatial size in
% pixel; "nz" the number of energy layers
[nx ny nz]=size(map);
% "gmap" is an empty matrix which will be filled consecutively
gmapn=zeros(nx,ny,1);
minmapn=zeros(nx,ny,1);
gmapp=zeros(nx,ny,1);
minmapp=zeros(nx,ny,1);

for i=1:nx
    for j=1:ny
        
        specn(1:floor(nz/2)) = map(i,j,1:floor(nz/2));
        nspecn = specn/max(specn);
        sel=(max(nspecn)-min(nspecn))/25;
        [maxloc] = peakfinder(nspecn, sel, 0, 1);
        [minloc] = peakfinder(nspecn, sel, 1, -1);
        
        d=1;
        for k=1:length(minloc)
            if minloc(k)-maxloc(end) < 0 
                mp(d) = minloc(k);
                d = d+1;
            end
        end
        
        
        fpvn = en(maxloc(end)); 
        gmapn(i,j) = fpvn;
        
        minmapn(i,j)=specn(max(mp));
        
        clear minloc maxloc mp;
        
        specp(1:(nz-floor(nz/2))) = map(i,j,floor(nz/2)+1:nz);
        nspecp = specp/max(specp);
        sel=(max(nspecp)-min(nspecp))/25;
        [maxloc] = peakfinder(nspecp, sel, 0, 1);
        [minloc] = peakfinder(nspecp, sel, 1, -1);
        
        d=1;
        for k=1:length(minloc)
            if minloc(k)-maxloc(1) > 0 
                mp(d) = minloc(k);
                d = d+1;
            end
        end
        
        
        fpvp = en(floor(nz/2)+maxloc(1));
        gmapp(i,j) = fpvp;
        
        minmapp(i,j) = specp(min(mp));
        
%         spec(1:nz) = map(i,j,1:nz);
%         figure, plot(en,spec)
        
        clear minloc maxloc mp;
        test=1;
    end
end
end

%%

trsh = mean(mean(topo2c))+18*std(std(topo2c));
for i=1:253
    for j=1:253
        if topo2c(i,j,1) >= trsh
        testmask(i,j,1) = 1;
        else
        testmask(i,j,1) = 0;
        end
    end
end

img_plot3(testmask)

%%
function selectfeatures(topo1, topo2, fon)

if strcmp(fon,'ave')
    h = fspecial('average',[3,3]);
    topo1 = imfilter(topo1,h,'replicate');
    topo2 = imfilter(topo2,h,'replicate');
end
    
cpselect(topo2, topo1);
end

function [tformaff, tformpwl] = create_tform_frompoints(movingPoints, fixedPoints, moving, fixed)

moving_pts_adj= cpcorr(movingPoints, fixedPoints, moving, fixed);

tformaff = fitgeotrans(movingPoints,fixedPoints,'Affine');

movregaff = imwarp(moving,tform,'OutputView',imref2d(size(fixed)),'Interp','Cubic');


% or piecewise linear affine transformation

tformpwl = fitgeotrans(movingPoints,fixedPoints,'pwl');

movregpwl = imwarp(moving,tform,'OutputView',imref2d(size(fixed)),'Interp','Cubic');

figure,
subplot(2,2,1)
img_plot3(moving-fixed);
subplot(2,2,2)
img_plot3(movregaff-fixed);
subplot(2,2,3)
img_plot3(movregpwl-fixed);
subplot(2,2,4)
img_plot3(movregff-movregpwl);


end


