
filename = 'map2.3ds';
% filename = 'oldspec.DI1';
% filename = 'oldtopo.tfr';
% filename = 'oldmap.1fl';
fid = fopen(filename,'r');

% fseek(fid,1,2112)
% ftell(fid)

lines = {};
n = 1;
while ~feof(fid)
    lines{n} = fgetl(fid);
    if strcmp(lines{n},':HEADER_END:')
        pointer = ftell(fid);
        break
    end
    n=n+1;
end
fclose(fid);

fid = fopen(filename,'r','ieee-be');
start = pointer;
fseek(fid,start,'bof');
% data = fread(fid,'uint16');
data = fread(fid,'float');
fclose(fid);

n_params = 10;
n_sweeps = 200;
n_chan = 2;
nx = 30;
ny = 1;
exp_pixsize = n_params+n_sweeps*n_chan;

n = length(data);
% data3d = reshape(data,[nx,ny,length(data)/(nx*ny)]);










