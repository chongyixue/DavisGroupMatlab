%20180706
%Yi Xue Chong
%get data from excel file (user choose interactively),
%plot walker step size vs position, walking range
%and also return walker step size from each iteration
%please place the excel file in the same folder and example of first input
% "walkerdata2018"

function SizePerStep = analyse_walker(filename,header,varargin)

if isempty(varargin)==1
    n_iter = 6;
else
    n_iter = varargin{1};
end

stop = 0;
iteration = 1;


while stop ~= 1
    
    if iteration == 1
        logoDIFF = [];
        logoSTEPS = [];
        LEGEND = [{}];
    end
    
    %volt sets the color (related to plot_stepDIFF func) from 140=blue to
    %190=red
    volt = 140+(iteration-1)*50/n_iter;
    
    data = xlsread(filename,-1);%B

    %     newlegend = {'up'};
    
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
    [~,~,q] = plot_stepDIFF(header,2.3,top,bottom,steps,position_volt,volt,2121);
    p = plot_walker(header,2.3,top,bottom,steps,position_volt,volt,3131);
    % p2 = plot_walker("2018 walker exercise",2.3,top,bottom,steps,position_volt,volt,555,'newest');
    
    newlegend = {input('Legend for this curve? \n','s')};    
    %update a list of legends
    %LEGEND = [{'22'},{'43'}];
    LEGEND(end+1) = newlegend;
    
    logoDIFF(end+1) = q;
    logoSTEPS(end+1) = p;
    
    
    % legend([q1, q2],LEGEND)
    % legend([p1 p2],'a','b')
    legend(logoDIFF,LEGEND);
    legend(logoSTEPS,LEGEND);
    
    SizePerStep = stepsize('header',2.3,top,bottom,steps,position_volt);
    stop = input('stop? press "1"\n');
    iteration = iteration + 1;
end



end