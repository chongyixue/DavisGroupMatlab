function [mvmap1T, mv2map1T]=zbiasvortexradius2(data, vfeat1,vfeat2,vfeat3,vfeat4,vfeat5, radius,vortexnumber1,vortexnumber2,vortexnumber3,vortexnumber4,vortexnumber5,msdmapco)

piezo = data.r(2) - data.r(1);

radius = radius / (piezo);

ev = data.e;
map = data.map;

le = length(ev);

for j = 1:le
    if ev(j) == 0
        zlayer = j;
    end
end


zbmap = map(:,:,zlayer);
[nx,ny,nz] = size(zbmap);

opsmap = zeros(nx, ny, 1);
avespec = zeros(length(data.e),1);
avespecall = zeros(length(data.e),1);

t = 1;
tt = 1;
for i=1:nx
    for j=1:ny
        opsmap(i,j,1) = (mean(map(i,j,6:8))+mean(map(i,j,14:16)))/2 - mean(map(i,j,10:12));
        avespecall = avespecall + squeeze(map(i,j,:));
        tt = tt + 1;
        if opsmap(i,j,1) >= 30
            avespec = avespec + squeeze(map(i,j,:));
            t = t+1;
        end
    end
end

%%
[nx, ny, nz] = size(opsmap);
%%
% generate a histogram for difmap.  Will be used for setting
% color axis limit.  
% n = 1000;
% tmp_layer = reshape(opsmap,nx*ny,1);
% tmp_std = std(tmp_layer);
% % pick a common number of bins based on the largest spread of values in
% % one of the layers
% n1 = abs((max(tmp_layer) - min(tmp_layer)))/(2*tmp_std)*1000;
% n = max(n,floor(n1));    
% 
% clear tmp_layer n1 tmp_std;
% 
% % [histo.freq(1,1:n), histo.val(1,1:n)] = hist(reshape(opsmap(:,:,1),nx*ny,1),n);
% 
% 
% 
% 
% x0 = [max(histo.freq),mean(histo.val),mean(histo.val)];
% lb = [0,0,0];
% ub = [5*max(histo.freq),10*mean(histo.val),10*mean(histo.val)];
% 
% options = optimset('Algorithm','trust-region-reflective',...  % according to MATLAB the only one that allows bounds
%                    'TolX',1e-6,...
%                    'MaxIter',10000,...
%                    'MaxFunEvals',10000);
% 
% %% Fit to Gaussian
% 
% % xint=lsqcurvefit(@twodgauss,x0,xdata,zdata,lb,ub,options);
% [x,resnorm,residual]=lsqcurvefit(@onedgauss,x0,histo.val(1,1:n),histo.freq(1,1:n),lb,ub,options);
% finalfit=onedgauss(x,histo.val(1,1:n));
% figure, plot(histo.val(1,1:n),histo.freq(1,1:n),histo.val(1,1:n),finalfit,'r','LineWidth',2);
% test = 1;
%%




avespec = avespec/t;
avespecall = avespecall/tt;
figure, plot(data.e,avespec,'k',data.e,avespecall,'r');
legend('>= 30 in anti-gapmap','avespec');

zbmap = opsmap;



mvmap1T = zeros(nx, ny, 1);
mv2map1T = zeros(nx, ny, 1);
mv3map1T = zeros(nx, ny, 1);
mvmap2T = zeros(nx, ny, 1);
mv2map2T = zeros(nx, ny, 1);
mv3map2T = zeros(nx, ny, 1);
mvmap3T = zeros(nx, ny, 1);
mv2map3T = zeros(nx, ny, 1);
mv3map3T = zeros(nx, ny, 1);
mvmap4T = zeros(nx, ny, 1);
mv2map4T = zeros(nx, ny, 1);
mv3map4T = zeros(nx, ny, 1);
mvmap6T = zeros(nx, ny, 1);
mv2map6T = zeros(nx, ny, 1);
mv3map6T = zeros(nx, ny, 1);


