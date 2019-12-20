function corrstruct = fetese_irradiation_correlation(topo1al,topo2al,map1al,map2al,data)

en = data.e*1000;
di = (data.r(2)-data.r(1))/10;

[nx, ny, nz] = size(map1al);
dmap = zeros(nx, ny, nz);
corr_data1 = zeros(nx, ny, nz);
corr_data2 = zeros(nx, ny, nz);

% schablone = topo1al;
% schablone = topo2al;
schablone = map1al(:,:,11);
% schablone = map2al(:,:,11);

for i=1:nz
    dmap(:,:,i) = (map2al(:,:,i) - map1al(:,:,i));
    BW1(:,:,i) = im2bw(dmap(:,:,i), 0);
    BW2(:,:,i) = im2bw(-1*dmap(:,:,i), 0);
    
    
    
    pmap(:,:,i) = BW1(:,:,i) .* dmap(:,:,i);
    mmap(:,:,i) = BW2(:,:,i) .* dmap(:,:,i)*(-1);
    amap(:,:,i) = abs(dmap(:,:,i));
    
    corr_datap(:,:,i) = norm_xcorr2d(schablone,pmap(:,:,i));
    corr_datam(:,:,i) = norm_xcorr2d(schablone,mmap(:,:,i));
    corr_dataa(:,:,i) = norm_xcorr2d(schablone,amap(:,:,i));
    
    Op(:,i) = polar_average_pos(corr_datap(:,:,i),0,360,62,93);
    Om(:,i) = polar_average_pos(corr_datam(:,:,i),0,360,62,93);
    Oa(:,i) = polar_average_pos(corr_dataa(:,:,i),0,360,62,93);
    
    % for 8 T
%     Op(:,i) = polar_average_pos(corr_datap(:,:,i),0,360,99,89);
%     Om(:,i) = polar_average_pos(corr_datam(:,:,i),0,360,99,89);
%     Oa(:,i) = polar_average_pos(corr_dataa(:,:,i),0,360,99,89);
    
    do1(:,i) = (0:1:length(Op(:,i))-1) * di;
    en1(:,i) = en;
%     O2 = polar_average_pos(corr_data2(:,:,i),0,360,62,93);
    
%     figure, img_plot5(topo1al);
%     figure, img_plot5(topo2al);
%     figure, plot(do1,O1,'o');
%     figure, img_plot5(corr_data1(:,:,i));
%     figure, img_plot5(corr_data2(:,:,i));
    cvectorp(i) = corr_datap(62,93,i);
    cvectorm(i) = corr_datam(62,93,i);
    cvectora(i) = corr_dataa(62,93,i);
    
%     cvectorp(i) = corr_datap(99,89,i);
%     cvectorm(i) = corr_datam(99,89,i);
%     cvectora(i) = corr_dataa(99,89,i);
    
end

% figure, img_plot5(BW1(:,:,7))
% figure, img_plot5(pmap(:,:,7))
% figure, img_plot5(BW2(:,:,7))
% figure, img_plot5(mmap(:,:,7))
% figure, img_plot5(BW1(:,:,7)+BW2(:,:,7))
% figure, img_plot5(amap(:,:,7))
% 
% for i=1:nx
%     for j=1:ny
% %         cohl = sum(map1al(i,j,7:9))/3;
% %         ingap = sum(map1al(i,j,9:11))/3;
% %         cohr = sum(map1al(i,j,13:15))/3;
%         
%         cohl = sum(map1al(i,j,17:25))/9;
%         ingap = sum(map1al(i,j,25:41))/17;
%         cohr = sum(map1al(i,j,41:49))/9;
%         
%         
%         if cohl > ingap && cohr > ingap
%         else
%             pmap(i,j,:) = 0;
%             mmap(i,j,:) = 0;
%             amap(i,j,:) = 0;
%         end
%     end
% end

