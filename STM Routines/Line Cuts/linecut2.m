%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION: 
%
% ALGORITHM: 
%
% CODE HISTORY
%
% 080631 MHH Created
% 
function cut = linecut2(data)

[sx,sy,sz] = size(data.map);

%A  = floor(get_points(data.map(:,:,20),data.r,2,'jet'))
%slope of line
A = [129  200
     255  255];
dx = A(1,2) - A(1,1);
dy = A(2,2) - A(2,1);

if dx == 0
    xstep = 0;
    ystep = 1;
else
    ystep = dy/dx;
    xstep = 1;
end

for i=1:abs(A(1,1) - A(1,2))
    pos = A(:,1) + (i-1)*[xstep;ystep];
    %check to see if over one x pixel corresponds to an integer rise in the
    %y pixel. If so, then the value of the cut is just the equal to value
    %of the map evaluated at those pixels
    if pos(2)/floor(pos(2)) == 1
        cut(i,:) =  data.map(pos(1),pos(2),:);
    %if not, take weighted average of the pixel just above and below the line
    %at the given x pixel and non-integer y pixel.
    else
        d1 = shortest_dist(A(:,1),A(:,2),floor(pos));
        d2 = shortest_dist(A(:,1),A(:,2),ceil(pos));
        %calculate weight for the average
        w1 = 1 - d1/(d1+d2);
        w2 = 1 - d2/(d1+d2);
        cut(i,:) = w1*data.map(pos(1),floor(pos(2)),:) + w2*data.map(pos(1),ceil(pos(2)),:);
    end    
end

