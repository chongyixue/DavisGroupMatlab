function count_Se_S_atoms(data,sx,ex,sy,ey, cov)
% data = LF corrected data
% sx, ex, sy, ey = start and end coordinates for cropping the fov
% cov = cutoff value for histogram because of tip changes

% find the locations of the Se/S-atoms using LF-corrected data
data_loc = data;
phase_map = data_loc.phase_map;

pos_matrix = atomic_pos(phase_map,0,0);

nmap = data_loc.map(sy:ey, sx:ex, :);
pmat = pos_matrix(sy:ey, sx:ex, :);


[nx, ny, nz] = size(nmap);

tot_at = sum( sum( pmat) );
cc = 1;

for i=1:nx
    for j=1:ny
        
        if pmat(i,j,:) ==1;
            
            if nmap(i,j, :) <= cov
            
                tot_at_val(cc) = nmap(i,j,:);
                cc = cc+1;
                
            end
        
        end
    end
end

cc = cc-1;

tot_at = cc


nbins = 50;
figure, hist(tot_at_val, nbins);


[counts, centers] = hist(tot_at_val, nbins);


figure, plot(centers, counts)

%% F= x(1)*exp(-((xdata-x(2)).^2/(2*x(3)^2))) + x(4)*exp(-((xdata-x(5)).^2/(2*x(6)^2)));    

x0 = [max(counts); -0.02; abs(centers(2)-centers(1)); max(counts); 0.01; abs(centers(2)-centers(1))];

%% Defining upper "ub" and lower bounds "lb"

lb=[0; min(centers); 0; 0; min(centers); 0]; 
ub=[inf; max(centers); inf; inf; max(centers); inf]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Defining the fit options
options = optimset('Algorithm','trust-region-reflective',...  % according to MATLAB the only one that allows bounds
                   'TolX',1e-6,...
                   'MaxIter',10000,...
                   'MaxFunEvals',10000);

%% Fit the 2 1-dimensional Gaussians
[x,resnorm,residual]=lsqcurvefit(@two_1D_gauss,x0,centers,counts,lb,ub,options);

%% Plot the data and the fit next to each other
finalfit=two_1D_gauss(x,centers);

finalfit1=oneD_gauss([x(1), x(2), x(3)],centers);
finalfit2=oneD_gauss([x(4), x(5), x(6)],centers);

sulfur_cov = x(2)+1*x(3)
selenium_cov = x(5)-1*x(6)

% figure, plot(centers, counts, centers, finalfit, centers, finalfit1, centers, finalfit2)
figure, hist(tot_at_val, nbins);
hold on
plot(centers, finalfit,'y', centers, finalfit1,'r', centers, finalfit2,'c')
line([x(2)+1*x(3), x(2)+1*x(3)], [0, max(finalfit1)],'Color','r');
line([x(5)-1*x(6), x(5)-1*x(6)], [0, max(finalfit2)],'Color','c');
hold off

Q1 = trapz(centers, finalfit1)
Q2 = trapz(centers, finalfit2)
Q3 = trapz(centers, finalfit)


figure, imagesc(nmap);
axis image

figure, imagesc(pmat);
axis image

hold on
for i=1:nx
    for j=1:ny
        if pmat(i,j,:) ==1;
            
            if nmap(i,j, :) <= sulfur_cov
            
                plot(j, i,'Marker', 'o', 'MarkerSize', 1,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 3);
                
            elseif nmap(i,j, :) >= selenium_cov
                
                plot(j, i,'Marker', 'o', 'MarkerSize', 1,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
                
            end
        
        end
    end
end

end