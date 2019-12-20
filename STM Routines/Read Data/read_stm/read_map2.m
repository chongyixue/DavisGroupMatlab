function read_map2
    %cd ('C:\Data');
    [filename,pathname]=uigetfile('*','Select Data File(*.2FL,*.1FL, *.TFR)');
    filetype = filename(end-2:end);
    cd ([pathname]);
    switch filetype
        case '2FL'     %conductance map
            type=0;
            var = 'G';
        case '1FL'     %current map
            type=1;
            var = 'I';
        case 'TFR'     %topo map
            type=2;
            var = 'T';
    end

    % get additiaonal params
    hs=read_map_extra2([pathname filename]);
    s=hs.irows;
    
    % get data
    fid=fopen([pathname filename],'r');
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
    [sy, sx,sz]=size(map);
    for j=1:sz
        map(:,:,j) = flipud(map(:,:,j)');
    end
    %convert bit data to volts: ECU discretizes -10->+10V in 16 bits
    %w_factor = 20V/2^16, w_zero = -10V
    map = map*hs.w_factor + hs.w_zero; 
    if (type == 0)
        divider = 10; %voltage divider
        %convert LIA output to physical data signal using
        %output = (signal/sensitivity - offset)*expand*10V and inverting to
        %solve for signal which are the map values
        map = (map./(hs.li_expand*10) + hs.li_foffset*(-10/100))*hs.li_sens;        
        % make dI/dV by dividing by bias modulation
        map = map/(hs.li_amp/(100*divider));
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

    name = [filename(1:end-4)];
    [sy,sx,sz]=size(map);

    if type==0 || type ==1
        %dist = hs.xdist;
        %ave = squeeze(sum(sum(map)))/s/s;
        %dist = linspace(0,dist,s)';
        %en = linspace(hs.s_startvolt,hs.s_endvolt,hs.ilayers);
        %Pool all useful into a structure
        data.map = map;
        data.type = type; %define data type (conductance, current, topo)
        data.ave = squeeze(sum(sum(map)))/s/s; 
        data.name = name; %attach the file name to the structure
        data.r = linspace(0,hs.xdist,s)';
        data.e = linspace(hs.s_startvolt,hs.s_endvolt,hs.ilayers);   
        data.info = hs;

        %pick output name in workspace depending on map type
        assignin('base',[var],data);

    %for topographic data
    elseif type == 2

        dist=hs.xdist;
        dist=linspace(0,dist,s)';
        data.topo1 = map;
        data.map = prep_topo(map);
        data.e = [1];
        data.type = type;
        data.name = filename(1:end-3);
        data.r = dist;
        data.info = hs;
        assignin('base',[var],data);    
    end
end


