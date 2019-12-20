function new_data = fano_recon2(data,fano_a,fano_b,fano_c,fano_d,fano_e,fano_g,fano_q)
new_data = data;
[nr,nc,nz] = size(data.map);
new_map = zeros(nr,nc,nz);
a = fano_a; b = fano_b; c = fano_c; d = fano_d; e = fano_e; g = fano_g; q = fano_q;
for i=1:nz
    energy = data.e(i)*1000;
    new_map(:,:,i) = a.*((energy - e)./g + q).^2./(1 + ((energy - e)./g).^2) + b*energy^2 + c*energy + d;
end
    new_data.map = new_map;
    new_data.ave = squeeze(squeeze(sum(sum(new_data.map))/nr/nc));
end