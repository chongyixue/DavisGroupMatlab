function hs=read_map_extra2(name)

hs.filename=name;

% DOUMENT INFO, offset256

%XXX
start=5;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.bit_offset=fread(fid,1, 'bit32',00,'l')';
fclose(fid);
%XXX

%XXX
start=25;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.date=fread(fid,20, 'bit8=>char',00,'l')';
fclose(fid);
%XXX

%XXX
start=45;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.description=fread(fid,40, 'bit8=>char','l')';
fclose(fid);
%XXX

%XXX
start=179;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.w_factor=fread(fid,1, 'float',00,'l')';
fclose(fid);
%XXX

%XXX
start=183;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.w_zero=fread(fid,1, 'float',00,'l')';
fclose(fid);
%XXX

%XXX
start=151;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.irows=fread(fid,1, 'bit16',00,'l')';
fclose(fid);
%XXX

%XXX
start=155;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.icols=fread(fid,1, 'bit16',00,'l')';
fclose(fid);
%XXX

%XXX
start=225;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.ilayers=fread(fid,1, 'bit16',00,'l')';
fclose(fid);
%XXX

%XXX
start=195;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.unit=fread(fid,10, 'bit8=>char','l')';
fclose(fid);
%XXX

%XXX
start=205;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.xyunit=fread(fid,10, 'bit8=>char','l')';
fclose(fid);
%XXX


%XXX
start=163;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.x_distmin=fread(fid,1, 'float','l')';
fclose(fid);
%XXX

%XXX
start=167;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.x_distmax=fread(fid,1, 'float','l')';
fclose(fid);
%XXX
hs.xdist=hs.x_distmax-hs.x_distmin;

%XXX
start=171;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.y_distmin=fread(fid,1, 'float','l')';
fclose(fid);
%XXX

%XXX
start=175;
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.y_distmax=fread(fid,1, 'float','l')';
fclose(fid);
%XXX
hs.ydist=hs.y_distmax-hs.y_distmin;


%%%%%%%%%%%% LI parameters, offset1356

%XXX
start=1;
fid=fopen(name);
fread(fid,1356+start-1, 'ubit8',00,'l');
hs.li_f=fread(fid,1, 'float','l')';
fclose(fid);
%XXX
%XXX
start=5;
fid=fopen(name);
fread(fid,1356+start-1, 'ubit8',00,'l');
hs.li_amp=fread(fid,1, 'float','l')';
fclose(fid);
%XXX
%XXX
start=9;
fid=fopen(name);
fread(fid,1356+start-1, 'ubit8',00,'l');
hs.li_phase=fread(fid,1, 'float','l')';
fclose(fid);
%XXX
%XXX
start=13;
fid=fopen(name);
fread(fid,1356+start-1, 'ubit8',00,'l');
hs.li_sens=fread(fid,1, 'float','l')';
fclose(fid);
%XXX
%XXX
start=17;
fid=fopen(name);
fread(fid,1356+start-1, 'ubit8',00,'l');
hs.li_tconst=fread(fid,1, 'float','l')';
fclose(fid);
%XXX
%XXX
start=21;
fid=fopen(name);
fread(fid,1356+start-1, 'ubit8',00,'l');
hs.li_rolloff=fread(fid,1, 'bit16','l')';
fclose(fid);
%XXX
%XXX
start=23;
fid=fopen(name);
fread(fid,1356+start-1, 'ubit8',00,'l');
hs.li_reserve=fread(fid,1, 'bit16','l')';
fclose(fid);
%XXX
%XXX
start=25;
fid=fopen(name);
fread(fid,1356+start-1, 'ubit8',00,'l');
hs.li_filters=fread(fid,1, 'bit16','l')';
fclose(fid);
%XXX
%XXX
start=27;
fid=fopen(name);
fread(fid,1356+start-1, 'ubit8',00,'l');
hs.li_harmonic=fread(fid,1, 'bit16','l')';
fclose(fid);
%XXX
%XXX
start=29;
fid=fopen(name);
fread(fid,1356+start-1, 'ubit8',00,'l');
hs.li_expand=fread(fid,1, 'bit16','l')';
if (hs.li_expand == 0)
    hs.li_expand = 1;
end
fclose(fid);
%XXX
%XXX
start=31;
fid=fopen(name);
fread(fid,1356+start-1, 'ubit8',00,'l');
hs.li_foffset=fread(fid,1, 'float','l')';
fclose(fid);
%XXX

%XXX scanparameters offset 1280
%XXX
start=1;
fid=fopen(name);
fread(fid,1280+start-1, 'ubit8',00,'l');
hs.s_startvolt=fread(fid,1, 'float','l')';
fclose(fid);
%XXX

%XXX
start=5;
fid=fopen(name);
fread(fid,1280+start-1, 'ubit8',00,'l');
hs.s_endvolt=fread(fid,1, 'float','l')';
fclose(fid);
%XXX


%XXX scanpar offset 1384

%XXX
start=23;
fid=fopen(name);
fread(fid,1384+start-1, 'ubit8',00,'l');
hs.s_vtip=fread(fid,1, 'float','l')';
fclose(fid);
%XXX

%XXX
start=27;
fid=fopen(name);
fread(fid,1384+start-1, 'ubit8',00,'l');
hs.s_itip=fread(fid,1, 'float','l')';
fclose(fid);
%XXX
hs.s_jr=abs(hs.s_vtip/hs.s_itip);


%{
for j=1400:1410

start=1;
fid=fopen(name);
fread(fid,j+start-1, 'ubit8',00,'l');
hs.test=fread(fid,1, 'float','l')';
fclose(fid);
%XXX
hs.test
if find(hs.test==-90)
   j
end
end
%find(hs.li_phase==-88.26)
%hs.li_phase
%}