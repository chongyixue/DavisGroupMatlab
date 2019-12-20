function MNQ_E(data,pt1,pt2,width)
map = data.map; e = data.e*1000; w = width;
nz = size(map,3);
mnq = zeros(1,nz);
for i = 1:nz
    a = sum(sum(map(pt1(2)-w:pt1(2)+w,pt1(1)-w:pt1(1)+w,i)));
    b = sum(sum(map(pt2(2)-w:pt2(2)+w,pt2(1)-w:pt2(1)+w,i)));
    mnq(i) = abs(a - b)/max(a,b);
end
figure; plot(e,mnq,'rx');
xlabel('Energy'); ylabel('MNQ');
end