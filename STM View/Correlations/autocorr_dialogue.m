function varargout = autocorr_dialogue(data)
if isstruct(data)     
    img = data.map;
else      
    img = data;
end

[nr nc nz] = size(img);

for k = 1:nz
    acorr_img(:,:,k) = norm_xcorr2d(img(:,:,k),img(:,:,k));
end

if isstruct(data)
    new_data = make_struct;
    new_data.map = acorr_img;
    new_data.e = data.e;
    new_data.r = data.r;
    new_data.name = data.name;
    new_data.type = 3;
    new_data.var = 'AC';
    new_data.ops{1} = ['Autocorrelation of ' data.name '_' data.var];
    varargout{1} = new_data;
    img_obj_viewer2(new_data);
else
    varargout{1} = acorr_img;
end


end