function read_tmp(name)
fid=fopen(name);
%crap
fread(fid,256, 'ubit8',00,'l');
%endcrab

version=fread(fid,1, 'bit32',00,'l')'
start=fread(fid,1, 'bit32',00,'l')'

%crab
a=fread(fid,44-8, 'ubit8',00,'l');
%endcrab

%desc starts at 45...84
description=fread(fid,48, 'bit8=>char',00,'l')'

%crab
a=fread(fid,178-84, 'ubit8',00,'l');
%endcrab

w_factor=fread(fid,1, 'float',00,'l')'
w_zero=fread(fid,1, 'float',00,'l')'

fclose(fid);


%XXX
start=25
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
date=fread(fid,20, 'bit8=>char',00,'l')'
fclose(fid);
%XXX