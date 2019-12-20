%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION: 
%
% ALGORITHM: 
%
% CODE HISTORY
%
% 080631 MHH Created
% 
function cut = linecut3(data,pos1,pos2,avg_px)
%avg_px = 2;
[nr,nc,nz] = size(data.map);
A = [pos1(1) pos2(1)
     pos1(2) pos2(2)];
%A  = floor(get_points(data.map(:,:,20),data.r,2,'jet'))
%slope of line
%A = [129  250
%     129  250];
 
%A =  [65 65
%      65 120];
%A = [129  129
%     129  200];

dx = A(1,2) - A(1,1);
dy = A(2,2) - A(2,1);

if dx == 0
    xstep = 0;
    ystep = 1;
else
    ystep = dy/dx;
    xstep = 1;
end

% for i=1:abs(A(1,1) - A(1,2))
% pos = A(:,1) + (i-1)*[xstep;ystep];
% d1 = shortest_dist(A(:,1),A(:,2),floor(pos));
% d2 = shortest_dist(A(:,1),A(:,2),ceil(pos));
% %calculate weight for the average
%     if (d1 == d2)
%         w1 = 0.5;
%         w2 = 0.5;
%     else
%         w1 = 1 - d1/(d1+d2);
%         w2 = 1 - d2/(d1+d2);
%     end
% 
%     cut(i,:) = w1*data.map(pos(1),floor(pos(2)),:) + w2*data.map(pos(1),ceil(pos(2)),:);
% end
cut = zeros(max(abs(dx),abs(dy)),nz);

for i=1:max(abs(dx),abs(dy))
    pos = A(:,1) + (i-1)*[xstep;ystep];
    d1 = shortest_dist(A(:,1),A(:,2),floor(pos));
    d2 = shortest_dist(A(:,1),A(:,2),ceil(pos));
    %calculate weight for the average
    if (d1 == d2)
        w1 = 0.5;
        w2 = 0.5;
    else
        w1 = 1 - d1/(d1+d2);
        w2 = 1 - d2/(d1+d2);
    end
    cut(i,:) = w1*data.map(pos(1),floor(pos(2)),:) + w2*data.map(pos(1),ceil(pos(2)),:);
    
    for j=1:(avg_px)
        k = 2*j - 1;
        avg_pts(:,k) = pos + k*[-ystep;xstep];
        avg_pts(:,k+1) = pos + (-k)*[-ystep;xstep];
    end
    for j=1:(avg_px)
         
        lat_pts1 = squeeze(squeeze(data.map(floor(avg_pts(1,2*j-1)),floor(avg_pts(2,2*j-1)),:)...
                         + data.map(ceil(avg_pts(1,2*j-1)),ceil(avg_pts(2,2*j-1)),:)...
                         + data.map(floor(avg_pts(1,2*j-1)),ceil(avg_pts(2,2*j-1)),:)...
                         + data.map(ceil(avg_pts(1,2*j-1)),floor(avg_pts(2,2*j-1)),:)))/4;
        
        lat_pts2 = squeeze(squeeze(data.map(floor(avg_pts(1,2*j)),floor(avg_pts(2,2*j)),:)...
                         + data.map(ceil(avg_pts(1,2*j)),ceil(avg_pts(2,2*j)),:)...
                         + data.map(floor(avg_pts(1,2*j)),ceil(avg_pts(2,2*j)),:)...
                         + data.map(ceil(avg_pts(1,2*j)),floor(avg_pts(2,2*j)),:)))/4;
                     
        cut(i,:) = cut(i,:) + lat_pts1' + lat_pts2';
    end
    cut(i,:) = cut(i,:)/(2*avg_px + 1);
end
    
end

