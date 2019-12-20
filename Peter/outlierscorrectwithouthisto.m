function [nmap, nmap2, nmap3, nmap4, nmap5, nmap6, nmap7, nmap8] = outlierscorrectwithouthisto(map, map2, map3, map4, map5, map6, map7, map8)


[nx,ny,nz] = size(map);
mapnew = map;



ptbc = {};
cc = 1;
for k=1:nz
    for i=1:nx
            for j=1:ny
                if map(i,j,1) == 0 
                    
                    ptbc{cc} = [i,j,k];
                    cc = cc+1;
                    
                        if i==1 && j==1
                            test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k)]);
                            mapnew(i,j,k) = test;
                        elseif i==nx && j==ny
                            test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k)]);
                            mapnew(i,j,k) = test;
                        elseif i==1 && j==ny
                            test = mean([map(i+1,j,k),map(i,j-1,k),map(i+1,j-1,k)]);
                            mapnew(i,j,k) = test;
                        elseif i==nx && j==1
                            test = mean([map(i-1,j,k),map(i,j+1,k),map(i-1,j+1,k)]);
                            mapnew(i,j,k) = test;
                        elseif i==1 && j > 1 && j < ny
                            test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
                                map(i,j-1,k),map(i+1,j-1,k)]);
                            mapnew(i,j,k) = test;
                        elseif i >1 && i < nx && j==1
                            test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
                                map(i-1,j,k),map(i-1,j+1,k)]);
                            mapnew(i,j,k) = test;
                        elseif i==nx && j > 1 && j < ny
                            test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
                                map(i,j+1,k),map(i-1,j+1,k)]);
                            mapnew(i,j,k) = test;
                        elseif i >1 && i < nx && j==ny
                            test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
                                map(i+1,j-1,k),map(i+1,j,k)]);
                            mapnew(i,j,k) = test;
                        elseif i > 1 && i < nx && j >1 && j < ny
                            test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
                                map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),map(i+1,j-1,k),map(i-1,j+1,k)]);
                            mapnew(i,j,k) = test;
                        end



                end
            end
    end
end

nmap = mapnew;

%%
mapnew = map2;
map = map2;

for m=1:length(ptbc)
    i = ptbc{1}(1);
    j = ptbc{1}(2);
    k = ptbc{1}(3);
    
    if i==1 && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i==1 && j > 1 && j < ny
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i,j-1,k),map(i+1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i-1,j,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j > 1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i,j+1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j-1,k),map(i+1,j,k)]);
        mapnew(i,j,k) = test;
    elseif i > 1 && i < nx && j >1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),map(i+1,j-1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    end
                        
end

nmap2 = mapnew;
%%
mapnew = map3;
map = map3;

for m=1:length(ptbc)
    i = ptbc{1}(1);
    j = ptbc{1}(2);
    k = ptbc{1}(3);
    
    if i==1 && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i==1 && j > 1 && j < ny
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i,j-1,k),map(i+1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i-1,j,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j > 1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i,j+1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j-1,k),map(i+1,j,k)]);
        mapnew(i,j,k) = test;
    elseif i > 1 && i < nx && j >1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),map(i+1,j-1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    end
                        
end

nmap3 = mapnew;
%%
mapnew = map4;
map = map4;

for m=1:length(ptbc)
    i = ptbc{1}(1);
    j = ptbc{1}(2);
    k = ptbc{1}(3);
    
    if i==1 && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i==1 && j > 1 && j < ny
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i,j-1,k),map(i+1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i-1,j,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j > 1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i,j+1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j-1,k),map(i+1,j,k)]);
        mapnew(i,j,k) = test;
    elseif i > 1 && i < nx && j >1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),map(i+1,j-1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    end
                        
end

nmap4 = mapnew;
%%
mapnew = map5;
map = map5;

for m=1:length(ptbc)
    i = ptbc{1}(1);
    j = ptbc{1}(2);
    k = ptbc{1}(3);
    
    if i==1 && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i==1 && j > 1 && j < ny
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i,j-1,k),map(i+1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i-1,j,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j > 1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i,j+1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j-1,k),map(i+1,j,k)]);
        mapnew(i,j,k) = test;
    elseif i > 1 && i < nx && j >1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),map(i+1,j-1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    end
                        
end

nmap5 = mapnew;

%%
mapnew = map6;
map = map6;

for m=1:length(ptbc)
    i = ptbc{1}(1);
    j = ptbc{1}(2);
    k = ptbc{1}(3);
    
    if i==1 && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i==1 && j > 1 && j < ny
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i,j-1,k),map(i+1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i-1,j,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j > 1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i,j+1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j-1,k),map(i+1,j,k)]);
        mapnew(i,j,k) = test;
    elseif i > 1 && i < nx && j >1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),map(i+1,j-1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    end
                        
end

nmap6 = mapnew;

%%
mapnew = map7;
map = map7;

for m=1:length(ptbc)
    i = ptbc{1}(1);
    j = ptbc{1}(2);
    k = ptbc{1}(3);
    
    if i==1 && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i==1 && j > 1 && j < ny
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i,j-1,k),map(i+1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i-1,j,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j > 1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i,j+1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j-1,k),map(i+1,j,k)]);
        mapnew(i,j,k) = test;
    elseif i > 1 && i < nx && j >1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),map(i+1,j-1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    end
                        
end

nmap7 = mapnew;

%%
mapnew = map8;
map = map8;

for m=1:length(ptbc)
    i = ptbc{1}(1);
    j = ptbc{1}(2);
    k = ptbc{1}(3);
    
    if i==1 && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i==1 && j > 1 && j < ny
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i,j-1,k),map(i+1,j-1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==1
        test = mean([map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),...
        map(i-1,j,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i==nx && j > 1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i,j+1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    elseif i >1 && i < nx && j==ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j-1,k),map(i+1,j,k)]);
        mapnew(i,j,k) = test;
    elseif i > 1 && i < nx && j >1 && j < ny
        test = mean([map(i-1,j,k),map(i,j-1,k),map(i-1,j-1,k),...
        map(i+1,j,k),map(i,j+1,k),map(i+1,j+1,k),map(i+1,j-1,k),map(i-1,j+1,k)]);
        mapnew(i,j,k) = test;
    end
                        
