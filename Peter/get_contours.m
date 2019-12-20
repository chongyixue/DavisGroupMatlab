function cont=get_contours(kx,ky,band,en)

fact=max(max(abs(kx(:))),max(abs(ky(:))))+1;
kx=kx/fact;
ky=ky/fact;

c=contourc(kx,ky,band,[en en]);
c=c';
c=c(1:end,:);
%plot(c(:,2))
ind=find(c(:,2)>2);
ind=[ind; length(c(:,2))];
cont=cell(length(ind)-1,1);
for j=1:length(ind)-1
    tmp=c(ind(j)+1:ind(j+1)-1,:);
    cont{j}=tmp*fact;
end


