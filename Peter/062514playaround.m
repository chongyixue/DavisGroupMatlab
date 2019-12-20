


% img_plot3(topo1c);
% topo1c1 = topo1c(1:round(nx/2),1:round(ny/2),1);
% img_plot3(topo1c1);
% topo1c2 = topo1c(1:round(nx/2),round(ny/2)+1:end,1);
% img_plot3(topo1c2);
% topo1c3 = topo1c(round(nx/2)+1:end,1:round(ny/2),1);
% img_plot3(topo1c3);
% topo1c4 = topo1c(round(nx/2)+1:end,round(ny/2)+1:end,1);
% img_plot3(topo1c4);

% topo2c1 = topo2c(1:round(nx/2),1:round(ny/2),1);
% topo2c2 = topo2c(1:round(nx/2),round(ny/2)+1:end,1);
% topo2c3 = topo2c(round(nx/2)+1:end,1:round(ny/2),1);
% topo2c4 = topo2c(round(nx/2)+1:end,round(ny/2)+1:end,1);

% 
% topo1c1 = topo1c(1:end,1:round(ny/4),1);
% 
% topo1c2 = topo1c(1:end,round(ny/4)+1:2*round(ny/4),1);
% 
% topo1c3 = topo1c(1:end,2*round(ny/4)+1:3*round(ny/4),1);
% 
% topo1c4 = topo1c(1:end,3*round(ny/4)+1:end,1);

% topo2c1 = topo2c(1:end,1:round(ny/4),1);
% 
% topo2c2 = topo2c(1:end,round(ny/4)+1:2*round(ny/4),1);
% 
% topo2c3 = topo2c(1:end,2*round(ny/4)+1:3*round(ny/4),1);
% 
% topo2c4 = topo2c(1:end,3*round(ny/4)+1:end,1);
%%
[nx, ny, ne] = size(topo1c);

[tformall, fixed, moving] = fetese_alignment(topo1c, topo2c);

nl = 4;

for i=0:nl-1
    topo1c2 = topo1c(round(i*nx/nl)+1:round((i+1)*nx/nl),1:end,1);
    topo2c2 = topo2c(round(i*nx/nl)+1:round((i+1)*nx/nl),1:end,1);
    
    tform = fetese_alignment(topo1c2,topo2c2);
        
    tformcell{i+1} = tform;
    
    topo2al = imwarp(topo2c2,tform,'OutputView',imref2d(size(topo1c2)),'Interp','Cubic');
    
    if i==0
        topo2cw = topo2al;
    else
        topo2cw = cat(1,topo2cw,topo2al);
    end
end


figure, img_plot4(abs(fixed-moving));
figure, img_plot4(abs(topo1c-topo2cw));
figure, img_plot4(abs(fixed-moving)- abs(topo1c-topo2cw));


%%
map = abs(fixed-moving);
map = abs(topo1c-topo2cw);
fmap = zeros(nx, ny, ne);
for i=2:nx-1
    for j=2:ny-1
        
        duml = [map(i-1,j,1), map(i+1,j,1), map(i,j-1,1), map(i,j+1,1),...
            map(i-1,j-1,1), map(i-1,j+1,1), map(i+1,j-1,1), map(i+1,j+1,1)];
        if abs ( map(i,j,1) - mean(duml) ) > std(duml)
            fmap(i,j,1) = mean(duml);
        end
    end
end
        
figure, img_plot4(fmap);      
        
        
        
        
topo1c1 = topo1c(1:round(nx/4),1:end,1);

topo1c2 = topo1c(round(nx/4)+1:2*round(nx/4),1:end,1);

topo1c3 = topo1c(2*round(nx/4)+1:3*round(nx/4),1:end,1);

topo1c4 = topo1c(3*round(nx/4)+1:end,1:end,1);

topo2c1 = topo2c(1:round(nx/4),1:end,1);

topo2c2 = topo2c(round(nx/4)+1:2*round(nx/4),1:end,1);

topo2c3 = topo2c(2*round(nx/4)+1:3*round(nx/4),1:end,1);

topo2c4 = topo2c(3*round(nx/4)+1:end,1:end,1);

tform1 = fetese_alignment(topo1c1,topo2c1);
tform2 = fetese_alignment(topo1c2,topo2c2);
tform3 = fetese_alignment(topo1c3,topo2c3);
tform4 = fetese_alignment(topo1c4,topo2c4);

movingRegistered1 = imwarp(topo2c1,tform1,'OutputView',imref2d(size(topo1c1)));
movingRegistered2 = imwarp(topo2c2,tform2,'OutputView',imref2d(size(topo1c2)));
movingRegistered3 = imwarp(topo2c3,tform3,'OutputView',imref2d(size(topo1c3)));
movingRegistered4 = imwarp(topo2c4,tform4,'OutputView',imref2d(size(topo1c4)));

topo2cw = cat(1,movingRegistered1,movingRegistered2,movingRegistered3,movingRegistered4);


figure
imshowpair(topo1c, topo2cw,'Scaling','joint');

figure, img_plot4(abs(topo1c-topo2cw);