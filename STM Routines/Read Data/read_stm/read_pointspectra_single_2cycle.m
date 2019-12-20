function zz=read_pointspectra_single_2cycle(file,base)

if file<10; file=['0' num2str(file)];
else file=num2str(file); end

dir='';%'~/data/stm/70508/';
%base='NISTView80114A';

[base file '.DI1']

fid=fopen([base file '.DI2'],'r');
a=fread(fid,'float');
fclose(fid);

v=a(1:2:end);
v=v(265:end); 
v=v*1000;

a=a(2:2:end);
a=a(265:end); 


aa=-a(1:length(a)/2);
bb=-a(length(a)/2+1:end);
tt=-(-a(1:length(a)/2)-a(length(a)/2+1:end))/2;


assignin('base', ['z' file 'a'], ...
    aa); 
assignin('base', ['z' file 't'], ...
    tt); 
assignin('base', ['z' file 'b'], ...
    bb); 
assignin('base', ['v' file], v(1:length(a)/2)); 

[dv,daa,ddc]=numder(v,aa,1);
[dv,dbb,ddc]=numder(v,bb,1);
[dv,dtt,ddc]=numder(v,tt,1);



assignin('base', ['dz' file 'a'], ...
    daa); 
assignin('base', ['dz' file 't'], ...
    dtt); 
assignin('base', ['dz' file 'b'], ...
    dbb); 
assignin('base', ['dv' file], ...
    dv); 