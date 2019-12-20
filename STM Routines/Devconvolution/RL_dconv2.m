%%%%%%%
% CODE DESCRIPTION: Deconvolution algorithm based on the Richardson-Lucy
% Method.  
%   
% CODE HISTORY
%
% 090921 MHH Created
%
%%%%%%%

function dconv_data = RL_dconv2(energy,spectra,VA)
n = 10;
%ln = length(energy);
%a = zeros(n,ln);
%a(1,:) = spectra;

top = LIA_conv(energy,spectra,VA,-1);
tmp = spectra;
for i=1:n       
    bot_1 = LIA_conv(energy(1+i:end-i),tmp(2:end-1),VA,1);
    bot_2 = LIA_conv(energy(1+i:end-i),bot_1,VA,-1);
    %a(i,:) = a(i-1,:).*(top(i,end-i)./bot_2);
    a = tmp(2:end-1).*(top(1+i:end-i)./bot_2);
    %figure; plot(energy,top); hold on; plot(energy,bot_2,'r'); hold on; plot(energy,top./bot_2,'g')
    %hold on; plot(energy,a,'k');
    %ylim([-1 40]);
    tmp = a;
end
dconv_data = a;
end