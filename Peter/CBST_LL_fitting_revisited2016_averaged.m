function [llmap, llwmap, llamap, llarea, cbkg, lbkg, qbkg, qbkgc] = CBST_LL_fitting_revisited2016_averaged(data, llmap, llfpar)

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


avp = llmapnew;
avpw = round( mean(llfpar(3,:,:),3));
avpw2 = round( mean(llfpar(2,:,:),3));


[llmap,llwmap,llamap,cbkg...
,lbkg,qbkg,qbkgc, llarea]...
        = Landaulevelmap_averaged(data,avp,avpw,avpw2);



toc

end