end

nmap8 = mapnew;


%%
for k=1:nz
    nmap(:,:,k) = medfilt2(nmap(:,:,k), [3,3]);
    nmap2(:,:,k) = medfilt2(nmap2(:,:,k), [3,3]);
    nmap3(:,:,k) = medfilt2(nmap3(:,:,k), [3,3]);
    nmap4(:,:,k) = medfilt2(nmap4(:,:,k), [3,3]);
    nmap5(:,:,k) = medfilt2(nmap5(:,:,k), [3,3]);
    nmap6(:,:,k) = medfilt2(nmap6(:,:,k), [3,3]);
    nmap7(:,:,k) = medfilt2(nmap7(:,:,k), [3,3]);
    nmap8(:,:,k) = medfilt2(nmap8(:,:,k), [3,3]);
end

%%

for k=1:nz

                         i=1; 
                         j=1;
                            test = mean([nmap(i+1,j,k),nmap(i,j+1,k),nmap(i+1,j+1,k)]);
                            nmap(i,j,k) = test;
                         i=nx;
                         j=ny;
                            test = mean([nmap(i-1,j,k),nmap(i,j-1,k),nmap(i-1,j-1,k)]);
                            nmap(i,j,k) = test;
                         i=1;
                         j=ny;
                            test = mean([nmap(i+1,j,k),nmap(i,j-1,k),nmap(i+1,j-1,k)]);
                            nmap(i,j,k) = test;
                         i=nx;
                         j=1;
                            test = mean([nmap(i-1,j,k),nmap(i,j+1,k),nmap(i-1,j+1,k)]);
                            nmap(i,j,k) = test;

end

for k=1:nz

                        i=1; 
                        j=1;
                            test = mean([nmap2(i+1,j,k),nmap2(i,j+1,k),nmap2(i+1,j+1,k)]);
                            nmap2(i,j,k) = test;
                        i=nx;
                        j=ny;
                            test = mean([nmap2(i-1,j,k),nmap2(i,j-1,k),nmap2(i-1,j-1,k)]);
                            nmap2(i,j,k) = test;
                        i=1;
                        j=ny;
                            test = mean([nmap2(i+1,j,k),nmap2(i,j-1,k),nmap2(i+1,j-1,k)]);
                            nmap2(i,j,k) = test;
                        i=nx;
                        j=1;
                            test = mean([nmap2(i-1,j,k),nmap2(i,j+1,k),nmap2(i-1,j+1,k)]);
                            nmap2(i,j,k) = test;
                       

end

for k=1:nz

                        i=1; 
                        j=1;
                            test = mean([nmap3(i+1,j,k),nmap3(i,j+1,k),nmap3(i+1,j+1,k)]);
                            nmap3(i,j,k) = test;
                        i=nx;
                        j=ny;
                            test = mean([nmap3(i-1,j,k),nmap3(i,j-1,k),nmap3(i-1,j-1,k)]);
                            nmap3(i,j,k) = test;
                        i=1;
                        j=ny;
                            test = mean([nmap3(i+1,j,k),nmap3(i,j-1,k),nmap3(i+1,j-1,k)]);
                            nmap3(i,j,k) = test;
                        i=nx;
                        j=1;
                            test = mean([nmap3(i-1,j,k),nmap3(i,j+1,k),nmap3(i-1,j+1,k)]);
                            nmap3(i,j,k) = test;
                        

