function Laplacian_filter_dialogue(data)
prompt = {'Enter alpha used for Laplacian shape:'};
dlg_title = 'Laplacian filter';
num_lines = 1;
default_answer = {'0.2'};
answer = inputdlg(prompt,dlg_title,num_lines,default_answer);

new_data = Laplacian_filter_image(data,str2double(answer{1}));
new_data.var = [new_data.var '_filtered'];
new_data.ops{end+1} = ['Laplacian filter: alpha value= ' str2double(answer{1})];
img_obj_viewer2(new_data);
display('New Data Created');

end