function hs=read_map_extra3(name)

hs.filename=name;

% DOUMENT INFO, offset256
r_offset = 256;
%XXX
start=5; %
fid=fopen(name);
fseek(fid,r_offset+start-1,'bof');
%fread(fid,r_offset+start-1, 'ubit8',00,'l');
hs.bit_offset=fread(fid,1, 'bit32',00,'l')';
%XXX

%XXX
start=25;
fseek(fid,r_offset+start-1,'bof');
hs.date=fread(fid,20, 'bit8=>char',00,'l')';
%XXX

%XXX
start=45;
fseek(fid,r_offset+start-1,'bof');
hs.description=fread(fid,40, 'bit8=>char','l')';
%XXX

%XXX
start=179;
fseek(fid,r_offset+start-1,'bof');
hs.w_factor=fread(fid,1, 'float',00,'l')';
%XXX

%XXX
start=183;
fseek(fid,r_offset+start-1,'bof');
hs.w_zero=fread(fid,1, 'float',00,'l')';
%XXX

%XXX
start=151;
fseek(fid,r_offset+start-1,'bof');
hs.irows=fread(fid,1, 'bit16',00,'l')';
%XXX

%XXX
start=155;
fseek(fid,r_offset+start-1,'bof');
hs.icols=fread(fid,1, 'bit16',00,'l')';
%XXX

%XXX
start=225;
fseek(fid,r_offset+start-1,'bof');
hs.ilayers=fread(fid,1, 'bit16',00,'l')';
%XXX

%XXX
start=195;
fseek(fid,r_offset+start-1,'bof');
hs.unit=fread(fid,10, 'bit8=>char','l')';
%XXX

%XXX
start=205;
fseek(fid,r_offset+start-1,'bof');
hs.xyunit=fread(fid,10, 'bit8=>char','l')';
%XXX


%XXX
start=163;
fseek(fid,r_offset+start-1,'bof');
hs.x_distmin=fread(fid,1, 'float','l')';
%XXX

%XXX
start=167;
fseek(fid,r_offset+start-1,'bof');
hs.x_distmax=fread(fid,1, 'float','l')';
%XXX
hs.xdist=hs.x_distmax-hs.x_distmin;

%XXX
start=171;
fseek(fid,r_offset+start-1,'bof');
hs.y_distmin=fread(fid,1, 'float','l')';
%XXX

%XXX
start=175;
fseek(fid,r_offset+start-1,'bof');
hs.y_distmax=fread(fid,1, 'float','l')';
%XXX
hs.ydist=hs.y_distmax-hs.y_distmin;


%%%%%%%%%%%% LI parameters, offset1356
r_offset = 1356;
%XXX
start=1;
fseek(fid,r_offset+start-1,'bof');
hs.li_f=fread(fid,1, 'float','l')';
%XXX
%XXX
start=5;
fseek(fid,r_offset+start-1,'bof');
hs.li_amp=fread(fid,1, 'float','l')';
%XXX
%XXX
start=9;
fseek(fid,r_offset+start-1,'bof');
hs.li_phase=fread(fid,1, 'float','l')';
%XXX
%XXX
start=13;
fseek(fid,r_offset+start-1,'bof');
hs.li_sens=fread(fid,1, 'float','l')';
%XXX
%XXX
start=17;
fseek(fid,r_offset+start-1,'bof');
hs.li_tconst=fread(fid,1, 'float','l')';
%XXX
%XXX
start=21;
fseek(fid,r_offset+start-1,'bof');
hs.li_rolloff=fread(fid,1, 'bit16','l')';
%XXX
%XXX
start=23;
fseek(fid,r_offset+start-1,'bof');
hs.li_reserve=fread(fid,1, 'bit16','l')';
%XXX
%XXX
start=25;
fseek(fid,r_offset+start-1,'bof');
hs.li_filters=fread(fid,1, 'bit16','l')';
%XXX
%XXX
start=27;
fseek(fid,r_offset+start-1,'bof');
hs.li_harmonic=fread(fid,1, 'bit16','l')';
%XXX
%XXX
start=29;
fseek(fid,r_offset+start-1,'bof');
hs.li_expand=fread(fid,1, 'bit16','l')';
if (hs.li_expand == 0)
    hs.li_expand = 1;
end
%XXX
%XXX
start=31;
fseek(fid,r_offset+start-1,'bof');
hs.li_foffset=fread(fid,1, 'float','l')';
%XXX
%%%%%%%%%%%% scan parameters, offset 1280 %%%%%%%%%%%%%%%%%%%%%%%
%XXX
r_offset = 1280;
start=1;
fseek(fid,r_offset+start-1,'bof');
hs.s_startvolt=fread(fid,1, 'float','l')';
%XXX

%XXX
start=5;
fseek(fid,r_offset+start-1,'bof');
hs.s_endvolt=fread(fid,1, 'float','l')';
%XXX


%%%%%%%%%%%% additional scan parameters, offset 1384 %%%%%%%%%%%%%%%%%%%
r_offset = 1384;
%XXX
start=23;
fseek(fid,r_offset+start-1,'bof');
hs.s_vtip=fread(fid,1, 'float','l')';
%XXX

%XXX
start=27;
fseek(fid,r_offset+start-1,'bof');
hs.s_itip=fread(fid,1, 'float','l')';
fclose(fid);
%XXX
hs.s_jr=abs(hs.s_vtip/hs.s_itip);
