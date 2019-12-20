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
function transform = transform_map3(data)

energy = 16;
A = get_points2(data.map(:,:,energy),data.r,2,'jet');
%A = get_points2(gcf,2);
%A = [1.976 -2.028; 2.124 2.098]; 090317
%A = [2.003 -1.920; 2.107 2.080]; %090227/2.5deg
%A = [2.702 -2.807; 2.974 2.869]; % 090411
%A = [2.050 -2.005; 2.028 2.073];
%A = [2.448 -2.433; 2.550 2.556]; %090417/1.0deg
%A = [ 2.573 -2.674; 2.732 2.715]; %090425/0.75deg/block_sym
%A = [2.218 -2.232; 2.337 2.337]; %090430/0.5deg
%A = [2.657 -2.573; 2.766 2.782]; %090510/1.5deg
%A = [2.790 -2.773; 2.953 2.953]; %090512/1deg

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