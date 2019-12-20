%%
path = 'C:\Analysis Code\MATLAB\STM View\Color Map\';
c = dir([path '*.txt']);
for i = 1:length(c)
    inputname{i} = c(i).name;
end
%%
for i = 1:length(c)
    file = inputname{i};
    name = file(1:end-4);
    [A] = importdata(inputname{i});
    if ~isempty(A)
        A.data = A.data/max(max(A.data));
        path = 'C:\Analysis Code\MATLAB\STM View\Color Maps\';
        outputname = [path name '.mat'];
        s1 = [name '= A.data'];
        eval(s1);
        save(outputname,name);
    end
end
%%