function sixfold_dialogue2(data)

prompt = {'Offset angle'};
dlg_title = 'Six Fold Symm';
num_lines = 1;
default_answer = {'0'};

while 1
    answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
    angle = str2double(answer);
    ang = [num2str(angle)];
    if isempty(answer)
        return;
    end
    if angle >= 0 
        new_data = six_fold_symmetrize(data,angle);
        new_data.ave = [];
        new_data.var = [new_data.var '_sym_six_' ang];
        new_data.ops{end+1} = ['sixfold sym with horizontal at ' ang ' degrees'];
        img_obj_viewer_test(new_data);
        %display('New Data Created');
        return;
    else
    end
end

end
