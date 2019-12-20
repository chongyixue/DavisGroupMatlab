%% BSCCO Gap map
x1 = G.e*1000; x = x1(end:-1:1);

%y1 = G.ave'; y = y1(end:-1:1);
y1 = squeeze(squeeze(G.map(43,12,:)))'; y = y1(end:-1:1);
%% BSCCO Gap map
tic;
[nr nc nz] = size(G.map);
%find the midpoint of spectra (different if there are even or odd number of
%points
if (mod(nz,2) == 0)
    mid_point1 = floor(nz/2);
    mid_point2 = mid_point1 + 1;
else
    mid_point1 = find(G.e == 0) - 1;
    mid_point2 = mid_point1 + 2;
end

% split spectrum in two to find peaks separately
x1 = G.e(1:mid_point1)*1000;
map1 = G.map(:,:,1:mid_point1);
x2 = G.e(mid_point2:end)*1000;
map2 = G.map(:,:,mid_point2:end);
% rearrange spectrum starting from -ve to +ve energies
if G.e(1) > G.e(end)
    x1 = x1(end:-1:1);
    map1 = map1(:,:,end:-1:1);
    x2 = x2(end:-1:1);
    map2 = map2(:,:,end:-1:1);
end
%nr = 50; nc = 50;
gap_map1 = zeros(nr,nc);
gap_map2 = zeros(nr,nc);

for i = 1:nr
    i
    for j = 1:nc                     
        %find +ve edge
        y1 = squeeze(squeeze(map1(i,j,1:mid_point1)))'; 
        peaks1 = findpeaks(x1,y1,0.004,0,3,4);
        gap_map1(i,j) = min(peaks1(:,2));
        %find -ve edge
        y2 = squeeze(squeeze(map2(i,j,1:end)))';        
        peaks2 = findpeaks(x2,y2,0.004,0,3,4);
        
        if peaks2(end,2) > -10
            if size(peaks2,1) > 1
                gap_map2(i,j) = peaks2(end-1,2);
            else                
                gap_map2(i,j) = 0;
            end
        else
            gap_map2(i,j) = max(peaks2(:,2));
        end
    end
end
% option - set bad points to the mode of map
gap_map1(find(gap_map1 == 0)) = mode(mode(gap_map1));
gap_map2(find(gap_map2 == 0)) = mode(mode(gap_map2));

img_plot2(gap_map1,Cmap.Defect1,'BSCCO Gap Map +ve');
img_plot2(gap_map2,Cmap.Defect1,'BSCCO Gap Map -ve');


toc        
clear map1 map2 i j peaks1 peaks2 nr nc nz x1 x2 y1 y2 mid_point1 mid_point2
%%
x1 = G.e*1000; x = x1(end:-1:1);
n = 10;
%y1 = G.ave'; y = y1(end:-1:1);
y1 = squeeze(squeeze(G.map(r(n),c(n),:)))'; y = y1(end:-1:1);
%%
[nr nc nz] = size(G.map);
gap1_index = zeros(nr,nc);
gap2_index = zeros(nr,nc);
energy = G.e*1000;
for i = 1:nr
    i
    for j = 1:nc
        gap1_index(i,j) = find(gap_map1(i,j) == energy);       
        gap2_index(i,j) = find(gap_map2(i,j) == energy);
    end
end
img_plot2(gap1_index,Cmap.Defect1,'BSCCO Gap Map +ve');
img_plot2(gap2_index,Cmap.Defect1,'BSCCO Gap Map -ve');

clear nr nc nz i j energy 

%% 
m = 50; q = 78;
gg = 9;
x1 = G.e*1000;
y1 = squeeze(squeeze(G.map(m,q,:))); y1 = y1';
x_pos = x1(9:gap1_index(m,q)-gg); y_pos = y1(9:gap1_index(m,q)-gg);
spc = mean(abs(diff(x_pos)));
figure; plot(x_pos,y_pos,'x');
[p_pos,S_pos] = polyfit(x_pos,y_pos,4);
x_refine = x_pos(1):spc/7:x_pos(end);
f_pos = polyval(p_pos,x_refine,S_pos);
hold on; plot(x_refine,f_pos,'r.');
[df_pos dx_pos] = num_der2b(2,f_pos,x_refine);
x = dx_pos(end:-1:1); y = df_pos(end:-1:1); 
yinv = max(y) -  y;
pos = findpeaks(x,yinv,0.00001,min(yinv),2,3) %pos = pos(end,2);  
figure; plot(x,y);

%x = x_pos(end:-1:1); y = f_pos(end:-1:1); y = max(y) - y;
%pos = findpeaks(x,y,0.001,0,1,3);
%%
m = 109; q= 104;
res = 10;
frac = 0.5;

x = G.e*1000; 
y = squeeze(squeeze(G.map(m,q,:))); 
l_y = length(y(1:gap1_index(m,q)));
peak_val = y(gap1_index(m,q));
min_val = min(y(1:gap1_index(m,q)));
min_val_ind = find(y(1:gap1_index(m,q))==min_val,1,'last');
frac_val = (peak_val - min_val)*frac + min_val;%(1-frac)*peak_val + min_val;

% find set indices which satisfy being larger that frac_val and
% on the right side of the minimum
frac_peak_ind = find( (y>=frac_val)'.*(x>=x(min_val_ind)) == 1,1);
%frac_peak_ind = (find(y(1:gap1_index(m,q)) >= frac_val,1));
kstart = 1; kend = l_y - frac_peak_ind + 1 ;
count = 0;
while(count < 12)
    
x1 = x(kstart:gap1_index(m,q)-kend); y1 = y(kstart:gap1_index(m,q)-kend); y1 = y1';    

    spc = mean(abs(diff(x1)));
    [p S] = polyfit(x1,y1,4);
    x_refine = x1(1):spc/res:x1(end);
    f = polyval(p,x_refine,S);
    %figure; plot(x1,y1,'x'); hold on;
    %plot(x_refine,f,'r.');
    [df2 dx2] = num_der2b(2,f,x_refine);
    %figure; plot(dx2,df2)
    inflect_index = find_zero_crossing(df2);
    if length(inflect_index) > 1    
        if count <=6
            kstart = round(inflect_index(1)/res) + 1;
            count = count +1;
        else
            display('here');
            kstart = round(inflect_index(1)/res) + 1;
            if kend < gap1_index(m,q)
                kend = kend - 1;
                count = 0;
            else 
                return;
            end
        end
    else
        break;
    end
end

if length(inflect_index) > 1           
    inflect_index = inflect_index(end);
end
% if isempty(inflect_index)
%    0
% else
%    x_refine(inflect_index);
% end
% end

% 
% if length(inflect_index) > 1
%     count
%     inflect_index = inflect_index(end);
% end
x_inflect = x_refine(inflect_index)
omega = gap_map(m,q) - x_inflect
figure; plot(x1,y1,'bx'); hold on; 
plot(x_refine,f,'r'); hold on; plot([x_inflect x_inflect],ylim)

%% Find E1* values - inflection points near the humps beyond coherence peaks
[nr nc nz] = size(G.map);
%nr = 100; nc = 100;
E_neg = zeros(nr,nc);
E_pos = zeros(nr,nc);
x1 = G.e*1000;

for i = 1:nr
    i
    for j = 1:nc
        y1 = squeeze(squeeze(G.map(i,j,:))); y1 = y1';
        x_pos = x1(1:gap1_index(i,j)-4); y_pos = y1(1:gap1_index(i,j)-4);        
        if length(y_pos) <= 3
            pos = 0;
        else
            [p_pos,S_pos] = polyfit(x_pos,y_pos,4);
            f_pos = polyval(p_pos,x_pos,S_pos);
            [df_pos dx_pos] = num_der2b(1,f_pos,x_pos);
            x = dx_pos(end:-1:1); y = df_pos(end:-1:1); 
            pos = findpeaks(x,y,0.001,min(y),2,3); pos = pos(end,2);            
        end
        E_pos(i,j) = pos;
    end
end

img_plot2(E_pos,Cmap.Defect1,'E* Positive iter1');
%% E1* second interation to get rid of high valued outliers 
E_pos2 = E_pos;
mean_E_pos = mean(mean(E_pos2));
std_E_pos = std(reshape(E_pos2,length(E_pos2)*length(E_pos2),1));
[r c] = find(E_pos2 >= 90);%(mean_E_pos + 2*std_E_pos) );

for i = 1:length(r)
    i    
    y1 = squeeze(squeeze(G.map(r(i),c(i),:))); y1 = y1';
    x_pos = x1(3:gap1_index(r(i),c(i))-4); y_pos = y1(3:gap1_index(r(i),c(i))-4);        
    if length(y_pos) <= 3
        pos = 0;
    else
        [p_pos,S_pos] = polyfit(x_pos,y_pos,4);
        f_pos = polyval(p_pos,x_pos,S_pos);
        [df_pos dx_pos] = num_der2b(1,f_pos,x_pos);
        x = dx_pos(end:-1:1); y = df_pos(end:-1:1); 
        pos = findpeaks(x,y,0.001,min(y),2,3); pos = pos(1,2);            
    end
    E_pos2(r(i),c(i)) = pos;

end
img_plot2(E_pos2,Cmap.Defect1,'E* Positive iter 2');

%%
mean_E_pos = mean(mean(E_pos2))
std_E_pos = std(reshape(E_pos2,length(E_pos2)*length(E_pos2),1))
[r c] = find(E_pos >= 93);%(mean_E_pos + 2*std_E_pos) );
%% E1* testing
n=1;
r = 228; c = 90;
y1 = squeeze(squeeze(G.map(r(n),c(n),:))); y1 = y1';
x_pos = x1(3:gap1_index(r(n),c(n))-4); y_pos = y1(3:gap1_index(r(n),c(n))-4);  

