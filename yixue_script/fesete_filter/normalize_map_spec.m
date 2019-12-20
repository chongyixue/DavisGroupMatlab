% 2019-7-30 YXC
% fesete is disordered. Perhaps normalizing spectra from map would help

nmap = map;
pix = 200;
for i = 1:pix
    for j = 1:pix
        spec = map.map(i,j,:);
        minn = min(spec);
        maxx = max(spec);
        spec = (spec-minn);%./(maxx-minn);
        nmap.map(i,j,:)=spec;
    end
end
nmap.name =strcat(['normalized_',nmap.name]);
img_obj_viewer_test(nmap)





