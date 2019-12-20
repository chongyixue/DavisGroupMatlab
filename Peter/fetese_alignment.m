function [tform, fixed, movingRegistered] = fetese_alignment(topo1,topo2)



% % uncomment the following two lines if you want to interpolate
% [nx, ny, ne] = size(topo1);
% 
% intnum = 400;
% 
% if nx > ny
%     intpx = intnum;
%     intpy = intnum*ny/nx;
% elseif ny > nx
%     intpx = intnum*nx/ny;
%     intpy = intnum;
% elseif nx == ny
%     intpx = intnum;
%     intpy = intnum;
% end
% 
% a1 = imresize(topo1,[intpx, intpy],'Cubic');
% a2 = imresize(topo2,[intpx, intpy],'Cubic');



% 
a1 = topo1;
a2 = topo2;

% % try if averaging makes it even better
% h = fspecial('average',[3,3]);
% a1 = imfilter(a1,h,'replicate');
% h = fspecial('average',[3,3]);
% a2 = imfilter(a2,h,'replicate');

% The two images to be aligned with respect to each other
fixed = a1;
moving = a2;

% set the values used for the algorithm that aligns the images
[optimizer, metric] = imregconfig('multimodal');

optimizer.InitialRadius = 0.0009;
optimizer.Epsilon = 1.5e-4;
optimizer.GrowthFactor = 1.001;
optimizer.MaximumIterations = 5000;

% % plot both images before they have been aligned
% figure, imshowpair(fixed, moving,'Scaling','joint');

% get the transformation = tform that best aligns the two images
tform = imregtform(moving, fixed, 'affine', optimizer, metric);

% apply the transformation to the image 
movingRegistered = imwarp(moving,tform,'OutputView',imref2d(size(fixed)),'Interp','Cubic');
% movingRegistered = imwarp(moving,tform,'Interp','Cubic');

% plot the overlay of the images after the alignment
% figure
% imshowpair(fixed, movingRegistered,'Scaling','joint');

befali = abs(fixed-moving);
sum(sum(abs(fixed-moving)))/(size(fixed,1)*size(fixed,2))

img_plot3(fixed);
img_plot3(moving);
img_plot3(movingRegistered);
img_plot3(moving - movingRegistered);

% [nmrx, nmry, nmrz] = size(movingRegistered);
% 
% fixed2 = imresize(fixed,[nmrx, nmry],'Cubic');
% 
% aftali = abs(fixed2-movingRegistered);
% 
% figure, img_plot5(aftali)
% cox = 3;
% coy = 3;

% h = fspecial('average',[3,3]);
% avbefali = imfilter(befali,h,'replicate');
% h = fspecial('average',[3,3]);
% avaftali = imfilter(aftali,h,'replicate');
% 
% figure, img_plot4(befali(1+cox:end-cox,1+coy:end-coy,1));
% figure, img_plot4(aftali(1+cox:end-cox,1+coy:end-coy,1));

% figure, img_plot4(avbefali(1+cox:end-cox,1+coy:end-coy,1));
% figure, img_plot4(avaftali(1+cox:end-cox,1+coy:end-coy,1));
end