%%%%%%%
% CODE DESCRIPTION: Deconvolution algorithm based on the Richardson-Lucy
% Method.  
%   
% CODE HISTORY
%
% 090921 MHH Created
%
%%%%%%%

function dconv_data = RL_dconv_2(energy,spectra,VA)
count = 1;
%initialize variable to hold successive iterations of process spectra
a(1,:) = spectra;
%initialize the error estimate
er_tol(1) = 100;
er_tol(count+1) = RMS_er(energy,spectra,a(count,:),VA);
%constant numerator in RL algorithm - calculate once only
top = LIA_conv(energy,spectra,VA,-1);

% set tolerance for the RMS error - stop condition
tolerance = 0.0005;
while (-diff(er_tol(end-1:end)) > tolerance)
    count = count + 1;
    tmp = a;
    bot_1 = LIA_conv(energy,tmp,VA,1);
    bot_2 = LIA_conv(energy,bot_1,VA,-1);
    a = tmp.*(top./bot_2);
    er_tol(count+1) = RMS_er(energy,spectra,a,VA);
end
% count
dconv_data = a;
figure;
subplot(1,3,1); plot((-diff(er_tol(2:end))),'gx-');
title('error diff')
subplot(1,3,2); plot(energy,spectra,'r'); hold on; plot(energy,dconv_data(end,:));
title('deconvolved spectra vs original in red')
subplot(1,3,3);plot(energy,spectra,'r');hold on; plot(energy,LIA_conv(energy,dconv_data(end,:),VA,1));
title('reconvolvution of processed spectra vs original in red')

end
function err_est = RMS_er(x,y,y2,LIA_amp)
N = length(x);
err_est = sqrt(1/N*sum((y - LIA_conv(x,y2,LIA_amp)).^2));
end