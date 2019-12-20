function new_data = rm_center(data)
load_color;
if isstruct(data)
    img = data.map;
else
    img = data;
end
[nr nc nz] = size(img);


prompt={'Enter Width of Gaussian for Subtraction'};
name='Center Removal for FT Image';
numlines=1;
defaultanswer= {'0'};
answer = inputdlg(prompt,name,numlines,defaultanswer);    
if isempty(answer)
    return;
end
sigma = str2double(answer{1});

if mod(nr,2) == 0
    cr = nr/2 + 0.5;
else 
    cr = nr/2;
end

if mod(nc,2) == 0
    cc = nc/2 + 0.5;
else 
    cc = nc/2;
end
gauss_filt = Gaussian_v2(1:nr,1:nc,sigma,sigma,0,[cr cc],1);

for k = 1:nz
    new_img(:,:,k) = img(:,:,k) - gauss_filt.*img(:,:,k);
end

if isstruct(data)
    new_data = data;
    new_data.map = new_img;
    new_data.var = [new_data.var '_center-rm_'];
    new_data.ops{end+1} = ['Center removed with width ' answer{1}];
    img_obj_viewer2(new_data);   
else
    new_data = new_img;
    img_plot2(new_data,Cmap.Blue2,'Center Removed');
end

end