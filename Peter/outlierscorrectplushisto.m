function nmap = outlierscorrectplushisto(map,nbin)


[nx,ny,nz] = size(map);
mapnew = map;

gapvec = reshape(map,nx*ny,1);
meangap = mean(gapvec)
stdgap = std(gapvec)

for i=1:nx
        for j=1:ny
            if map(i,j,1) == 0 || map(i,j,1) < meangap - 4*stdgap || map(i,j,1) > meangap + 4*stdgap
                
%                 if map(i,j,1) == 0
                    if i==1 && j==1
                        test = median([map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1)]);
                        mapnew(i,j,1) = test;
                    elseif i==nx && j==ny
                        test = median([map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1)]);
                        mapnew(i,j,1) = test;
                    elseif i==1 && j > 1 && j < ny
                        test = median([map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1),...
                            map(i,j-1,1),map(i+1,j-1,1)]);
                        mapnew(i,j,1) = test;
                    elseif i >1 && i < nx && j==1
                        test = median([map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1),...
                            map(i-1,j,1),map(i-1,j+1,1)]);
                        mapnew(i,j,1) = test;
                    elseif i==nx && j > 1 && j < ny
                        test = median([map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1),...
                            map(i,j+1,1),map(i-1,j+1,1)]);
                        mapnew(i,j,1) = test;
                    elseif i >1 && i < nx && j==ny
                        test = median([map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1),...
                            map(i+1,j-1,1),map(i+1,j,1)]);
                        mapnew(i,j,1) = test;
                    elseif i > 1 && i < nx && j >1 && j < ny
                        test = median([map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1),...
                            map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1),map(i+1,j-1,1),map(i-1,j+1,1)]);
                        mapnew(i,j,1) = test;
                    end
                    
                    if mapnew(i,j,1) < meangap - 4*stdgap
                        mapnew(i,j,1) = meangap - 3.1*stdgap;
                    end
                    
                    if mapnew(i,j,1) > meangap + 4*stdgap
                        mapnew(i,j,1) = meangap + 3.1*stdgap;
                    end
            end
        end
end

% map = ave_filter_image(mapnew,3,3);
%%
map = mapnew;

    for i=1:nx
        for j=1:ny
            if map(i,j,1) < meangap - 3*stdgap || map(i,j,1) > meangap + 3*stdgap
                
%                 if map(i,j,1) == 0
                    if i==1 && j==1
                        test = mean([map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1)]);
                        mapnew(i,j,1) = test;
                    elseif i==nx && j==ny
                        test = mean([map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1)]);
                        mapnew(i,j,1) = test;
                    elseif i==1 && j > 1 && j < ny
                        test = mean([map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1),...
                            map(i,j-1,1),map(i+1,j-1,1)]);
                        mapnew(i,j,1) = test;
                    elseif i >1 && i < nx && j==1
                        test = mean([map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1),...
                            map(i-1,j,1),map(i-1,j+1,1)]);
                        mapnew(i,j,1) = test;
                    elseif i==nx && j > 1 && j < ny
                        test = mean([map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1),...
                            map(i,j+1,1),map(i-1,j+1,1)]);
                        mapnew(i,j,1) = test;
                    elseif i >1 && i < nx && j==ny
                        test = mean([map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1),...
                            map(i+1,j-1,1),map(i+1,j,1)]);
                        mapnew(i,j,1) = test;
                    elseif i > 1 && i < nx && j >1 && j < ny
                        test = mean([map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1),...
                            map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1),map(i+1,j-1,1),map(i-1,j+1,1)]);
                        mapnew(i,j,1) = test;
                    end
                    
                    if mapnew(i,j,1) < meangap - 3*stdgap
                        mapnew(i,j,1) = meangap - 3*stdgap;
                    end
                    
                    if mapnew(i,j,1) > meangap + 3*stdgap
                        mapnew(i,j,1) = meangap + 3*stdgap;
                    end
                    
                    
