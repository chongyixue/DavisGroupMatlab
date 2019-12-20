% 2019-7-5 YXC
% plot lines for linecuts 


% cuts = [x1,y1,x2,y2];

map  = obj_90705A00_G;

clear name; clear setup;
pathname = "C:\Users\chong\Desktop\FeSeTe\fesete2019\FeSeTe_2019_log";
datapath = 'C:\Users\chong\Documents\MATLAB\STMdata\FeSeTe_2019\';

[data,name] = xlsread(pathname,-1);

x1 = data(:,1);
y1 = data(:,2);
x2 = data(:,3);
y2 = data(:,4);
class = data(:,5); % so that we can color it differently
number = length(x1); % number of cuts


% figure,imagesc(map.map(:,:,23));
figure,imagesc(obj_90705a00_T.map);
colormap(gray)
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
daspect([1 1 1])
hold on
for n = 1:number
    if class(n) == 1
        col = 'r';
    elseif class(n) == 2
        col = 'g';
    elseif class(n) == 3
        col = 'b';
    elseif class(n) == 4
        col = 'y';
    elseif class(n) == 5
        col = 'm';
    else
        col = 'w';
    end
    plot([x1(n),x2(n)],[y1(n),y2(n)],'Color',col)
end
hold off

% for n = 1:number
%     line_cut_v3(map,[x1(n),y1(n)],[x2(n),y2(n)],1)
% end


    
    
    
    
    
    
    
    