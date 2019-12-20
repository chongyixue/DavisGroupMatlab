% image register, https://www.mathworks.com/help/images/register-an-aerial-photograph-to-a-digital-orthophoto.html

% orthophoto = imread('westconcordorthophoto.png');
% figure, imshow(orthophoto)
% unregistered = imread('westconcordaerial.png');
% figure, imshow(unregistered)
% 
% 
% cpselect(unregistered, orthophoto) % brings up a window to choose points from both images
% 
% mytform = fitgeotrans(movingPoints, fixedPoints, 'projective');
% registered = imwarp(unregistered, mytform);

testmap = obj_81108a00_G;

layers = size(testmap.map,3);
for layer = 1:layers
    testmap.map(:,:,layer) = imwarp(testmap.map(:,:,layer),mytform);
end
img_obj_viewer_test(testmap)