function new_data = crop_dialogue(data)

if isstruct(data)
    [nr nc nz] = size(data.map);
    img = data.map;
else
    [nr nc nz] = size(data);
    img = data;
end

prompt = {'Upper Left Corner - x:','Upper Left Corner - y:','Lower Right Corner - x:', 'Lower Right Corner - y:'};
dlg_title = 'Coordinates for Square Crop Area';
num_lines = 1;
default_answer = {'1','1','1','1'};
confirm = 0;
while 1
answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
if isempty(answer)
    return;
end
if abs(str2double(answer{1}) - str2double(answer{3})) == ...
                        abs(str2double(answer{2}) - str2double(answer{4}))
    break;
else
    display('Not Square Coordinates - Try Again');    
end
end

new_img = crop_img(img,str2double(answer{1}),str2double(answer{3}),...
                       str2double(answer{2}),str2double(answer{4}));
if isstruct(data)
    new_data = data;
    new_data.map = new_img;
    new_data.ave = squeeze(mean(mean(new_img)));
    new_data.r = data.r(1:(str2double(answer{3})-str2double(answer{1}))+1);
    new_data.var = [new_data.var '_crop'];
    new_data.ops{end+1} = ['Crop' answer{1} ' ,' answer{2} ':' answer{3} ',' answer{4}] ;
    img_obj_viewer2(new_data);
else
    new_data = new_img;
end
display('New Data Created');
end