

edata = obj_60801a00_G;

el = length(edata.e);
cc = 1;
[nx, ny, nz] = size(edata.map(:,:,1));
nmap = zeros(nx, ny, 1);

for i=1:el
    if mod(edata.e(i)*1000, 5) == 0
        nmap(:,:,cc) = edata.map(:,:,i);
        ne(cc) = edata.e(i);
        cc = cc + 1;
    end
end

nedata = edata;
nedata.map = nmap;
nedata.e = ne;

[nx, ny, nz] = size(osrrot.map(:,:,1));
nmap2 = zeros(nx, ny, 1);
nmap3 = zeros(nx, ny, 1);

cc = 1;
for i=1:121
    if mod(round(osrrot.e(i)*1000), 5) == 0
        if round(abs(osrrot.e(i))*1000) <= 50
            nmap2(:,:,cc) = osrrot.map(:,:,i);
            nmap3(:,:,cc) = nosrrot.map(:,:,i);
            ne2(cc) = osrrot.e(i);
            cc = cc + 1;
        end
    end
end

cosrrot = osrrot;
cnosrrot = nosrrot;
cosrrot.map = nmap2;
cosrrot.e = ne2;
cnosrrot.map = nmap3;
cnosrrot.e = ne2;