function fano_map3(map,energy,init_guess,name)
[nr,nc,nz] = size(map);
fano_a = zeros(nr,nc);
fano_b = zeros(nr,nc);
fano_c = zeros(nr,nc);
fano_e = zeros(nr,nc);
fano_g = zeros(nr,nc);
fano_q = zeros(nr,nc);
%fano_gof = zeros(nr,nc);

vol_r = nr*nc*(nz-1);

map_r = permute(map,[3 1 2]);
area = nz*nr;
s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',init_guess,...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-5,...
    'MaxIter',2000,...
    'MaxFunEvals', 5000);


for k = 1:nz:vol_r
        [param,gof] = fano_fit2(energy,map_r(k:k+nz-1)',init_guess,s);
        i = mod(k-1,nz) + 1;
        j = floor(k-1/area) + 1;
        fano_a(i,j) = param.a;
        fano_b(i,j) = param.b;
        fano_c(i,j) = param.c;
        fano_e(i,j) = param.e;
        fano_g(i,j) = param.g;
        fano_q(i,j) = param.q;
 %s       fano_gof(i,j) = gof;
end
fano.a = fano_a;
fano.b = fano_b;
fano.c = fano_c;
fano.e = fano_e;
fano.g = fano_g;
fano.q = fano_q;
%fano.gof = fano_gof;
assignin('base',[name 'fano'],fano);
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