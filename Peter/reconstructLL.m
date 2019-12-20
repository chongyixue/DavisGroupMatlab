function LLOmap = reconstructLL(data,llmap,llamap,llwmap)



map = data.map;
ev = data.e * 1000;
[nx,ny,np] = size(llmap);




for i=1:nx
    for j=1:ny
    

    for k=1:np
        if k==1
            peak1=llamap(i,j,k).*(llwmap(i,j,k)/2).^2./((ev-llmap(i,j,k)).^2+(llwmap(i,j,k)/2).^2);
        else
            peak1 = peak1 + llamap(i,j,k).*(llwmap(i,j,k)/2).^2./((ev-llmap(i,j,k)).^2+(llwmap(i,j,k)/2).^2);
        end
        test = 1;
    end
    LLOmap(i,j,:) = peak1;
    
%     figure, plot(ev,peak1)
    test =1;
    clear peak1;
    end
end



end