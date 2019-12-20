%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION: 
%
% ALGORITHM: 
%
%INPUT: pos1 = [x1 y1], pos2 = [x2 y2], where the linecut goes from pos1 to
%       pos2.
%
% CODE HISTORY
%
% 080631 MHH Created
% 130418 MHH Modified to properly take arbitrary cuts
% 
function [l_cut,posi] = line_cut_correl(topo,pos1,pos2)

lcut = [];

img=topo;

[nr nc nz] = size(img);

     

A = [pos1(1) pos2(1)
     pos1(2) pos2(2)];
 
dx = A(1,2) - A(1,1);
dy = A(2,2) - A(2,1);
%% Plot topo

img_plot2(img(:,:,1));
hold on;  plot([pos1(1) pos2(1)],[pos1(2) pos2(2)],'r','Linewidth',2);
% coordinate systems has x increase towards right and y increase going down
% So quadrants I - bottom right, II - bottom left, III - top left, IV - top
% right
if dx == 0
    xstep = 0;
    ystep = 1*sign(dy); 
    % sign gives 1 for dy>0, 0 for dy=0, and -1 for dy<0
    step_n = abs(dy);
elseif dy == 0
    xstep = 1*sign(dx);
    ystep = 0;
    step_n = abs(dx);
else
    m = dy/dx;
    if abs(m) <= 1 && m > 0 % first of third quadrant, angle < than 45
        xstep = 1*sign(dx);
        ystep = dy/dx*sign(dx);
        step_n = abs(dx);
    elseif abs(m) > 1 && m > 0 %first and third quadrant, angle > than 45
        ystep = 1*sign(dy);
        xstep = dx/dy*sign(dy);
        step_n = abs(dy);
    elseif abs(m) <=1 && m < 0 %second and forth quadrant, angle < than 45
        xstep = 1*sign(dx);
        ystep = dy/dx*sign(dx);
        step_n = dx;
    elseif abs(m) >1 && m < 0 % second a forth quadrant, angle > than 45
        ystep = 1*sign(dy);
        xstep = dx/dy*sign(dy);
        step_n = abs(dy);
    end
end


cut = zeros(step_n,nz);

for i=1:step_n        
    pos(:,i) = A(:,1) + (i-1)*[xstep;ystep];
    posi(:,i) = round(A(:,1) + (i-1)*[xstep;ystep]);
    
%     d1 = shortest_dist(A(:,1),A(:,2),floor(pos));
%     d2 = shortest_dist(A(:,1),A(:,2),ceil(pos));
%     
%     %calculate weight for the average
%     if (d1 == d2)
%         w1 = 0.5;
%         w2 = 0.5;
%     else
%         w1 = 1 - d1/(d1+d2);
%         w2 = 1 - d2/(d1+d2);
%     end          
    
%     cut(i,:) =  w1*img(floor(pos(2)),floor(pos(1)),:) + w2*img(ceil(pos(2)),ceil(pos(1)),:);
    cut(i,:) =  img(round(pos(2,i)),round(pos(1,i)),:);
    
%     % produce a table of coordinates for used in the trasverse averaging
%     for k=1:(avg_px)               
%         avg_pts1(:,k) = pos + k*[-ystep;xstep] ; % above the linecut      
%         avg_pts2(:,k) = pos + (-k)*[-ystep;xstep]; % below the linecut
%        % hold on; plot([avg_pts1(1,k) avg_pts2(1,k)],[avg_pts1(2,k) avg_pts2(2,k)],'.');        
%     end  
%     % start transverse averaging using interpolation function
%     % pixel_val_interp
%     for j = 1:nz
%         tmp_img = img(:,:,j);
%         for k = 1:avg_px
%             cut(i,j) = cut(i,j) + pixel_val_interp(tmp_img,avg_pts1(1,k),avg_pts1(2,k)) +...
%                 pixel_val_interp(tmp_img,avg_pts2(1,k),avg_pts2(2,k));
%         end
%         cut(i,j) = cut(i,j)/(2*avg_px + 1);
%     end    
%     clear avg_pts1 avg_pts2;
end

if posi(1,i)== A(1,2) && posi(2,i) == A(2,2)
else
    cut(length(cut)+1,:) =  img(A(2,2),A(1,2),:);
    posi(1,length(cut))=A(1,2);
    posi(2,length(cut))=A(2,2);
end
% if isstruct(data)
%     x = data.r;
%     x1 = sqrt(x(pos1(1))^2 + x(pos1(2))^2);
%     x2 = sqrt(x(pos2(1))^2 + x(pos2(2))^2);
%     n = size(cut,1);
%     r = linspace(x1,x2,n);
%     l_cut.cut = cut;
%     l_cut.r = r';
%     l_cut.e = data.e;
% else
%     l_cut = cut;
% end

l_cut = cut;


figure, plot((1:1:length(cut)),cut,'.')
    

end