[p_pos,S_pos] = polyfit(x_pos,y_pos,3);
f_pos = polyval(p_pos,x_pos,S_pos);
[df_pos dx_pos] = num_der2b(1,f_pos,x_pos);
x = dx_pos(end:-1:1); y = df_pos(end:-1:1); 
pos = findpeaks(x,y,0.001,min(y),2,3); pos = pos(1,2);
figure; plot(x_pos,y_pos,'x'); hold on; plot(x_pos,f_pos,'r');
hold on; plot([pos pos], ylim,'g');
figure; plot(dx_pos,df_pos,'b'); hold on; hold on; plot([pos pos], ylim,'g');
%% Find E2* values - inflection points near the humps beyond coherence peaks
[nr nc nz] = size(G.map);
%nr = 100; nc = 100;
E_neg = zeros(nr,nc);
x1 = G.e*1000;

for i = 1:nr
    i
    for j = 1:nc
        y1 = squeeze(squeeze(G.map(i,j,:))); y1 = y1';
        x_neg = x1(gap2_index(i,j)+4:end); y_neg = y1(gap2_index(i,j)+4:end);        
        if length(y_neg) <= 3
            pos = 0;
        else
            [p_neg,S_neg] = polyfit(x_neg,y_neg,4);
            f_neg = polyval(p_neg,x_neg,S_neg);
            [df_neg dx_neg] = num_der2b(1,f_neg,x_neg);
            x = dx_neg(end:-1:1); y = df_neg(end:-1:1); 
            neg = findpeaks(x,y,0.001,min(y),2,3); neg = neg(1,2);            
        end
        E_neg(i,j) = neg;
    end
