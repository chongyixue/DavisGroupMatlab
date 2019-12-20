function [topo1c,topo2c, imap1c, imap2c, map1c, map2c] = coarsealign(data1,data2,a1,a2,tdata1,tdata2,idata1, idata2)

le = length(data1.e);

load_color;
a1 = round(a1);
a2 = round(a2);

dx = a1(1) - a2(1);
dy = a1(2) - a2(2);


map1 = data1.map;
map2 = data2.map;
topo1 = tdata1.map;
topo2 = tdata2.map;
imap1 = idata1.map;
imap2 = idata2.map;


map1c = [];
map2c = [];
topo1c = [];
topo2c = [];
imap1c = [];
imap2c = [];

if dx < 0 
    map1c = map1(1:end+dx,:,:);
    map2c = map2(1-dx:end,:,:);
    topo1c = topo1(1:end+dx,:,:);
    topo2c = topo2(1-dx:end,:,:);
    imap1c = imap1(1:end+dx,:,:);
    imap2c = imap2(1-dx:end,:,:);
end
if dx > 0
    map1c = map1(1+dx:end,:,:);
    map2c = map2(1:end-dx,:,:);
    topo1c = topo1(1+dx:end,:,:);
    topo2c = topo2(1:end-dx,:,:);
    imap1c = imap1(1+dx:end,:,:);
    imap2c = imap2(1:end-dx,:,:);
end
if dy < 0 
    map1c = map1c(:,1:end+dy,:);
    map2c = map2c(:,1-dy:end,:);
    topo1c = topo1c(:,1:end+dy,:);
    topo2c = topo2c(:,1-dy:end,:);
    imap1c = imap1c(:,1:end+dy,:);
    imap2c = imap2c(:,1-dy:end,:);
end
if dy > 0
    map1c = map1c(:,1+dy:end,:);
    map2c = map2c(:,1:end-dy,:);
    topo1c = topo1c(:,1+dy:end,:);
    topo2c = topo2c(:,1:end-dy,:);
    imap1c = imap1c(:,1+dy:end,:);
    imap2c = imap2c(:,1:end-dy,:);
end

img_plot3(topo1c);
img_plot3(topo2c);


end
        