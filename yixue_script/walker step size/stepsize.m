%20180702
%produces 1 plots (ONLY IF varargin>0) 
%   1. step size per position
%   2. position in nm versus steps
%   3. position in voltage versus steps

%returns a number: step size in nm

%key in a list of 
%fwdx - a list of steps eg. [0, 10, 20 ,30 ... 84]
%fwdy - a list of positions at steps fwdx eg. [-128.8,-83.2, ... 450.0]


function stepsize = stepsize(header,fullrange,TOPposition,BOTTOMposition,steps,position_volt,varargin)

%remove this if steps already in x 1000 units!!
steps = steps/1000;

VoltageToNM = (1000*fullrange)/(TOPposition-BOTTOMposition);
fwdyV = (position_volt-BOTTOMposition)*VoltageToNM;



fwdAVGPOS = [];
for x = 1: length(fwdyV)-1
    fwdAVGPOS(x) = 0.5*(fwdyV(x)+fwdyV(x+1));
end

fwdDIFF = [];
for x = 1: length(fwdyV)-1
    nsteps = steps(x+1)-steps(x);
    fwdDIFF(x) = (fwdyV(x+1)-fwdyV(x))/(nsteps);
end

if length(varargin) > 0
    
    figure()
    plot(fwdAVGPOS,fwdDIFF)
    hold on
    plot(fwdAVGPOS,fwdDIFF,'bs')
    title(header)
    xlabel("average position(nm)")
    ylabel("average step size(nm)")
    hold off
    
    figure()
    plot(steps, fwdyV)
    hold on
    plot(steps, fwdyV,'bs')
    title(header)
    ylabel("position(nm)")
    xlabel("steps (x 1000)")
    hold off
    
    figure()
    plot(steps, position_volt)
    hold on
    plot(steps, position_volt,'bs')
    title(header)
    ylabel("position(V)")
    xlabel("steps (x 1000)")
    hold off
end

stepsize = (fwdyV(end)-fwdyV(1))/(steps(end)-steps(1))
