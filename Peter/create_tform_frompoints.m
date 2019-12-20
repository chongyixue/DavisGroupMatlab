function [tformaff, tformaffopt] = create_tform_frompoints(movingPoints, fixedPoints, moving, fixed)

moving_pts_adj= cpcorr(movingPoints, fixedPoints, moving, fixed);

tformaff = fitgeotrans(movingPoints,fixedPoints,'Affine');

movregaff = imwarp(moving,tformaff,'OutputView',imref2d(size(fixed)),'Interp','Cubic');


% set the values used for the algorithm that aligns the images
[optimizer, metric] = imregconfig('multimodal');

optimizer.InitialRadius = 0.0009;
optimizer.Epsilon = 1.5e-6;
optimizer.GrowthFactor = 1.001;
optimizer.MaximumIterations = 10000;

% % plot both images before they have been aligned
% figure, imshowpair(fixed, moving,'Scaling','joint');

% get the transformation = tform that best aligns the two images
tformaffopt = imregtform(moving, fixed, 'affine', optimizer, metric,...
    'InitialTransformation',tformaff,'PyramidLevels',3);

movregaffopt = imwarp(moving,tformaffopt,'OutputView',imref2d(size(fixed)),'Interp','Cubic');

figure,
subplot(2,2,1)
img_plot4(moving-fixed);
subplot(2,2,2)
img_plot4(movregaff-fixed);
subplot(2,2,3)
img_plot4(movregaffopt-fixed);
subplot(2,2,4)
img_plot4(movregaffopt-movregaff);

corr_data1 = norm_xcorr2d(fixed,moving);
corr_data2 = norm_xcorr2d(fixed,movregaff);
corr_data3 = norm_xcorr2d(fixed,movregaffopt);
corr_data4 = norm_xcorr2d(fixed,fixed);
figure,
subplot(2,2,1)
img_plot4(corr_data1);
subplot(2,2,2)
img_plot4(corr_data2);
subplot(2,2,3)
img_plot4(corr_data3);
subplot(2,2,4)
img_plot4(corr_data4);

testmed = medfilt2(movregaffopt-fixed,[4,4]);
testwiener = wiener2(movregaffopt-fixed, [4,4]);

figure,
subplot(1,2,1)
img_plot4(testmed);
subplot(1,2,2)
img_plot4(testwiener);

%% median filter medfilt2 actually seems to do more than wiener2

end