%20180701
%get step size per step and also average position of steps
%bckx is a list of steps (in 1000 step chunk units)

%have a list of fwdx in 1000-step units and fwdyV in nm units
%similarly for bckx and bckyV



%for each of forward (FWD) and backward(BCK)
%key in a list of 
%fwdx - a list of steps eg. [0, 10, 20 ,30 ... 84]
%fwdy - a list of positions at steps fwdx eg. [-128.8,-83.2, ... 450.0]
%similarly for bckx and bcky

header = 'RUNC71 2018-07-01 RT 170V';
fullrange = 2.2; %in mm
TOPposition = 450; %in voltage
BOTTOMposition = -128.8; %in voltage

VoltageToNM = (1000*fullrange)/(TOPposition-BOTTOMposition);
bckyV = (bcky-BOTTOMposition)*VoltageToNM;
fwdyV = (fwdy-BOTTOMposition)*VoltageToNM;

bckAVGPOS = [];
for x = 1:length(bckyV)-1
    bckAVGPOS(x) = 0.5*(bckyV(x)+bckyV(x+1));
end

bckDIFF = [];
for x = 1: length(bckyV)-1
    nsteps = bckx(x+1)-bckx(x);
    bckDIFF(x) = (bckyV(x)-bckyV(x+1))/(nsteps);
end


fwdAVGPOS = [];
for x = 1: length(fwdyV)-1
    fwdAVGPOS(x) = 0.5*(fwdyV(x)+fwdyV(x+1));
end

fwdDIFF = [];
for x = 1: length(fwdyV)-1
    nsteps = fwdx(x+1)-fwdx(x);
    fwdDIFF(x) = (fwdyV(x+1)-fwdyV(x))/(nsteps);
end

figure()
plot(fwdAVGPOS,fwdDIFF)
hold on
plot(bckAVGPOS, bckDIFF, 'r')
plot(bckAVGPOS, bckDIFF, 'rs')
plot(fwdAVGPOS,fwdDIFF,'bs')
title(header)
xlabel("average position(nm)")
ylabel("average step size(nm)")
legend('FWD','BCK')
hold off

figure()
plot(fwdx, fwdyV)
hold on
plot(bckx, bckyV,'r')
plot(fwdx, fwdyV,'bs')
plot(bckx, bckyV,'rs')
title(header)
xlabel("position(nm)")
ylabel("steps (x 1000)")
legend('FWD','BCK')
hold off
