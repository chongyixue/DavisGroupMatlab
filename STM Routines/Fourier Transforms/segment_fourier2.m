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

function Fdata = segment_fourier2(Gdata,window)

%calculate the segment coordinates
[sy,sx,sz] = size(Gdata.map);
x_cut = floor(sx/2);
y_cut = floor(sy/2);
tmpdata = Gdata;
new_coord = Gdata.r(1:x_cut);
tmpdata.r = new_coord;

block = Gdata.map(1:x_cut,1:y_cut,:);
bdata1 = tmpdata;
bdata1.map = block;
bdata1 = poly_detrend2(bdata1,0);

block = Gdata.map(1:x_cut,(y_cut+1):end,:);
bdata2 = tmpdata;
bdata2.map = block;
bdata2 = poly_detrend2(bdata2,0);

block = Gdata.map((x_cut+1):end,1:y_cut,:);
bdata3 = tmpdata;
bdata3.map = block;
bdata3 = poly_detrend2(bdata3,0);

block = Gdata.map((x_cut+1):end,(y_cut+1):end,:);
bdata4 = tmpdata;
bdata4.map = block;
bdata4 = poly_detrend2(bdata4,0);


%atomic position in Fourier space
ap_x = 2.1464;
ap_y = 2.1464;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BLOCK 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F1 = fourier_block2(bdata1,window);
F1 = block_symmetrize(F1);
%F1 = transform_map2(F1,[ap_x ap_y], [-ap_x ap_y]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BLOCK 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F2 = fourier_block2(bdata2,window);
F2 = block_symmetrize(F2);
%F2 = transform_map2(F2,[ap_x ap_y], [-ap_x ap_y]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BLOCK 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F3 = fourier_block2(bdata3,window);
F3 = block_symmetrize(F3);
%F3= transform_map2(F3,[ap_x ap_y], [-ap_x ap_y]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BLOCK 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F4 = fourier_block2(bdata4,window);
F4 = block_symmetrize(F4);
%F4= transform_map2(F4,[ap_x ap_y], [-ap_x ap_y]);


%average all four blocks together
%avg_power = (power1 + power2 + power3 + power4)/4;
% fold along vertical and diagonal for symmetrization
Fdata = Gdata;
Fdata.r = F1.r;
Fdata.map = sqrt(abs(F1.map).^2 + abs(F2.map).^2 + abs(F3.map).^2 + abs(F4.map).^2)/4;

%avg_power = symmetrize_map(avg_power);
%fourierMap = sqrt(avg_power);
%k = k1;
end