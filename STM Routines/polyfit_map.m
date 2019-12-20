function polyfit_map(map,energy,order,name)

[nr,nc,nz] = size(map);
%nr =2;
%nc =2;
param = zeros(nr,nc,order+1);
%gof = zeros(nr,nc);
for i = 1:nr
    for j = 1:nc
        [p,g] = polyfit(energy',squeeze(squeeze(map(i,j,:))),order);
        param(i,j,:)= p;
        %gof(i,j) = g;        
    end
end
figure;
for i=1:nr
    for j=1:nc
        y = polyval(squeeze(squeeze(param(i,j,:))),energy);
        plot(energy,y)
        hold on
    end
end
assignin('base',[name 'poly_param' ],param);
%assignin('base',[name 'poly_gof' ],gof);
end