function [avg,energy] =  read_pointspectra3(varargin)
%modified 8 Nov 2017 to add variable input
%when input data use ' instead of "
%example input is '71122a05' or '71122a05.DI1'
%to suppress plot, give more than one input. example ('71122a05',34)


% NOTE: will have to make modification if only one of fwd/bkwd data
% exists

% conversion to volt
%w_factor = 8.89233e-5;
%w_zero =-2.75;
w_zero = -10;
w_factor = 20/2^16;
%w_zero = -10;
%prompt for file selection - current(DI1) or conductance(DI2) - STM2
%     [filename,pathname] = uigetfile({'*.DI1;*.DI2','MATLAB Files (*.DI1,*.DI2)'},...
%                                      'Select Spectra Data File(*.DI1, *DI2)');%,...
%                                      %'C:\Data\stm data\');


if nargin == 0
    %prompt for file selection - current(DIC) or conductance(DI1) - STM1
    [filename,pathname] = uigetfile({'*.DIC;*.DI1','MATLAB Files (*.DIC,*.DI1)'},...
        'Select Spectra Data File(*.DIC, *DI1)');%,...
    %'C:\Data\stm data\');
else
    if nargin == 1
        filename = varargin{1};
        %     pathname = 'C:\Users\chong\Documents\MATLAB\STMdata\MoTeSe\';
        pathname = 'C:\Users\chong\Documents\MATLAB\STMdata\BST 2019\';

    else
        pathname = varargin{1};
        filename = varargin{2};
    end
    if length(filename)<9
        filename = strcat(filename,'.DI1');
    end
end

cd (pathname);
fid = fopen(filename,'r');
raw_data = fread(fid,'float');
a = raw_data;
%length(raw_data)
fclose(fid);
% parse out energy information in mV
v = raw_data(1:2:end);
v = v(265:end);
energy = v(1:length(v)/2);
% energy = v(1:length(v));
energy = energy*1000;

%% 07/27/2016 P.O.S. add offset in mV - has to be always manually
%% changed, set it to 0 by deafult

offset = 0;
energy = energy + offset;

%%

%parse out current/conductance data
data=raw_data(2:2:end);
data=data(265:end);


%%  060213 Changed by Peter Sprau (no multiplication with w_factor and
%%  addition of w_zero
%data taken in the forward(fwd), backward(bkwd) directions
fwd = data(1:length(data)/2);
%     fwd = fwd*w_factor + w_zero;
bkwd = data(length(data)/2+1:end);
%     bkwd = bkwd*w_factor + w_zero;
%%
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

if nargin<3
    figure;
    plot(energy,fwd,'k.-',energy,bkwd,'r.-',energy,avg,'b.-','linewidth',2)
    axis([min(energy) max(energy) min(min([fwd,bkwd,avg])) max(max([fwd,bkwd,avg]))])
    xlabel('V [mV]','fontsize',12,'fontweight','b')
    if strcmp(filename(end-2:end),'DI1')==1
        %  ylabel('dI/dV [nS]','fontsize',12,'fontweight','b')
    elseif strcmp(filename(end-2:end),'DIC')==1
        ylabel('I [nA]','fontsize',12,'fontweight','b')
    end
    legend('fwd','bkwd','avg');
    title(filename,'fontsize',20,'fontweight','b')
end


end

