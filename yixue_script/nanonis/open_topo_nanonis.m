function [header,topo] = open_topo_nanonis(pathname,filename,varargin)

if length(filename)~=16
    name = inputdlg('Map name (7 chars):','s');
    name = name{1};
else
    name = filename(4:11);
end
% name = 'gentopo';

filename  = strcat(pathname,filename);
% fid = fopen(filename,'r');

% plott = 0;
% if nargin>1
%     plott = 1;
% end

%% use nanonis provided function to extract data and make structure
[header,data] = loadsxm(filename,1);
ny = header.scan_pixels(1);
nx = header.scan_pixels(2);
sy = header.scan_range(1)*(10^10);
sx = header.scan_range(2)*(10^10); %units in Angstroem
nxy = max(nx,ny);
sxy = max(sx,sy);

%% make object
obj.nanonis_info = header;
obj.r = linspace(0,sxy,nxy);
obj.e  = 0;
obj.name = name;
obj.coord_type = 'r';
obj.ops = '';

data = fliplr(data);
topo = obj;
topo.type = 2;
topo.topo1 = data;
topo.map = prep_topo(topo.topo1);
% topo.map(1:nx,1:ny) = data;
topo.name = strcat([name,'_FWD']);
topo.var = 'T';
assignin('base',['obj_' topo.name '_' topo.var],topo);
img_obj_viewer_test(topo)

[~,data] = loadsxm(filename,0);
topo.type = 2;
topo.topo1 = data;
topo.map = prep_topo(topo.topo1);
% topo.map(1:nx,1:ny) = data;
topo.var = 'T';
topo.name = strcat([name,'_BWD']);
assignin('base',['obj_' topo.name '_' topo.var],topo);
img_obj_viewer_test(topo)

end