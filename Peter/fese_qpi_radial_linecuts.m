function [ampl, width, pc] = fese_qpi_radial_linecuts(data, ev, dcut, pcut)
tic 
% map = data.map(:,:, data.e*1000 == ev);
[nx, ny, nz] = size(data.map);

xc = round(nx/2)+1;
yc = round(ny/2)+1;

cc = size(dcut, 2);

    
ev_list = [-25, -23.75, -22.5, -21.25, -20, -18.75, -17.5, -16.25, -15,...
           15, 16.25, 17.5, 18.75, 20, 21.25, 22.5, 23.75, 25];
    
evi = find(ev_list == ev);



  
    
%% 09/16/2017
%% start points for fits negative bias / energy
%           0   5   10  15  20  25  30  35  40  45  50  55  60  65  70  75  80  85  90
sp_m25 =   [27, 27, 27, 26, 25, 24, 21, 19, 18, 16, 18, 20, 24, 26, 20, 22, 23, 24, 24];
sp_m2375 = [26, 27, 26, 26, 25, 23, 21, 19, 17, 16, 18, 20, 23, 24, 18, 20, 21, 22, 22];
sp_m225 =  [26, 26, 25, 25, 24, 22, 20, 18, 17, 16, 18, 20, 22, 24, 23, 23, 23, 23, 23];
sp_m2125 = [24, 24, 25, 24, 23, 22, 20, 18, 17, 16, 17, 19, 22, 23, 21, 21, 21, 21, 21];
sp_m20 =   [24, 23, 23, 23, 23, 21, 19, 17, 17, 16, 17, 19, 20, 23, 25, 22, 23, 23, 23];
%           0   5   10  15  20  25  30  35  40  45  50  55  60  65  70  75  80  85  90
sp_m1875 = [22, 22, 22, 22, 21, 20, 18, 17, 16, 15, 17, 18, 20, 23, 27, 19, 19, 19, 19];
sp_m175 =  [21, 21, 21, 21, 20, 19, 17, 16, 15, 14, 16, 17, 19, 20, 23, 19, 19, 19, 19];
sp_m1625 = [19, 19, 19, 20, 19, 18, 13, 13, 12, 12, 15, 16, 18, 19, 23, 15, 15, 15, 15];
sp_m15 =   [18, 19, 19, 19, 18, 17, 13, 13, 12, 12, 13, 15, 17, 19, 23, 15, 15, 15, 15];

%% end points for fits negative bias / energy
%            0   5  10  15  20  25  30  35  40  45  50  55  60  65  70  75  80  85  90
ep_m25 =   [35, 35, 36, 34, 33, 32, 31, 29, 28, 26, 29, 32, 33, 34, 47, 48, 49, 50, 50];
ep_m2375 = [34, 33, 35, 34, 32, 32, 30, 28, 26, 24, 27, 28, 33, 36, 47, 48, 49, 50, 50];
ep_m225 =  [33, 34, 35, 34, 33, 31, 30, 28, 26, 25, 28, 29, 33, 34, 47, 48, 49, 50, 50];
ep_m2125 = [33, 33, 32, 33, 32, 31, 29, 27, 26, 24, 28, 30, 32, 32, 47, 48, 49, 50, 50];
ep_m20 =   [31, 32, 32, 31, 30, 31, 29, 26, 25, 23, 26, 30, 30, 34, 34, 48, 49, 50, 50];
%           0   5   10  15  20  25  30  35  40  45  50  55  60  65  70  75  80  85  90
ep_m1875 = [33, 32, 32, 31, 30, 31, 28, 27, 24, 23, 27, 29, 29, 33, 36, 48, 49, 50, 50];
ep_m175 =  [33, 32, 31, 30, 32, 31, 30, 28, 26, 22, 26, 27, 30, 32, 34, 48, 49, 50, 50];
ep_m1625 = [31, 30, 30, 29, 28, 26, 26, 28, 26, 22, 25, 27, 35, 37, 38, 48, 49, 50, 50];
ep_m15 =   [29, 29, 29, 29, 28, 26, 25, 28, 26, 22, 29, 31, 34, 35, 36, 48, 49, 50, 50];
%% start points for fits positive bias / energy
%           0   5   10  15  20  25  30  35  40 45  50 55 60 65 70 75 80 85 90
sp_p15 =   [19, 19, 19, 24, 27, 23, 20, 18, 10, 9, 8, 7, 7, 7, 7, 7, 7, 7, 7];
sp_p1625 = [19, 19, 19, 24, 27, 23, 20, 18, 10, 9, 9, 7, 7, 7, 7, 7, 7, 7, 7];
sp_p175 =  [19, 19, 19, 24, 27, 22, 20, 13, 12, 7, 8, 7, 7, 7, 7, 7, 7, 7, 7];
sp_p1875 = [19, 19, 19, 20, 27, 22, 20, 14, 13, 11, 7, 7, 7, 7, 7, 6, 5, 5, 6];
sp_p20 =   [19, 19, 19, 24, 27, 24, 20, 18, 13, 12, 12, 12, 12, 8, 8, 5, 6, 6, 6];
%% 0 left on positive side, 0 on negative: +/- 25 to +/- 15 meV - 09/21/2017
%% open question how to handle the fact that I can't always fit up to the same angle
%%
%           0    5  10  15  20  25  30  35  40  45  50  55  60 65 70 75 80 85 90
sp_p2125 = [19, 19, 19, 22, 27, 24, 19, 18, 14, 12, 13, 13, 9, 5, 5, 5, 5, 5, 5];
sp_p225 =  [20, 20, 20, 20, 20, 25, 19, 18, 17, 13, 13, 13, 13, 9, 9, 9, 9, 9, 9];
sp_p2375 = [19, 19, 19, 22, 28, 25, 19, 18, 15, 13, 13, 13, 13, 9, 9, 9, 9, 9, 9];
sp_p25 =   [21, 20, 20, 21, 20, 26, 23, 18, 16, 15, 14, 13, 13, 10, 9, 9, 9, 9, 9];

