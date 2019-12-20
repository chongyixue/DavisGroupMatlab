%20180703

% logoDIFF = [];
% logoSTEPS = [];
% LEGEND = [{}];

% data2018_1 = xlsread("walkerdata2018",-1);%B
% data2018_2 = xlsread("walkerdata2018",-1);%F
% data2018_3 = xlsread("walkerdata2018",-1);%B
% data2018_4 = xlsread("walkerdata2018",-1);%F
% data2018_5 = xlsread("walkerdata2018",-1);%B
% 



data2018_1 = xlsread("walkerdata2018",-1);%B
data = data2018_1;
volt =170;
newlegend = {'up'};

%2018 
% top = 450;
% bottom = -128.8;

% %before 2018
% top = 200;
% bottom = -440;

top = 440;
bottom = -200;

steps = data(:,1);
position_volt = data(:,2);
[~,~,q] = plot_stepDIFF("280V stepsize 2018",2.3,top,bottom,steps,position_volt,volt,2121);
p = plot_walker("280V walker 2018",2.3,top,bottom,steps,position_volt,volt,3131);
% p2 = plot_walker("2018 walker exercise",2.3,top,bottom,steps,position_volt,volt,555,'newest');


%update a list of legends 
%LEGEND = [{'22'},{'43'}];
LEGEND(end+1) = newlegend;

logoDIFF(end+1) = q;
logoSTEPS(end+1) = p;


% legend([q1, q2],LEGEND)
% legend([p1 p2],'a','b')
legend(logoDIFF,LEGEND);
legend(logoSTEPS,LEGEND);

clear stepsize
STEPsize = stepsize('header',2.3,top,bottom,steps,position_volt)

