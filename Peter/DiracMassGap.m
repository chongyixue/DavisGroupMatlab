function [edmap,mgmapnofit]=DiracMassGap(llmap, llm1, ll0, llp1)


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
                    
                    if llmapnew(i,j,1) > meangap + 4*stdgap
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
                    if llmapnew(i,j,1) > meangap + 3*stdgap
                        llmapnew(i,j,1) = meangap + 3*stdgap;
                    end
                    

            end
        end
    end
%                 figure, img_plot4(llmap(:,:,k));
%                 figure, img_plot4(llmapnew(:,:,k));
%                 tes = 1;

end

mgmapnofit = zeros(nx,ny,1);
edmap = zeros(nx,ny,1);

for i=1:nx
        for j=1:ny
%
%             test=1;
            dum1 = (llmapnew(i,j,llm1)+llmapnew(i,j,llp1))/2;
            
            ed = dum1;
            mgmapnofit(i,j,1) = llmapnew(i,j,ll0) - ed;
            edmap(i,j,1) = ed;

        end
end



end