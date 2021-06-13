% 2020-4-14 YXC 
% incrementally explore functionalities for a gui to register atoms and
% shift to same FOV

%% load some data and call map1 and map2
map1 = map0_LFCorrect;
map2 = map5p_LFCorrect;

map1 = croptopo(map1,5,390,5,390);
map2 = croptopo(map2,5,390,5,390);

%% explore plotting lines on top of topo/cond image

% figure,imagesc(map1.map);
% hold on
% plot([-30,540],[-3,540],'r');
% axis off
% plot([-40,500],[-3,500],'r');

%% explore MATLAB FTspace and real space

% testmap = simulate_lattice_with_k(10,1);
% img_obj_viewer_test(testmap)

% x = linspace(0,100,1000);
% y = sin(x);
% figure,plot(x,y);
% ylim([-2,2])
% 
% k = fft(x);
% figure,plot(k)


%% explore transforming Bragg peak into lines in real space

% img_obj_viewer_test(map1)


% [nx,~,~] = size(map1.map);
% centerpx = floor(nx/2+1);
% % Bragg = [199,138];
% 
% % Bragg = [206,142]; 
% 
Bragg = [199,137];%after crop
Bragg2 = [250,173];
Bragg3 = [245,229];



combinepairsmap1=plotgrids(map1,Bragg,Bragg2,Bragg3);
title('map1')
% combinepairsmap2=plotgrids(map2,Bragg,Bragg2,Bragg3);
% title('map2')
% plotgridtomap(map2,combinepairs);
% title('map2 grid1')
plotmultiplegridstomap(map2,combinepairsmap1,'r',combinepairsmap2,'k')
title('map2')
%% explore Bragg displacement
% % map3 = simulate_lattice_with_k(20,1,1,20);
% 
% n = 77;
% xstart = 7;
% ystart = 3;
% 
% 
% 
% for i=1:6
%     if i~=1
%         ystart = ystart+2;
%     end    
%     map4=croptopo(map3,xstart,xstart+n,ystart,ystart+n);
%     % img_obj_viewer_test(map4);
%     
%     if i==1
%         ftmap = fourier_transform2d(map4,'sine','amplitude','ft');
%         [~,bx] = max(max(ftmap.map));
%         [~,by] = max(max(ftmap.map'));
%         
%         
%         if abs(bx-n/2)<abs(by-n/2)
%             dir = 'vertical';
%         else
%             dir = 'horizontal';
%         end
%         
%     end
%     Bragg = [bx,by];
%     % Bragg = [50,41];
%     [Bragg,phase] = subpixelBragg(map4,Bragg(1),Bragg(2));
%     
% % FTmap2 = fourier_transform2d(map4,'sine','phase','ft');
% % phase = pixel_val_interp(FTmap2.map,by,bx);
% 
%     figure,imagesc(map4.map);
%     title([dir,' phase=',num2str(phase/(2*pi)),' a_0']);
% %     title([dir,' phase=',num2str(phase)]);
%     
%     
% end




%% functions

function plotmultiplegridstomap(map,varargin)
figure,imagesc(map.map);
hold on
for i=1:round((nargin-1)/2)
    col = varargin{i*2};
    pairs = varargin{i*2-1};
    [npairs,~,~]=size(pairs);
    for j=1:npairs
        x = squeeze(pairs(j,:,1));
        y = squeeze(pairs(j,:,2));
        plot(x,y,col);
    end
end



end

function plotgridtomap(map,pairs)
figure,imagesc(map.map);
hold on
[npairs,~,~]=size(pairs);
for j=1:npairs
    x = squeeze(pairs(j,:,1));
    y = squeeze(pairs(j,:,2));
    plot(x,y,'r');
end

end


function combinepairs = plotgrids(map,varargin)
totalpairs = 0;
figure,imagesc(map.map)
hold on
for i=1:nargin-1
    Bragg = varargin{i};
    pairs = FOVpairs(Bragg(1),Bragg(2),map);
    [npairs,~,~]=size(pairs);
    combine{i} = pairs;
    for j=1:npairs
        x = squeeze(pairs(j,:,1));
        y = squeeze(pairs(j,:,2));
        plot(x,y,'r');
    end
    totalpairs = npairs+totalpairs;
end
combinepairs = zeros(totalpairs,2,2);
pointer = 1;
for k=1:nargin-1
    pairs = combine{k};
    [npairs,~,~]=size(pairs);
    combinepairs(pointer:pointer-1+npairs,:,:) = pairs;
    pointer = pointer+npairs;
end



end


% given Braggpeak, and map
function pairs = FOVpairs(Braggx,Braggy,map,varargin)

%% improvement: varargin to shift grid


%% the rest

    

[Bragg,phase] = subpixelBragg(map,Braggx,Braggy);

[nx,~,~]=size(map.map);
centerpx = floor(nx/2+1);
dky = Bragg(2)-centerpx;
dkx = Bragg(1)-centerpx;

gradient = -dkx/dky; %kspace to real space, inverse gradient
%     dist = nx/sqrt(dkx^2+dky^2);


if gradient ~= 1/0    
    atomx = 1;
    yspace = nx/abs(dky);
    atomy = yspace*((phase)/(2*pi));

    estimate = round(nx/yspace)-3;
    
    % pairnumber,x,y
    pairs = zeros(estimate+5,2,2);
    
    if gradient > 0
        intercept = atomy-gradient*atomx+(estimate+5)*yspace; % pedagogical
        addorsub = -1;

    else
        intercept = atomy-gradient*atomx;
        addorsub = +1;       
    end
    
    stop = 0;
    count = 0;
    while stop == 0
        [in_or_not,x,y]=boundarypoints(gradient,intercept,nx);
        if in_or_not == 1
            count = count+1;
            pairs(count,1,1)=x(1);
            pairs(count,1,2)=y(1);
            pairs(count,2,1)=x(2);
            pairs(count,2,2)=y(2);
        end
        
        if count>estimate && in_or_not == 0
            stop = 1;
            pairs(count+1:end,:,:)=[];
        end
        intercept = intercept + addorsub*yspace;
    end
    
else
    xspace = nx/abs(dkx);
    lo = 0.5;
    hi = nx+0.5;
    
    atomx = xspace*((phase)/(2*pi));
    estimate = round(nx/yspace)-3;
    pairs = zeros(estimate+5,2,2);
    if atomx<0
        atomx = atomx+xspace;
    end
    count = 0;
    stop = 0;
    while stop == 0
        count = count+1;
        if atomx>xspace
            stop =1;
            pairs(count:end,:,:)=[];
        else        
            pairs(count,1,1)=atomx;
            pairs(count,1,2)=lo;
            pairs(count,2,1)=atomx;
            pairs(count,2,2)=hi;
        end
        atomx = atomx + xspace;

    end



end

end

% given gradient and intercept, and nx for imagesc, return edge coordinate
% pairs
function [in_or_not,x,y]=boundarypoints(gradient,intercept,pixsize)

lo = 0.5;
hi = pixsize+0.5; %translate boundaries from imagesc


in_or_not=1;

left_intercept = polyval([gradient,intercept],lo);
right_intercept = polyval([gradient,intercept],hi);

%% draw two vertical walls on the box sides, consider those lines.
if left_intercept>hi 
    if right_intercept>hi 
        in_or_not = 0;
    elseif right_intercept>lo
        x = [hi,(hi-intercept)/gradient];
        y = [right_intercept,hi];
    else
        x = [(hi-intercept)/gradient,(lo-intercept)/gradient];
        y = [hi,lo];
    end
elseif left_intercept<lo
    if right_intercept<lo
       in_or_not = 0;
    elseif right_intercept<hi
        x = [(lo-intercept)/gradient,hi];
        y = [lo,right_intercept];
    else
        x = [(hi-intercept)/gradient,(lo-intercept)/gradient];
        y = [hi,lo];
    end
else
    if right_intercept>hi
        x = [lo,(hi-intercept)/gradient];
        y = [left_intercept,hi];
    elseif right_intercept<lo
        x = [lo,(lo-intercept)/gradient];
        y = [left_intercept,lo];
    else
        x = [lo,hi];
        y = [left_intercept,right_intercept];
    end
end

if in_or_not==0
    x = [0,0];
    y = [0,0];
end

end
    



% go to the vicinity of the bragg peak and vicinity and weighted average
function [newBragg,phase] = subpixelBragg(map,x,y)
window = 5;

%% first do background sub and FT 
mapsub = polyn_subtract(map,0,3); %dependency
FTmap = fourier_transform2d(mapsub,'sine','amplitude','ft');
[nx,~,~] = size(mapsub.map);

%% mask and do weighted average (find center of mass)
mask = zeros(nx,nx);
mask(y-window:y+window,x-window:x+window)=FTmap.map(y-window:y+window,x-window:x+window);
[X,Y] = meshgrid(linspace(1,nx,nx),linspace(1,nx,nx));
M = sum(sum(mask));
Braggx = sum(sum(mask.*X))/M;
Braggy = sum(sum(mask.*Y))/M;
newBragg = [Braggx,Braggy];

%% get phase of Bragg peak
FTmap2 = fourier_transform2d(mapsub,'sine','phase','ft');
% phase = pixel_val_interp(FTmap2.map,Braggx,Braggy);
phase = FTmap2.map(round(Braggy),round(Braggx));
% the real and imaginary part oscillate wildly, not a good idea to
% interpolate
end


    function newtopo=croptopo(data,x1,x2,y1,y2)

%         [nr nc nz] = size(data.map);
        img = data.map;
        

        new_img = crop_img(img,y1,y2,x1,x2);
        

            new_data = data;
            new_data.map = new_img;
            new_data.ave = squeeze(mean(mean(new_img)));
            new_data.r = data.r(1:(x2-x1)+1);
            new_data.var = [new_data.var '_crop'];
            new_data.ops{end+1} = ['Crop:' num2str(x1) ' ,' num2str(y1) ':' num2str(x2) ' ,' num2str(y2)];
%             img_obj_viewer_test(new_data);
        newtopo = new_data;
        
    end
