function fano_map(map,energy,name)

[nr,nc,nz] = size(map);
%nr =2;
%nc =2;
for i = 1:nr
    i
    for j = 1:nc
        [param,gof] = fano_fit(energy,squeeze(squeeze(map(i,j,:))));
        fano_a(i,j) = param.a;
        fano_b(i,j) = param.b;
        fano_c(i,j) = param.c;
        fano_e(i,j) = param.e;
        fano_g(i,j) = param.g;
        fano_q(i,j) = param.q;
        fano_gof(i,j) = gof;
    end
end
fano.a = fano_a;
fano.b = fano_b;
fano.c = fano_c;
fano.e = fano_e;
fano.g = fano_g;
fano.q = fano_q;
fano.gof = fano_gof;
assignin('base',[name 'fano'],fano);
% assignin('base',[name 'fano_a' ],fano_a);
% assignin('base',[name 'fano_b' ],fano_b);
% assignin('base',[name 'fano_c' ],fano_c);
% assignin('base',[name 'fano_e' ],fano_e);
% assignin('base',[name 'fano_g' ],fano_g);
% assignin('base',[name 'fano_q' ],fano_q);
% assignin('base',[name 'fano_gof' ],fano_gof);
%figure;
%pcolor(fano_a);
%shading interp;   
%figure;
%hist(reshape(fano_e,1,nr*nc));
%figure;
%x2 = min(energy):0.01:max(energy);
% for i=1:nr
%     for j=1:nc
%         p.a=fano_a(i,j);p.b=fano_b(i,j);p.c=fano_c(i,j);p.e=fano_e(i,j);p.g=fano_g(i,j);p.q=fano_q(i,j);
%         y2 = p.a*((x2 - p.e)/p.g + p.q).^2./(1 + ((x2 - p.e)/p.g).^2) + p.b*x2 + p.c;
%         plot(x2,y2)
%         hold on
%     end
% end
end