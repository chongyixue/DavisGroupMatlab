% 18/9/2017
% Yi Xue Chong

% take data, and initial offset angle of hexagon for data.

function new = six_fold_symmetrize2(data,angle)


if isstruct(data) % check if data is a full data structure
    [nr,nc,nz]=size(data.map);
    tmp_data = data.map;
else % single data image
    [nr,nc,nz] = size(data);
    tmp_data = data;
end


for k = 1:nz
    % R for rotation
    % create 6 rotated version of the data
    R1(:,:,k) = make_pixel_even(imrotate(tmp_data(:,:,k),angle,'bilinear'));
    R2(:,:,k) = make_pixel_even(imrotate(tmp_data(:,:,k),angle+60,'bilinear'));
    R3(:,:,k) = make_pixel_even(imrotate(tmp_data(:,:,k),angle+120,'bilinear'));
    R4(:,:,k) = make_pixel_even(imrotate(tmp_data(:,:,k),angle+180,'bilinear'));
    R5(:,:,k) = make_pixel_even(imrotate(tmp_data(:,:,k),angle+240,'bilinear'));
    R6(:,:,k) = make_pixel_even(imrotate(tmp_data(:,:,k),angle+300,'bilinear'));

    % V for vendetta (jk, vertical actually)
    % now create 6 versions of symmetrized data from R series
    V1(:,:,k) = symmetrize_image(R1(:,:,k),'v');
    V2(:,:,k) = symmetrize_image(R2(:,:,k),'v');
    V3(:,:,k) = symmetrize_image(R3(:,:,k),'v');
    V4(:,:,k) = symmetrize_image(R4(:,:,k),'v');
    V5(:,:,k) = symmetrize_image(R5(:,:,k),'v');
    V6(:,:,k) = symmetrize_image(R6(:,:,k),'v');

    % time to add off of them up to create 6 fold symmetrization.
    % then divide
    % S for six
    S1(:,:,k) = add_image(V1(:,:,k),V4(:,:,k));
    S2(:,:,k) = add_image(V2(:,:,k),V5(:,:,k));
    S3(:,:,k) = add_image(V3(:,:,k),V6(:,:,k));
    S4(:,:,k) = add_image(S1(:,:,k),S2(:,:,k));
    S5(:,:,k) = add_image(S3(:,:,k),S4(:,:,k));
    new_data(:,:,k) = S5(:,:,k)/6.0;
end
    

% crop out to make pixel number the same
new_length = length(new_data(:,:,1));
old_length = length(tmp_data(:,:,1));
start = round(0.5*(new_length-old_length)+1);
stop = round(start+old_length-1);
y1 = start; x1 = start;
y2 = stop; x2 = stop;

for k = 1:nz
    new_data2(:,:,k) = crop_img(new_data(:,:,k),y1,y2,x1,x2);
end

if isstruct(data) % check if data is a full data structure
    new = data;
    new.map = new_data2;   
else % single data image
    new = new_data2;
end


end
