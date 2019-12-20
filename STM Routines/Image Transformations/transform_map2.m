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
function transform = transform_map2(data,A0,B0)

energy = 1;
A = get_points2(data.map(:,:,energy),data.r,2,'jet');
transform = data;
% M = [A1(1) A1(2)    0     0
%        0      0    A1(1) A1(2) 
%      B1(1) B1(2)    0     0
%        0      0    B1(1) B1(2)]

M = [A(1,1) A(2,1)    0     0
       0      0    A(1,1) A(2,1) 
     A(1,2) A(2,2)    0     0
       0      0    A(1,2) A(2,2)];
   
   
b = [A0(1); A0(2); B0(1); B0(2)];

X = inv(M)*b;

xform2 = [X(1)   X(2)   0
          X(3)   X(4)   0
           0      0     1];
%  det(xform2)
%xform = xform2;
     
gtform = maketform('affine',xform2');
transform.map = imtransform(data.map, gtform,... 
                        'UData',[data.r(1) data.r(end)],...
                        'VData', [data.r(1) data.r(end)],...
                        'XData',[data.r(1) data.r(end)],...
                        'YData', [data.r(1) data.r(end)],...
                        'size', size(data.map));
%[xm,ym] = tformfwd(shearing, [A1(1) B1(1)], [A1(2) B1(2)])            
[xm,ym] = tformfwd(gtform, [A(1,1) A(2,1)], [A(1,2) A(2,2)]);          
                    
end