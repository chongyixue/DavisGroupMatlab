function co=fing_border_atoms(co,ssy,ssx,chardist)
co=[co(:,1) co(:,2) co(:,1)*0];


%make anstand
abst=zeros(ssx*ssy);
for j=1:ssx*ssy-1
    for m=j+1:ssy*ssx
        abst(j,m)=sqrt( (co(j,1)-co(m,1))^2 + ...
            (co(j,2)-co(m,2))^2) ;
    end
end
abst=abst+abst';


for k=1:length(co(:,1))
    
    [tmp,isort]=sort(abst(:,k),1);
        
    %pick first four;
    sortco=co(isort,:);
    neighs=sortco(2:5,1:2);

    currp=[co(k,1),co(k,2)];
    testit=[0 0];
    for m=1:4
        testit=testit+(neighs(m,:)-currp);
    end
    testit=testit*testit';
    if testit>chardist^2
        co(k,3)=1;
    end
end

hold off
plot(co(:,2),co(:,1),'ko')
hold on

ind=find(co(:,3)==1);
plot(co(ind,2),co(ind,1),'r.')