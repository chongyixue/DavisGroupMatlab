%just some finding peak distances (in energy). 
%e1,e2,e3 are distances between peaks counting from right
%sometime early November 2017
%Yi Xue Chong


map = obj_71101a07_G;
topo = obj_71101A07_T;

mapsize = 50;

clear e1;
clear e2;
clear e3;
clear peaks;

k=1;
m=1;
p=1; 
q =1;

% for xpix =30 : 30
%     for ypix = 30: 30
for xpix =1 : mapsize
    for ypix = 1: mapsize
        clear n;
        x = map.e*1000;
        y = squeeze(map.map(ypix,xpix,:));
        [~,n]=findpeaks(y);
        
        for kk = 1:size(n)
            peaks(q) = n(kk)*0.5;
            q = q+1;
        end
        
       
        e1(k) = (n(end)-n(end-1))*0.5;
        k = k+1;
       
        if length(n)>2
            e2(m) = (n(end)-n(end-2))*0.5;
            m=m+1;
            if length(n)>3
                e3(p) = (n(end)-n(end-3))*0.5;
                p=p+1;
            end
        end
        
    end
end
figure(55),
hist(e1,100);
figure(66);
hist(e2,100);
figure(77);
hist(e3,100);
figure(88);
hist(peaks,100);  


%x(n(1))