end

for k=1:nz

                        i=1; 
                        j=1;
                            test = mean([nmap4(i+1,j,k),nmap4(i,j+1,k),nmap4(i+1,j+1,k)]);
                            nmap4(i,j,k) = test;
                        i=nx;
                        j=ny;
                            test = mean([nmap4(i-1,j,k),nmap4(i,j-1,k),nmap4(i-1,j-1,k)]);
                            nmap4(i,j,k) = test;
                        i=1;
                        j=ny;
                            test = mean([nmap4(i+1,j,k),nmap4(i,j-1,k),nmap4(i+1,j-1,k)]);
                            nmap4(i,j,k) = test;
                        i=nx;
                        j=1;
                            test = mean([nmap4(i-1,j,k),nmap4(i,j+1,k),nmap4(i-1,j+1,k)]);
                            nmap4(i,j,k) = test;
                        

end

for k=1:nz

                        i=1; 
                        j=1;
                            test = mean([nmap5(i+1,j,k),nmap5(i,j+1,k),nmap5(i+1,j+1,k)]);
                            nmap5(i,j,k) = test;
                        i=nx;
                        j=ny;
                            test = mean([nmap5(i-1,j,k),nmap5(i,j-1,k),nmap5(i-1,j-1,k)]);
                            nmap5(i,j,k) = test;
                        i=1;
                        j=ny;
                            test = mean([nmap5(i+1,j,k),nmap5(i,j-1,k),nmap5(i+1,j-1,k)]);
                            nmap5(i,j,k) = test;
                        i=nx;
                        j=1;
                            test = mean([nmap5(i-1,j,k),nmap5(i,j+1,k),nmap5(i-1,j+1,k)]);
                            nmap5(i,j,k) = test;
                        

end

for k=1:nz

                        i=1; 
                        j=1;
                            test = mean([nmap6(i+1,j,k),nmap6(i,j+1,k),nmap6(i+1,j+1,k)]);
                            nmap6(i,j,k) = test;
                        i=nx;
                        j=ny;
                            test = mean([nmap6(i-1,j,k),nmap6(i,j-1,k),nmap6(i-1,j-1,k)]);
                            nmap6(i,j,k) = test;
                        i=1;
                        j=ny;
                            test = mean([nmap6(i+1,j,k),nmap6(i,j-1,k),nmap6(i+1,j-1,k)]);
                            nmap6(i,j,k) = test;
                        i=nx;
                        j=1;
                            test = mean([nmap6(i-1,j,k),nmap6(i,j+1,k),nmap6(i-1,j+1,k)]);
                            nmap6(i,j,k) = test;
                        

end

for k=1:nz

                        i=1; 
                        j=1;
                            test = mean([nmap7(i+1,j,k),nmap7(i,j+1,k),nmap7(i+1,j+1,k)]);
                            nmap7(i,j,k) = test;
                        i=nx;
                        j=ny;
                            test = mean([nmap7(i-1,j,k),nmap7(i,j-1,k),nmap7(i-1,j-1,k)]);
                            nmap7(i,j,k) = test;
                        i=1;
                        j=ny;
                            test = mean([nmap7(i+1,j,k),nmap7(i,j-1,k),nmap7(i+1,j-1,k)]);
                            nmap7(i,j,k) = test;
                        i=nx;
                        j=1;
                            test = mean([nmap7(i-1,j,k),nmap7(i,j+1,k),nmap7(i-1,j+1,k)]);
                            nmap7(i,j,k) = test;
                        

end

for k=1:nz

                        i=1; 
                        j=1;
                            test = mean([nmap8(i+1,j,k),nmap8(i,j+1,k),nmap8(i+1,j+1,k)]);
                            nmap8(i,j,k) = test;
                        i=nx;
                        j=ny;
                            test = mean([nmap8(i-1,j,k),nmap8(i,j-1,k),nmap8(i-1,j-1,k)]);
                            nmap8(i,j,k) = test;
                        i=1;
                        j=ny;
                            test = mean([nmap8(i+1,j,k),nmap8(i,j-1,k),nmap8(i+1,j-1,k)]);
                            nmap8(i,j,k) = test;
                        i=nx;
                        j=1;
                            test = mean([nmap8(i-1,j,k),nmap8(i,j+1,k),nmap8(i-1,j+1,k)]);
                            nmap8(i,j,k) = test;
                        

end

end