% test1 = bwarea(mvmap1T);
% test2 = bwarea(ones(nx,ny,1));

change_color_of_STM_maps(zbmap,'noinvert');

hold on

for i=1:vortexnumber1
    
    mx = vfeat1.fity(i);
    my = vfeat1.fitx(i);
    cm=circlematrix([nx,ny],radius,mx,my);
    mvmap1T = mvmap1T + double(cm);
    
    cm2=circlematrix([nx,ny],2*radius,mx,my);
    mv2map1T = mv2map1T + double(cm2);
    
%     test3 = bwarea(mv2map1T);
    
    cm3=circlematrix([nx,ny],3*radius,mx,my);
    mv3map1T = mv3map1T + double(cm3);
    
%     test4 = bwarea(mv2map1T);
    test5 =1;
%     w = 2*radius;
%     h = w;
%     x = mx - radius;
%     y = my - radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','r','LineStyle','-','LineWidth',2);
    
%     w = 4*radius;
%     h = w;
%     x = mx - 2*radius;
%     y = my - 2*radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','r','LineStyle','-','LineWidth',2);
    
    
end

for i=1:vortexnumber2
    
    mx = vfeat2.fity(i);
    my = vfeat2.fitx(i);
    cm=circlematrix([nx,ny],radius,mx,my);
    mvmap2T = mvmap2T + double(cm);
    
    cm2=circlematrix([nx,ny],2*radius,mx,my);
    mv2map2T = mv2map2T + double(cm2);
    
    cm3=circlematrix([nx,ny],3*radius,mx,my);
    mv3map2T = mv3map2T + double(cm3);
    
%     w = 2*radius;
%     h = w;
%     x = mx - radius;
%     y = my - radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','r','LineStyle','-','LineWidth',2);
    
%     w = 4*radius;
%     h = w;
%     x = mx - 2*radius;
%     y = my - 2*radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','b','LineStyle','-','LineWidth',2);
    
    
end

for i=1:vortexnumber3
    
    mx = vfeat3.fity(i);
    my = vfeat3.fitx(i);
    cm=circlematrix([nx,ny],radius,mx,my);
    mvmap3T = mvmap3T + double(cm);
    
    cm2=circlematrix([nx,ny],2*radius,mx,my);
    mv2map3T = mv2map3T + double(cm2);
    
    cm3=circlematrix([nx,ny],3*radius,mx,my);
    mv3map3T = mv3map3T + double(cm3);
    
%     w = 2*radius;
%     h = w;
%     x = mx - radius;
%     y = my - radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','r','LineStyle','-','LineWidth',2);
    
    w = 4*radius;
    h = w;
    x = mx - 2*radius;
    y = my - 2*radius;
    rectangle('position',[y,x,w,h],...
        'Curvature',[1,1],'EdgeColor','k','LineStyle','-','LineWidth',2);
%     
    
end

for i=1:vortexnumber4
    
    mx = vfeat4.fity(i);
    my = vfeat4.fitx(i);
    cm=circlematrix([nx,ny],radius,mx,my);
    mvmap4T = mvmap4T + double(cm);
    
    cm2=circlematrix([nx,ny],2*radius,mx,my);
    mv2map4T = mv2map4T + double(cm2);
    
    cm3=circlematrix([nx,ny],3*radius,mx,my);
    mv3map4T = mv3map4T + double(cm3);
    
%     w = 2*radius;
%     h = w;
%     x = mx - radius;
%     y = my - radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','r','LineStyle','-','LineWidth',2);
    
%     w = 4*radius;
%     h = w;
%     x = mx - 2*radius;
%     y = my - 2*radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','k','LineStyle','-','LineWidth',2);
    
    
end

for i=1:vortexnumber5
    
    mx = vfeat5.fity(i);
    my = vfeat5.fitx(i);
    cm=circlematrix([nx,ny],radius,mx,my);
    mvmap6T = mvmap6T + double(cm);
    
    cm2=circlematrix([nx,ny],2*radius,mx,my);
    mv2map6T = mv2map6T + double(cm2);
    
    cm3=circlematrix([nx,ny],3*radius,mx,my);
    mv3map6T = mv3map6T + double(cm3);
    
