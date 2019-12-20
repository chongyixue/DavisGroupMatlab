% 2019-10-12 YXC
% crop 90307a00 to 50nm (center)-that's the FOV of 90306a00 map
% name topo as crop


topo = crop2;
[nx,ny,~]=size(topo.map);
[freq,val] = hist(reshape(topo.map(:,:,1),nx*ny,1),100);


%% replace with mode if value too big (defect)

triggerval = 0.014;
figure,plot(val,freq)
hold on
plot([triggerval,triggerval],[0,max(freq)*1.2],'r--')
ylim([0,max(freq)*1.2])

windowradius = 10;
% for x = 1:nx
%     for y=1:ny
for x=1:nx
    for y=1:ny
        
        if crop2.map(x,y,1)>triggerval
            xmin = max(1,x-windowradius);
            xmax = min(nx,x+windowradius);
            ymin = max(1,y-windowradius);
            ymax = min(ny,y+windowradius);
            matrix = crop2.map(xmin:xmax,ymin:ymax,1);
            topo.map(x,y,1) = return_mode(matrix);
        end
    end
end
topo.name = 'magfilter';
img_obj_viewer_test(topo);

diff = crop2;
diff.name = 'diff';
diff.map = crop2.map-topo.map;
img_obj_viewer_test(diff);

%% mode filter everything
additional_n = 0;
windowradius=5;
if additional_n>0
    for i=1:additional_n
        topotemp = topo;
        for x=1:nx
            for y=1:ny
                xmin = max(1,x-windowradius);
                xmax = min(nx,x+windowradius);
                ymin = max(1,y-windowradius);
                ymax = min(ny,y+windowradius);
                
                matrix = topotemp.map(xmin:xmax,ymin:ymax,1);
                topo.map(x,y,1) = return_mode(matrix);
            end
        end
    end
    topo.name = strcat(topo.name,'_all');
    img_obj_viewer_test(topo)
end


%% replace with avg if magnitude too different compared to mode
diffthres = 0.017;


times = 1;
window = 6;
if times>0
    for i=1:times
        topotemp = topo;
        for x=1:nx
            for y=1:ny
                xmin = max(1,x-windowradius);
                xmax = min(nx,x+windowradius);
                ymin = max(1,y-windowradius);
                ymax = min(ny,y+windowradius);

                matrix = topotemp.map(xmin:xmax,ymin:ymax,1);
                mode = return_mode(matrix);
                if abs(mode-topo.map(x,y,1))>diffthres || topo.map(x,y,1)>triggerval*0.5
                    topo.map(x,y,1) = return_averaged(matrix);
                end
            end
        end
    end
    topo.name = strcat(topo.name,'_gradfilter');
    img_obj_viewer_test(topo)
end


%% average everything

averagingtimes = 0;
averagingwindow = 130;
if averagingtimes>0
    for i=1:averagingtimes
        topotemp = topo;
        for x=1:nx
            for y=1:ny
                xmin = max(1,x-windowradius);
                xmax = min(nx,x+windowradius);
                ymin = max(1,y-windowradius);
                ymax = min(ny,y+windowradius);

                matrix = topotemp.map(xmin:xmax,ymin:ymax,1);
                topo.map(x,y,1) = return_averaged(matrix);
            end
        end
    end
    topo.name = strcat(topo.name,'_average');
    img_obj_viewer_test(topo)
end

% diff.map = topo.map-topotemp.map;
% img_obj_viewer_test(diff)

% topo.map = blur(topo.map,100,30);
% topo.name = strcat('_modefiltersize_',num2str(windowradius));




function mode = return_mode(matrix)
[nx,ny]=size(matrix);
[freq,val] = hist(reshape(matrix,nx*ny,1),100);
[~,index] = max(freq);
mode = val(index);
end

function av = return_averaged(matrix)
[nx,ny]=size(matrix);
N = nx*ny;
val = sum(sum(matrix));
av = val/N;
end