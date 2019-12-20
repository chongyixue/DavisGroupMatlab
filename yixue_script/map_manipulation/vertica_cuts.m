map = map;

clear N_pix;clear size;clear avg_pix; clear Y;

N_pix = length(map.map);
layers = size(map.map,3);
avg_pix =8;

start = round((N_pix-avg_pix)/2)+1;
fin = round((N_pix+avg_pix)/2);
q = map.r;
n = fin-start+1;



shiftup = 10;
add = -shiftup;

%take one energy layer
layer = 1;
E = map.e(layer)*1000;
figure()
for layer = 1:layers
    add = shiftup + add;
    %set colors
    R = layer;
    B = length(xpoints)-layer;
    G = 1;
    T = R+G+B;
    R = R/T;
    B = B/T;
    G = 1-R-B;
    color{layer} = [R,G,B];
    
    
    for p = 1:N_pix
        intensity = 0;
        for sum = start:fin
            intensity = intensity + map.map(p,sum,layer);
        end
        intensity = intensity/n;
        Y(p) = intensity + add;
    end
    
    plot(q,Y,'color',color{layer});
    hold on

end
ymax = 170+add;
plot([q(33) q(33)],[0 ymax],'k')
plot([q(79) q(79)],[0 ymax],'k')
title([num2str(n) '-pixel averaged cut in q-space']);
% title([num2str(n) '-pixel averaged' num2str(E) ' mV layer']);
xlabel('q[A^-^1]');