%     w = 2*radius;
%     h = w;
%     x = mx - radius;
%     y = my - radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','r','LineStyle','-','LineWidth',2);
    
%     w = 4*radius;
%     h = w;
%     x = mx - 2*radius;
%     y = my - 2*radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','k','LineStyle','-','LineWidth',2);
    
    
end

mvmap1T = im2bw(mvmap1T,0);
mv2map1T = im2bw(mv2map1T,0);
mv3map1T = im2bw(mv3map1T,0);
mvmap2T = im2bw(mvmap2T,0);
mv2map2T = im2bw(mv2map2T,0);
mv3map2T = im2bw(mv3map2T,0);
mvmap3T = im2bw(mvmap3T,0);
mv2map3T = im2bw(mv2map3T,0);
mv3map3T = im2bw(mv3map3T,0);
mvmap4T = im2bw(mvmap4T,0);
mv2map4T = im2bw(mv2map4T,0);
mv3map4T = im2bw(mv3map4T,0);
mvmap6T = im2bw(mvmap6T,0);
mv2map6T = im2bw(mv2map6T,0);
mv3map6T = im2bw(mv3map6T,0);



hold off

figure, img_plot5(mvmap1T)
figure, img_plot5(mv2map1T)
figure, img_plot5(mv3map1T)

figure, img_plot5(mvmap2T)
figure, img_plot5(mv2map2T)
figure, img_plot5(mv3map2T)

figure, img_plot5(mvmap3T)
figure, img_plot5(mv2map3T)
figure, img_plot5(mv3map3T)

figure, img_plot5(mvmap4T)
figure, img_plot5(mv2map4T)
figure, img_plot5(mv3map4T)

figure, img_plot5(mvmap6T)
figure, img_plot5(mv2map6T)
figure, img_plot5(mv3map6T)

epv = 15.94;
epvl = epv - 6.65;
epvh = epv + 6.65;

ops1T = mv2map1T .* opsmap;
ops2T = mv2map2T .* opsmap;
ops3T = mv2map3T .* opsmap;
ops4T = mv2map4T .* opsmap;
ops6T = mv2map6T .* opsmap;


ideal1T = sum(sum(mv2map1T * max(max(opsmap)))) / sum(sum(mv2map1T));
actual1T = sum(sum(mv2map1T .* opsmap)) / sum(sum(mv2map1T));

ideal2T = sum(sum(mv2map2T * max(max(opsmap)))) / sum(sum(mv2map2T));
actual2T = sum(sum(mv2map2T .* opsmap)) / sum(sum(mv2map2T));

ideal3T = sum(sum(mv2map3T * max(max(opsmap)))) / sum(sum(mv2map3T));
actual3T = sum(sum(mv2map3T .* opsmap)) / sum(sum(mv2map3T));

ideal4T = sum(sum(mv2map4T * max(max(opsmap)))) / sum(sum(mv2map4T));
actual4T = sum(sum(mv2map4T .* opsmap)) / sum(sum(mv2map4T));

ideal6T = sum(sum(mv2map6T * max(max(opsmap)))) / sum(sum(mv2map6T));
actual6T = sum(sum(mv2map6T .* opsmap)) / sum(sum(mv2map6T));

t1 = 1;
t2 = 1;
t3 = 1;
t4 = 1;
t5 = 1;


for i=1:nx
    for j=1:ny
        
        if  abs(ops1T(i,j,1)) > 0
            ops1Tvec(t1) = ops1T(i,j,1);
            t1 = t1+1;
        end
        
        if  abs(ops2T(i,j,1)) > 0
            ops2Tvec(t2) = ops2T(i,j,1);
            t2 = t2+1;
        end
        if  abs(ops3T(i,j,1)) > 0
            ops3Tvec(t3) = ops3T(i,j,1);
            t3 = t3+1;
        end
        if  abs(ops4T(i,j,1)) > 0
            ops4Tvec(t4) = ops4T(i,j,1);
            t4 = t4+1;
        end
        if  abs(ops6T(i,j,1)) > 0
            ops6Tvec(t5) = ops6T(i,j,1);
            t5 = t5+1;
        end
    end
