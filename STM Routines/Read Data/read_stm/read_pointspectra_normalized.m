function read_pointspectra
    % NOTE: will have to make modification if only one of fwd/bkwd data
    % exists
    
    % conversion to volt
    w_factor = 0.89; 
    w_zero =0.007;

    %prompt for file selection - current(DI1) or conductance(DI2)
    [filename,pathname] = uigetfile({'*.DI1;*.DI2','MATLAB Files (*.DI1,*.DI2)'},...
                                     'Select Spectra Data File(*.DI1, *DI2)',...
                                     'C:\Data\stm data\BSCCO\RUN063\OD80K\110413');
    
    cd (pathname);
    fid = fopen(filename,'r');
    raw_data = fread(fid,'float');

    % parse out energy information in mV
    v = raw_data(1:2:end);
    v = v(265:end); 
    energy = v(1:length(v)/2);
    energy = energy*1000;

    %parse out current/conductance data
    data=raw_data(2:2:end);
    data=data(265:end); 

    %data taken in the forward(fwd), backward(bkwd) directions
    fwd = data(1:length(data)/2); fwd = fwd*w_factor + w_zero;
    bkwd = data(length(data)/2+1:end); bkwd = bkwd*w_factor + w_zero;

    %always write data variables with the first elements always being at the most
    %negative energies
%     if energy(1) < energy(end)
%         tmp = fwd(end:-1:1); fwd = tmp;
%         tmp = bkwd(end:-1:1); bkwd = tmp;
%     else
%         tmp = energy(end:-1:1); energy = tmp;
%     end
    avg = (fwd + bkwd)/2; % average of directional spectra    
    
    data_out.fwd = fwd; data_out.bkwd = bkwd; 
    data_out.avg = avg; data_out.energy = energy;
    data_out.name = filename(1:end-4);
    assignin('base',['obj_' filename(1:end-4) '_S'],data_out);

end

