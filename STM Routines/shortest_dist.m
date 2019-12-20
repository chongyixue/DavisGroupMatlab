%%%%%%%
% CODE DESCRIPTION: Finds the shortest distance between a line defined by
% the vectors Y1 and Y2, and the point X.  The solving method is
% accomplished by solving for the intersection of the two lines, one
% directed by r and the other by rperp.  The distance between the point of
% intersection and the point X gives the desired shortest distance.
%
%S is the vector containing the two parametrization scalars, one for the r
%line and the other for the rperp line.  This is the value solve for in
%the algorithm.
%
%INPUTS: All inputs are given in column vector form
%   
% CODE HISTORY
%
% 080418 MHH Created
% 

function distance = shortest_dist(Y1,Y2,X)
    if Y1 == Y2
        distance = nan;
        return; %line not uniquely determined
    end
    % vector direction between two points
    r = [Y2(1) - Y1(1); Y2(2) - Y1(2)];     
    rperp = [Y2(2) - Y1(2), -Y2(1) + Y1(1)]; % perpendicular vector
    
    %solve for the intersection of the two lines    
    C = X - Y1;
    R = [ r(1) -rperp(1)
          r(2) -rperp(2)];    
    S = inv(R)*C;
    Xint = r*S(1) + Y1;
    distance = norm(Xint - X);
end
    