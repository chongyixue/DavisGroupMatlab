name = 'C:\Data\stm data\URuSi\RUN060\TH-URUSI\090227\90227A13.2FL';

%XXX
start=5; %
fid=fopen(name);
fread(fid,256+start-1, 'ubit8',00,'l');
hs.bit_offset=fread(fid,1,'bit32',00,'l')';
fseek(fid,256+25-1,'bof');
%fclose(fid);
%XXX

% %XXX
% start=25;
% fid=fopen(name);
% fread(fid,256+start-1, 'ubit8',00,'l');
 hs.date=fread(fid,20, 'bit8=>char',00,'l')';
fclose(fid);
% %XXX