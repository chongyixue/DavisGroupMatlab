function [llmapa, llwmapa, llamapa, llareaa, cbkga, lbkga, qbkga, qbkgca] = CBST_LL_fitting_revisited2016_averaged_corrected(data, llmap, llfpar, reg1co, reg2co, llmapa, llwmapa, llamapa, llareaa, cbkga, lbkga, qbkga, qbkgca)

%% 
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
            end
            
            if llmapnew(i,j,k) < meangap - 4*stdgap
                llmapnew(i,j,k) = meangap - 3.1*stdgap;
            end
            
            if llmapnew(i,j,k) > meangap + 4*stdgap
                llmapnew(i,j,k) = meangap + 3.1*stdgap;
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

            end
            
            if llmapnew(i,j,k) < meangap - 3*stdgap
                llmapnew(i,j,k) = meangap - 3*stdgap;
            end
            
            if llmapnew(i,j,k) > meangap + 3*stdgap
                llmapnew(i,j,k) = meangap + 3*stdgap;
            end
            
        end
    end
%                 figure, img_plot4(llmap(:,:,k));
%                 figure, img_plot4(llmapnew(:,:,k));
%                 tes = 1;

end


ndata = data;
ndata.map = data.map(reg1co(1):reg1co(2),reg1co(3):reg1co(4), :);
llmapnewc = llmapnew(reg1co(1):reg1co(2),reg1co(3):reg1co(4), :);


avp = llmapnewc;
avpw = round( mean(llfpar(3,:,:),3));
avpw2 = round( mean(llfpar(2,:,:),3));


[llmap1,llwmap1,llamap1,cbkg1...
,lbkg1,qbkg1,qbkgc1, llarea1]...
        = Landaulevelmap_averaged(ndata,avp,avpw,avpw2);



toc


%%

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
            end
            
            if llmapnew(i,j,k) < meangap - 4*stdgap
                llmapnew(i,j,k) = meangap - 3.1*stdgap;
            end
            
            if llmapnew(i,j,k) > meangap + 4*stdgap
                llmapnew(i,j,k) = meangap + 3.1*stdgap;
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

            end
            
            if llmapnew(i,j,k) < meangap - 3*stdgap
                llmapnew(i,j,k) = meangap - 3*stdgap;
            end
            
            if llmapnew(i,j,k) > meangap + 3*stdgap
                llmapnew(i,j,k) = meangap + 3*stdgap;
            end
            
        end
    end
%                 figure, img_plot4(llmap(:,:,k));
%                 figure, img_plot4(llmapnew(:,:,k));
%                 tes = 1;

end

ndata = data;
ndata.map = data.map(reg2co(1):reg2co(2),reg2co(3):reg2co(4), :);
llmapnewc = llmapnew(reg2co(1):reg2co(2),reg2co(3):reg2co(4), :);


avp = llmapnewc;
avpw = round( mean(llfpar(3,:,:),3));
avpw2 = round( mean(llfpar(2,:,:),3));


[llmap2,llwmap2,llamap2,cbkg2...
,lbkg2,qbkg2,qbkgc2, llarea2]...
        = Landaulevelmap_averaged(ndata,avp,avpw,avpw2);



toc


llmapa(reg2co(1):reg2co(2),reg2co(3):reg2co(4), :) = llmap2;
llwmapa(reg2co(1):reg2co(2),reg2co(3):reg2co(4), :) = llwmap2;
llamapa(reg2co(1):reg2co(2),reg2co(3):reg2co(4), :) = llamap2;
llareaa(reg2co(1):reg2co(2),reg2co(3):reg2co(4), :) = llarea2;
cbkga(reg2co(1):reg2co(2),reg2co(3):reg2co(4), :) = cbkg2;
lbkga(reg2co(1):reg2co(2),reg2co(3):reg2co(4), :) = lbkg2;
qbkga(reg2co(1):reg2co(2),reg2co(3):reg2co(4), :) = qbkg2;
qbkgca(reg2co(1):reg2co(2),reg2co(3):reg2co(4), :) = qbkgc2;

llmapa(reg1co(1):reg1co(2),reg1co(3):reg1co(4), :) = llmap1;
llwmapa(reg1co(1):reg1co(2),reg1co(3):reg1co(4), :) = llwmap1;
llamapa(reg1co(1):reg1co(2),reg1co(3):reg1co(4), :) = llamap1;
llareaa(reg1co(1):reg1co(2),reg1co(3):reg1co(4), :) = llarea1;
cbkga(reg1co(1):reg1co(2),reg1co(3):reg1co(4), :) = cbkg1;
lbkga(reg1co(1):reg1co(2),reg1co(3):reg1co(4), :) = lbkg1;
qbkga(reg1co(1):reg1co(2),reg1co(3):reg1co(4), :) = qbkg1;
qbkgca(reg1co(1):reg1co(2),reg1co(3):reg1co(4), :) = qbkgc1;

end