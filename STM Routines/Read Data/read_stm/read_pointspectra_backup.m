function z=read_pointspectra(file)

dir='~/data/stm/70508/';
base='70508A';
fid=fopen([base file '.DI1'],'r');
a=fread(fid,'uint64');

a=a(265:length(a)); 

fid=fopen([dir base file '.DI2'],'r');
b=fread(fid,'uint64');

b=b(265:length(b)); 

% from nuber to volt
w_factor=8.89233e-5; 
w_zero=-2.75;

a=a*w_factor+w_zero;
b=b*w_factor+w_zero;

z=a+i*b;