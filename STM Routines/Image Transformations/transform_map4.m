%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION: The function takes as input a data map and four points, 
% the first two as pretranforms of the second two.  It then generates a 
% transformation matrix that defines the transformation from the first 
% set of points to the second set.  The transformation matrix is then 
% applied to the data map.  Such as tranformation is a composition of
% rotations, shears, expansions. 
%
% ALGORITHM: Finding the transformation matrix follows from taking the
% set of equations given by  
% T*(p,q)=(x,y) and T*(r,s)=(w,z) where T = [a b; c d] is unknown 
% and rewriting them to solve for a,b,c,d which gives
% [ p q 0 0 ] [a] = [x]
% [ 0 0 p q ] [b]   [y]
% [ r s 0 0 ] [c]   [w]
% [ 0 0 r s ] [d]   [z]
%
% It is then a simple matrix inversion to solve for a,b,c,d.
% The actual image manipulation is done using the image processing toolgox
% and 'imtransform'
%
% CODE HISTORY
%
% 080131 MHH Created
% 
function transform = transform_map4(data,varargin)

% if isstruct(data) % check if data is a full data structure
%     [nr,nc,nz]=size(data.map);
%     energy = 1;
%     A = get_points2(data.map(:,:,energy),data.r,2,'jet');
% else % single data image
%     [nr,nc,nz] = size(data);
%     energy = 1;
%     A = get_points2(data(:,:,energy),data.r,2,'jet');
% end

%energy = 1;
%A = get_points2(data.map(:,:,energy),data.r,2,'jet');
A = [1.931 -2.009; 2.183 1.989];

%Use the mean location of the observed crystal lattice points to stretch
%image onto a square
mean_x = (abs(A(1,1)) + abs(A(1,2)))/2;
mean_y = (abs(A(2,1)) + abs(A(2,2)))/2;

meanv = (mean_x + mean_y)/2;
% vector of final position for atomic points to get stretched onto.
A0(1) = meanv ;A0(2) = meanv;
B0(1) = -meanv; B0(2) = meanv;

%A0(1) = 1.5; A0(2) = 1.5;
%B0(1) = -1.5; B0(2) = 1.5;

transform = data;

M = [A(1,1) A(2,1)    0     0
       0      0    A(1,1) A(2,1) 
     A(1,2) A(2,2)    0     0
       0      0    A(1,2) A(2,2)];
   
   
b = [A0(1); A0(2); B0(1); B0(2)];

X = inv(M)*b;

xform2 = [X(1)   X(2)   0
          X(3)   X(4)   0
           0      0     1];
 %det(xform2);
     
gtform = maketform('affine',xform2');
transform.map = imtransform(data.map, gtform,'bicubic',... 
                        'UData',[data.r(1) data.r(end)],...
                        'VData', [data.r(1) data.r(end)],...
                        'XData',[data.r(1) data.r(end)],...
                        'YData', [data.r(1) data.r(end)],...
                        'size', size(data.map));          
[xm,ym] = tformfwd(gtform, [A(1,1) A(1,2)], [A(2,1) A(2,2)])

end