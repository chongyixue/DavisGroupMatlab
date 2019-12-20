%%
cut = cut_4px;
figure; 
for i = 1:length(cut.e)-4
plot(cut.r,cut.cut(:,i)+i/3,'color',a(i,:)); hold on;
end
%%
B = bilateral_filt(img,10,[5 0.1]);
%%
%img_plot2(img,Cmap.Defect1); caxis([0.01 0.15])
img_plot2(B,Cmap.Defect1);caxis([0.01 0.15])
%%
matlabpool(3)
parfor i=1:3, c(:,:,i) = eig(rand(1000)); end