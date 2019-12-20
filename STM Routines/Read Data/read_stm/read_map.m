function read_map
digits(7);
    %cd ('C:\Data');
    [filename,pathname]=uigetfile('*','Select Data File(*.2FL,*.1FL, *.TFR)');
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
    end

    % get additional params
    hs=read_map_extra3([pathname filename]);
    s = max(hs.irows,hs.icols);
    
    % get data
    fid = fopen([pathname filename],'r');
    a = fread(fid,'uint16');
    fclose(fid);
    a = a(1057:length(a)); 
    h = (length(a)-1300)/s^2;
    map = zeros(s,s,h);
    for j=1:h;
        for i=1:s;
           map(:,i,j) = a(((i-1)*s+1)+(j-1)*s^2 :i*s+(j-1)*s^2);
        end
    end

    %transpose data
    [nr,nc,nz] = size(map);
    for j=1:nz
        map(:,:,j) = flipud(map(:,:,j)');
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
    if (type == 0)
        divider = 10; %voltage divider
        %convert LIA output to physical data signal using
        %output = (signal/sensitivity - offset)*expand*10V and inverting to
        %solve for signal which are the map values
        %hs.li_foffset = 0;
        map = (map./(hs.li_expand*10) + hs.li_foffset*(1/100))*hs.li_sens;  
         max(max(max(map)))
        % make dI/dV by dividing by bias modulation
        map = map/(hs.li_amp/(100*divider));
        hs.factor = 1;
        map = map*hs.factor;
    elseif (type == 1)        
        % current data is not processed by LIA but has a correction factor
        % due to the ECU     
        hs.factor = -1; %inverting amplifier
        map = map*hs.factor;        
    elseif (type == 2)
        hs.factor = 1;
        map = map*hs.factor;
    end

    name = filename(1:end-4);
    [nr,nc,nz]=size(map);

    if type==0 || type ==1
        
        %Collect all useful into a structure
        data.map = map;
        data.type = type; %define data type (conductance, current, topo)
        data.ave = squeeze(sum(sum(map)))/s/s; 
        data.name = name; %attach the file name to the structure
        data.r = num_conv(linspace(0,hs.xdist,s)');
        %data.e = linspace(num_conv(hs.s_startvolt),num_conv(hs.s_endvolt),hs.ilayers);          
        %data.e =double(vpa(linspace(hs.s_startvolt,hs.s_endvolt,hs.ilayers)));   
        data.e =num_conv(linspace(hs.s_startvolt,hs.s_endvolt,hs.ilayers));   
        data.info = hs;
        data.var = var;

        %pick output name in workspace depending on map type
        assignin('base',[var],data);

    %for topographic data
    elseif type == 2
       % dist=hs.xdist;
        %dist=linspace(0,hs.xdist,s)';
        data.topo1 = map;
        data.map = prep_topo(map);
        data.e = 0;
        data.type = type;
        data.name = filename(1:end-3);
        data.r = linspace(0,hs.xdist,s)';
        data.info = hs;
        data.var = var;
        assignin('base',[var],data);    
    end
   % view6(data);
end

function y = num_conv(x)
%topometrix values are read in with some inherent error in the actual
%value; e.g. 0.04V is read in as 0.039999999110000V
%this function converts such number into doubles with 7 decimal place
%accuracy which will round such numbers to the expected values.
digits(7);
tmp = vpa(x);
y = double(tmp);
end

