function [edmap,mgmapnofit,mgmapfit,vfermimap,rmsemap,gofcell]=DiracMassGapFit2016(llmap)


[nx, ny, nz] =size(llmap);


llm3 = mean(mean(llmap(:,:,1)));
llm2 = mean(mean(llmap(:,:,2)));
llm1 = mean(mean(llmap(:,:,3)));
llp1 = mean(mean(llmap(:,:,5)));
llp2 = mean(mean(llmap(:,:,6)));
llp3 = mean(mean(llmap(:,:,7)));



ed = mean ([llm3, llm2, llm1, llp1, llp2, llp3] );
            
ed1 = mean ([llm1, llp1] )
            
ed2 = mean ([llm2, llp2] )
            
ed3 = mean ([llm3, llp3] )


mgnofit = mean(mean(llmap(:,:,4))) - ed
ednofit = ed1
        
y = [squeeze(((mean(mean(llmap(:,:,1:10)))-ed)*10^-3).^2)];
range = [-3, -2, -1,0,1,2,3,4,5, 6]';
% y = [squeeze(((mean(mean(llmap(:,:,2:9)))-ed1)*10^-3).^2)];
% range = [-2, -1,0,1,2,3,4,5]';
% y = [squeeze(((mean(mean(llmap(:,:,2:8)))-ed1)*10^-3).^2)];
% range = [-2, -1,0,1,2,3,4]';
% y = [squeeze(((mean(mean(llmap(:,:,3:8)))-ed1)*10^-3).^2)];
% range = [-1,0,1,2,3,4]';
% y = [squeeze(((mean(mean(llmap(:,:,1:10)))-ed1)*10^-3).^2)];
% range = [-3, -2, -1,0,1,2,3,4,5, 6]';
% y = [squeeze(((mean(mean(llmap(:,:,1:3)))-ed1)*10^-3).^2);...
%     squeeze(((mean(mean(llmap(:,:,5:10)))-ed1)*10^-3).^2)];
% range = [-3, -2, -1,1,2,3,4,5, 6]';

% y = [squeeze(((mean(mean(llmap(:,:,2:9)))-ed1)*10^-3).^2)];
% range = [ -2, -1,0,1,2,3,4,5]';
% y = [squeeze(((mean(mean(llmap(:,:,5:10)))-ed1)*10^-3).^2)];
% range = [1,2,3,4,5, 6]';

guess = [((mean(mean(llmap(:,:,6)))-mean(mean(llmap(:,:,7))))*10^-3)^2,(mgnofit*10^-3)^2];
% guess = [((mean(mean(llmap(:,:,6)))-mean(mean(llmap(:,:,7))))*10^-3)^2,(0.1*10^-3)^2];
low = [0,0];
upp = [((mean(mean(llmap(:,:,6)))-mean(mean(llmap(:,:,7))))*10^-3)^2*10,(mgnofit*10^-3)^2*10];
[y_new, p,gof]=DiracLandauLevelLine(y,range,guess,low,upp);
mgfit = p.b.^0.5*1000
dummy = confint(p);

%mgfit = p.b*1000
vfermi = (p.a/(2*6.58211928*10^-16*8.5))^0.5

cvf = p.a;

figure, plot(range,y*1000,'ko',range,y_new*1000,'r+','LineWidth',2);
legend('data', 'fit');
ylabel('(E_n - E_D)^2 [10^{-3} eV^2]', 'Fontsize', 20);
xlabel('n', 'Fontsize', 20);
ax2 = gca;
axis([-3 6 0 12]);
ax2.XTick = linspace(-3,6,10);
ax2.YTick = linspace(0,0.012,4)*1000;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

% ax2 = gca;
% axis([-2 5 0 12]);
% ax2.XTick = linspace(-2,5,8);
% ax2.YTick = linspace(0,0.012,4)*1000;
% ax2.FontSize = 20;
% ax2.TickLength = [0.02 0.02];
% ax2.LineWidth = 2;
% box on
% 
% ax2 = gca;
% axis([-2 4 0 12]);
% ax2.XTick = linspace(-2,4,7);
% ax2.YTick = linspace(0,0.012,4)*1000;
% ax2.FontSize = 20;
% ax2.TickLength = [0.02 0.02];
% ax2.LineWidth = 2;
% box on

