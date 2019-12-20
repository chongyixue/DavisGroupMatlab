function [edmap,mgmapnofit,mgmapfit,vfermimap,rmsemap,gofcell]=DiracMassGapFit(llmap)


[nx, ny, nz] =size(llmap);

llmapnew = llmap;


for k=1 : nz
    gapvec = reshape(llmap(:,:,k),nx*ny,1);
    meangap = mean(gapvec);
    stdgap = std(gapvec);

    for i=1:nx
        for j=1:ny
            if llmap(i,j,k) == 0 || llmap(i,j,k) < meangap - 4*stdgap || llmap(i,j,k) > meangap + 4*stdgap
                
%                 if llmap(i,j,1) == 0
                    if i==1 && j==1
                        test = median([llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i==nx && j==ny
                        test = median([llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i==1 && j > 1 && j < ny
                        test = median([llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k),...
                            llmap(i,j-1,k),llmap(i+1,j-1,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i >1 && i < nx && j==1
                        test = median([llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k),...
                            llmap(i-1,j,k),llmap(i-1,j+1,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i==nx && j > 1 && j < ny
                        test = median([llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k),...
                            llmap(i,j+1,k),llmap(i-1,j+1,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i >1 && i < nx && j==ny
                        test = median([llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k),...
                            llmap(i+1,j-1,k),llmap(i+1,j,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i > 1 && i < nx && j >1 && j < ny
                        test = median([llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k),...
                            llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k),llmap(i+1,j-1,k),llmap(i-1,j+1,k)]);
                        llmapnew(i,j,k) = test;
                    end
                    
                    if llmapnew(i,j,1) < meangap - 4*stdgap
                        llmapnew(i,j,1) = meangap - 3.1*stdgap;
                    end
                    if llmapnew(i,j,1) > meangap - 4*stdgap
                        llmapnew(i,j,1) = meangap + 3.1*stdgap;
                    end
            end
        end
end

llmap(:,:,k) = llmapnew(:,:,k);
    
    
    for i=1:nx
        for j=1:ny
            if llmap(i,j,k) < meangap - 3*stdgap || llmap(i,j,k) > meangap + 3*stdgap
                
%                 if llmap(i,j,k) == 0
                    if i==1 && j==1
                        test = mean([llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i==nx && j==ny
                        test = mean([llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i==1 && j > 1 && j < ny
                        test = mean([llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k),...
                            llmap(i,j-1,k),llmap(i+1,j-1,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i >1 && i < nx && j==1
                        test = mean([llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k),...
                            llmap(i-1,j,k),llmap(i-1,j+1,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i==nx && j > 1 && j < ny
                        test = mean([llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k),...
                            llmap(i,j+1,k),llmap(i-1,j+1,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i >1 && i < nx && j==ny
                        test = mean([llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k),...
                            llmap(i+1,j-1,k),llmap(i+1,j,k)]);
                        llmapnew(i,j,k) = test;
                    elseif i > 1 && i < nx && j >1 && j < ny
                        test = mean([llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k),...
                            llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k),llmap(i+1,j-1,k),llmap(i-1,j+1,k)]);
                        llmapnew(i,j,k) = test;
                    end
                    
                    if llmapnew(i,j,1) < meangap - 3*stdgap
                        llmapnew(i,j,1) = meangap - 3*stdgap;
                    end
                    if llmapnew(i,j,1) > meangap - 3*stdgap
                        llmapnew(i,j,1) = meangap + 3*stdgap;
                    end
                    
                    
%                 else
%                 
%                     if i==1 && j==1
%                         test = mean([llmap(i,j,k),llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k)]);
%                         llmapnew(i,j,k) = test;
%                     elseif i==nx && j==ny
%                         test = mean([llmap(i,j,k),llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k)]);
%                         llmapnew(i,j,k) = test;
%                     elseif i==1 && j > 1 && j < ny
%                         test = mean([llmap(i,j,k),llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k),...
%                             llmap(i,j-1,k),llmap(i+1,j-1,k)]);
%                         llmapnew(i,j,k) = test;
%                     elseif i >1 && i < nx && j==1
%                         test = mean([llmap(i,j,k),llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k),...
%                             llmap(i-1,j,k),llmap(i-1,j+1,k)]);
%                         llmapnew(i,j,k) = test;
%                     elseif i==nx && j > 1 && j < ny
%                         test = mean([llmap(i,j,k),llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k),...
%                             llmap(i,j+1,k),llmap(i-1,j+1,k)]);
%                         llmapnew(i,j,k) = test;
%                     elseif i >1 && i < nx && j==ny
%                         test = mean([llmap(i,j,k),llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k),...
%                             llmap(i+1,j-1,k),llmap(i+1,j,k)]);
%                         llmapnew(i,j,k) = test;
%                     elseif i > 1 && i < nx && j >1 && j < ny
%                         test = mean([llmap(i,j,k),llmap(i-1,j,k),llmap(i,j-1,k),llmap(i-1,j-1,k),...
%                             llmap(i+1,j,k),llmap(i,j+1,k),llmap(i+1,j+1,k),llmap(i+1,j-1,k),llmap(i-1,j+1,k)]);
%                         llmapnew(i,j,k) = test;
%                     end
%                 end
%                 test1 = llmap(i,j,k)
%                 test
                
            end
        end
    end
%                 figure, img_plot4(llmap(:,:,k));
%                 figure, img_plot4(llmapnew(:,:,k));
%                 tes = 1;

end

mgmapnofit = zeros(nx,ny,1);
mgmapfit = zeros(nx,ny,1);
edmap = zeros(nx,ny,1);
vfermimap = zeros(nx,ny,1);
rmsemap = zeros(nx,ny,1);

for i=1:nx
        for j=1:ny
%             ed = llmapnew(i,j,3) + (llmapnew(i,j,5)-llmapnew(i,j,3))/2;
%             mgmapnofit(i,j,1) = llmapnew(i,j,4) - ed;
%             edmap(i,j,1) = ed;
%             
%             y = [squeeze(((llmap(i,j,4:5)-ed)*10^-3).^2);mean([squeeze(((llmap(i,j,2)-ed)*10^-3).^2),...
%                 squeeze(((llmap(i,j,6)-ed)*10^-3).^2)]);squeeze(((llmap(i,j,7:9)-ed)*10^-3).^2)];
%             range = [0,1,2,3,4,5]';
%             guess = [((llmapnew(i,j,6)-llmapnew(i,j,7))*10^-3)^2,(mgmapnofit(i,j,1)*10^-3)];
%             low = [-inf,0];
%             upp = [inf,inf];
%             [y_new, p,gof]=DiracLandauLevelLine(y,range,guess,low,upp);
%             mgmapfit(i,j,1) = p.b*1000;
%             vfermimap(i,j,1) = (p.a/(2*6.58211928*10^-16*8.5))^0.5;
% %             figure, plot(range,y,'ko',range,y_new,'r','LineWidth',2);
%             test=1;
            dum1 = (llmapnew(i,j,1)+llmapnew(i,j,2))/2;
            dum2 = (llmapnew(i,j,4)+llmapnew(i,j,5))/2;
            ed = dum1 + (dum2-dum1)/2;
            mgmapnofit(i,j,1) = llmapnew(i,j,3) - ed;
            edmap(i,j,1) = ed;
            
            y = squeeze(((llmapnew(i,j,1:8)-ed)*10^-3).^2);
            range = [-2,-1,0,1,2,3,4,5]';
            guess = [((llmapnew(i,j,6)-llmapnew(i,j,7))*10^-3)^2,(mgmapnofit(i,j,1)*10^-3)];
%             low = [-inf,0];
            low = [-inf,-inf];
            
            upp = [inf,inf];
            [y_new, p,gof]=DiracLandauLevelLine(y,range,guess,low,upp);
%             if p.b > 0
                mgmapfit(i,j,1) = (abs(p.b)).^0.5*1000;
%             else
%                 mgmapfit(i,j,1) = -p.b*1000;
%             end
            rmsemap(i,j,1) = gof.rmse;
            gofcell{i,j,1} = gof;
            vfermimap(i,j,1) = (p.a/(2*6.58211928*10^-16*8.5))^0.5;
%             figure, plot(range,y,'ko',range,y_new,'r+','LineWidth',2);
            test=1;

%             y = [squeeze(((llmap(i,j,2:3))*10^-3));squeeze(((ed*10^-3-(llmap(i,j,4)-ed)*10^-3)));squeeze(((llmap(i,j,4:9))*10^-3))];
%             range2 = [-2,-1,0,0,1,2,3,4,5]';
            y = [squeeze(((llmapnew(i,j,1:3))*10^-3));squeeze(((llmapnew(i,j,4:8))*10^-3))];
            range2 = [-2,-1,0,1,2,3,4,5]';
            guess = [ed,((llmapnew(i,j,7)-llmapnew(i,j,6))*10^-3)^2,(mgmapnofit(i,j,1)*10^-3)];
            low = [0,0,-inf];
            upp = [2*ed,2*vfermimap(i,j,1),inf];
%             guess = [((llmapnew(i,j,7)-llmapnew(i,j,6))*10^-3)^2,(mgmapnofit(i,j,1)*10^-3)];
%             low = [0,0];
%             upp = [2*vfermimap(i,j,1),2*mgmapnofit(i,j,1)];
            
            [y_new2, p,gof2]=DiracLandauLevelRoot(y,range2,guess,low,upp);
            mgmapfit(i,j,2) = (abs(p.c)).^0.5*1000;
            vfermimap(i,j,2) = (p.b/(2*6.58211928*10^-16*8.5))^0.5;
            edmap(i,j,2) = p.a*1000;
%             edmap(i,j,2) = ed;
            rmsemap(i,j,2) = gof2.rmse;
            gofcell{i,j,2} = gof2;
%              edmap(i,j,2) = ed;
%             figure, plot(range2,y,'ko',range2,y_new2,'r+','LineWidth',2);
            test=1;
        end
end

% figure, img_plot4(edmap)
% figure, img_plot4(mgmapnofit)
% figure, img_plot4(mgmapfit)
% figure, img_plot4(vfermimap)

%             ed = mean(mean(llmapnew(:,:,3))) + (mean(mean(llmapnew(:,:,5)))-mean(mean(llmapnew(:,:,3))))/2;
%             mgnofit = mean(mean(llmapnew(:,:,4))) - ed
%             ednofit = ed
%             
%             y = [squeeze(((mean(mean(llmap(:,:,2:9)))-ed)*10^-3).^2)];
%             range = [2,1,0,1,2,3,4,5]';
%             guess = [((mean(mean(llmapnew(:,:,7)))-mean(mean(llmapnew(:,:,6))))*10^-3)^2,(mgnofit*10^-3)];
%             low = [-inf,0];
%             upp = [inf,inf];
%             [y_new, p,gof]=DiracLandauLevelLine(y,range,guess,low,upp);
%             mgfit = p.b*1000
%             vfermi = (p.a/(2*6.58211928*10^-16*8.5))^0.5
%             figure, plot(range,y,'ko',range,y_new,'r','LineWidth',2);
%             test=1;

            dum1 = (mean(mean(llmapnew(:,:,1)))+mean(mean(llmapnew(:,:,2))))/2;
            dum2 = (mean(mean(llmapnew(:,:,4)))+mean(mean(llmapnew(:,:,5))))/2;
            ed = dum1 + (dum2-dum1)/2;
            mgnofit = mean(mean(llmapnew(:,:,3))) - ed
            ednofit = ed
            
            y = [squeeze(((mean(mean(llmapnew(:,:,1:8)))-ed)*10^-3).^2)];
            range = [-2,-1,0,1,2,3,4,5]';
            guess = [((mean(mean(llmapnew(:,:,6)))-mean(mean(llmapnew(:,:,7))))*10^-3)^2,(mgnofit*10^-3)];
%             low = [-inf,0];
            low = [-inf,-inf];
            upp = [inf,inf];
            [y_new, p,gof]=DiracLandauLevelLine(y,range,guess,low,upp);
            mgfit = (abs(p.b)).^0.5*1000
%             mgfit = p.b*1000
            vfermi = (p.a/(2*6.58211928*10^-16*8.5))^0.5
            figure, plot(range,y,'ko',range,y_new,'r+','LineWidth',2);
            test=1;

%             y = [squeeze(((llmap(i,j,1))*10^-3));squeeze(((ed*10^-3-(llmap(i,j,2)-ed)*10^-3)));squeeze(((llmap(i,j,2:7))*10^-3))];
%             range2 = [-1,0,0,1,2,3,4,5]';
            y = [squeeze(((mean(mean(llmapnew(:,:,1:3))))*10^-3));squeeze(((mean(mean(llmapnew(:,:,4:8))))*10^-3))];
            range2 = [-2,-1,0,1,2,3,4,5]';
            guess = [ed,((mean(mean(llmapnew(:,:,7)))-mean(mean(llmapnew(:,:,6))))*10^-3)^2,(mgnofit*10^-3)];
            low = [0,0,-inf];
            upp = [2*ed,2*vfermi,inf];
            [y_new2, p,gof]=DiracLandauLevelRoot(y,range2,guess,low,upp);
            mgfit2 = (abs(p.c)).^0.5*1000
            vfermi2 = (p.b/(2*6.58211928*10^-16*8.5))^0.5
            edfit = p.a*1000
%             edfit = ed
            figure, plot(range2,y,'ko',range2,y_new2,'r+','LineWidth',2);
            test=1;

end