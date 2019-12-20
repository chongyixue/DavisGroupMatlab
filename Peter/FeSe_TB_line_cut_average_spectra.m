%%

% change_color_of_STM_maps(obj_60222A00_T.map,'no')
% 
% hold on
% 
% rectangle('Position', [1, 1, 10, 10], 'EdgeColor', 'k', 'LineWidth', 3)
% 
% rectangle('Position', [21, 21, 10, 10], 'EdgeColor', 'r', 'LineWidth', 3)
% 
% rectangle('Position', [41, 41, 10, 10], 'EdgeColor', 'b', 'LineWidth', 3)
% 
% rectangle('Position', [61, 61, 10, 10], 'EdgeColor', 'm', 'LineWidth', 3)
% 
% rectangle('Position', [81, 81, 10, 10], 'EdgeColor', 'c', 'LineWidth', 3)
% 
% rectangle('Position', [101, 101, 10, 10], 'EdgeColor', 'g', 'LineWidth', 3)
% 
% hold off

%%
% ev = obj_60222a00_G.e*1000;
% x = ev(45:55)';
% 
% 
% figure, plot(ev, G_22_crop_1_10.ave, 'k', ev, G_22_crop_21_30.ave, 'r',...
%     ev, G_22_crop_41_50.ave, 'b', ev, G_22_crop_61_70.ave, 'm', ...
%     ev, G_22_crop_81_90.ave, 'c', ev, G_22_crop_101_110.ave,'g')
% 
% 
% pl = [1, 2, 3, 4, 5, 6];
% 
% y = G_22_crop_1_10.ave(45:55);
% [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
% 
% plc(1) = p.d;
% 
% figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
% legend('data', 'fit');
% 
% y = G_22_crop_21_30.ave(45:55);
% [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
% 
% plc(2) = p.d;
% 
% figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
% legend('data', 'fit');
%         
% y = G_22_crop_41_50.ave(45:55);
% [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
% 
% plc(3) = p.d;
% 
% figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
% legend('data', 'fit');
% 
% y = G_22_crop_61_70.ave(45:55);
% [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
% 
% plc(4) = p.d;
% 
% figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
% legend('data', 'fit');
% 
% y = G_22_crop_81_90.ave(45:55);
% [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
% 
% plc(5) = p.d;
% 
% figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
% legend('data', 'fit');
% 
% y = G_22_crop_101_110.ave(45:55);
% [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
% 
% plc(6) = p.d;
% 
% figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
% legend('data', 'fit');
% 
% 
% figure, plot(pl(1), plc(1), '+k', pl(2), plc(2), '+r', pl(3), plc(3), '+b',...
%     pl(4), plc(4), '+m', pl(5), plc(5), '+c', pl(6), plc(6), '+g')  


%%

% ll = length(l_cut_60222.r);
% plca = [];
% 
% for i=1:ll
%     y = squeeze(l_cut_60222.cut(i,45:55))';
%     [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
% 
%     plca(i) = p.d;
% end
% 
% figure, plot(l_cut_60222.r/10, plca)
%%
% [nx, ny, nz] = size(obj_60222a00_G.map);
% 
% fmap = zeros(nx, ny, 4);
% 
% for i=1:nx
%     for j=1:ny
%         
%         y = squeeze( obj_60222a00_G.map(i,j,45:55) );
%         [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
%         
% %         figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
% %         legend('data', 'fit');
%         % write power of fit into matrix
%         fmap(i,j,1) = p.d;
%         % write offset into matrix
%         fmap(i,j,2) = p.c;
%         % y-offset
%         fmap(i,j,3) = p.a;
%         % amplitude of powerfit
%         fmap(i,j,4) = p.b;
%     end
% end
% 
% 
% obj_60222a00_fit = obj_60222a00_G;
% obj_60222a00_fit.map = fmap;
% obj_60222a00_fit.e = [1,2,3,4];


%%
% [nx, ny, nz] = size(obj_60222a00_G.map);
% ev = obj_60222a00_G.e*1000;
% x = ev(45:55)';
% 
% 
% fmap = zeros(nx, ny, 4);
% mmap = zeros(nx, ny, 1);
% 
% for i=1:nx
%     for j=1:ny
%         
%         y = squeeze( obj_60222a00_G.map(i,j,45:55) );
% %         y = y + abs(min(y));
%         y2 = cat(1, squeeze( obj_60222a00_G.map(i,j,1:6) ), squeeze( obj_60222a00_G.map(i,j,94:100) ));
%         mmap(i,j,1) = mean(y)/ mean(y2);
% %         [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
% %         
% % %         figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
% % %         legend('data', 'fit');
% %         % write power of fit into matrix
% %         fmap(i,j,1) = p.d;
% %         % write offset into matrix
% %         fmap(i,j,2) = p.c;
% %         % y-offset
% %         fmap(i,j,3) = p.a;
% %         % amplitude of powerfit
% %         fmap(i,j,4) = p.b;
%     end
% end
% 
% 
% obj_60222a00_mean = obj_60222a00_G;
% obj_60222a00_mean.map = mmap;
% obj_60222a00_mean.e = 1;
%%
% [nx, ny, nz] = size(obj_60229A00_G.map);
% ev = obj_60229A00_G.e*1000;
% x = ev(46:56)';
% 
% 
% fmap = zeros(nx, ny, 4);
% 
% for i=1:nx
%     for j=1:ny
%         
%         y = squeeze( obj_60229A00_G.map(i,j,46:56) );
%         [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
%         
% %         figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
% %         legend('data', 'fit');
%         % write power of fit into matrix
%         fmap(i,j,1) = p.d;
%         % write offset into matrix
%         fmap(i,j,2) = p.c;
%         % y-offset
%         fmap(i,j,3) = p.a;
%         % amplitude of powerfit
%         fmap(i,j,4) = p.b;
%     end
% end
% 
% 
% obj_60229A00_fit = obj_60229A00_G;
% obj_60229A00_fit.map = fmap;
% obj_60229A00_fit.e = [1,2,3,4];

%%
% [nx, ny, nz] = size(obj_50830A00_G.map);
% ev = obj_50830A00_G.e*1000;
% x = ev(27:35)';
% 
% 
% fmap = zeros(nx, ny, 4);
% mmap = zeros(nx, ny, 1);
% 
% for i=1:nx
%     for j=1:ny
%         
%         y = squeeze( obj_50830A00_G.map(i,j,27:35) );
%         y = y + abs(min(y));
%         y2 = cat(1, squeeze( obj_50830A00_G.map(i,j,1:4) ), squeeze( obj_50830A00_G.map(i,j,58:61) ));
%         mmap(i,j,1) = mean(y)/ mean(y2);
% %         [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
% %         
% % %         figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
% % %         legend('data', 'fit');
% %         % write power of fit into matrix
% %         fmap(i,j,1) = p.d;
% %         % write offset into matrix
% %         fmap(i,j,2) = p.c;
% %         % y-offset
% %         fmap(i,j,3) = p.a;
% %         % amplitude of powerfit
% %         fmap(i,j,4) = p.b;
%     end
% end
% 
% 
% obj_50830A00_mean = obj_50830A00_G;
% obj_50830A00_mean.map = mmap;
% obj_50830A00_mean.e = 1;
%%
% [nx, ny, nz] = size(obj_60609a00_G.map);
% ev = obj_60609a00_G.e*1000;
% x = ev(1:11)';
% 
% 
% fmap = zeros(nx, ny, 4);
% 
% for i=1:nx
%     for j=1:ny
%         
%         y = squeeze( obj_60609a00_G.map(i,j,1:11) );
%         [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
%         
% %         figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
% %         legend('data', 'fit');
%         % write power of fit into matrix
%         fmap(i,j,1) = p.d;
%         % write offset into matrix
%         fmap(i,j,2) = p.c;
%         % y-offset
%         fmap(i,j,3) = p.a;
%         % amplitude of powerfit
%         fmap(i,j,4) = p.b;
%     end
% end
% 
% 
% obj_60609a00_fit = obj_60609a00_G;
% obj_60609a00_fit.map = fmap;
% obj_60609a00_fit.e = [1,2,3,4];


%%
[nx, ny, nz] = size(obj_60726A00_G.map);
ev = obj_60726A00_G.e*1000;
x = ev(57:70)';


fmap = zeros(nx, ny, 4);

for i=1:nx
    for j=1:ny
        
        y = squeeze( obj_60726A00_G.map(i,j,57:70) );
        [y_new, p,gof]=abs_exp(y,x,[0, 1, 0, 2],[-inf, -inf, -0.5,0],[inf, inf, 0.5, inf]);
        
%         figure, plot(x,y,'ko',x,y_new,'r+','LineWidth',2);
%         legend('data', 'fit');
        % write power of fit into matrix
        fmap(i,j,1) = p.d;
        % write offset into matrix
        fmap(i,j,2) = p.c;
        % y-offset
        fmap(i,j,3) = p.a;
        % amplitude of powerfit
        fmap(i,j,4) = p.b;
    end
end


obj_60726A00_fit = obj_60726A00_G;
obj_60726A00_fit.map = fmap;
obj_60726A00_fit.e = [1,2,3,4];