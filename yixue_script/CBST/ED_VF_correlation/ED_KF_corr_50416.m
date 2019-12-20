% from peter analysis 50416a00 
% yxc 2019-10-2

% first load the data from peter analysis
% index 4 is 0th LL

smoothenmap = obj_50416A00_G;
map = obj_50416A00_G;
[~,~,lay]=size(smoothenmap.map);
for j=1:lay
   smoothenmap.map(:,:,j)=sequencedpeakremoval(obj_50416A00_G.map(:,:,j),5,5,4,4,4,3,3,3,2,2,1,1,1,0.5,0.5);
end
img_obj_viewer_test(smoothenmap)

[pix,~,ll] = size(llmap);

% for i = 1:ll
%    llmap(:,:,i) = sequencedpeakremoval(llmap(:,:,i),100,80,50,40,40,30,20,10,10,5); 
% end


En2 = llmap(:,:,2);
En = llmap(:,:,3);
E0 = llmap(:,:,4);
E1 = llmap(:,:,5);
E2 = llmap(:,:,6);


llmapshow = obj_50416A00_G;
llmapshow.name = 'llmap';
% llmapshow.map(:,:,1:ll)=llmap;
llmapshow.map=llmap;
llmapshow.e = linspace(-3,ll-4,ll)./1000;
img_obj_viewer_test(llmapshow)


%% using LL -1,0,1,2 to find 2 different VF,Ed,Del
num = (E0.^2+E2.^2-2*E1.^2);
dem = 2*(E0+E2-2*E1);
ED = num./dem;
VH = abs(sqrt(0.5*(E2.^2-E0.^2+2*ED.*(E0-E2))));
Del = E0-ED;
VL = abs(sqrt((ED-En).^2-Del.^2));

% Del = sequencedpeakremoval(Del,50,40,30);
% ED = sequencedpeakremoval(ED,50,40,30);
% VH = sequencedpeakremoval(VH,50,40,30);
% VL = sequencedpeakremoval(VL,50,40,30);


% map.map(:,:,1)=ED;
map.map = ED;
map.e=0;
map.name = 'ED_pos';
img_obj_viewer_test(map);
mean(mean(ED))

map.map(:,:,1)=VH;
map.name = 'VH_pos';
img_obj_viewer_test(map);
mean(mean(VH))

map.map(:,:,1)=VL;
map.name = 'VL_pos';
img_obj_viewer_test(map);
mean(mean(VL))
map.map(:,:,1)=Del;
map.name = 'Del_pos';
img_obj_viewer_test(map);
mean(mean(Del))

% %% using LL -2,-1,0,1 to find 2 different VF,Ed,Del
% num = (E0.^2+En2.^2-2*En.^2);
% dem = 2*(E0+En2-2*En);
% ED = num./dem;
% Del = E0-ED;
% VH = abs(sqrt((E1-ED).^2-Del.^2));
% VL = abs(sqrt((ED-En).^2-Del.^2));
% V_avg=0.5*(VH+VL);
% 
% 
% % map = obj_50223A00_G;
% map.map(:,:,1)=ED;
% map.name = 'ED_neg';
% img_obj_viewer_test(map);
% mean(mean(ED))
% 
% map.map(:,:,1)=VH;
% map.name = 'VH_neg';
% img_obj_viewer_test(map);
% mean(mean(VH))
% 
% map.map(:,:,1)=VL;
% map.name = 'VL_neg';
% img_obj_viewer_test(map);
% mean(mean(VL))
% 
% map.map(:,:,1)=V_avg;
% map.name = 'V_avg_neg';
% img_obj_viewer_test(map);
% mean(mean(V_avg))
% 
% 
% map.map(:,:,1)=Del;
% map.name = 'Del_neg';
% img_obj_viewer_test(map);
% mean(mean(Del))
% 
% 
% 
% %% using LL -1,0,1 to find a single VF, Ed, Del
% ED = 0.5*(E1+En);
% Del = E0-ED;
% V = abs(sqrt((E1-ED).^2-Del.^2));
% V = abs(sqrt((En-ED).^2-Del.^2));
% 
% % map = obj_50223A00_G;
% map.map(:,:,1)=ED;
% map.name = 'ED_singleVF';
% img_obj_viewer_test(map);
% mean(mean(ED))
% 
% map.map(:,:,1)=Del;
% map.name = 'Del_singleVF';
% img_obj_viewer_test(map);
% mean(mean(Del))
% 
% map.map(:,:,1)=V;
% map.name = 'V_singleVF';
% img_obj_viewer_test(map);
% mean(mean(V))