end
% figure, plot(1,ideal1T,'ko',1,actual1T,'ro',2,ideal2T,'ko',2,actual2T,'ro',...
%     3,ideal3T,'ko',3,actual3T,'ro',4,ideal4T,'ko',4,actual4T,'ro',...
%     6,ideal6T,'ko',6,actual6T,'ro');

figure, bar([1,2,3,4,6],[actual1T,actual2T,...
    actual3T,actual4T,actual6T],0.5);
title('2 sigma')
hold on
plot([0,1,2,3,4,5,6,6.5],[epv,epv,epv,epv,epv,epv,epv,epv],'k');
plot([0,1,2,3,4,5,6,6.5],[epvl,epvl,epvl,epvl,epvl,epvl,epvl,epvl],'r');
plot([0,1,2,3,4,5,6,6.5],[epvh,epvh,epvh,epvh,epvh,epvh,epvh,epvh],'r');
errorbar(1,mean(ops1Tvec),std(ops1Tvec),'r');
errorbar(2,mean(ops2Tvec),std(ops2Tvec),'r');
errorbar(3,mean(ops3Tvec),std(ops3Tvec),'r');
errorbar(4,mean(ops4Tvec),std(ops4Tvec),'r');
errorbar(6,mean(ops6Tvec),std(ops6Tvec),'r');
hold off

clear actual1T actual2T actual3T actual4T actual6T

ideal1T = sum(sum(mvmap1T * max(max(opsmap)))) / sum(sum(mvmap1T));
actual1T = sum(sum(mvmap1T .* opsmap)) / sum(sum(mvmap1T));

ideal2T = sum(sum(mvmap2T * max(max(opsmap)))) / sum(sum(mvmap2T));
actual2T = sum(sum(mvmap2T .* opsmap)) / sum(sum(mvmap2T));

ideal3T = sum(sum(mvmap3T * max(max(opsmap)))) / sum(sum(mvmap3T));
actual3T = sum(sum(mvmap3T .* opsmap)) / sum(sum(mvmap3T));

ideal4T = sum(sum(mvmap4T * max(max(opsmap)))) / sum(sum(mvmap4T));
actual4T = sum(sum(mvmap4T .* opsmap)) / sum(sum(mvmap4T));

ideal6T = sum(sum(mvmap6T * max(max(opsmap)))) / sum(sum(mvmap6T));
actual6T = sum(sum(mvmap6T .* opsmap)) / sum(sum(mvmap6T));

% figure, plot(1,ideal1T,'ko',1,actual1T,'ro',2,ideal2T,'ko',2,actual2T,'ro',...
%     3,ideal3T,'ko',3,actual3T,'ro',4,ideal4T,'ko',4,actual4T,'ro',...
%     6,ideal6T,'ko',6,actual6T,'ro');

figure, bar([1,2,3,4,6],[actual1T,actual2T,...
    actual3T,actual4T,actual6T],0.5);
title('1 signma');
hold on
plot([0,1,2,3,4,5,6,6.5],[epv,epv,epv,epv,epv,epv,epv,epv],'k');
plot([0,1,2,3,4,5,6,6.5],[epvl,epvl,epvl,epvl,epvl,epvl,epvl,epvl],'r');
plot([0,1,2,3,4,5,6,6.5],[epvh,epvh,epvh,epvh,epvh,epvh,epvh,epvh],'r');
hold off

clear actual1T actual2T actual3T actual4T actual6T

ideal1T = sum(sum(mv3map1T * max(max(opsmap)))) / sum(sum(mv3map1T));
actual1T = sum(sum(mv3map1T .* opsmap)) / sum(sum(mv3map1T));

