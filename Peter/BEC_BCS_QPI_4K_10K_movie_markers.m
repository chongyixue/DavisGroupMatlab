

data4K = obj_60721a00_G_crop_ft_sym_8cr;
data10K = obj_60803a00_G_crop_ft_sym_8cr;

ev = data4K.e;
%%

le = length(ev);
xg1 = 1i*ones(1, le);
yg1 = 1i*ones(1, le);
xg2 = 1i*ones(1, le);
yg2 = 1i*ones(1, le);
xg3 = 1i*ones(1, le);
yg3 = 1i*ones(1, le);

xg4 = 1i*ones(1, le);
yg4 = 1i*ones(1, le);
xg5 = 1i*ones(1, le);
yg5 = 1i*ones(1, le);
xg6 = 1i*ones(1, le);
yg6 = 1i*ones(1, le);

% markers fro size of q-space area
xgqd = 0.29*ones(1, le);
ygqd = 0.29*ones(1, le);

% 4K
data4K.x = xg1;
data4K.y = yg1;

data4K.x2 = xg2;
data4K.y2 = yg2;

data4K.x3 = xg3;
data4K.y3 = yg3;

data4K.x4 = xg4;
data4K.y4 = yg4;

data4K.x5 = xg5;
data4K.y5 = yg5;

data4K.x6 = xg6;
data4K.y6 = yg6;

data4K.xqd = xgqd;
data4K.yqd = ygqd;

% 10K
data10K.x = xg1;
data10K.y = yg1;

data10K.x2 = xg2;
data10K.y2 = yg2;

data10K.x3 = xg3;
data10K.y3 = yg3;

data10K.x4 = xg4;
data10K.y4 = yg4;

data10K.x5 = xg5;
data10K.y5 = yg5;

data10K.x6 = xg6;
data10K.y6 = yg6;

data10K.xqd = xgqd;
data10K.yqd = ygqd;


%% line cuts

%% 4.2 K

cut_qx1 = line_cut_v4(obj_60721a00_G_crop_ft_sym,[13, 35],[58, 35],0);
cut_qx2 = line_cut_v4(obj_60721a00_G_crop_ft_sym,[13, 36],[58, 36],0);
cut_qx3 = line_cut_v4(obj_60721a00_G_crop_ft_sym,[13, 34],[58, 34],0);
cut_qx4 = line_cut_v4(obj_60721a00_G_crop_ft_sym,[13, 37],[58, 37],0);

cut_qx = cut_qx1;

cut_qx.cut = (cut_qx1.cut + cut_qx2.cut + cut_qx3.cut + cut_qx4.cut) / 4;

% cut_qx.cut = (cut_qx1.cut + cut_qx2.cut) / 2;


figure, hold on
for i=1:1:length(cut_qx.e)
    plot(cut_qx.r,cut_qx.cut(:,i)/max(cut_qx.cut(:,i))+(i-1)*0.25,'.-', 'LineWidth', 2);
end
hold off

cut_qx4K = cut_qx;

cut_qy1 = line_cut_v4(obj_60721a00_G_crop_ft_sym,[35, 13],[35, 58],0);
cut_qy2 = line_cut_v4(obj_60721a00_G_crop_ft_sym,[36, 13],[36, 58],0);
cut_qy3 = line_cut_v4(obj_60721a00_G_crop_ft_sym,[34, 13],[34, 58],0);
cut_qy4 = line_cut_v4(obj_60721a00_G_crop_ft_sym,[37, 13],[37, 58],0);

cut_qy = cut_qy1;

cut_qy.cut = (cut_qy1.cut + cut_qy2.cut + cut_qy3.cut + cut_qy4.cut) / 4;

% cut_qy.cut = (cut_qy1.cut + cut_qy2.cut) / 2;

figure, hold on
for i=1:1:length(cut_qy.e)
    plot(cut_qy.r,cut_qy.cut(:,i)/max(cut_qy.cut(:,i))+(i-1)*0.25,'.-', 'LineWidth', 2);
end
hold off

cut_qy4K = cut_qy;


