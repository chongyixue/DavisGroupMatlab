function map = splinefit_gapmap_dialogue(data)

prompt = {'in mV: '};
dlg_title = 'Maximum gapsize';
num_lines = 1;
default_answer = {'0.15'};

while 1
    answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
    if isempty(answer)
        return;
    end
    break;

end

maxgap = str2double(answer{1});

map = gap_from_spline_function(data,maxgap);

end