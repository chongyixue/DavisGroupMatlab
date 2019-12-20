% 20180703 
% the aim is to plot the average step size from each cooldown
% have an excel file in the walker folder with step sizes



function [date,stepsizes,voltage] = walker_years_plot(filename,fullrange,TOPposition,BOTTOMposition)



%filename = "walker_20180701";
%n = 2; %number of dataset to put in
%fullrange = 2.2; in mm
%TOPposition = 450;
%BOTTOMposition = -128.8;

x = {};
y = {};
voltage = {};

header = "STM1 walker average step size over the years";

prompt = 'input date in Y-M-D format eg. 20180702\n';
sets = 1;
more = 1;

while more == 1
    fprintf("select steps data")
    steps = xlsread(filename,-1);
    if size(steps,2)>1
        position = steps(:,2);
        steps = steps(:,1);
    else        
        fprintf("select position data")
        position = xlsread(filename, -1);
    end
    y{sets} = stepsize(header,fullrange,TOPposition,BOTTOMposition,steps,position);
    
    str = input(prompt);
%     str = num2str(str);
    Y = round(round(str,-4)/10000);
    M = round(round((str-10000*Y),-2)/100);
    D = round(str-10000*Y-100*M);
%     Y = str(1:4);
%     M = str(5:6);
%     D = str(7:8);
    x{sets} = datetime(Y,M,D);
    
    volt = input('drive voltage?\n');
    voltage{sets} = volt;
    B = (280-volt)/(140);
    if B > 1
        B=1;
    end
    if B<0
        B=0;
    end
    R = 1-B;
    
    
    figure(55),plot(x{sets},y{sets},'MarkerEdgeColor',[R,0,B],'Marker', 'o', 'MarkerSize', 10)
    hold on
    
    sets = sets + 1;
    more = input('more? 1 for yes \n');
end

title('header');
xlabel('date');
ylabel('average walker size');
hold off

date = x;
stepsizes = y;

