% function awesomemap(vdata05,vdata1,vdata2,vdata3,vdata4,vdata6, bdmap,msdmapco,mbdmap,expflux,areas)
function awesomemap(vdata)


% [nx, ny, nz] = size(vdata05.map);
% 
% vmap05 = vdata05.map;
% vmap1 = vdata1.map;
% vmap2 = vdata2.map;
% vmap3 = vdata3.map;
% vmap4 = vdata4.map;
% vmap6 = vdata6.map;
% 
% bvmap05 = zeros(nx,ny,1);
% bvmap1 = zeros(nx,ny,1);
% bvmap2 = zeros(nx,ny,1);
% bvmap3 = zeros(nx,ny,1);
% bvmap4 = zeros(nx,ny,1);
% bvmap6 = zeros(nx,ny,1);
% 
% 
% for i=1:nx
%     for j=1:ny
%         if vmap05(i,j,1) > 13.1206
%             bvmap05(i,j,1) = 1;
%         end
%         if vmap1(i,j,1) > 13.3032
%             bvmap1(i,j,1) = 1;
%         end
%         if vmap2(i,j,1) > 13.4198
%             bvmap2(i,j,1) = 1;
%         end
%         if vmap3(i,j,1) > 16.2871
%             bvmap3(i,j,1) = 1;
%         end
%         if vmap4(i,j,1) > 19.4297
%             bvmap4(i,j,1) = 1;
%         end
%         if vmap6(i,j,1) > 23.3101
%             bvmap6(i,j,1) = 1;
%         end
%         
%     end
% end
% 
% figure, img_plot5(bvmap05);
% figure, img_plot5(bvmap1);
% 
% olm05 = im2bw((bvmap05 + msdmapco)/2,0.6); 
% olm1 = im2bw((bvmap1 + msdmapco)/2,0.6); 
% olm2 = im2bw((bvmap2 + msdmapco)/2,0.6); 
% olm3 = im2bw((bvmap3 + msdmapco)/2,0.6); 
% olm4 = im2bw((bvmap4 + msdmapco)/2,0.6); 
% olm6 = im2bw((bvmap6 + msdmapco)/2,0.6); 
% 
% obs05 = bwarea(bvmap05);
% obs1 = bwarea(bvmap1);
% obs2 = bwarea(bvmap2);
% obs3 = bwarea(bvmap3);
% obs4 = bwarea(bvmap4);
% obs6 = bwarea(bvmap6);
% 
% smobs05 = bwarea(olm05);
% smobs1 = bwarea(olm1);
% smobs2 = bwarea(olm2);
% smobs3 = bwarea(olm3);
% smobs4 = bwarea(olm4);
% smobs6 = bwarea(olm6);
% 
% 
% figure, img_plot5(olm3);
% 
% bda = areas.bigdefectscircles;
% 
% figure, plot([0.5,1,2,3,4,6],expflux,'k');
% hold on
% plot([0.5,1,2,3,4,6,7],[bda,bda,bda,bda,bda,bda,bda],'r');
% bar([0.5,1,2,3,4,6],[obs05, obs1, obs2, obs3, obs4, obs6]);
% bar([0.5,1,2,3,4,6],[smobs05, smobs1, smobs2, smobs3, smobs4, smobs6]);
% hold off
% 
% 

%%
[nx, ny, nz] = size(vdata.map);
% 
% vmap = vdata.map;
% 
% bvmap = zeros(nx,ny,1);
% bv2map = zeros(nx,ny,1);
% 
% 
% for i=1:nx
%     for j=1:ny
%         if vmap(i,j,1) > 19.3251
%             bvmap(i,j,1) = 1;
%         end
%         if vmap(i,j,1) > 23.3101
%             bv2map(i,j,1) = 1;
%         end
%         
%     end
% end
% 
% figure, img_plot5(bvmap);
% figure, img_plot5(bv2map);

            

n = 10000;
tmp_layer = reshape(vdata.map,nx*ny,1);
tmp_std = std(tmp_layer);
% pick a common number of bins based on the largest spread of values in
% one of the layers
n1 = abs((max(tmp_layer) - min(tmp_layer)))/(2*tmp_std)*1000;
n = max(n,floor(n1));    

