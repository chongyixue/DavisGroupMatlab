function f=write_map(map,name)

%read header from another file

fid=fopen('~/data/stm/70420/70420A00.1FL','r+');
a=fread(fid,'ubit8');
a=a(1:2112); 
fclose(fid);


%map to correct units
[map,w_z,w_f]=volt2file(ns2volt(map));


%write

fid = fopen(name,'w+');

fwrite(fid, a(1:434), 'ubit8','l');
fwrite(fid, w_f, 'float','l');
fwrite(fid, w_z, 'float','l');
fwrite(fid, a(443:length(a)), 'ubit8','l');
fwrite(fid, map, 'uint16','l');
fwrite(fid, zeros(1300,1), 'uint16','l');

fclose(fid)

