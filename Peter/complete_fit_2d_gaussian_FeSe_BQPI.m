function [x,resnorm,residual]=complete_fit_2d_gaussian_FeSe_BQPI(data)




zdata=data; % box around vortex

%% Create meshgrid for fit-function
[X,Y]=meshgrid(1:1:max(size(data(:,:,1),2)),1:1:max(size(data(:,:,1),1)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE HOW TO USE MESHGRID - START
% [X,Y] = meshgrid(-2:.2:2, -2:.2:2);                                
% Z = X .* exp(-X.^2 - Y.^2);  
% figure;
% surf(X,Y,Z)
% EXAMPLE - END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xdata(:,:,1)=X;
xdata(:,:,2)=Y;
%% Starting guess for the following fit function
% calculate the center of intensity / mass com coordinates
comx=sum(sum(data.*X))/sum(sum(data));
comy=sum(sum(data.*Y))/sum(sum(data));
x0 = [1; comx; 1; comy; 1; 1];

%%
% x0 = [1; comx; 1; comy; 1; 1; 1; comx; 1; comy];

%%
% x0 = [1; round(max(size(data(:,:,1),2))/2); 1; round(max(size(data(:,:,1),2))/2); 1; 1; 0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Rotate by angle x(7)
% xdatarot(:,:,1)=xdata(:,:,1)*cos(x(7))-xdata(:,:,2)*sin(x(7));
% ydatarot(:,:,1)=xdata(:,:,1)*sin(x(7))+xdata(:,:,2)*cos(x(7));
% x0rot=x(2)*cos(x(7))-x(4)*sin(x(7));
% y0rot=x(2)*sin(x(7))+x(4)*cos(x(7));
% 
% %% Two-dimensional Gaussian
% F= x(1)*exp(-((xdatarot(:,:,1)-x0rot)^2/(2*x(3)^2)+(ydatarot(:,:,1)-y0rot)^2/(2*x(5)^2)))+x(6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Defining upper "ub" and lower bounds "lb"
% lb=[min(min(zdata)); 1; cohlen*0.5; 1; cohlen*0.5; 0; -pi/2]; 
% lb=[min(min(zdata)); 1; 1; 1; 1; 0; -pi/2]; 
lb=[min(min(zdata)); 1; 0; 1; 0; -inf]; 
ub=[max(max(zdata)); max(size(data(:,:,1),1)); max(size(data(:,:,1),1));...
    max(size(data(:,:,1),2)); max(size(data(:,:,1),2)); max(max(zdata))]; 


% lb=[min(min(zdata)); 1; 0; 1; 0; -inf; -inf; 1; -inf; 1]; 
% ub=[max(max(zdata)); max(size(data(:,:,1),1)); max(size(data(:,:,1),1));...
%     max(size(data(:,:,1),2)); max(size(data(:,:,1),2)); max(max(zdata));...
%     max(max(zdata)); max(size(data(:,:,1),1)); max(max(zdata)); max(size(data(:,:,1),2))]; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Defining the fit options
options = optimset('Algorithm','trust-region-reflective',...  % according to MATLAB the only one that allows bounds
                   'TolX',1e-6,...
                   'MaxIter',10000,...
                   'MaxFunEvals',10000);

%% Fit the two-dimensional Gaussian

% xint=lsqcurvefit(@twodgauss,x0,xdata,zdata,lb,ub,options);
[x,resnorm,residual]=lsqcurvefit(@twodgauss_xy_rigid,x0,xdata,zdata,lb,ub,options);

%% Plot the data and the fit next to each other
finalfit=twodgauss_xy_rigid(x,xdata);
% subdata=zdata-finalfit;
% figure;
% imagesc(subdata);
figure;
subplot(1,2,1)
imagesc(zdata)
hold on
plot(comx,comy,'b+','Linewidth',10);
plot(x(2),x(4),'rx','Linewidth',10);

hold off
subplot(1,2,2)
imagesc(finalfit)
hold on
plot(comx,comy,'b+','Linewidth',10);
plot(x(2),x(4),'rx','Linewidth',10);

hold off
a=1;



end


