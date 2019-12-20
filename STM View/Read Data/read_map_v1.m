function data = read_map_v1
%cd ('C:\Data');
[filename,pathname]=uigetfile('*','Select Data File(*.2FL,*.1FL, *.TFR, *.1FR)');

if filename == 0;
    data = [];
    return;
end
filetype = filename(end-2:end);
cd (pathname);
switch filetype
    case '2FL'     %conductance map
        type = 0;
        var = 'G';
    case '1FL'     %current map
        type = 1;
        var = 'I';
    case 'TFR'     %topo map
        type = 2;
        var = 'T';
    case '1FR' % feedback current map
        type = 3;
        var = 'IF';
    otherwise
        data = '';
        disp('Invalid Data Type');
        return;
end

test=[pathname filename];
fid = fopen([pathname filename],'r');
% get image data
start = 2112;
fseek(fid,start,'bof');
a = fread(fid,'uint16');

% get additional params
hs=read_map_extra_v1([pathname filename],fid);
s = max(hs.irows,hs.icols);
fclose(fid);

%process image data into 3D matrix
if type == 2 || type == 3
    a = a(1:s^2);
else
    a = a(1:end-1300);
end
h = floor(length(a))/s^2;
map = reshape(a,[s s h]);
for k = 1:h
    map(:,:,k) = rot90(map(:,:,k),1);
    map(:,:,k) = flipud(map(:,:,k));
end


    %********************************************************
    %   *HOW TO CONVERT DATA TO REAL WORLD UNITS (FROM V TO NS)*
    %   ********************************************************
    %   When the data was initially loaded, it was unsigned integers, ranging from
    %   0 to 65535=2^16-1.
    %   Within File_ReadTopoData.pro, the unsigned integers were converted to floats
    %   using DACtoWorld and DACtoWorldZero.
    %   Since the input of the ECU is always a voltage between -10V and +10V, and
    %   the DAC is always 16-bit = 65536, the conversion factors are the same
    %   for every dI/dV map:
    %   DACtoWorld = 0.000305180 = 20/65536
    %   DACtoWorldZero = -10
    %   But the DACtoWorld part has already been taken care of when the data was
    %   loaded from the file, so we don't need to worry about it now.
    %   What is left to worry about is sensitivity, driveamp, and attenuation:
    %   1100 takes care of the bias dividers
    %   (fsens/10)/driveamp turns it into nS except that due to high freq of data
    %   taking, driveamp is effectively attenuated (should actually be smaller
    %   number than that recorded).
    %   1.495 factor is approximate value of attenuation (scales the map curves
    %   onto the the single spectra curves which are taken at a lower frequency
    %   and are less attenuated).

%convert bit data to volts: ECU discretizes -10->+10V in 16 bits
%w_factor = 20V/2^16, w_zero = -10V

map = map*hs.w_factor + hs.w_zero;
map(:,1)
if (type == 0)
    divider = 10; %voltage divider on bias line
    %convert LIA output to physical data signal using
    %output = (signal/sensitivity - offset)*expand*10V and inverting to
    %solve for signal which are the map values
    %hs.li_foffset = 0;
    map = (map./(hs.li_expand*10) + hs.li_foffset*(1/100))*hs.li_sens;      
    % make dI/dV by dividing by bias modulation
    map = map/(hs.li_amp/(100*divider)); %100 comes form ECU divider
    hs.factor = 1;
    map = map*hs.factor;
elseif (type == 1)        
    % current data is not processed by LIA but has a correction factor
    % due to the ECU
    %hs.factor = 13.4808;
    hs.factor = -1; %inverting amplifier
    map = map*hs.factor;        
elseif (type == 2)
    hs.factor = 1;
    map = map*hs.factor;
end

name = filename(1:end-4);

% for dI/dV and current map data
if type== 0 || type == 1

    %Collect all useful into a structure
    data.map = map;
    data.type = type; %define data type (conductance, current, topo)
    data.ave = squeeze(sum(sum(map)))/s/s; 
    data.name = name; %attach the file name to the structure
    data.r = num_conv(linspace(0,hs.xdist,s)');
    data.e =num_conv(linspace(hs.s_startvolt,hs.s_endvolt,hs.ilayers)); 
    data.info = hs;
    data.ops = '';
    data.var = var;

%for topographic data
elseif type == 2 || type == 3
    data.topo1 = map;
    data.map = prep_topo(map);
    data.e = 0;
    data.type = type;
    data.name = filename(1:end-4);
    data.r = num_conv(linspace(0,hs.xdist,s)');
    data.info = hs;   
    data.ops = '';
    data.var = var;
end    
end

function y = num_conv(x)
%topometrix values are read in with some inherent error in the actual
%value; e.g. 0.04V is read in as 0.039999999110000V
%this function converts such number into doubles with 7 decimal place
%accuracy which will round such numbers to the expected values.
% digits(7);
% tmp = vpa(x);
tmp=x;
y = double(tmp);
end

