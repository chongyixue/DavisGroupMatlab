function gauss_filter_dialogue(data)
prompt = {'Enter Pixel Width:','Enter Gaussian Width:'};
dlg_title = 'Gauss Filter Image';
num_lines = 1;
default_answer = {'1','1'};
answer = inputdlg(prompt,dlg_title,num_lines,default_answer);

new_data = gauss_filter_image(data,str2double(answer{1}),str2double(answer{2}));
new_data.var = [new_data.var '_gauss_filt'];
new_data.ops{end+1} = ['Gaussian Filter: pixel width= ' str2double(answer{1})...
                        'gauss width= ' str2double(answer{2})];
img_obj_viewer2(new_data);
display('New Data Created');
end