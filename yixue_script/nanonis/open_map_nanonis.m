% 2019-10-15 YXC
% opens nanonis map files (3ds)

function [map,topo,current,parammap,all] =  open_map_nanonis(pathname,filename,varargin)

% filename = 'map2.3ds';
% filename
if length(filename)~=12
    name = inputdlg('Map name (7 chars):','s');
    name = name{1};
else
    name = filename(4:11);
end

filename  = strcat(pathname,filename);
assignin('base','fname',filename);
fid = fopen(filename,'r');

plott = 0;
if nargin>1
    plott = 1;
end

%% use nanonis-provided matlab script to read header into structure form
[header,~,~] = load3ds(filename); %header is a struct
nx = header.grid_dim(2);
ny = header.grid_dim(1);
grid_sett = header.grid_settings;
cx = grid_sett(2);
cy= grid_sett(1);
sx = grid_sett(4);
sy = grid_sett(3);
angle = grid_sett(5);

nxy = max(nx,ny);
sxy = max(sx,sy);

expt_param_cells = header.experiment_parameters;
points = header.points;
% n_expt_params = length(expt_param_cells);
n_fixed_params = length(header.fixed_parameters);
n_params = header.num_parameters;
layers = header.points;
n_channels = length(header.channels);
points_per_px = n_params+n_channels*points;

%% layer for topo at z_i of the 3d map later
for i=1:length(expt_param_cells)
    parametername = expt_param_cells{i};
    switch parametername
        case 'Z (m)'
            z_i = i+n_fixed_params;
        case 'Z offset (m)'
            z_offset_i = i+n_fixed_params;   
    end   
end

%% assign channels to G or I map (or any other map)
channels = header.channels;
% change names of known channels to match 'I' and 'G'
% specific to physically which chaneel you chose for your nanonis
for i = 1:length(channels)
    channel = channels{i};
    switch channel
        case 'Current (A)'
            channels{i} = 'I';
        case 'Input 3 (V)'
            channels{i} = 'G';
    end
end

%% now get 1D data
d = get_1d_data(fid,filename); %updated 2020/3/8 to load unfinished map.
assignin('base','d',d);
[sd,~] = size(d);
data = zeros(nx*ny*points_per_px,1);
data(1:sd) = d;

% updated for incomplete map
data3D = reshape(data,points_per_px,nx,ny);
assignin('base','data3D',data3D);
% data3D = permute(data3D,[2,3,1]);
data3D = permute(data3D,[3,2,1]);
data3D = flipud(data3D);

assignin('base','data3Dnew',data3D);

%% make general object
obj.nanonis_info = header;
obj.r = 10^(10)*linspace(0,sxy,nxy)'; %in Angstroem
if strcmp(header.filetype,'MLS')
   st = header.MLSsegments;
   en = [];
   for i=1:st.segments
       if isempty(en)==0
           en(end)=[];
       end
      en(end+1:end+st.steps_xn(i)) = linspace(st.segment_start_v(i),st.segment_end_v(i),st.steps_xn(i));
   end
   obj.e = en;
else
   obj.e = linspace(data(1),data(2),layers);
end
obj.name = name;
obj.coord_type = 'r';
obj.ops = '';

%% initialize topo obj
topo = obj;
topo.type = 2;
topo.map = zeros(nxy,nxy,1);
topo.e = 0;
topo.topo1 = data3D(:,:,z_i)-data3D(:,:,z_offset_i);
topo.map = prep_topo(topo.topo1);
topo.var ='T';
assignin('base',['obj_' topo.name '_' topo.var],topo); % exports the data to the workspace

%% parameters obj
parammap = obj;
parammap.type = 0;
parammap.map = zeros(nxy,nxy,n_params);
% parammap.map(1:nx,1:ny,:) = data3D(:,:,1:n_params);
parammap.map(1:nx,1:ny,:) = reshape(data3D(:,:,1:n_params),nx,ny,[]);
parammap.ave = squeeze(mean(mean(parammap.map,1)));
parammap.var = 'Params';
parammap.e = linspace(1,n_params,n_params)*0.001;
assignin('base',['obj_' parammap.name '_' parammap.var],topo); % exports the data to the workspace


%% generate objects for all channels
map = 0; current = 0;
all.topo = topo;
all.params = parammap;
all.info = header;
for i = 1:length(channels)
    img_obj = obj;
    img_obj.map = zeros(nxy,nxy,layers);
%     img_obj.map(1:nx,1:ny,:) = data3D(:,:,n_params+(i-1)*layers+1:n_params+(i)*layers);
    img_obj.map(1:nx,1:ny,:) = reshape(data3D(:,:,n_params+(i-1)*layers+1:n_params+(i)*layers),nx,ny,[]);
    img_obj.ave = squeeze(mean(mean(img_obj.map,1)));
    img_obj.var = channels{i};
    img_obj.type = 5;
    switch channels{i}
        case 'G'
            img_obj.type = 0;
            map = img_obj;
        case 'I'
            img_obj.type = 1;
            current = img_obj;
    end
    all.(genvarname(['channel_' num2str(i) '_' channels{i}]))=img_obj;

    if plott==1
        img_obj_viewer_test(img_obj)
    end
    varname = ['obj_' img_obj.name '_' img_obj.var];
    varname = strrep(varname,' ','');
    varname = strrep(varname,'(','_');
    varname = strrep(varname,')','_');
    varname = strrep(varname,'/','_');
    assignin('base',varname,img_obj); % exports the data to the workspace
end

if plott==1
    img_obj_viewer_test(parammap)
    img_obj_viewer_test(topo)
end


%% find where data starts and get 1D data
function data = get_1d_data(fid,filename)
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
end

end