%% end points for fits positive bias / energy
%           0   5   10  15  20  25  30  35  40  45  50  55  60  65  70  75  80  85  90
ep_p15 =   [50, 50, 49, 48, 47, 37, 31, 28, 22, 21, 22, 21, 21, 22, 22, 23, 24, 24, 23];
% ep_p15 =   [50, 50, 49, 48, 47, 33, 31, 28, 22, 21, 22, 21, 21, 22, 22, 23, 24, 24, 23];
ep_p1625 = [50, 50, 49, 48, 47, 32, 30, 28, 25, 21, 23, 23, 23, 23, 23, 24, 24, 24, 23];
ep_p175 =  [50, 50, 49, 48, 33, 36, 30, 28, 26, 22, 23, 23, 24, 23, 23, 24, 24, 24, 23];
% ep_p175 =  [50, 50, 49, 48, 33, 33, 30, 28, 26, 22, 23, 23, 24, 23, 23, 24, 24, 24, 23];
ep_p1875 = [50, 50, 49, 48, 35, 36, 32, 29, 26, 22, 24, 25, 24, 24, 23, 24, 24, 25, 25];
% ep_p1875 = [50, 50, 49, 48, 35, 33, 32, 29, 26, 22, 24, 25, 24, 24, 23, 24, 24, 25, 25];
ep_p20 =   [50, 50, 49, 48, 35, 38, 32, 30, 27, 23, 25, 25, 25, 25, 25, 24, 24, 25, 25];
% ep_p20 =   [50, 50, 49, 48, 35, 35, 32, 30, 27, 23, 25, 25, 25, 25, 25, 24, 24, 25, 25];

