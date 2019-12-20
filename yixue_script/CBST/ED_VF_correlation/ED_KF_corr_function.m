% from peter analysis 50416a00 and 50223 
% save each llmap as llmap_50416 and llmap_50223
% yxc 2019-10-2

% first load the data from peter analysis
% index 4 is 0th LL

function [llmapshow,Del,VF_lower,VF_higher,Ed] = ED_KF_corr_function(llmap,map,zeroLLnumber,method,varargin)
if nargin>4 
    plott = 1;
    if isstring(varargin{1})
        name = varargin{1};
    else
        name = map.name(1:5);
    end 
else
    name = map.name(1:5);
    plott = 0;
end
% [~,~,lay]=size(map.map);


[~,~,ll] = size(llmap);

if zeroLLnumber>2 
    En2 = llmap(:,:,zeroLLnumber-2);
end
En = llmap(:,:,zeroLLnumber-1);
E0 = llmap(:,:,zeroLLnumber);
E1 = llmap(:,:,zeroLLnumber+1);
if ll>3
E2 = llmap(:,:,zeroLLnumber+2);
end

llmapshow = map;
llmapshow.name = 'llmap';
% llmapshow.map(:,:,1:ll)=llmap;
llmapshow.map=llmap;
llmapshow.e = linspace(-zeroLLnumber+1,ll-zeroLLnumber,ll)./1000;

[~,~,lay] = size(llmapshow.map);
for j=1:lay
    llmapshow.map(:,:,j) = sequencedpeakremoval(llmapshow.map(:,:,j),50,30,10,10);
end

if plott == 1
    img_obj_viewer_test(llmapshow)
end

if method == 1 
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
    map.name = strcat('ED_pos',name);
    if plott == 1
        img_obj_viewer_test(map);
    end
%     mean(mean(ED))
    Ed=map;
    
    map.map(:,:,1)=VH;
    map.name = strcat('VH_pos',name);
    if plott == 1
        img_obj_viewer_test(map);
    end
%     mean(mean(VH))
    VF_higher = map;
    
    map.map(:,:,1)=VL;
    map.name = strcat('VL_pos',name);
    if plott==1
        img_obj_viewer_test(map);
    end
%     mean(mean(VL))
    VF_lower = map;
    
    map.map(:,:,1)=Del;
    map.name = strcat('Del_pos',name);
    if plott == 1
        img_obj_viewer_test(map);
    end
    %     mean(mean(Del))
    Del = map;
    
elseif method == -1
    %% using LL -2,-1,0,1 to find 2 different VF,Ed,Del
    num = (E0.^2+En2.^2-2*En.^2);
    dem = 2*(E0+En2-2*En);
    ED = num./dem;
    Del = E0-ED;
    VH = abs(sqrt((E1-ED).^2-Del.^2));
    VL = abs(sqrt((ED-En).^2-Del.^2));
    V_avg=0.5*(VH+VL);
    
    
    % map = obj_50223A00_G;
    map.map=ED;
    map.name = strcat('ED_neg',name);
    if plott == 1
        img_obj_viewer_test(map);
    end
    %     mean(mean(ED))
    Ed = map;
    
    map.map(:,:,1)=VH;
    map.name = strcat('VH_neg',name);
    if plott == 1
        img_obj_viewer_test(map);
    end
%     mean(mean(VH))
    VF_higher=map;
    
    map.map(:,:,1)=VL;
    map.name = strcat('VL_neg',name);
    if plott ==1
        img_obj_viewer_test(map);
    end
%     mean(mean(VL))
    VF_lower = map;
    
    map.map(:,:,1)=V_avg;
    map.name = strcat('V_avg_neg',name);
    if plott == 1
        img_obj_viewer_test(map);
    end
%     mean(mean(V_avg))
    
    
    map.map(:,:,1)=Del;
    map.name = strcat('Del_neg',name);
    if plott==1
        img_obj_viewer_test(map);
    end
    %     mean(mean(Del))
    Del = map;
    
else
    %% using LL -1,0,1 to find a single VF, Ed, Del
    ED = 0.5*(E1+En);
    Del = E0-ED;
    V = abs(sqrt((E1-ED).^2-Del.^2));
    
    map.map=ED;
    map.e = 0;
    map.name = strcat('ED_singleVF',name);
    if plott == 1
        img_obj_viewer_test(map);
    end
%     mean(mean(ED))
    Ed = map;
    
    map.map(:,:,1)=Del;
    map.name = strcat('Del_singleVF',name);
    if plott == 1
        img_obj_viewer_test(map);
    end
%     mean(mean(Del))
    Del = map;
    
    map.map(:,:,1)=V;
    map.name = strcat('V_singleVF',name);
    if plott==1
        img_obj_viewer_test(map);
    end
%     mean(mean(V))
    VF_higher = map;
    VF_lower = map;
end



Del.name = strcat(Del.name,name);
Ed.name = strcat(Ed.name,name);
VF_higher.name = strcat(VF_higher.name,name);
VF_lower.name = strcat(VF_lower.name,name);





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

end
