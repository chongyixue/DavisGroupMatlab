% 2019-6-12 YXC
% from lorentztit_test.m, obtained many matrix fitted data
% now we want to align the landau level to the right location

% 90228a00
% [-3,-2,-1,0,1,2,3,4,5,6,7,8]
% for (x,y) = (1,1):
peakmV_array = [0,0,105,140,180,204,0,0,0];
e_array = [-1,0,1,2]/1000;
background = 2;

map = invert_map(obj_90227A00_G);
ll = fitted_to_viewer(map,llmatrix,background,e_array,'90227a00_llmap_splineminima',peakmV_array);
ll_0 = fitted_to_viewer(map,llmatrix,0,e_array,'90227a00_llmap_no_background',peakmV_array);
ll_1 = fitted_to_viewer(map,llmatrix,1,e_array,'90227a00_llmap_3pointspline',peakmV_array);

% img_obj_viewer_test(ll);
% do the following to see which peak has been plotted, and look at
% img_obj_viewer to see if it has been assigned correctly
% fit_and_plot(map,x,y,background,peakmV_array)

% make sure LL assigned correctly
ll = LL_assign_fix_all(ll,llmatrix,peakmV_array);
ll_0 = LL_assign_fix_all(ll_0,llmatrix,peakmV_array);
ll_1 = LL_assign_fix_all(ll_1,llmatrix,peakmV_array);

% img_obj_viewer_test(ll);
% img_obj_viewer_test(ll_1);
% img_obj_viewer_test(ll_0);
[~,~,nz] = size(ll.map);
llmap_combine = ll;
for lay = 1:nz
    measure = ll.map(:,:,lay) == 0;
    llmap_combine.map(:,:,lay) = (1-measure).*ll.map(:,:,lay) + ll_1.map(:,:,lay).*measure;
    measure = llmap_combine.map(:,:,lay) == 0;
    llmap_combine.map(:,:,lay) = (1-measure).*llmap_combine.map(:,:,lay) + ll_0.map(:,:,lay).*measure;
end
llmap_combine.name = '90227a00_llmap_combined';

img_obj_viewer_test(llmap_combine);





llmap_combine_filtered_90227 = llmap_combine;
llmap_combine_filtered_90227.map = replace_with_neighbors(llmap_combine_filtered_90227.map,2);
% for lay = 1:nz
%     llmap_combine_filtered.map(:,:,lay) = removepeaks(llmap_combine.map(:,:,lay),10);
% end
llmap_combine_filtered_90227.name = 'filtered_90227';
llmap_combine_filtered_90227.method = 5;

img_obj_viewer_test(llmap_combine_filtered_90227);
filtered_peakarray = peakmV_array;
range = 5;
llmap_combine_filtered_90227 = filter_misfits(llmap_combine_filtered_90227,peakmV_array,range);
img_obj_viewer_test(llmap_combine_filtered_90227);


% llmap_reassign = LL_assign_fix(llmap_combine_filtered_90228,llmatrix,230,4,[1,100],[1,100]);
% llmap_reassign.name = 'reassigned';
% % llmap_reassign = LL_assign_fix(llmap_combine_filtered_90228,llmatrix,223,4,[3],[61]);
% % llmap_reassign = LL_assign_fix(ll,llmatrix,223,4,[3],[61]);
% % llmap_reassign = LL_assign_fix(ll,llmatrix,223,4,[1,34],[23,75]);
% img_obj_viewer_test(llmap_reassign);


% 
% % to see one particular point
% x = 3;y=61;backg = 2;
% fit_and_plot(invert_map(obj_90228A00_G),x,y,backg,peakmV_array)


%% functions

function matrix = replace_with_neighbors(matrix_in,threshold)
matrix = matrix_in;
[nx,ny,nz] = size(matrix);
for lay = 1:nz
    for x = 1:nx
        for y = 1:ny
            if matrix(x,y,lay)<threshold
                
                [xlist,ylist]= neighbors(matrix(:,:,1),x,y);
                
                listt = [];
                for j = 1:length(xlist)
                    ref = matrix(xlist(j),y,lay);
                    if ref>threshold
                        listt(length(listt)+1) = ref;
                    end
                end
                for k = 1:length(ylist)
                    ref = matrix(x,ylist(k),lay);
                    if ref>threshold
                        listt(length(listt)+1) = ref;
                    end
                end
              
                mean(listt);
                matrix(x,y,lay)=mean(listt);
            end
        end
    end
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



% %find coordinate that uses all 12 spots
% maxindex = 5;
% count = 0;
% xx = 1;
% yy = 1;
% for method = 1:3
%     for x = 1:100
%         for y = 1:100
%             index = 1;
%             for i = 3:12
%                 if llmatrix(method,x,y,i)>0
%                     index = i;
%                     i = i+12;
%                 end
%             end
%             if index>maxindex
%                 maxindex = index;
%                 xx = x;
%                 yy = y;
%                 methodbackground = method;
%             end
%         end
%     end
% end
% % many-point spline background,xx=5,yy=18 


