function new_data = LF_correct_map_v2(topo_f_x,topo_f_y,data,varargin)

if isstruct(data)
    map = data.map;    
    img_r = data.r;    
else
    map = data;
    img_r = varargin{1}; %if the input is not a structure, then the user also input the coordinate of the image
end
[nr nc nz] = size(map);
new_map = zeros(nr,nc,nz);
[X Y] = meshgrid(img_r,img_r);

% reinterpolate data on transformed coordinate grid
for k = 1:nz
    img_correct = [];
    img_correct = griddata(topo_f_x,topo_f_y,map(:,:,k),X,Y,'linear');
    A = isnan(img_correct);
    img_correct(A) = 0;
    new_map(:,:,k) = img_correct;    
end
if isstruct(data)
    new_data = data;
    new_data.map = new_map;
    new_data.var = [new_data.var '_LFCorrect'];
    new_data.ops{end+1} = 'LF Correction';
else
    new_data = new_map;
end
% f=fft2(img_correct - mean(mean(img_correct)));
% f=fftshift(f);
% img_plot2(abs(f));
% img_plot2(real(f))
% img_plot2(imag(f));
end