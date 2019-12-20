% 2018-10-22
% YXC



topo = obj_90702a11_T;

% % excel_point_spect = xlsread("C:\Users\chong\Desktop\CBST\CBST_2019_log",-1);%B
clear name; clear setup;
pathname = "C:\Users\chong\Desktop\FeSeTe\fesete2019\FeSeTe_2019_log";
datapath = 'C:\Users\chong\Documents\MATLAB\STMdata\FeSeTe_2019\';

[data,name] = xlsread(pathname,-1);
setup = data(:,1:2);
point = data(:,3:4);

% [~,name] = xlsread(pathname,-1);
% setup = xlsread(pathname,-1);
% point = xlsread(pathname,-1);

number = length(setup);
shiftup = 10;
offset = 0;

onethird = round(number/3);
twothird = round(number*2/3);
chunk1 = 1/onethird; chunk2 = 1/(twothird-onethird);
pp = figure();
R = 0;G = 0;B=0;
color = zeros(number,3);
maxx = 0;
for n = 1:number
    %     if setup(n,1)>0
    %         B = 0;
    %         R = 1*(number-n)/number;
    %     else
    %         R = 0;
    %         B = 1*(number-n)/number;
    %     end

%     %choice 1
%     if n<onethird
%         increment1 = chunk1;
%         R = R + increment1;
%     elseif n<twothird
%         increment2 = chunk2;
%         B = B + increment2;
%     else
%         increment = R/(number-twothird);
%         R = R - increment;
%     end
    
    %choice 2
    R = (number-n)/number;
    B = 1-R;
    
    
    color(n,:) = [R G B];
    col = color(n,:);
    [avg,energy] =  read_pointspectra3(datapath,name{n},'noplot');
    maxx = max(max(avg+offset+shiftup),maxx);
    plot(energy,avg+offset,'Color',col);
    hold on
%        title([name{n} '  ('  num2str(point(n,1)) ',' num2str(point(n,2)) ')'],'FontSize',15);

    offset = offset+shiftup;
    
%     resis = setup(n,1)/setup(n,2);
%     title([name{n} '  '  num2str(setup(n,1)) 'mV/' num2str(setup(n,2)) 'pA   ' num2str(resis,3) ' GOhm'],'FontSize',15);
%     plot(energy,avg,'color',color);
%     hold on
end
xlim([-3,3]);
title("pointspectra");
plot([0,0],[0,maxx],'k--')

figure,imagesc(topo.map)
colormap(gray)
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
daspect([1 1 1])
hold on
for i = 1:number
    plot(point(i,1),point(i,2),'Color',color(i,:),'Marker','.','MarkerSize',10)
    hold on
end



