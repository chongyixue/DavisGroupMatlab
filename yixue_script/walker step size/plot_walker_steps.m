%20180702
%produces 3 plots: 
%   1. step size per position
%   2. position in nm versus steps
%   3. position in voltage versus steps

%STEPS in 1000 unless in 1 then put in argument for varargin 
%for each of forward (FWD) and backward(BCK)
%key in a list of 
%fwdx - a list of steps eg. [0, 10, 20 ,30 ... 84]
%fwdy - a list of positions at steps fwdx eg. [-128.8,-83.2, ... 450.0]
%similarly for bckx and bcky

function plot_walker_steps(header,fullrange,TOPposition,BOTTOMposition,fwdx,fwdy,bckx,bcky,varargin)
if length(varargin>0)
    fwdx = fwdx/1000;
    bckx = bckx/1000;
end

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

figure(33),plot(fwdAVGPOS,fwdDIFF)
hold on
plot(bckAVGPOS, bckDIFF, 'r')
plot(bckAVGPOS, bckDIFF, 'rs')
plot(fwdAVGPOS,fwdDIFF,'bs')
title(header)
xlabel("average position(micro-m)")
ylabel("average step size(micro-m)")
legend('FWD','BCK')
hold off

figure(44),plot(fwdx, fwdyV)
hold on
plot(bckx, bckyV,'r')
plot(fwdx, fwdyV,'bs')
plot(bckx, bckyV,'rs')
title(header)
ylabel("position(micro-m)")
xlabel("steps (x 1000)")
legend('FWD','BCK')
hold off

figure(11),plot(fwdx, fwdy)
hold on
plot(bckx, bcky,'r')
plot(fwdx, fwdy,'bs')
plot(bckx, bcky,'rs')
title(header)
ylabel("position(V)")
xlabel("steps (x 1000)")
legend('FWD','BCK')
hold off
