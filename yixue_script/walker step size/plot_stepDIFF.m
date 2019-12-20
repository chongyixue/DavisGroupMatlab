%20180702
%produces 1 plot (ONLY IF varargin>0)
%   1. step size per position

%key in a list of
%fwdx - a list of steps eg. [0, 10, 20 ,30 ... 84]
%fwdy - a list of positions at steps fwdx eg. [-128.8,-83.2, ... 450.0]


function [fwdAVGPOS,fwdDIFF,p] = plot_stepDIFF(header,fullrange,TOPposition,BOTTOMposition,steps,position_volt,volt,figure_n,varargin)

%remove this if steps already in x 1000 units!!
steps = steps/1000;

VoltageToMM = (fullrange)/(TOPposition-BOTTOMposition);
fwdyV = (position_volt-BOTTOMposition)*VoltageToMM;



fwdAVGPOS = [];
for x = 1: length(fwdyV)-1
    fwdAVGPOS(x) = 0.5*(fwdyV(x)+fwdyV(x+1));
end

fwdDIFF = [];
for x = 1: length(fwdyV)-1
    nsteps = steps(x+1)-steps(x);
    fwdDIFF(x) = (fwdyV(x+1)-fwdyV(x))/(nsteps);
end


R = (volt-140)/50;
B = 1-R;
color = [R,0,B];

if R>1
    color = [1,0,0];
elseif R < 0
    color = [0,0,0];
end



figure(figure_n),plot(fwdAVGPOS,fwdDIFF*1000,'Color',  color)
hold all
p = plot(fwdAVGPOS,fwdDIFF*1000,'p','MarkerEdgeColor',color,'MarkerSize',10,'MarkerFaceColor',color);
title(header)
xlabel("average position(mm)")
ylabel("average step size(nm)")

if length(varargin)>0
    legend(p,varargin{1})
end




