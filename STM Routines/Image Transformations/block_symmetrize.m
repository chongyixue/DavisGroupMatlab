%%%%%%%
% CODE DESCRIPTION: To overcome the off-by-one pixel problem in the FFT of
% a even-pixeled image, this function restablishes the block symmetry that
% should be inherent in the fourier transform of a real signal i.e.
% the symmetry of quadrants 1 and 3, as well as the symmetry of 2 and 4.
% This is implemented by copying the mirror image of quadrant 1 to quadrant
% and similarly for quadrants 2 and 4.
%   
% CODE HISTORY
%
% 0803010 MHH Created

function new_data = block_symmetrize(data)

[sx,sy,sz] = size(data.map);
new_map(1:sx/2,1:sy/2,1:sz) = data.map(1:sx/2,1:sy/2,1:sz);
new_map((sx/2+1):sx,(sy/2+1):sy,1:sz) = rotate_map(data.map(1:sx/2,1:sy/2,1:sz),180);
new_map(1:sx/2,(sy/2+1):sy,1:sz)=  data.map(1:sx/2,(sy/2+1):sy,1:sz);
new_map((sx/2+1):sx,1:sy/2,1:sz) = rotate_map(data.map(1:sx/2,(sy/2+1):sy,1:sz),180);
new_data = data;
new_data.map = new_map;
%figure; doser_mo(new_map,E,R,R)
end