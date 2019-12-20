function Interpolation_dialogue(data)
prompt = {'Enter new x-pixel number:','Enter new y-pixel number:'};
dlg_title = 'Interpolation to higher or lower pixel number';
num_lines = 1;
[nx, ny, nz] = size(data.map);
default_answer = {num2str(nx),num2str(ny)};
answer = inputdlg(prompt,dlg_title,num_lines,default_answer);

newmap = imresize(data.map,[str2double(answer{1}), str2double(answer{2})],'Cubic');

new_data = data;
new_data.map = newmap;

maxpix = max(str2double(answer{1}), str2double(answer{2}));
new_data.r = linspace(0,new_data.info.xdist,maxpix)';

new_data.var = [new_data.var '_interpolated'];
new_data.ops{end+1} = ['Interpolation: old x-pixel number= ' nx...
                        'old y-pixel number= ' ny];
img_obj_viewer2(new_data);
display('New Data Created');

end

