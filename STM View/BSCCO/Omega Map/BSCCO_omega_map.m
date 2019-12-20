function omap = BSCCO_omega_map(data,gap_map, degree_poly,frac_peak,res)
%degree_poly = 4; frac_peak = 0.7; res = 100;
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
omap = abs(infl_map - gap_map);
omap(infl_map == 0) = 0;
load_color
img_plot2(omap,Cmap.Defect4);