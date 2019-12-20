function data=read_scopedata_txt(nr)


filenr=num2str(nr);


dir='~/data/stm/TimeDomain/';
file=['Trigger_lockin_' filenr 'mV.txt'];


[dir file]


data=load([dir file]);




assignin('base', ['sc_p' num2str(nr+31)], data); 

%{

if nr>=0
    assignin('base', ['sc_p' filenr], data); 
elseif nr <0
    nr=-nr;
    filenr=num2str(nr);
    assignin('base', ['sc_n' filenr], data); 
else 
    x=1000000000
end


%}