%%
%           0    5  10  15  20  25  30  35  40  45  50  55  60  65  70  75  80  85  90
ep_p2125 = [50, 50, 49, 48, 39, 38, 35, 30, 27, 24, 25, 25, 24, 25, 25, 24, 25, 25, 25];
ep_p225 =  [50, 50, 49, 48, 47, 36, 35, 31, 27, 24, 25, 26, 25, 26, 25, 25, 25, 25, 25];
ep_p2375 = [50, 50, 49, 48, 39, 36, 33, 31, 27, 25, 26, 26, 27, 27, 27, 26, 26, 26, 27];
ep_p25 =   [50, 50, 49, 48, 47, 37, 35, 32, 27, 25, 27, 27, 27, 28, 28, 28, 27, 27, 28];
%%
%            0    5   10   15    20   25  30   35   40   45   50   55   60   65   70   75   80   85   90
pc_m25 =   ['r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'k', 'k', 'k', 'k', 'k'];
pc_m2375 = ['r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'k', 'k', 'k', 'k', 'k'];
pc_m225 =  ['r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'k', 'k', 'k', 'k', 'k'];
pc_m2125 = ['r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'k', 'k', 'k', 'k', 'k'];
pc_m20 =   ['r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'k', 'k', 'k', 'k'];
pc_m1875 = ['r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'k', 'k', 'k', 'k'];
pc_m175 =  ['r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'k', 'k', 'k', 'k'];
pc_m1625 = ['r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'k', 'k', 'k', 'k'];
pc_m15 =   ['r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'k', 'k', 'k', 'k'];
%%
%            0    5   10   15    20   25  30   35   40   45   50   55   60   65   70   75   80   85   90
pc_p15 =   ['k', 'k', 'k', 'k', 'k', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r'];
pc_p1625 = ['k', 'k', 'k', 'k', 'k', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r'];
pc_p175 =  ['k', 'k', 'k', 'k', 'k', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r'];
pc_p1875 = ['k', 'k', 'k', 'k', 'k', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r'];
pc_p20 =   ['k', 'k', 'k', 'k', 'k', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r'];
pc_p2125 = ['k', 'k', 'k', 'k', 'k', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r'];
pc_p225 =  ['k', 'k', 'k', 'k', 'k', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r'];
pc_p2375 = ['k', 'k', 'k', 'k', 'k', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r'];
pc_p25 =   ['k', 'k', 'k', 'k', 'k', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r', 'r'];

degrees = {'0', '-5', '-10', '-15', '-20', '-25', '-30', '-35', '-40', '-45', '-50', '-55', '-60', ...
    '-65', '-70', '-75', '-80', '-85', '-90'};
degrees_num = [0, -5, -10, -15, -20, -25, -30, -35, -40, -45, -50, -55, -60,...
    -65, -70, -75, -80, -85, -90];
%% for -25 meV you can try to fit up to 65 degrees then it is out of range

switch ev
    case -25
        sp = sp_m25;
        ep = ep_m25;
        pc = pc_m25;
    case -23.75
        sp = sp_m2375;
        ep = ep_m2375;
        pc = pc_m2375;
    case -22.5
        sp = sp_m225;
        ep = ep_m225;
        pc = pc_m225;
    case -21.25
        sp = sp_m2125;
        ep = ep_m2125;
        pc = pc_m2125;
    case -20
        sp = sp_m20;
        ep = ep_m20;
        pc = pc_m20;
    case -18.75
        sp = sp_m1875;
        ep = ep_m1875;
        pc = pc_m1875;
    case -17.5
        sp = sp_m175;
        ep = ep_m175;
        pc = pc_m175;
    case -16.25
        sp = sp_m1625;
        ep = ep_m1625;
        pc = pc_m1625;
    case -15
        sp = sp_m15;
        ep = ep_m15;
        pc = pc_m15;
    %%
    case 15
        sp = sp_p15;
        ep = ep_p15;
        pc = pc_p15;
    case 16.25
        sp = sp_p1625;
        ep = ep_p1625;
        pc = pc_p1625;
    case 17.5
        sp = sp_p175;
        ep = ep_p175;
        pc = pc_p175;
    case 18.75
        sp = sp_p1875;
        ep = ep_p1875;
        pc = pc_p1875;
    case 20
        sp = sp_p20;
        ep = ep_p20;
        pc = pc_p20;
    case 21.25
        sp = sp_p2125;
        ep = ep_p2125;
        pc = pc_p2125;
    case 22.5
        sp = sp_p225;
        ep = ep_p225;
        pc = pc_p225;
    case 23.75
        sp = sp_p2375;
        ep = ep_p2375;
        pc = pc_p2375;
    case 25
        sp = sp_p25;
        ep = ep_p25;
        pc = pc_p25;
    otherwise
        sp = ones(19,1);
        ep = le*ones(19,1);
        pc = ['k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k', 'k'];
end
%%
for k=1:cc
    % exp_gaussian = 'a + b*(x-c) + h * exp( - (x-k)^2 / (2*l^2) )';
    cq = dcut{evi, k, 1}(sp(k):ep(k));
    cI = dcut{evi, k, 2}(sp(k):ep(k));

    slope = cI(end)-cI(1);

    if slope > 0
        slope_low = slope/2;
        slope_upp = 2*slope;
    else
        slope_low = 2*slope;
        slope_upp = slope/2;
    end


    %           a       b       c              h            k               l
    guess = [min(cI), slope, mean(cq), max(cI) - min(cI), cq(cI == max(cI)), abs(cq(2) -cq(1))*2];
    %      a       b       c       h        k             l
%     low = [0, slope_low, cq(1), min(cI), cq(1), abs(cq(2) -cq(1))];
    low = [0, slope_low, cq(1), 0, cq(1), abs(cq(2) -cq(1))];
    %         a           b        c       h        k              l
%     upp = [mean(cI), slope_upp, cq(end), max(cI), cq(end), abs(cq(end) -cq(1))/2];
    upp = [max(cI), slope_upp, cq(end), max(cI), cq(end), inf];

    % Gaussian fit
    [y_new, p,gof, ci]=FeSe_radial_fit_function_2(cI,cq,guess,low,upp);
    

    %% save the various quantities extracted from fit
    rp = p.k/abs(data.r(2)-data.r(1));
    
    % pixel location of band/peak for respective cut
    qx(k) =  xc + rp*cos(abs(degrees_num(k)) * pi/180)  ;
    qy(k) =  yc + rp*sin(abs(degrees_num(k)) * pi/180)  ;
    
    % fitted peak
    peak{k} = y_new;
    
    % amplitude and width of the peak
    ampl(k) = p.h;
    %ampl_error(k) = abs(ci(1,4)-ci(2,4))/2;
    width(k) = p.l;
    %width_error(k) = abs(ci(1,6)-ci(2,6))/2;
    
    figure, plot(dcut{evi, k, 1}(sp(k):ep(k)), dcut{evi, k, 2}(sp(k):ep(k)),...
            'k.-', 'LineWidth', 2, 'MarkerSize',15)
    title(strcat(degrees{k},' degrees'))
end


close all;
%%
%% plot the line-cuts all on top of one qpi layer
img_plot2(data.map(:,:, data.e*1000 == ev));
hold on
for k=1:cc
    %line-cut
    plot([xc pcut{evi, k, 1}],[yc pcut{evi, k, 2}],'w');
    %extracted energy contour position
    if pc(k) == 'r'
        plot(qx(k), qy(k), 'Marker', '+', 'MarkerSize', 12,'MarkerEdgeColor',...
            'w','MarkerFaceColor','w', 'LineWidth', 3);
    end
end
hold off  

%% plot the line-cuts all on top of one qpi layer

quarter_map = data.map(xc-3:end,yc-3:end, data.e*1000 == ev);
quarter_max = max(max( quarter_map) )/3;
[qnx, qny] = size(quarter_map);

for i=1:qnx
    for j=1:qny
        
        if quarter_map(i,j) > quarter_max
            quarter_map(i,j) = quarter_max;
        end
        
    end
end

img_plot2(quarter_map);
hold on
for k=1:cc
    %line-cut
    plot([4 pcut{evi, k, 1}-xc+4],[4 pcut{evi, k, 2}-yc+4],'w');
    %extracted energy contour position
    if pc(k) == 'r'
        plot(qx(k)-xc+4, qy(k)-yc+4, 'Marker', 'o', 'MarkerSize', 9,'MarkerEdgeColor',...
            'w','MarkerFaceColor','k', 'LineWidth', 2);
    end
end
hold off  

%%
figure, 
%plot(degrees_num(1), ampl(1), '+k', 'LineWidth', 2, 'MarkerSize',10)
hold on
for k=1:cc
    
    if pc(k) == 'r'
        plot(degrees_num(k), ampl(k), '+k', 'LineWidth', 2, 'MarkerSize',10)
        %errorbar(degrees_num(k), ampl(k), ampl_error(k), 'k')
    end
    
end
hold off
title('Peak amplitudes')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 20);
xlabel('angle in degrees','FontSize',20);
xlim([-90, 0])
ylabel('Ampl. [arb. u.]','FontSize', 20);

figure, 
%plot(degrees_num(1), width(1), '+k', 'LineWidth', 2, 'MarkerSize',10)
hold on
for k=1:cc
    
    if pc(k) == 'r'
        plot(degrees_num(k), width(k), '+k', 'LineWidth', 2, 'MarkerSize',10)
        %errorbar(degrees_num(k), width(k), width_error(k), 'k')
    end
    
end
hold off
title('Peak widths')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 20);
xlabel('angle in degrees','FontSize',20);
xlim([-90, 0])
ylabel('Width [1/A]','FontSize', 20);



%%
figure, plot(dcut{evi, 1, 1}, dcut{evi, 1, 2} / mean(dcut{evi, 1, 2}(sp(1):ep(1))),...
    'k.-', 'LineWidth', 2, 'MarkerSize',15)
hold on
for k=2:cc
    
    plot(dcut{evi, k, 1}, dcut{evi, k, 2} / mean(dcut{evi, k, 2}(sp(k):ep(k))) +...
        (k-1)*1, 'k.-', 'LineWidth', 2, 'MarkerSize',15)
    
end

for k=1:cc
    
    plot(dcut{evi, k, 1}(sp(k):ep(k)), dcut{evi, k, 2}(sp(k):ep(k)) /...
        mean(dcut{evi, k, 2}(sp(k):ep(k)))+ (k-1)*1, strcat(pc(k),'.-'),...
        'LineWidth', 2, 'MarkerSize',15)
    
end

for k=1:cc
    
    if pc(k) == 'r'
        plot(dcut{evi, k, 1}(sp(k):ep(k)), peak{k} / ...
            mean(dcut{evi, k, 2}(sp(k):ep(k))) + (k-1)*1, 'b-',...
            'LineWidth', 2, 'MarkerSize',15)
    end
    
end

hold off

title('Line-cuts')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 20);
xlabel('q [1/A]','FontSize',20);
ylabel('I [arb. u.]','FontSize', 20);
ylim([0, 22])

%%






toc
end