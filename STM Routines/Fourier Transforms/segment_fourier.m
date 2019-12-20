%%%%%%%
% CODE DESCRIPTION: Segments real space map into four pieces and take their
% individual fourier transforms.  The output is the average fourier
% transform over the four segments and a cojugate space scaling.  This
% function makes use of the function FOURIER_BLOCK to calculate the fourier
% transform.
%   
% CODE HISTORY
%
% 080131 MHH Created
% 080310 MHH Added features to do shear correction of fourier image based
%        using the function transform_map.

function [k,fourierMap] = segment_fourier(map,coord,clmap)

%calculate the segment coordinates
[sy,sx,sz] = size(map);
x_cut = floor(sx/2);
y_cut = floor(sy/2);

block1 = map(1:x_cut,1:y_cut,:);
block1 = poly_detrend(block1,coord,coord,0);

block2 = map(1:x_cut,(y_cut+1):end,:);
block2 = poly_detrend(block2,coord,coord,0);

block3 = map((x_cut+1):end,1:y_cut,:);
block3 = poly_detrend(block3,coord,coord,0);

block4 = map((x_cut+1):end,(y_cut+1):end,:);
block4 = poly_detrend(block4,coord,coord,0);

new_coord = coord(1:x_cut);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BLOCK 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[k1,four1] = fourier_block(block1,new_coord,'kaiser');
four1 = block_symmetrize(four1);
% get points on image which correspond to atomic peaks.  
pt1 = get_points(four1(:,:,11),k1,2,clmap)
% these points are use to correct for shear
four1 = transform_map(four1,k1,pt1(:,1),pt1(:,2),[2.15 2.15],[-2.15 2.15]);
%four1 = transform_map2(four1,k1,pt1(:,1),pt1(:,2),pt1(:,3));
power1 = abs(four1).^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BLOCK 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[k2,four2] = fourier_block(block2,new_coord,'kaiser');
four2 = block_symmetrize(four2);
pt2 = get_points(four2(:,:,11),k2,2,clmap)
four2 = transform_map(four2,k2,pt2(:,1),pt2(:,2),[2.15 2.15],[-2.15 2.15]);
%four2 = transform_map2(four2,k1,pt2(:,1),pt2(:,2),pt2(:,3));
power2 = abs(four2).^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BLOCK 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[k3,four3] = fourier_block(block3,new_coord,'kaiser');
four3 = block_symmetrize(four3);
pt3 = get_points(four3(:,:,11),k3,2,clmap)
four3 = transform_map(four3,k3,pt3(:,1),pt3(:,2),[2.15 2.15],[-2.15 2.15]);
%four3 = transform_map2(four3,k1,pt3(:,1),pt3(:,2),pt3(:,3));
power3 = abs(four3).^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BLOCK 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[k4,four4] = fourier_block(block4,new_coord,'kaiser');
four4 = block_symmetrize(four4);
pt4 = get_points(four4(:,:,11),k4,2,clmap)
four4 = transform_map(four4,k4,pt4(:,1),pt4(:,2),[2.15 2.15],[-2.15 2.15]);
%four4 = transform_map2(four1,k1,pt4(:,1),pt4(:,2),pt4(:,3));
power4 = abs(four4).^2;

%average all four blocks together
avg_power = (power1 + power2 + power3 + power4)/4;
% fold along vertical and diagonal for symmetrization
avg_power = symmetrize_map(avg_power);
fourierMap = sqrt(avg_power);
k = k1;
end