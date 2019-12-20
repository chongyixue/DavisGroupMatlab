%2019-8-6
function new_data = crop_center_dialogue(data,varargin)
varargin{:}
if isstruct(data)
    [nr nc nz] = size(data.map);
    img = data.map;
else
    [nr nc nz] = size(data);
    img = data;
end
if nargin < 2
    prompt = {'Center - x:','Center - y:','pixel width:'};
%     prompt = {'Upper Left Corner - x:','Upper Left Corner - y:','Lower Right Corner - x:', 'Lower Right Corner - y:'};
    dlg_title = 'Coordinates for Square Crop Area';
    num_lines = 1;
    default_answer = {'30','30','50'};
    confirm = 0;
    while 1
        answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
        if isempty(answer)
            return;
        end
        x1 = str2double(answer{1})-round(str2double(answer{3})/2);%>0;
        x2 = str2double(answer{1})+round(str2double(answer{3})/2);%<nr+1;
        y1 = str2double(answer{2})-round(str2double(answer{3})/2);%>0;
        y2 = str2double(answer{2})+round(str2double(answer{3})/2);%<nc+1;
        if x1>0 && x2<nr+1 && y1>0 &&y2<nc+1
            break
%         if abs(str2double(answer{1}) - str2double(answer{3})) == ...
%                                 abs(str2double(answer{2}) - str2double(answer{4}))
%             break;
        else
            display('Not Square Coordinates - Try Again');    
        end
    end
%     x1 = str2double(answer{1}); x2 = str2double(answer{3}); 
%     y1 = str2double(answer{2}); y2 = str2double(answer{4});
else
    x = varargin{1}; y = varargin{2}; pix = varargin{3};
    x1 = x-round(pix/2); x2 = x+round(pix/2);
    y1 = y-round(pix/2); y2 = y+round(pix/2);

%     x = varargin{1}; y = varargin{2};
%     x1 = x(1); x2 = x(2);
%     y1 = y(1); y2 = y(2);
end

new_img = crop_img(img,y1,y2,x1,x2);

if isstruct(data)
    new_data = data;
    new_data.map = new_img;
    new_data.ave = squeeze(mean(mean(new_img)));
    new_data.r = data.r(1:(x2-x1)+1);
    new_data.var = [new_data.var '_crop'];
    new_data.ops{end+1} = ['Crop:' num2str(x1) ' ,' num2str(y1) ':' num2str(x2) ' ,' num2str(y2)];
    img_obj_viewer_test(new_data);
else
    new_data = new_img;
end
display('New Data Created');
end