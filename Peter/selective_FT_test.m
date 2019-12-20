function selective_FT_test(data, direction, coordinates, windowsize)
% data is either a FT of STM-data or STM-data
% direction ... 'ft' or inverse 'ift' depending on which data you input
% coordinates ... coordinates for mask 
% windowsize ... tells you how big of a square around the coordinates
% should be created for the mask

% create mask from coordinates and windowsize
[nx ny nz] = size(data.map);
A = zeros(nx,ny,1);
cx = coordinates(:,1);
cy = coordinates(:,2);
ws = windowsize;
B = ones(2*ws+1,2*ws+1,1);

for i=1:length(cx)
    
%     lxm = cx(i) - ws;
%     lxp = cx(i) + ws;
%     lym = cy(i) - ws;
%     lyp = cy(i) - ws;
    
A(cx(i)-ws:cx(i)+ws,cy(i)-ws:cy(i)+ws) = B;

    
end
% multiply data with mask and plot both the result and the data

mdata = data .* A;

figure; imagesc(A);

for i=1:nz
    img_plot3(data(:,:,i));
    img_plot3(mdata(:,:,i));
    test = 1;
end

% calculate the FT for the processed and raw data and plot them as well

F = fourier_transform2d(data,'none','complex','ift')

F = fourier_transform2d(mdata,'none','complex','ift')


end