ideal2T = sum(sum(mv3map2T * max(max(opsmap)))) / sum(sum(mv3map2T));
actual2T = sum(sum(mv3map2T .* opsmap)) / sum(sum(mv3map2T));

ideal3T = sum(sum(mv3map3T * max(max(opsmap)))) / sum(sum(mv3map3T));
actual3T = sum(sum(mv3map3T .* opsmap)) / sum(sum(mv3map3T));

ideal4T = sum(sum(mv3map4T * max(max(opsmap)))) / sum(sum(mv3map4T));
actual4T = sum(sum(mv3map4T .* opsmap)) / sum(sum(mv3map4T));

ideal6T = sum(sum(mv3map6T * max(max(opsmap)))) / sum(sum(mv3map6T));
actual6T = sum(sum(mv3map6T .* opsmap)) / sum(sum(mv3map6T));

% figure, plot(1,ideal1T,'ko',1,actual1T,'ro',2,ideal2T,'ko',2,actual2T,'ro',...
%     3,ideal3T,'ko',3,actual3T,'ro',4,ideal4T,'ko',4,actual4T,'ro',...
%     6,ideal6T,'ko',6,actual6T,'ro');

figure, bar([1,2,3,4,6],[actual1T,actual2T,...
    actual3T,actual4T,actual6T],0.5);
title('3 sigma');
hold on
plot([0,1,2,3,4,5,6,6.5],[epv,epv,epv,epv,epv,epv,epv,epv],'k');
plot([0,1,2,3,4,5,6,6.5],[epvl,epvl,epvl,epvl,epvl,epvl,epvl,epvl],'r');
plot([0,1,2,3,4,5,6,6.5],[epvh,epvh,epvh,epvh,epvh,epvh,epvh,epvh],'r');
hold off
% change_color_of_STM_maps(vdata.map);
% 
% hold on
% 
% for i=1:vortexnumber
%     
%     mx = vfeat.fity(i);
%     my = vfeat.fitx(i);
%     
%     w = 2*radius;
%     h = w;
%     x = mx - radius;
%     y = my - radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','r','LineStyle','-','LineWidth',2);
%     
%     w = 4*radius;
%     h = w;
%     x = mx - 2*radius;
%     y = my - 2*radius;
%     rectangle('position',[y,x,w,h],...
%         'Curvature',[1,1],'EdgeColor','r','LineStyle','-.','LineWidth',2);
%     
%     
% end
% 
% 
% hold off

%%
olm1 = im2bw((mv2map1T + msdmapco)/2,0.6); 
olm2 = im2bw((mv2map2T + msdmapco)/2,0.6); 
olm3 = im2bw((mv2map3T + msdmapco)/2,0.6); 
olm4 = im2bw((mv2map4T + msdmapco)/2,0.6); 
olm6 = im2bw((mv2map6T + msdmapco)/2,0.6); 

obs1 = bwarea(mv2map1T);
obs2 = bwarea(mv2map2T);
obs3 = bwarea(mv2map3T);
obs4 = bwarea(mv2map4T);
obs6 = bwarea(mv2map6T);

smobs1 = bwarea(olm1);
smobs2 = bwarea(olm2);
smobs3 = bwarea(olm3);
smobs4 = bwarea(olm4);
smobs6 = bwarea(olm6);

obs = [vortexnumber1,vortexnumber2,vortexnumber3,vortexnumber4,vortexnumber5]+26;
smobs = [vortexnumber1*smobs1/obs1,vortexnumber2*smobs2/obs2,vortexnumber3*smobs3/obs3,vortexnumber4*smobs4/obs4,vortexnumber5*smobs6/obs6]+26;

figure, 
hold on
bar([1,2,3,4,6],obs,0.4,'b','BaseValue',26);
bar([1,2,3,4,6],smobs,0.4,'r','BaseValue',26);
plot([0,0.5,1,2,3,4,6,7],[26,26,26,26,26,26,26,26],'LineWidth',2);
plot([0,0.5,1,2,3,4,6,7],[0,7,14,28,42,56,84,98],'LineWidth',2);
hold off



end

