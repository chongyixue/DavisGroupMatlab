function [ln_cut,O]=qpi_cut(FFT,offset,angle)

%% taking cut
%define zero degree cut
[nx ny nz] = size(FFT.map);
in1 = [(round(nx/2)+offset) (round(ny/2))];
in2 = [nx round(ny/2)];
% compute the cut coordinates
[out1, out2] = coordinates_from_angle(in1,in2,angle,round(nx/2));
% take the cut;
ln_cut=line_cut_v4(FFT,out1,out2,5);
% plot the cut
% figure(1424), imagesc(flipud(ln_cut.cut'));
% % figure(1425), imagesc((ln_cut.cut'));
% colormap(hsv);
figure(1424), imagesc([fliplr(flipud(ln_cut.cut(1:end,:)')) flipud(ln_cut.cut(1:end,:)')])
colormap(gray)
%% divide row by mean of every row
for i=1:length(ln_cut.e)
    ncut(:,i)=ln_cut.cut(:,i)/mean(ln_cut.cut(:,i));
end
% figure(1425), imagesc(flipud(ncut(1:end,:)'));
% colormap(gray);
figure(1426), imagesc([fliplr(flipud(ncut(1:end,:)')) flipud(ncut(1:end,:)')])
colormap(gray)

%% divide column by mean of every column
for i=1:length(ln_cut.cut(:,1))
    ncut2(i,:)=ln_cut.cut(i,:)/mean(ln_cut.cut(i,:));
end
% figure(1425), imagesc(flipud(ncut(1:end,:)'));
% colormap(gray);
figure(1427), imagesc([fliplr(flipud(ncut2(1:end,1:end)')) flipud(ncut2(1:end,1:end)')])
colormap(gray)

%% divide column by mean of every column and row by mean of every row

for i=1:length(ln_cut.e)
    ncut3(:,i)=ncut2(:,i)/mean(ln_cut.cut(:,i));
end

% figure(1425), imagesc(flipud(ncut(1:end,:)'));
% colormap(gray);
figure(1428), imagesc([fliplr(flipud(ncut3(1:end,1:end)')) flipud(ncut3(1:end,1:end)')])
colormap(gray)

%% polar average
O = polar_average_odd(FFT,0,360);
% figure(1426), imagesc(flipud(O(1:end,2:end)'));
% colormap(hsv);
figure(1425), imagesc([fliplr(flipud(O(1:end,:)')) flipud(O(1:end,:)')])
colormap(gray)
%% divide row by mean of every row
for i=1:length(ln_cut.e)
    nO(:,i)=O(:,i)/mean(O(:,i));
end
% figure(1427), imagesc(flipud(nO(1:end,:)'));
% colormap(gray);
figure(1429), imagesc([fliplr(flipud(nO(1:end,:)')) flipud(nO(1:end,:)')]);
colormap(gray);

%% divide column by mean of every column
for i=1:length(ln_cut.cut(:,1))
    nO2(i,:)=O(i,:)/mean(O(i,:));
end
% figure(1425), imagesc(flipud(ncut(1:end,:)'));
% colormap(gray);
figure(1430), imagesc([fliplr(flipud(nO2(1:end,1:end)')) flipud(nO2(1:end,1:end)')])
colormap(gray)

%% divide column by mean of every column and row by mean of every row

for i=1:length(ln_cut.e)
    nO3(:,i)=nO2(:,i)/mean(O(:,i));
end

% figure(1425), imagesc(flipud(ncut(1:end,:)'));
% colormap(gray);
figure(1431), imagesc([fliplr(flipud(nO3(1:end,1:end)')) flipud(nO3(1:end,1:end)')])
colormap(gray)
% for i=1 : 31
%     figure(i+10); plot(offset:129,(O(offset:end,i)),'.k');
%     title([num2str(ln_cut.e(i)*1000) 'mV ' 'single peak']);
% end
% Doesn't work very well to plot all in one
% % figure;
% % hold on
% % for i=1 : 31
% %     plot(1:129,((O(:,i))/max(O(:,i)))+i*0.1,'.k');
% %     title([num2str(ln_cut.e(1)*1000) 'mV to ' num2str(ln_cut.e(end)*1000)  'mV single peak']);
% % end
% % hold off
end