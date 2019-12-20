%% CT fitting Scheme #1 - 1st  Derivate fitting 
c = 100; r = 50;
x0_neg = energy(50:end);
x0_pos = energy(1:30);
y_neg = squeeze(squeeze(G_crop(r,c,50:end)));
y_pos = squeeze(squeeze(G_crop(r,c,1:30)));

x1_pos =x0_pos; % x0_pos(2:end-1);
x1_neg = x0_neg;%x0_neg(2:end-1);
y1_pos = num_der2(1,y_pos);
y1_neg = num_der2(1,y_neg);

%% fit function
fit_func ='a*exp(b*x)';
% (a b c d)
%init_g = [0 0.001 -5 -0.012];
init_g = [-0 0.05 -0.0 0.5];
%init_g = [10 -0.001 1 -1]; %param for 1st derivative fit - ve side
    s = fitoptions('Method','NonlinearLeastSquares',...
        'Startpoint',init_g,...
        'Algorithm','Levenberg-Marquardt',...
        'TolX',1e-6,...
        'MaxIter',10000,...
        'MaxFunEvals', 10000);

f = fittype(fit_func,'options',s);
%%
tic; [p,g] = fit(x1_pos'-2000,y1_pos',f); toc;
%figure; plot(p); hold on; plot(x1_neg,y1_neg,'x');
figure; plot(p); hold on; plot(x1_pos-2000,y1_pos,'x');
p
%%
fp = feval(p,x1_pos);
max_val = max(fp);
x1_pos(max(fp < max_val/exp(1)))
%%
P.a = zeros(78, 256); P.b = zeros(78, 256); P.c = zeros(78, 256); P.d = zeros(78, 256);
clear y1_neg;
for i = 1:78
    i
    yy = squeeze(G_crop(i,:,50:end));
    parfor j =1:256      
        y_val = squeeze(yy(j,:));
        %y_pos = squeeze(squeeze(G_crop(i,j,1:30)));
        %y_neg = squeeze(squeeze(G_crop(i,j,50:end)));
        %y1_pos = num_der2(1,y_pos);
        x = num_der2(1,y_val);        
        y1_neg = num_der2(1,y_val);        
        %p = fit(x1_pos',y1_pos',f);
        %p = fit(x1_neg',y1_neg',f);
        %figure; plot(x1_pos,y1_pos,'x'); hold on; plot(p);
        %figure; plot(x1_neg,y1_neg,'x'); hold on; plot(p);
        %P.a(i,j) = p.a; P.b(i,j) = p.b; P.c(i,j) = p.c; P.d(i,j) = p.d;        
    end    
end

%%
p_pos =  polyfit(x1_pos,y1_pos,3);
f_pos = polyval(p_pos,x1_pos);
p_neg =  polyfit(x1_neg,y1_neg,3);
f_neg = polyval(p_neg,x1_neg);

figure; plot(x1_pos,y1_pos); hold on; plot(x1_pos,f_pos,'r');
figure; plot(x1_neg,y1_neg); hold on; plot(x1_neg,f_neg,'r');

%hold on; plot(x,f,'r');
%x = energy(3:end-2);
%figure; plot(x,num_der2b(1,f));
%%