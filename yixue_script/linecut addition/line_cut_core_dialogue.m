function line_cut_core_dialogue(data)


% prompt = {'Pt1 - x:','Pt1 - y:','Pt2 - x:', 'Pt2 - y:','Pixel Width:'};
prompt = {'Pt1 - x:','Pt1 - y:','Pixel Width:'};
dlg_title = 'Linecut Through Core';
num_lines = 1;
default_answer = {'20','20','1'};

%this helps to determine the location of the core
pixels =  size(data.map,1);
center = ceil((pixels+1)/2);
while 1
answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
if isempty(answer)
    return;
else
    pos1x = str2double(answer{1});
    pos1y = str2double(answer{2});
    
    pos2x = center*2-pos1x;
    pos2y = center*2-pos1y;
%     pos2x = round(pixels-pos1x)+1;%+1 due to discreteness
%     pos2y = round(pixels-pos1y)+1;
    l_cut = line_cut_v3(data,[pos1x pos1y],...
        [pos2x pos2y],str2double(answer{3})); 
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