figure('Position',[300, 300, 700, 500]);
plot(en,cvectorp,'k-o',en,cvectorm,'r-+',en,cvectora,'b-x','LineWidth',2);
title('Norm. Xcorr.','FontSize',16);
set(gca,'FontSize',16);
set(get(gca,'XLabel'),'String','E [meV]','FontSize',16);
set(get(gca,'YLabel'),'String','Norm. Xcorr.','FontSize',16);
legend('(6 T - 0 T) > 0','(6 T - 0 T) < 0','|6 T - 0 T| > 0');

corrstruct.pmap = pmap;
corrstruct.mmap = mmap;
corrstruct.amap = amap;
corrstruct.Op = Op;
corrstruct.Om = Om;
corrstruct.Oa = Oa;
corrstruct.do1 = do1;
corrstruct.en1 = en1;
corrstruct.cvectorp = cvectorp;
corrstruct.cvectorm = cvectorm;
corrstruct.cvectora = cvectora;
corrstruct.corr_datap = corr_datap;
corrstruct.corr_datam = corr_datam;
corrstruct.corr_dataa = corr_dataa;

% for i=1:nz
%     figure
%     plot(do1,Op(:,i));
%     legend(num2str(i));
% end
en2 = (en(1,1:2:end));
for i=1:length(en2)
    en3{i} = num2str(en2(i));
end

do2 = round(do1(1:10:end));

for i=1:length(do2)
    do3{i} = num2str(do2(i));
end

figure, surf(Op,'FaceColor','interp',...
   'EdgeColor','none',...
   'FaceLighting','phong');
view(-140,50)
set(gca,'Xlim',[1,21]);
set(gca,'XTick',[1:2:21]);
set(gca,'XTickLabel',en3);
set(gca,'Ylim',[do1(1),do1(end)]);
set(gca,'YTick',[0:10:do1(end)]);
set(gca,'YTickLabel',do3);
set(gca,'Zlim',[min(min(Op)),max(max(Op))]);
set(gca,'FontSize',16);
set(get(gca,'XLabel'),'String','E [meV]','FontSize',16);
set(get(gca,'YLabel'),'String','Distance [nm]','FontSize',16);
set(get(gca,'ZLabel'),'String','norm. Xcorr.','FontSize',16);
title(gca,'Polar average of norm. Xcorr. Pmap','FontSize',16);
colorbar('FontSize',16);

figure, surf(Om,'FaceColor','interp',...
   'EdgeColor','none',...
   'FaceLighting','phong');
view(-140,50)
set(gca,'Xlim',[1,21]);
set(gca,'XTick',[1:2:21]);
set(gca,'XTickLabel',en3);
set(gca,'Ylim',[do1(1),do1(end)]);
set(gca,'YTick',[0:10:do1(end)]);
set(gca,'YTickLabel',do3);
set(gca,'Zlim',[min(min(Om)),max(max(Om))]);
set(gca,'FontSize',16);
set(get(gca,'XLabel'),'String','E [meV]','FontSize',16);
set(get(gca,'YLabel'),'String','Distance [nm]','FontSize',16);
set(get(gca,'ZLabel'),'String','norm. Xcorr.','FontSize',16);
title(gca,'Polar average of norm. Xcorr. Mmap','FontSize',16);
colorbar('FontSize',16);

figure, surf(Oa,'FaceColor','interp',...
   'EdgeColor','none',...
   'FaceLighting','phong');
view(-140,50)
set(gca,'Xlim',[1,21]);
set(gca,'XTick',[1:2:21]);
set(gca,'XTickLabel',en3);
set(gca,'Ylim',[do1(1),do1(end)]);
set(gca,'YTick',[0:10:do1(end)]);
set(gca,'YTickLabel',do3);
set(gca,'Zlim',[min(min(Oa)),max(max(Oa))]);
set(gca,'FontSize',16);
set(get(gca,'XLabel'),'String','E [meV]','FontSize',16);
set(get(gca,'YLabel'),'String','Distance [nm]','FontSize',16);
set(get(gca,'ZLabel'),'String','norm. Xcorr.','FontSize',16);
title(gca,'Polar average of norm. Xcorr. Amap','FontSize',16);
colorbar('FontSize',16);

end