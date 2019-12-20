%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION: IGOR layered images are saved in text files as q*n matrix 
% with n % the number of column and q = #rows*#layers.  The current function 
% assumes % that the number of columns and rows are the same and then 
% consructs an m*n*p matrix.
%
% ALGORITHM: 
%
% CODE HISTORY
%
% 100913 MHH Created

function new_data = IGOR_lyr_img_convert(data)
[nr nc] = size(data);
layers = nr/nc;
new_data = zeros(nc,nc,layers);
for k = 1:layers
    new_data(:,:,k) = rotate_map(data((k-1)*nc +1:(k-1)*nc + nc,:),90);
    new_data(:,:,k) = flipud(new_data(:,:,k));
    new_data(isnan(new_data(:,:,k)),k) = 0;
end

end

