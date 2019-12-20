function topon=boxestoones(topo,divisor)

[nx ny nz]=size(topo);


a= nx/divisor;
% a=26;
% a=52;
% a=78;

for i=1:a:nx
    for j=1:a:nx
        
        topo1=topo(i:i+a-1,j:j+a-1);
        [nx1 ny1 nz1]=size(topo1);
        for k=1:nx1
            for l=1:ny1
                if topo1(k,l)<= mean(mean(topo1))+0.15*(max(max(topo1))-mean(mean(topo1)))
                    topo2(k,l)=0;
                else
                    topo2(k,l)=1;
                end
            end
        end
%         figure, imagesc(topo1), colormap(gray)
%         figure, imagesc(topo2), colormap(gray)
        topon(i:i+a-1,j:j+a-1)=topo2;
        clear topo1 topo2;
    end
end




figure, imagesc(topo), colormap(gray)
figure, imagesc(topon), colormap(gray)






end