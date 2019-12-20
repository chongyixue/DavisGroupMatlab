function ave_filter_dialogue(data)
prompt = {'# pixels used for averaging (default: [3,3]), pixelx:','pixely:'};
dlg_title = 'Average Filter Image';
num_lines = 1;
default_answer = {'3','3'};
answer = inputdlg(prompt,dlg_title,num_lines,default_answer);

new_data = ave_filter_image(data,str2double(answer{1}),str2double(answer{2}));
new_data.var = [new_data.var '_gauss_filt'];
new_data.ops{end+1} = ['Gaussian Filter: pixel width= ' str2double(answer{1})...
                        'gauss width= ' str2double(answer{2})];
img_obj_viewer2(new_data);
display('New Data Created');
end