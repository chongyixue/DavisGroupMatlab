%20180702
%produces 2 plots: 

%   1. position in nm versus steps
%   2. position in voltage versus steps

%STEPS in 1000 unless in 1 then put in argument for varargin 
%for each of forward (FWD) and backward(BCK)
%key in a list of 
%fwdx - a list of steps eg. [0, 10, 20 ,30 ... 84]
%fwdy - a list of positions at steps fwdx eg. [-128.8,-83.2, ... 450.0]
%similarly for bckx and bcky

function p = plot_walker(header,fullrange,TOPposition,BOTTOMposition,steps,position_volt,volt,figure_n,varargin)

%remove this if steps already in x 1000 units!!
steps = steps/1000;

VoltageToMM = (fullrange)/(TOPposition-BOTTOMposition);
fwdyV = (position_volt-BOTTOMposition)*VoltageToMM;

R = (volt-140)/50;
B = 1-R;
color = [R,0,B];

if R>1
    color = [1,0,0];
elseif R < 0
    color = [0,0,0];
end


figure(figure_n),plot(steps, fwdyV,'Color',  color)
hold all
p = plot(steps, fwdyV,'d','MarkerEdgeColor',color,'MarkerSize',10,'MarkerFaceColor',color);
title(header)
ylabel("position(mm)")
xlabel("steps (x 1000)")

if length(varargin)>0
    legend(p,varargin{1})
end


% figure(111),plot(fwdx, fwdy)
% hold on
% plot(bckx, bcky,'r')
% plot(fwdx, fwdy,'bs')
% plot(bckx, bcky,'rs')
% title(header)
% ylabel("position(V)")
% xlabel("steps (x 1000)")
% legend('FWD','BCK')
% hold off
