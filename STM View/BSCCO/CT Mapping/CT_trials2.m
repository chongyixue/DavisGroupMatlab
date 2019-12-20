%%
y0 = squeeze(squeeze(G_crop(50,200,50:end)));
y0_1 = num_der2(1,y0);
%%
fit_func ='a*exp(b*x)';
init_g = [-0.00043 0.001]; 
    s = fitoptions('Method','NonlinearLeastSquares',...
        'Startpoint',init_g,...
        'Lower', [-1, -1], ...
        'Upper',[1,1],...        
        'TolX',1e-6,...
        'MaxIter',10000,...
        'MaxFunEvals', 10000);

f = fittype(fit_func,'options',s);
P.a = zeros(78, 256); P.b = zeros(78, 256);
%%
for i = 1:78
    i
    yy = squeeze(G_crop(i,:,:));
    parfor j = 1:256      
       
        y_val = squeeze(yy(j,:));
        %y_pos = squeeze(squeeze(G_crop(i,j,1:30)));
        %y_neg = squeeze(squeeze(G_crop(i,j,50:end)));
        %y1_pos = num_der2(1,y_val);        
        y1_neg = num_der2(1,y_val);        
        %p = fit(x1_pos',y1_pos',f);
        %p = fit(x1',y1_pos',f);
        p = fit(x2',y1_neg',f);
        %figure; plot(x1_pos,y1_pos,'x'); hold on; plot(p);
        %figure; plot(x1_neg,y1_neg,'x'); hold on; plot(p);
        %P.a(i,j) = p.a; P.b(i,j) = p.b; P.c(i,j) = p.c; P.d(i,j) = p.d;        
        a(j) = p.a; b(j) = p.b; %c(j) = p.c; d(j) = p.d;
    end    
    P.a(i,:) = a; P.b(i,:) = b; %P.c(i,:) = c; P.d(i,:) = d;        
end