function refined = sequencedpeakremoval(matrix,varargin)
refined = matrix;
for i = 1:length(varargin)
    refined = removepeaks(refined,varargin{i});
end
end

function refined = removepeaks(matrix,magnitude_diff,varargin)
[nx,ny] = size(matrix);

filter = showpeaks(matrix,magnitude_diff);

% [index_x,index_y] = extractindex(filter);
% refined(index_x,index_y) = neighboraverge(matrix,index_x,index_y);

neighborratio = zeros(nx,ny)+3;
neighborratio(2:end-1,2:end-1) = 4;
neighborratio(1,1) = 2;
neighborratio(1,end) = 2;
neighborratio(end,1) = 2;
neighborratio(end,end) = 2;

up = zeros(nx+2,ny+2);
down = up; left = down; right = left;
ref = up;

ref(2:end-1,2:end-1) = filter;
up(1:end-2,2:end-1) = matrix;
down(3:end,2:end-1) = matrix;
right(2:end-1,3:end) = matrix;
left(2:end-1,1:end-2) = matrix;

refined = (up+down+right+left).*ref;
refined = refined(2:end-1,2:end-1);
refined = refined./neighborratio;

refined = refined.*filter + matrix.*(1-filter);



if nargin>2
    iteration = varargin{1};
    if iteration>2
        refined = removepeaks(matrix,magnitude_diff,iteration-1);
    else
        refined = removepeaks(matrix,magnitude_diff);
    end
end
end


 
function refined = showpeaks(matrix,magnitude_diff)
%refined defines the locations of "peaks or troughs"

mag = magnitude_diff^2;
matrix2 = matrix - mean(mean(matrix));

[nx,ny] = size(matrix2);
reference = zeros(nx+2,ny+2);
ref1 = reference;
ref1(2:end-1,2:end-1) = matrix2;
refleft = reference;
refleft(2:end-1,1:end-2) = matrix2;
refright = reference;
refright(2:end-1,3:end) = matrix2;
refup  = reference;
refup(1:end-2,2:end-1)=matrix2;
refdown = reference;
refdown(3:end,2:end-1) = matrix2;

refleft = ref1-refleft;
refright = ref1-refright;
refup = ref1-refup;
refdown = ref1-refdown;

refined = (refleft+refright).*(refup+refdown)./4;
refined = abs(refined(2:end-1,2:end-1));
refined = refined > mag;

end

function [xlist,ylist] = neighbors(matrix,x,y)

[nx,ny] = size(matrix);
if and(x~=1,x~=nx)
    xlist = [x-1,x+1];
else
    xlist = [mod(x+1,nx)];
    if xlist == 1
        xlist = nx-1;
    end
end

if and(y~=1,y~=ny)
    ylist = [y-1,y+1];
else
    ylist = [mod(y+1,ny)];
    if ylist == 1
        ylist = ny-1;
    end
end

end

function value = neighboraverage(matrix,x,y)

[xlist,ylist] = neighbors(matrix,x,y);
sum = 0;
for i = 1:length(xlist)
    sum = sum+matrix(xlist(i),y);
end
for i = 1:length(ylist)
    sum = sum + matrix(x,ylist(i));
end
value = sum/(length(xlist)+length(ylist));
end


