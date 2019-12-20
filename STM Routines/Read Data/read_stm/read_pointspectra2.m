function read_pointspectra2
    % NOTE: will have to make modification if only one of fwd/bkwd data
    % exists
    
    % conversion to volt
    %w_factor = 8.89233e-5;    
    %w_zero =-2.75;
    w_zero = 0;
    w_factor = 20/2^16; 
    %w_zero = -10;
    %prompt for file selection - current(DI1) or conductance(DI2)
    [filename,pathname] = uigetfile({'*.DI1;*.DI2','MATLAB Files (*.DI1,*.DI2)'},...
                                     'Select Spectra Data File(*.DI1, *DI2)');%,...
                                     %'C:\Data\stm data\');
    
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
   w_factor = 1;
    fwd = data(1:length(data)/2);  fwd = fwd*w_factor + w_zero;
    bkwd = data(length(data)/2+1:end); bkwd = bkwd*w_factor + w_zero;
    %fwd = fwd*0.02/10; fwd = fwd/(0.001/1000);
    %bkwd = bkwd*0.02/10; bkwd = bkwd/(0.001/1000);
%     map = map*hs.w_factor + hs.w_zero;
%     if (type == 0)
%         divider = 10; %voltage divider
%         %convert LIA output to physical data signal using
%         %output = (signal/sensitivity - offset)*expand*10V and inverting to
%         %solve for signal which are the map values
%         %hs.li_foffset = 0;
%         map = (map./(hs.li_expand*10) + hs.li_foffset*(1/100))*hs.li_sens;  
%          max(max(max(map)))
%         % make dI/dV by dividing by bias modulation
%         map = map/(hs.li_amp/(100*divider));
%         hs.factor = 1;
%         map = map*hs.factor;
%     
%     
    
    
    
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
    assignin('base','S',data_out);

end

