function line_cut_dialogue(data)
% size(data.map,1)

prompt = {'Pt1 - x:','Pt1 - y:','Pt2 - x:', 'Pt2 - y:','Pixel Width:'};
dlg_title = 'Coordinates for Square Crop Area';
num_lines = 1;
default_answer = {'1','1','1','1','0'};

while 1
answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
if isempty(answer)
    return;
else
    l_cut = line_cut_v3(data,[str2double(answer{1}) str2double(answer{2})],...
        [str2double(answer{3}) str2double(answer{4})],str2double(answer{5})); 
    break;
end
end
prompt={'Enter Cut variable name for workspace:'};
name='Export to Workspace';
numlines=1;         
defaultanswer={'cut'};
answer = inputdlg(prompt,name,numlines,defaultanswer);
if isempty(answer)
    return;
else
    
    assignin('base',answer{1},l_cut);
end
end
