






[counts, centers] = hist(sfunc, 50);

figure, hist(sfunc, 50)

figure, plot(centers, counts)


%% F= x(1)*exp(-((xdata-x(2)).^2/(2*x(3)^2))) + x(4)*exp(-((xdata-x(5)).^2/(2*x(6)^2)));    

x0 = [mean(counts); -0.4; 1; mean(counts); 0.3; 1];

%% Defining upper "ub" and lower bounds "lb"

lb=[0; min(centers-0.4); 0; 0; max(centers+0.3); 0]; 
ub=[inf; max(centers-0.4); inf; inf; min(centers+0.3); inf]; 
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

figure, plot(centers, counts, centers, finalfit)