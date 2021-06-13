function [header, data, par, data_pos] = load3ds(fn, pt_index)
% loadsxm  Nanonis 3ds file loader
%   [header, data, par] = load3ds(fn, pt_index) reads a Nanonis
%   3ds file fn.
%   Without a second argument, only the header is returned.
%   With a second argument pt_index, the return value 'data'
%   contains the spectroscopy data set of point pt_index (zero
%   based). Each column in the data array corresponds to an
%   acquired channel.
%   The 'par' variable will contain the parameters of the data
%   set at the specified point.

data=''; header=''; par=''; data_pos = '';

if exist(fn, 'file')
    fid = fopen(fn, 'r', 'ieee-be');    % open with big-endian
else
    fprintf('File does not exist.\n');
    return;
end

% read header data
% The header consists of key-value pairs, separated by an equal sign,
% e.g. Grid dim="64 x 64". If the value contains spaces it is enclosed by
% double quotes (").
while 1
    s = strtrim(fgetl(fid));
    if strcmp(upper(s),':HEADER_END:')
        data_pos = ftell(fid);
        break
    end
    
    %s1 = strsplit(s,'=');  % not defined in Matlab
    s1 = strsplit_i(s,'=');
    
    s_key = strrep(lower(s1{1}), ' ', '_');
    s_val = strrep(s1{2}, '"', '');
    
    switch s_key
        
        % dimension:
        case 'grid_dim'
            s_vals = strsplit_i(s_val, 'x');
            header.grid_dim = [str2num(s_vals{1}), str2num(s_vals{2})];
            
            % grid settings
        case 'grid_settings'
            header.grid_settings = sscanf(s_val, '%f;%f;%f;%f;%f');
            
            % filetype - tells you linear or MLS
        case 'filetype'
            header.filetype = sscanf(s_val, '%s');
            
        case 'segment_start_(v),_segment_end_(v),_settling_(s),_integration_(s),_steps_(xn)'
            segments = strsplit(s_val,';');
            
            skey = strsplit(s_key,',');
            skey = strrep(skey,'(','');
            skey = strrep(skey,')','');
            
            
            for k=1:length(segments)
                segments{k} = str2double(strsplit(segments{k},','));
            end

            val = reshape([segments{:}],length(skey),length(segments));
            for i=1:length(skey)
                key = skey{i};
                while key(1)=='_'
                    key = key(2:end);
                end
                arraystr = num2str(squeeze(val(i,:)));
                arraystr = strcat('[',arraystr,']');
                evalstr=strcat('header.MLSsegments.',key,'=',arraystr);
                eval(evalstr);
            end
            
            header.MLSsegments.segments = length(segments);
            
            % fixed parameters, experiment parameters, channels:
        case {'fixed_parameters', 'experiment_parameters', 'channels'}
            s_vals = strsplit_i(s_val, ';');
            header.(s_key) = s_vals;
            
            % number of parameters
        case '#_parameters_(4_byte)'
            header.num_parameters = str2num(s_val);
            
            % experiment size
        case 'experiment_size_(bytes)'
            header.experiment_size = str2num(s_val);
            
            % spectroscopy points
        case 'points'
            header.points = str2num(s_val);
            
            % sweep signal (could be Bias or Z for example)
        case 'sweep_signal'
            header.sweep_signal = s_val;
            
        case 'bias_spectroscopy>sweep_start_(v)'
            header.st_sweep = str2num(s_val);
            
        case 'bias_spectroscopy>sweep_end_(v)'
            header.end_sweep = str2num(s_val);
            
            %bias modulation amplitude
        case 'lock-in>amplitude'
            header.bias_mod = str2num(s_val);
            
            % delay before measuring
        case 'delay_before_measuring_(s)'
            header.delay_before_meas = str2num(s_val);
            
            % other parameters -> treat as strings
        otherwise
            s_key = regexprep(s_key, '[^a-z0-9_]', '_');
            % header.(s_key) = s_val;
    end
end

% read the data if requested
if nargin > 1
    exp_size = header.experiment_size + header.num_parameters*4;
    fseek(fid, pt_index*exp_size, 0);
    
    par = fread(fid, header.num_parameters, 'float');
    data = fread(fid, [header.points prod(size(header.channels))], 'float');
    %data = transpose(data);
end

fclose(fid);
end  % of function load3ds


function s = strsplit_i(str, del)
s = {};
while ~isempty(str),
    [t,str] = strtok(str, del);
    s{end+1} = t;
end
end