% 20180702 
% the aim is to plot the average step size from each cooldown
% have an excel file in the walker folder with step sizes

% filename = "walker_20180701";
filename = "walker2018";
n = 1; %number of dataset to put in

x = {};
y = {};
voltage = {};
fullrange = 2.3;
TOPposition = 256;
BOTTOMposition = -450;
header = "2011";

prompt = 'input date in Y-M-D format eg. 20180702\n';


for sets = 1:n
    fprintf("select steps data (or-with position data too)")
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
    
    figure(44),plot(x{sets},y{sets},'MarkerEdgeColor',[R,0,B],'Marker', 'x', 'MarkerSize', 15)
    hold on
    
end


xlabel('date');
ylabel('average walker size');
hold off


