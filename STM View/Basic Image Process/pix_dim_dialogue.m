function pix_dim_dialogue(data)
prompt = {'New Linear Pixel Dimension'};
dlg_title = 'Changle Pixel Dimension';
num_lines = 1;
default_answer = {'1'};

while 1
    answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
    if isempty(answer)
        return;
    end
    if str2double(answer) > 0 
        pix_dim(data,str2double(answer));
        return;
    else
        display('Enter Valid Pixel Dimension > 0');    
    end
end

end