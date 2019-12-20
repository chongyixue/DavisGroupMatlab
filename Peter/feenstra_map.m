
function new_map = feenstra_map(G,I)

new_map = G;

[rxx,ryy,ee]=ndgrid(G.r,G.r,G.e);

nmap = I.map;
e = I.e;
% e = round(I.e*100000000)/100000000;

[nx, ny, nz] = size(nmap);

ee = ones(nx, ny, nz);
for i=1:nz
    ee(:,:,i) = ee(:,:,i) .* e(i);
end

new_map.map=(G.map./nmap) .* ee;
new_map.var = 'feenstra';
end