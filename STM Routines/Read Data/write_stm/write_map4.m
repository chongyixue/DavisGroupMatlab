function f=write_map(map,name)

%read header from another file

fid=fopen('~/data/stm/70420/70420A00.1FL','r');
a=fread(fid,'ubit8');
a=a(1:2112); 
fclose(fid);


%map to correct units
[map,w_z,w_f]=volt2file(ns2volt(map));

[sy,sx,sz]=size(map);
%write

fid = fopen(name,'w');

fwrite(fid, a(1:406), 'ubit8','l');
fwrite(fid, sy, 'uint32','l');
fwrite(fid, sx, 'uint32','l');
fwrite(fid, a(414:433), 'uint8','l');
fwrite(fid, w_f, 'float','l');
fwrite(fid, w_z, 'float','l');

fwrite(fid, a(442:479), 'uint8','l');


fwrite(fid, sz, 'uint32','l');

fwrite(fid, a(465:length(a)), 'ubit8','l');
fwrite(fid, map, 'uint16','l');
fwrite(fid, zeros(1300,1), 'uint16','l');

fclose(fid);

