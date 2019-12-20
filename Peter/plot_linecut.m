function M=plot_linecut(line_cut,freq,N,k)
% plot line cuts
% freq of 2 means plot every 2nd energy
% freq of 3 means plot every 3rd energy
col=1;
offset = mean(mean(line_cut.cut));
if(N==0)
    for i=1:length(line_cut.e)
        if(mod(i,freq)==1)
            M(:,col)=line_cut.cut(:,i)+(col-1)*offset;
            col=col+1;
        end
    end
else
    z = ceil(N/k);
    for j=1:z
        figure(100+j);
        hold on
        col=1;
        for i=1+k*(j-1):min(N,k*j)
            M(:,col)=line_cut.cut(:,i)+(col-1)*offset;
            col=col+1;
        end
        plot(M,'.k');
        hold off
        clear M
    end

end
