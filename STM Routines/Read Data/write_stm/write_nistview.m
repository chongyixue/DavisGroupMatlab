function write_nistview(name,map)

% make map quadratic
[sy,sx,sz]=size(map);
ss=max(sx,sy);
mapt=zeros(ss,ss,sy);
mapt(1:sy,1:sx,1:sz)=map;


%read header from another file

fid=fopen('~/data/stm/70420/70420A00.1FL','r+');
a=fread(fid,'ubit8');
tit=a(1:2112); 
fclose(fid);

[map,w_z,w_f]=volt2file(map);

fid = fopen(name,'w+');

fwrite(fid, tit, 'ubit8','l');
%fwrite(fid, mapt, 'uint16','l');
fwrite(fid, zeros(1300,1), 'uint16','l');

fclose(fid);



% write things that are important
w_f=.13;w_z=.123;


%XXX F
start=179;
fid=fopen(name,'wb');
fwrite(fid, [1 ;1; w_z],'float32',256+start-1);
%hs.w_factor=fread(fid,1, 'float',00,'l')';
fclose(fid);
%XXX









%XXX
start=179;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
a=fread(fid,10, 'float32')
ftell(fid)
fclose(fid);
%XXX


