function fese_self_energy_plot(amplitudes, widths, keys, which_band)

ev_list = [-25, -23.75, -22.5, -21.25, -20, -18.75, -17.5, -16.25, -15,...
           15, 16.25, 17.5, 18.75, 20, 21.25, 22.5, 23.75, 25];
       

cc = size(amplitudes, 2);

degrees_num = [0, -5, -10, -15, -20, -25, -30, -35, -40, -45, -50, -55, -60,...
    -65, -70, -75, -80, -85, -90];

if strcmp(which_band, 'electron')
    max_ind = cc;
    figure, plot(ev_list(10:18), amplitudes(:,cc))
    figure, plot(ev_list(10:18), widths(:,cc))
elseif strcmp(which_band, 'hole')
    max_ind = 1;
    figure, plot(ev_list(1:9), flipud(amplitudes(:,1)))
    figure, plot(ev_list(1:9), flipud(widths(:,1)))
end

[nx, ny] = size(amplitudes);


for i=1:nx
    for j=1:ny
        if keys(i,j) == 'k'
            amplitudes(i,j) = 0;
        end

    end
end

norm_matrix = repmat(max(amplitudes,[],2),1,cc); 

norm_amplitudes = (amplitudes ./ norm_matrix);

mean_ampl = zeros(cc,1);
ampl_error = zeros(cc,1);
ac = 1;

for j=1:ny
    mc=1;
    d = 0;
    for i=1:nx
        
        if norm_amplitudes(i,j) > 0
            d(mc) = norm_amplitudes(i,j);
            mc = mc+1;
        end
        
        
    end
    mean_ampl(ac) = mean(d);
    ampl_error(ac) = std(d);
    ac = ac+1;
%     test=1;
end
        
mean_width = zeros(cc,1);
width_error = zeros(cc,1);
ac = 1;

for j=1:ny
    mc=1;
    d = 0;
    for i=1:nx
        
        if keys(i,j) == 'r'
            d(mc) = widths(i,j);
            mc = mc+1;
        end
        
        
    end
    mean_width(ac) = mean(d);
    width_error(ac) = std(d);
    ac = ac+1;
%     test=1;
end

%%

figure, 
%plot(degrees_num(1), ampl(1), '+k', 'LineWidth', 2, 'MarkerSize',10)
hold on
for k=1:cc
    
    if mean_ampl(k) > 0
        plot(degrees_num(k), mean_ampl(k), '+k', 'LineWidth', 2, 'MarkerSize',10)
        errorbar(degrees_num(k), mean_ampl(k), ampl_error(k), 'k')
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
    
    if mean_width(k) > 0
        plot(degrees_num(k), mean_width(k), '+k', 'LineWidth', 2, 'MarkerSize',10)
        errorbar(degrees_num(k), mean_width(k), width_error(k), 'k')
    end
    
end
hold off
title('Peak widths')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 20);
xlabel('angle in degrees','FontSize',20);
xlim([-90, 0])
ylabel('Width [1/A]','FontSize', 20);


%% repeat / expand to whole 0 to 2*pi range

counter = 1;

for i=0:5:360
    deg(counter) = i;
    counter = counter +1;
end

%% amplitudes

dummy = [mean_ampl; flipud(mean_ampl(1:end-1))];

mean_ampl_360 = [dummy; dummy(2:end)];

dummy = [ampl_error; flipud(ampl_error(1:end-1))];

ampl_error_360 = [dummy; dummy(2:end)];

figure, 
%plot(degrees_num(1), ampl(1), '+k', 'LineWidth', 2, 'MarkerSize',10)
hold on
for k=1:length(deg)
    
    if mean_ampl_360(k) > 0
        plot(deg(k), mean_ampl_360(k), '+k', 'LineWidth', 2, 'MarkerSize',10)
        errorbar(deg(k), mean_ampl_360(k), ampl_error_360(k), 'k')
    end
    
end
hold off
title('Peak amplitudes')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 20);
xlabel('angle in degrees','FontSize',20);
xlim([0, 360])
ylabel('Ampl. [arb. u.]','FontSize', 20);
%% width


dummy = [mean_width; flipud(mean_width(1:end-1))];

mean_width_360 = [dummy; dummy(2:end)];

dummy = [width_error; flipud(width_error(1:end-1))];

width_error_360 = [dummy; dummy(2:end)];

figure, 
%plot(degrees_num(1), width(1), '+k', 'LineWidth', 2, 'MarkerSize',10)
hold on
for k=1:length(deg)
    
    if mean_width_360(k) > 0
        plot(deg(k), mean_width_360(k), '+k', 'LineWidth', 2, 'MarkerSize',10)
        errorbar(deg(k), mean_width_360(k), width_error_360(k), 'k')
    end
    
end
hold off
title('Peak widths')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 20);
xlabel('angle in degrees','FontSize',20);
xlim([0, 360])
ylabel('Width [1/A]','FontSize', 20);

end