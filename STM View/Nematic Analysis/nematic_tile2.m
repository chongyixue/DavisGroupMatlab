function new_data = nematic_tile2(data,varargin)

if isstruct(data)
    [nr nc nz] = size(data.map);
    nem_img = data.map;
    Cu_index = data.Cu_index;
    Ox_index1 = data.Ox_index1;
    Ox_index2 = data.Ox_index2;
    Oy_index1 = data.Oy_index1;
    Oy_index2 = data.Oy_index2;
else   
    if nargin < 6
        display('Enter All Cu and O indices');
        return;
    end
    [nr nc nz] = size(data);
    nem_img = data;
    Cu_index = varargin{1};
    Ox_index1 = varargin{2};
    Ox_index2 = varargin{3};
    Oy_index1 = varargin{4};
    Oy_index2 = varargin{5};
end
tile_image = zeros(nr,nc,nz);
x = 1:nr; y = 1:nc;
[xx yy] = meshgrid(x,y);
sum_coord = xx + yy;
diff_coord = xx-yy;


for i = 1:length(Cu_index)       
        
    if (Ox_index1(i,1)~=0 && Ox_index2(i,1)~=0 && Oy_index1(i,1)~=0 && Oy_index2(i,1)~=0)

        A = (sum_coord >= sum_coord(Oy_index2(i,1),Oy_index2(i,2)));
        B = (sum_coord <= sum_coord(Oy_index1(i,1),Oy_index1(i,2)));
        C = (diff_coord >= diff_coord(Ox_index2(i,1),Ox_index2(i,2)));
        D = (diff_coord <= diff_coord(Ox_index1(i,1),Ox_index1(i,2)));
        E = logical(A.*B.*C.*D);
        for k = 1:nz
            val = nem_img(Cu_index(i,1),Cu_index(i,2),k);
            tmp = tile_image(:,:,k);
            tmp(E) = (val);
            tile_image(:,:,k) = tmp;            
        end
    end
end
if isstruct(data)
    new_data = data;
    new_data.map = tile_image;
    new_data.var = [new_data.var '_tile'];
    new_data.ops{end+1} = 'Nematic Tiling';
    img_obj_viewer2(new_data);
    display('New Data Created');
else
    new_data = tile_image;
end
%load_color;
%figure; imagesc(tile_image); axis off; axis equal;
%colormap(Cmap.PurBlaCop);
end