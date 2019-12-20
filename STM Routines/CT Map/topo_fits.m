y = T.map(1:78,234);
y = boxcar_avg(y,2);
x = 1:length(y);
figure; plot(x,y,'bx');
%% fit topo lines to sine + background
fit_func ='a*sin(b*x + c) + d*x^4 + e*x + f';
% (a b c d e f g h)
    s = fitoptions('Method','NonlinearLeastSquares',...
        'Startpoint',[0.02 0.5 -2 0.00 -0.00 0.04],...
        'Algorithm','Levenberg-Marquardt',...
        'TolX',1e-6,...
        'MaxIter',5000,...
        'MaxFunEvals', 5000);

f = fittype(fit_func,'options',s);
[p,g] = fit(x',y,f);
%%
%figure; plot(100*(feval(p,x)-(p.d*(x').^2 + p.g*x')));
%hold on; plot(mod(p.b*x + p.c,2*pi),'r');
%hold on; plot(2*sin(p.b*x + p.c) + 4,'g');
figure; plot(p); hold on; plot(x,y,'rx');
%%
fit_func ='a*sin(b*x + c) + d*x^4 + e*x + f';
% (a b c d e f g h)
    s = fitoptions('Method','NonlinearLeastSquares',...
        'Startpoint',[0.02 0.6 -2 0.00 -0.00 0.04],...                
        'Algorithm','Levenberg-Marquardt',...
        'TolX',1e-6,...
        'MaxIter',5000,...
        'MaxFunEvals', 5000);

f = fittype(fit_func,'options',s);
%%

%A = zeros(78,256);
B = zeros(78,256);
%C = zeros(78,256);
D = zeros(78,256);
for i = 1:256
    i
    y = T.map(1:78,i);
    y = boxcar_avg(y,2);
    x = 1:length(y);
    [p,g] = fit(x',y,f);
    %A(:,i) = feval(p,x) - p.d*(x').^2 + p.g*x';
    B(:,i) = sin(p.b*x + p.c);
    %C(:,i) = feval(p,x);
    D(:,i) = p.b*x + p.c;
end

%figure; plot(p); hold on; plot(x,y,'rx');

%%
figure; plot(100*(feval(p,x)-(p.d*(x').^2 + p.g*x')));
hold on; plot(mod(p.b*x + p.c,2*pi),'r');
hold on; plot(2*sin(p.b*x + p.c) + 4,'g');
%%
img_plot2(B);
img_plot2(D);
%% Bin phase data
nbin=7;
%bin_img = mod(SM_fit1.phase,2*pi);
bin_img = asin(SM_fit1.sine);

%bin_img = sin_phi;
[sin_bin bin_val] = bin_map(bin_img,nbin,min(min(bin_img)),max(max(bin_img)));
%%
for i=1:nbin
    tmp = (sin_bin == bin_val(i));
    for j = 1:73
        g = G_crop(:,:,j);
        ctval(i,j) = mean(mean(g(tmp)));
    end
    %ctval = G_crop(tmp);  
    %gmap_ctmap(i,1) = mean(ctval);
    %gmap_ctmap(i,2) = std(ctval);
    %errorbar(binval(i),gmap_ctmap(i,1),gmap_ctmap(i,2),'.');
    %hold on
    %clear tmp;
end
%% plot binned CT spectra
cmap = jet(nbin);
figure; hold on;
for i = 1:nbin
    plot(energy,ctval(i,:),'Color',cmap(i,:));
    hold on;
end
%% plot CT spectra after substraction from first bin spectra
cmap = jet(nbin);
figure; hold on;
for i = 1:nbin
    plot(energy,(ctval(7,:) - squeeze(ctval(i,:))),'Color',cmap(i,:));
    hold on;
end
%% CT map based on simple threshold
energy_crop = energy(55:end);
for i = 1:78
    i
    for j = 1:256
        g = squeeze(squeeze(G_crop(i,j,55:end)));
%        figure; plot(energy(55:end),g)        
        LB_test3(i,j) = mean(energy_crop(find(g < 1.7 & g > 1.3)))  ;      
    end
end
%% waterfall plot
figure; 
cmap = autumn(78);
for i = 1:78
 Gg(i,:) = squeeze(squeeze(G_crop(i,50,:)));
 plot(energy,Gg(i,:)+0.1*i,'Color',cmap(i,:)); hold on;
end
%% CT Map based on 15% threshold
for i = 1:78
    i
    for j = 1:256
        g = squeeze(squeeze(G_crop(i,j,51:end)));
        LB_test(i,j) = min(energy(find(g < 0.15*max(g))));        
    end
end
%% Find radius of curvature
%x = energy;
%y = avg_spect;
clear r;
for i = 50:50+length(energy(50:end))-4
    i
    x = energy(i:3+i);
    y = 0;
%y = avg_spect(i:3+i)';
 A = [x.^2+y.^2,x,y,ones(size(x))]; % Set up least squares problem
 [U,S,V] = svd(A,0); % Use economy version sing. value decompos.
 a = V(1,4); b = V(2,4); % Choose eigenvector from V
 c = V(3,4); d = V(4,4); % with smallest eigenvalue
 xc = -b/(2*a); yc = -c/(2*a); % Find center and radius of the
 r(i) = sqrt(xc^2+yc^2-d/a); % circle, a*(x^2+y^2)+b*x+c*y+d=0
end
figure; plot(r(50:end)');
%%
clear r;
%for i = 50:50+length(energy(50:end))-4
for i = 1:length(energy)-4
    i
    x = energy(i:3+i);
    y = avg_spect(i:3+i)';
%y = avg_spect(i:3+i)';
mx = mean(x); my = mean(y)
 X = x - mx; Y = y - my; % Get differences from means
 dx2 = mean(X.^2); dy2 = mean(Y.^2); % Get variances
 t = [X,Y]\(X.^2-dx2+Y.^2-dy2)/2; % Solve least mean squares problem
 a0 = t(1); b0 = t(2); % t is the 2 x 1 solution array [a0;b0]
 r = sqrt(dx2+dy2+a0^2+b0^2); % Calculate the radius
 a = a0 + mx; b = b0 + my; % Locate the circle's center
 curv(i) = 1/r; % Get the curvature

end
figure; plot(curv(60:end))
%%
cmap = jet(5);
y = num_der2b(1,avg_spect);
x = energy(2:end-1);
figure; plot(x,y);
for i = 1:5
[p S] = polyfit(x(35-i*5:35+i*5),y(35-i*5:35+i*5),1);
f = polyval(p,x);
hold on; plot(x,f,'Color',cmap(i,:));
ss(i) = S.normr;
end
%figure; plot(ss);

%%
x = energy(2:end-1);
y = squeeze(squeeze(G_crop(61,1,:)));
y = num_der2b(1,y);

figure; plot(y);
p1 = polyfit(61:71,y(61:end),1);
f = polyval(p1,61:71);
hold on; plot(61:71,f,'Color','r');
p2 = polyfit(14:55,y(14:55),1);
int = (p2(2) - p1(2))/(p1(1) - p2(1))
hold on; plot([int int], [-.5 0.5],'g')
%%
x = energy(2:end-1);
for i = 1:78
    i
    for j= 1:256
        
        y = squeeze(squeeze(G_crop(i,j,:)));
        y = num_der2b(1,y);
        p1 = polyfit(61:71,y(61:end),1);
        p2 = polyfit((17:55),y(17:55),1);
        int = (p2(2) - p1(2))/(p1(1) - p2(1));
        upper_b(i,j) = int;
    end
end
   img_plot2(upper_b)
colormap(Cmap.Defect1)
caxis([55 68]);
%%
x = energy(2:end-1);
y = squeeze(squeeze(G_crop(1,1,:)));
y = num_der2b(1,y);
figure; plot(x,y)
p =  polyfit(x,y,7);
f = polyval(p,x);
hold on; plot(x,f,'r');

figure; plot(num_der2b(1,f));