clear tmp_layer n1 tmp_std;

[histo.freq(1,1:n), histo.val(1,1:n)] = hist(reshape(vdata.map(:,:,1),nx*ny,1),n);

histo.freq = histo.freq / (nx*ny);

testarea = trapz(histo.val,histo.freq);

histo.freq = histo.freq / testarea;

normarea = trapz(histo.val,histo.freq);

% figure, bar(histo.val(1,1:n),histo.freq(1,1:n));

% [dum1,dumind1] = max(histo.freq);
% % 
% % x0 = [max(histo.freq),histo.val(dumind1),mean(histo.val)];
% % lb = [0,0,0];
% % ub = [5*max(histo.freq),10*mean(histo.val),10*mean(histo.val)];
% x0 = [mean(histo.val),mean(histo.val)];
% lb = [0,0];
% ub = [inf,inf];
% 
% options = optimset('Algorithm','trust-region-reflective',...  % according to MATLAB the only one that allows bounds
%                    'TolX',1e-6,...
%                    'MaxIter',10000,...
%                    'MaxFunEvals',10000);
% 
% %% Fit to Gaussian
% 
% % xint=lsqcurvefit(@twodgauss,x0,xdata,zdata,lb,ub,options);
% [x,resnorm,residual]=lsqcurvefit(@lognormal,x0,histo.val(1,1:n),histo.freq(1,1:n),lb,ub,options);
% finalfit=lognormal(x,histo.val(1,1:n));
% 
% [mu, var] = lognstat(x(1),x(2));
% figure, bar(histo.val(1,1:n),histo.freq(1,1:n))
% hold on
% plot(histo.val(1,1:n),finalfit,'r','LineWidth',2);
% hold off
% 
% clear finalfit x x0 lb ub

[dum1,dumind1] = max(histo.freq);
% 
x0 = [max(histo.freq),histo.val(dumind1),mean(histo.val)];
lb = [0,0,0];
ub = [5*max(histo.freq),10*mean(histo.val),10*mean(histo.val)];


options = optimset('Algorithm','trust-region-reflective',...  % according to MATLAB the only one that allows bounds
                   'TolX',1e-6,...
                   'MaxIter',10000,...
                   'MaxFunEvals',10000);

%% Fit to Gaussian

nc = 1500;

% xint=lsqcurvefit(@twodgauss,x0,xdata,zdata,lb,ub,options);
[x,resnorm,residual]=lsqcurvefit(@onedgauss,x0,histo.val(1,1:nc),histo.freq(1,1:nc),lb,ub,options);
finalfit=onedgauss(x,histo.val(1,1:n));


figure, bar(histo.val(1,1:n),histo.freq(1,1:n))
hold on
plot(histo.val(1,1:n),finalfit,'r','LineWidth',2);
line([x(2)+4*x(3),x(2)+4*x(3)],[0,1.5*max(histo.freq)],'LineWidth',2);
hold off


% for i=2:length(histo.val)
%     area = trapz(histo.val(1:i),histo.freq(1:i));
%     if area/normarea >= 0.9
%         testcutoff = histo.val(i);
%     end
% end

vmap = vdata.map;

bvmap = zeros(nx,ny,1);
bv2map = zeros(nx,ny,1);


for i=1:nx
    for j=1:ny
        if vmap(i,j,1) > x(2)+3*x(3)
            bvmap(i,j,1) = 1;
        end
        if vmap(i,j,1) > x(2)+4*x(3)
            bv2map(i,j,1) = 1;
        end
        
    end
end

% figure, img_plot5(bvmap);
figure, img_plot5(bv2map);
fperimeter = bwboundaries(bv2map);
change_color_of_STM_maps(vmap,'no')

hold on
for i=1:length(fperimeter)

    dum1 = fperimeter{i};
    xxx = dum1(:,2);
    yyy = dum1(:,1);
    plot(xxx,yyy,'-','Color','r','LineWidth',3);
    % line is needed to close the region
    line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','r','LineStyle','-','LineWidth',3);
    

end
hold off
test = 1;

end