%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION: For layered images, the function generates a plot of
% the standard deviation of each layer against the layer index/energy.
%
% ALGORITHM: std function in MATLAB
%
% CODE HISTORY
%
% 100901 MHH Created
function y = std_trace(data)
[nr nc nz] = size(data.map);
y = zeros(56,1);
for i = 1:nz
    y(i) = std(reshape(data.map(:,:,i),nr*nc,1));
end
figure; plot(data.e*1000,y);
end