figure, imagesc(cut_qx4K.r,cut_qx4K.e*1000,cut_qx4K.cut')
set(gca,'YDir','normal')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q [A^{-1}]','FontSize',16);
ylabel('E [meV]','FontSize', 16);
    
cut2 = cut_qx4K.cut;

[lx, ly] = size(cut2);

%     for i=1:lx
%         dum1 = max(cut(i,:));
%         cut1(i,:) = cut1(i,:)/dum1;
%     end

for i=1:ly
    dum1 = max(cut2(:,i));
    cut2(:,i) = cut2(:,i)/dum1;
end

%     figure, imagesc(l_cut.r,l_cut.e,cut1')
%     set(gca,'YDir','normal')

figure, imagesc(cut_qy4K.r,cut_qy4K.e*1000,cut2')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q [A^{-1}]','FontSize',16);
ylabel('E [meV]','FontSize', 16);

figure, imagesc(cut_qy4K.r,cut_qy4K.e*1000,cut_qy4K.cut')
set(gca,'YDir','normal')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q [A^{-1}]','FontSize',16);
ylabel('E [meV]','FontSize', 16);
    
cut2 = cut_qy4K.cut;

[lx, ly] = size(cut2);

%     for i=1:lx
%         dum1 = max(cut(i,:));
%         cut1(i,:) = cut1(i,:)/dum1;
%     end

for i=1:ly
    dum1 = max(cut2(:,i));
    cut2(:,i) = cut2(:,i)/dum1;
end

%     figure, imagesc(l_cut.r,l_cut.e,cut1')
%     set(gca,'YDir','normal')

figure, imagesc(cut_qy4K.r,cut_qy4K.e*1000,cut2')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q [A^{-1}]','FontSize',16);
ylabel('E [meV]','FontSize', 16);


%% 10.0 K

cut_qx1 = line_cut_v4(obj_60803a00_G_crop_ft_sym,[14, 36],[59, 36],0);
cut_qx2 = line_cut_v4(obj_60803a00_G_crop_ft_sym,[14, 37],[59, 37],0);
cut_qx3 = line_cut_v4(obj_60803a00_G_crop_ft_sym,[14, 35],[59, 35],0);
cut_qx4 = line_cut_v4(obj_60803a00_G_crop_ft_sym,[14, 38],[59, 38],0);

cut_qx = cut_qx1;

cut_qx.cut = (cut_qx1.cut + cut_qx2.cut + cut_qx3.cut + cut_qx4.cut) / 4;

% cut_qx.cut = (cut_qx1.cut + cut_qx2.cut) / 2;


figure, hold on
for i=1:1:length(cut_qx.e)
    plot(cut_qx.r,cut_qx.cut(:,i)/max(cut_qx.cut(:,i))+(i-1)*0.25,'.-', 'LineWidth', 2);
end
hold off

cut_qx10K = cut_qx;

cut_qy1 = line_cut_v4(obj_60803a00_G_crop_ft_sym,[36, 14],[36, 59],0);
cut_qy2 = line_cut_v4(obj_60803a00_G_crop_ft_sym,[37, 14],[37, 59],0);
cut_qy3 = line_cut_v4(obj_60803a00_G_crop_ft_sym,[35, 14],[35, 59],0);
cut_qy4 = line_cut_v4(obj_60803a00_G_crop_ft_sym,[38, 14],[38, 59],0);

cut_qy = cut_qy1;

cut_qy.cut = (cut_qy1.cut + cut_qy2.cut + cut_qy3.cut + cut_qy4.cut) / 4;

% cut_qy.cut = (cut_qy1.cut + cut_qy2.cut) / 2;

figure, hold on
for i=1:1:length(cut_qy.e)
    plot(cut_qy.r,cut_qy.cut(:,i)/max(cut_qy.cut(:,i))+(i-1)*0.25,'.-', 'LineWidth', 2);
end
hold off

cut_qy10K = cut_qy;


figure, imagesc(cut_qx10K.r,cut_qx10K.e*1000,cut_qx10K.cut')
set(gca,'YDir','normal')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q [A^{-1}]','FontSize',16);
ylabel('E [meV]','FontSize', 16);
    
cut2 = cut_qx10K.cut;

[lx, ly] = size(cut2);

%     for i=1:lx
%         dum1 = max(cut(i,:));
%         cut1(i,:) = cut1(i,:)/dum1;
%     end

for i=1:ly
    dum1 = max(cut2(:,i));
    cut2(:,i) = cut2(:,i)/dum1;
end

%     figure, imagesc(l_cut.r,l_cut.e,cut1')
%     set(gca,'YDir','normal')

figure, imagesc(cut_qy10K.r,cut_qy10K.e*1000,cut2')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q [A^{-1}]','FontSize',16);
ylabel('E [meV]','FontSize', 16);

figure, imagesc(cut_qy10K.r,cut_qy10K.e*1000,cut_qy10K.cut')
set(gca,'YDir','normal')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q [A^{-1}]','FontSize',16);
ylabel('E [meV]','FontSize', 16);
    
cut2 = cut_qy10K.cut;

[lx, ly] = size(cut2);

%     for i=1:lx
%         dum1 = max(cut(i,:));
%         cut1(i,:) = cut1(i,:)/dum1;
%     end

for i=1:ly
    dum1 = max(cut2(:,i));
    cut2(:,i) = cut2(:,i)/dum1;
end

%     figure, imagesc(l_cut.r,l_cut.e,cut1')
%     set(gca,'YDir','normal')

figure, imagesc(cut_qy10K.r,cut_qy10K.e*1000,cut2')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q [A^{-1}]','FontSize',16);
ylabel('E [meV]','FontSize', 16);