end

img_plot2(E_neg,Cmap.Defect1,'E* Negative iter1');
%% E2* second interation to get rid of high valued outliers 
E_neg2 = E_neg;
mean_E_neg = mean(mean(E_neg2));
std_E_neg = std(reshape(E_neg2,length(E_neg2)*length(E_neg2),1));
[r c] = find(E_neg2 <= -80);%(mean_E_pos + 2*std_E_pos) );

for i = 1:length(r)
    i    
    y1 = squeeze(squeeze(G.map(r(i),c(i),:))); y1 = y1';
    x_neg = x1(gap1_index(r(i),c(i))+4:end-3); y_neg = y1(gap1_index(r(i),c(i))+4:end-3);        
    if length(y_neg) <= 3
        pos = 0;
    else
        [p_neg,S_neg] = polyfit(x_neg,y_neg,4);
        f_neg = polyval(p_neg,x_neg,S_neg);
        [df_neg dx_neg] = num_der2b(1,f_neg,x_neg);
        x = dx_neg(end:-1:1); y = df_neg(end:-1:1); 
        neg = findpeaks(x,y,0.001,min(y),2,3); neg = neg(1,2);            
    end
    E_neg2(r(i),c(i)) = neg;

end
img_plot2(E_neg2,Cmap.Defect1,'E* Negative iter 2');
%%
Omega1 = abs(E_pos2 - gap_map1);
Omega2 = abs(gap_map2 - E_neg2);
img_plot2(Omega1,Cmap.Defect1,'Omega1');
img_plot2(Omega2,Cmap.Defect1,'Omega2');