%                 else
%                     if i==1 && j==1
%                         test = mean([map(i,j,1),map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1)]);
%                         mapnew(i,j,1) = test;
%                     elseif i==nx && j==ny
%                         test = mean([map(i,j,1),map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1)]);
%                         mapnew(i,j,1) = test;
%                     elseif i==1 && j > 1 && j < ny
%                         test = mean([map(i,j,1),map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1),...
%                             map(i,j-1,1),map(i+1,j-1,1)]);
%                         mapnew(i,j,1) = test;
%                     elseif i >1 && i < nx && j==1
%                         test = mean([map(i,j,1),map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1),...
%                             map(i-1,j,1),map(i-1,j+1,1)]);
%                         mapnew(i,j,1) = test;
%                     elseif i==nx && j > 1 && j < ny
%                         test = mean([map(i,j,1),map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1),...
%                             map(i,j+1,1),map(i-1,j+1,1)]);
%                         mapnew(i,j,1) = test;
%                     elseif i >1 && i < nx && j==ny
%                         test = mean([map(i,j,1),map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1),...
%                             map(i+1,j-1,1),map(i+1,j,1)]);
%                         mapnew(i,j,1) = test;
%                     elseif i > 1 && i < nx && j >1 && j < ny
%                         test = mean([map(i,j,1),map(i-1,j,1),map(i,j-1,1),map(i-1,j-1,1),...
%                             map(i+1,j,1),map(i,j+1,1),map(i+1,j+1,1),map(i+1,j-1,1),map(i-1,j+1,1)]);
%                         mapnew(i,j,1) = test;
%                     end
%                 end
%                 test1 = map(i,j,1)
%                 test
%             if mapnew(i,j,1) < meangap - 3*stdgap || map(i,j,1) > meangap + 3*stdgap
%                 
%                 mapnew(i,j,1) = meangap - 3*stdgap;
%             elseif mapnew(i,j,1) > meangap + 3*stdgap
%                 mapnew(i,j,1) = meangap  + 3*stdgap;
%             end
            end
            end
    end

map = mapnew;
%%
nmap = map;
%%
% mmap = wiener2(mmap,[5 5]);
gapvec = reshape(map,nx*ny,1);
meangap = mean(gapvec)
stdgap = std(gapvec)

% change_color_of_STM_maps(map,'invert')
change_color_of_STM_maps(map,'ninvert')

fh = gcf;
cmap = get(fh,'Colormap');

% figure, hist(gapvec,50);


binranges = linspace(min(gapvec),max(gapvec),nbin);
[bincounts] = histc(gapvec,binranges);

bw = binranges(2)-binranges(1);
fcn = round((binranges(1)-min(gapvec))/(max(gapvec)-min(gapvec))*256);
% ecn = round((binranges(1)-min(gapvec))/(max(gapvec)-min(gapvec))*256);
if fcn == 0
    fcn =1;
end
fc = cmap(fcn,:);
ec = fc;
figure
bar(binranges(1),bincounts(1),bw,'FaceColor',fc,'EdgeColor',ec);
for i=2:length(binranges)
    fcn = round((binranges(i)-min(gapvec))/(max(gapvec)-min(gapvec))*256);
%     ecn = round((binranges(i)-min(gapvec))/(max(gapvec)-min(gapvec))*256);
    if fcn == 0
        fcn =1;
    end
    fc = cmap(fcn,:);
    ec = fc;
    hold on
    bar(binranges(i),bincounts(i),bw,'FaceColor',fc,'EdgeColor',ec);
    hold off
end

xlim([binranges(1)-bw/2,binranges(end)+bw/2]);
ax = gca;
% set(ax,'XTick',round(binranges(1:2:end)));
xlabel('\Delta [meV]','fontsize',24,'fontweight','b')
ylabel('Count','fontsize',24,'fontweight','b')



end