% ax2 = gca;
% axis([-1 4 0 8]);
% ax2.XTick = linspace(-1,4,6);
% ax2.YTick = linspace(0,0.008,5)*1000;
% ax2.FontSize = 20;
% ax2.TickLength = [0.02 0.02];
% ax2.LineWidth = 2;
% box on
test=1;
%%
mgmapnofit = zeros(nx,ny,1);
mgmapfit = zeros(nx,ny,1);
edmap = zeros(nx,ny,4);
vfermimap = zeros(nx,ny,1);
rmsemap = zeros(nx,ny,1);

for i=1:nx
        for j=1:ny
            
%             rn = floor(nx*(random('unif', 0, 1, 1, 2)))+1;
%             i = rn(1);
%             j = rn(2);
            
            llm3 = mean(mean(llmap(i,j,1)));
            llm2 = mean(mean(llmap(i,j,2)));
            llm1 = mean(mean(llmap(i,j,3)));
            llp1 = mean(mean(llmap(i,j,5)));
            llp2 = mean(mean(llmap(i,j,6)));
            llp3 = mean(mean(llmap(i,j,7)));

            ed = mean ([llm3, llm2, llm1, llp1, llp2, llp3] );
            
            ed1 = mean ([llm1, llp1] );
            
            ed2 = mean ([llm2, llp2] );
            
            ed3 = mean ([llm3, llp3] );


            mgmapnofit(i,j,1) = llmap(i,j,4) - ed;
            edmap(i,j,1) = ed;
            edmap(i,j,2) = ed1;
            edmap(i,j,3) = ed2;
            edmap(i,j,4) = ed3;
            
            y = squeeze(((llmap(i,j,1:10)-ed)*10^-3).^2);
            range = [-3, -2, -1, 0,1,2,3,4,5,6]';
%             y = squeeze(((llmap(i,j,2:9)-ed1)*10^-3).^2);
%             range = [-2, -1, 0,1,2,3,4,5]';
%               y = squeeze(((llmap(i,j,2:8)-ed1)*10^-3).^2);
%              range = [-2, -1, 0,1,2,3,4]';
%                y = squeeze(((llmap(i,j,3:8)-ed1)*10^-3).^2);
%              range = [-1, 0,1,2,3,4]';
%             y = [squeeze(((llmap(i,j,1:3)-ed1)*10^-3).^2);...
%                 squeeze(((llmap(i,j,5:10)-ed1)*10^-3).^2)];
%             range = [-3, -2, -1,1,2,3,4,5,6]';

%             y = squeeze(((llmap(i,j,2:9)-ed1)*10^-3).^2);
%             range = [-2, -1, 0,1,2,3,4,5]';
%             y = squeeze(((llmap(i,j,5:10)-ed1)*10^-3).^2);
%             range = [1,2,3,4,5, 6]';
            
            guess = [((llmap(i,j,6)-llmap(i,j,7))*10^-3)^2,(mgmapnofit(i,j,1)*10^-3)^2];
%             guess = [((llmap(i,j,6)-llmap(i,j,7))*10^-3)^2,(0.1*10^-3)^2];
%             low = [-inf,0];
            low = [0,0];
            
            upp = [((llmap(i,j,6)-llmap(i,j,7))*10^-3)^2*10,(mgmapnofit(i,j,1)*10^-3)^2*10];
            [y_new, p,gof]=DiracLandauLevelLine(y,range,guess,low,upp);
%             figure, plot(range,y,'ko',range,y_new,'r+','LineWidth',2);
%             if p.b > 0
                mgmapfit(i,j,1) = p.b.^0.5*1000;
%             else
%                 mgmapfit(i,j,2) = abs(p.b)*1000;
%             end
            rmsemap(i,j,1) = gof.rmse;
            gofcell{i,j,1} = gof;
            vfermimap(i,j,1) = (p.a/(2*6.58211928*10^-16*8.5))^0.5;
%             figure, plot(range,y,'ko',range,y_new,'r+','LineWidth',2);
            test=1;
            
%              range = [-1, 0,1,2,3,4]';
%              y = squeeze(((llmap(i,j,3:8)-ed1)*10^-3).^2)-cvf*abs(range);
%             guess = [(mgmapnofit(i,j,1)*10^-3)^2];
%             low = [0];
%             upp = [100];
%             [y_new, p,gof]=DiracLandauLevelLine_cvf(y,range,guess,low,upp);
%             figure, plot(range,y*1000,'ko',range,y_new*1000,'r+','LineWidth',2);
%             test = 1;
        end
end

% figure, img_plot4(edmap)
% figure, img_plot4(mgmapnofit)
% figure, img_plot4(mgmapfit)
% figure, img_plot4(vfermimap)

end