%%
gap_ind = zeros(200,200);
for i = 1:200
    for j = 1:200
        gap_ind(i,j) = find_gap_ind(gap_map_neg(i,j),G.e*1000);
    end
end

%%
%function omap = BSCCO_omega_map(data,gap_map, degree_poly,frac_peak,res)
degree_poly = 4; frac_peak = 0.7; res = 100;
[nr nc nz] = size(data.map);
energy = data.e*1000;

% first find gap index
gap_index = zeros(nr,nc);
for i = 1:nr
    for j = 1:nc
        gap_index(i,j) = find_gap_ind(gap_map(i,j),energy);
    end
end
%load_color


%img_plot2(gap_index,Cmap.Defect1,'Gap Index');
infl_map = zeros(nr,nc);
omap = zeros(nr,nc);
h = waitbar(0,'Please wait...','Name','Omega Map Progress');
for i=1:nr
    for j=1:nc
       
        if gap_index(i,j) ~= 0
            x = data.e(1:gap_index(i,j))*1000; 
            y = squeeze(squeeze(data.map(i,j,1:gap_index(i,j)))); 

            l_y = length(y);
            peak_val = y(end);
            min_val = min(y);
            min_val_ind = find(y==min_val,1,'last');
            frac_val = (peak_val - min_val)*frac_peak + min_val;
            % find set indices which satisfy being larger that frac_val and
            % on the right side of the minimum
            frac_peak_ind = find( (y>=frac_val)'.*(x>=x(min_val_ind)) == 1,1);
            %frac_peak_ind = (find(y >= frac_val,1));
            kstart = 1; kend = l_y - frac_peak_ind + 1 ;
            count = 0;

            while(count < 12)                      
                x1 = x(kstart:end-kend); 
                y1 = y(kstart:end-kend); y1 = y1';    
                %figure; plot(x1,y1)
                [p S] = polyfit(x1,y1,degree_poly);
                % generate fine spacing fit
                spc = mean(abs(diff(x1)));            
                x_refine = x1(1):spc/res:x1(end);
                f = polyval(p,x_refine,S);
               % hold on; plot(x_refine,f)
                % calc 2nd derivative from fit to find inflection points
                [df2 dx2] = num_der2b(2,f,x_refine);
                %find the minimum point on the fit
                min_fval_ind = find(f == min(f),1);
                %figure; plot(dx2,df2)
                inflect_index = find_zero_crossing(df2);
                %only select points on the left side of the minimum
                %inflect_index = inflect_index(inflect_index < min_fval_ind);
                % if there is more than one inflection point, truncate the
                % spectrum to get rid of the ones further one in energy
                if length(inflect_index) > 1    
                    if count <=6
                        kstart = round(inflect_index(1)/res) + 1;
                        count = count +1;
                    % if after a few tries, a single inflection point is not
                    % found, add points to the spectrum close to the coherence
                    % peak before fitting
                    else
                        %display('here');
                        kstart = round(inflect_index(1)/res) + 1;
                        % can only go out to coherence peak
                        if kend < (l_y - gap_index(i,j))
                            kend = kend - 1;
                            count = 0;
                        else 
                            break;
                        end
                    end
                else
                    break;
                end
            end
            % if no fit generates only one inflection point, then just pick the
            % one closest to the coherence peak
            if length(inflect_index) > 1           
                inflect_index = inflect_index(end);
            end
            if isempty(inflect_index)
                infl_map(i,j) = 0;
            else
                infl_map(i,j) = x_refine(inflect_index);
            end
        end
    end
    waitbar(i / nr,h,[num2str(i/nr*100) '%']); 
end
close(h);
omap = gap_map - infl_map;
omap(infl_map == 0) = 0;
img_plot2(omap,Cmap.Defect1);
%%
degree_poly = 4; frac_peak = 0.6; res = 10;
[r c] =find(omap > 0 & omap < 30);
%for i=1:length(r)
i =50;
    x = data.e(1:gap_index(r(i),c(i)))*1000; 
    y = squeeze(squeeze(data.map(r(i),c(i),1:gap_index(r(i),c(i)))));  
    figure; plot(y)
%end
l_y = length(y);
            peak_val = y(end)
            min_val = min(y)
            min_val_ind = find(y==min_val,1,'last')
            frac_val = (peak_val - min_val)*frac_peak + min_val
            % find set indices which satisfy being larger that frac_val and
            % on the right side of the minimum
            frac_peak_ind = find( (y>=frac_val)'.*(x>=x(min_val_ind)) == 1,1)
            %frac_peak_ind = (find(y >= frac_val,1));
            kstart = 1
            kend = l_y - frac_peak_ind + 1
            count = 0;

            while(count < 12)      
                count
                x1 = x(kstart:end-kend); 
                y1 = y(kstart:end-kend); y1 = y1';    
                %figure; plot(x1,y1)
                [p S] = polyfit(x1,y1,degree_poly);
                % generate fine spacing fit
                spc = mean(abs(diff(x1)));            
                x_refine = x1(1):spc/res:x1(end);
                f = polyval(p,x_refine,S);
               % hold on; plot(x_refine,f)
                % calc 2nd derivative from fit to find inflection points
                [df2 dx2] = num_der2b(2,f,x_refine);
                %find the minimum point on the fit
                min_fval_ind = find(f == min(f),1);
                %figure; plot(dx2,df2)
                inflect_index = find_zero_crossing(df2)
                %only select points on the left side of the minimum
                %inflect_index = inflect_index(inflect_index < min_fval_ind);
                % if there is more than one inflection point, truncate the
                % spectrum to get rid of the ones further one in energy
                if length(inflect_index) > 1    
                    if count <=6
                        kstart = round(inflect_index(1)/res) + 1;
                        count = count +1;
                    % if after a few tries, a single inflection point is not
                    % found, add points to the spectrum close to the coherence
                    % peak before fitting
                    else
                        %display('here');
                        kstart = round(inflect_index(1)/res) + 1;
                        % can only go out to coherence peak
                        if kend < (l_y - gap_index(i,j))
                            kend = kend - 1;
                            count = 0;
                        else 
                            break;
                        end
                    end
                else
                    break;
                end
            end
            % if no fit generates only one inflection point, then just pick the
            % one closest to the coherence peak
            if length(inflect_index) > 1           
                inflect_index = inflect_index(end);
            end
            figure; plot(x_refine,f,'.'); hold on;
            plot([x_refine(inflect_index) x_refine(inflect_index)], ylim)
%             if isempty(inflect_index)
%                 infl_map(i,j) = 0;
%             else
%                 infl_map(i,j) = x_refine(inflect_index);
%             end
      
