function [data,energy] =  read_pointspectra4
% NOTE: only one of fwd/bkwd data


%prompt for file selection - current(DIC) or conductance(DI1) - STM1
[filename,pathname] = uigetfile({'*.DIC;*.DI1','MATLAB Files (*.DIC,*.DI1)'},...
    'Select Spectra Data File(*.DIC, *DI1)');%,...
%'C:\Data\stm data\');

cd (pathname);
fid = fopen(filename,'r');
raw_data = fread(fid,'float');
a = raw_data;
%length(raw_data)
fclose(fid);
% parse out energy information in mV
v = raw_data(1:2:end);
v = v(265:end);
energy = v(1:length(v));
energy = energy*1000;
length(energy);
%% 07/27/2016 P.O.S. add offset in mV - has to be always manually
%% changed, set it to 0 by deafult

offset = 0;
energy = energy + offset;

%%


%parse out current/conductance data
data=raw_data(2:2:end);
data=data(265:end);
length(data);

%%  060213 Changed by Peter Sprau (no multiplication with w_factor and
%%
%always write data variables with the first elements always being at the most
%negative energies
%     if energy(1) < energy(end)
%         tmp = fwd(end:-1:1); fwd = tmp;
%         tmp = bkwd(end:-1:1); bkwd = tmp;
%     else
%         tmp = energy(end:-1:1); energy = tmp;
%     end
% avg = (fwd + bkwd)/2; % average of directional spectra

data_out.fwd = data;
% data_out.avg = avg;
data_out.energy = energy;
data_out.name = filename(1:end-4);
assignin('base','S',data_out);

figure;
%     plot(energy,fwd,'k.-',energy,bkwd,'r.-',energy,avg,'b.-','linewidth',2)
% plot(energy,fwd,'k.-',energy,bkwd,'r.-','linewidth',2)
plot(energy,data,'k.-','linewidth',2)
% axis([min(energy) max(energy) min(min([fwd,bkwd,avg])) max(max([fwd,bkwd,avg]))])
xlabel('V [mV]','fontsize',12,'fontweight','b')
if strcmp(filename(end-2:end),'DI1')==1
    ylabel('dI/dV [nS]','fontsize',12,'fontweight','b')
elseif strcmp(filename(end-2:end),'DIC')==1
    ylabel('I [nA]','fontsize',12,'fontweight','b')
end
% legend('fwd','bkwd','avg');
title(filename,'fontsize',20,'fontweight','b')

end

