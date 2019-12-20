function MNR_dialogue(data)
prompt={'Pixel Average Radius','Pixel Value to Skip (leave blank to skip nothing)','global or local Normalization'};
name='MNR Map Options';
numlines=1;         
defaultanswer={'0','','global'};
answer = inputdlg(prompt,name,numlines,defaultanswer);
new_data = [];
if strcmp(answer{3},'global')
    if ~strcmp(answer{2},'')    
        new_data = MNR2(data,str2double(answer{1}),answer{2});
    else
        new_data = MNR2(data,str2double(answer{1}));
    end
elseif strcmp(answer{3},'local')
    if ~strcmp(answer{2},'')    
        new_data = MNR4(data,str2double(answer{1}),answer{2});
        %new_data = MNR_combinatoric(data,str2double(answer{1}),answer{2});
    else
       new_data = MNR4(data,str2double(answer{1}));
       %new_data = MNR_combinatoric(data,str2double(answer{1}));
    end
end
if isempty(new_data)
    return;
end
img_obj_viewer2(new_data);
end