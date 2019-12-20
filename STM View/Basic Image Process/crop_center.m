%2019-9-25
function new_data = crop_center(data,x,y,pix)

if isstruct(data)
    [nr nc nz] = size(data.map);
    img = data.map;
else
    [nr nc nz] = size(data);
    img = data;
end

answer{1} = x;
answer{2} = y;
answer{3} = pix;


x = answer{1}; y = answer{2}; pix = answer{3};
x1 = x-round(pix/2); x2 = x+round(pix/2);
y1 = y-round(pix/2); y2 = y+round(pix/2);


new_img = crop_img(img,y1,y2,x1,x2);

if isstruct(data)
    new_data = data;
    new_data.map = new_img;
    new_data.ave = squeeze(mean(mean(new_img)));
    new_data.r = data.r(1:(x2-x1)+1);
    new_data.var = [new_data.var '_crop'];
    new_data.ops{end+1} = ['Crop:' num2str(x1) ' ,' num2str(y1) ':' num2str(x2) ' ,' num2str(y2)];
%     img_obj_viewer_test(new_data);
else
    new_data = new_img;
end

end