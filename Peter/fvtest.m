function fvtest(data)


[nx, ny, nz] = size(data.map);
map = data.map;
ev = data.e;
vmap = zeros(nx,ny);

for i=1:nx
    for j=1:ny
        spec(1:nz) = map(i,j,:);
        maxthresh = min(spec);
%         minthresh = max(spec);
        sel = (max(spec)-min(spec))/100;
        [peakloc, peakmag] = peakfinder(spec, sel, maxthresh, 1);
%         figure, plot(ev,spec,'o-',ev(peakloc),spec(peakloc),'r+','LineWidth',2,'MarkerSize',14);
        k = 1;
        while k < length(peakloc)
            if ev(peakloc(k)) >= -0.0004 && ev(peakloc(k)) <= 0.0004
                vmap(i,j) = 1 * trapz(ev(12:20),spec(12:20));
                k = length(peakloc)+1;
            end
            k = k+1;
        end
        test = 1;
    end
end

figure, imagesc(vmap)
axis image;

end