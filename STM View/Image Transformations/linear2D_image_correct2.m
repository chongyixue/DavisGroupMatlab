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
% INPUTS: p1 and p2 are the positions of the Bragg peaks given in indices. 
%         Data can be a STM structure or just and image.  In case where it 
%         is only an image then varargin sets the coordinates.  Otherwise, 
%         the data structure provides the information.
%
% CODE HISTORY
%
% 080131 MHH Created
% 101016 MHH Modified to work with STM_View
% 131202 MHH Modified to accept pixel values for Bragg peaks, not
%        coordinates values
% 140915 AK This version is reverted to work with coordinate values
% 
function transform = linear2D_image_correct2(p1,p2,data,varargin)
% 
% p1
% p2
% hello = 5
if isstruct(data) % check if data is a full data structure
 
    img = data.map;
    coord = data.r;
    if isfield(data,'coord_type')
        c_t = data.coord_type;
    else
        c_t = [];
    end
else % single data image  
    img = data;
    coord = varargin{1};
    c_t = [];
end
[nr nc nz] = size(img);
%if applying transformation to real space data need find k-space
%coordinates since those are the coordinates which define the shearing
if ~isempty(c_t)
    if c_t == 'r'
        %         k0 = 2*pi/(nr*abs(coord(1) - coord(2)));
        %         k = linspace(0,k0*nc/2,nc/2+1);
        %         k = [-1*k(end:-1:1) k(2:end-1)];
        k0 = pi/(abs(data.r(1) - data.r(2)));
        switch mod(nr,2)
            case 0
                k = linspace(0,k0,nc/2+1);
                k = [-1*k(end:-1:1) k(2:end-1)];
            case 1
                k=linspace(-k0,k0,nc);
        end
        coord = k;
    end
end

% pt1(1) = coord(p1(1)); pt1(2) = coord(p1(2));
% pt2(1) = coord(p2(1)); pt2(2) = coord(p2(2));

A = [p1(1) p1(2); p2(1) p2(2)];

%Use the mean location of the observed Bragg peak to stretch
%image onto a square
mean_x = (abs(A(1,1)) + abs(A(2,1)))/2;
mean_y = (abs(A(1,2)) + abs(A(2,2)))/2;

meanv = (mean_x + mean_y)/2;
% vector of final position for input points to get stretched onto.
A0(1) = sign(A(1,1))*meanv ;A0(2) = sign(A(1,2))*meanv;
B0(1) = sign(A(2,1))*meanv; B0(2) = sign(A(2,2))*meanv;

M = [A(1,1) A(1,2)    0     0
       0      0    A(1,1) A(1,2) 
     A(2,1) A(2,2)    0     0
       0      0    A(2,1) A(2,2)];
   
   
b = [A0(1); A0(2); B0(1); B0(2)];

X = M\b;

%if applying transformation to real space data need to switch x,y


xform2 = [X(1)   X(2)   0
          X(3)   X(4)   0
           0      0     1];
% if working on real space image nead to adjust for origin
if ~isempty(c_t)
    if c_t == 'r'
        for k = 1:nz
            tmp = squeeze(img(:,:,k));
            img(:,:,k) = flipud(tmp');
        end
        coord = data.r;
    end
end              
size(img)
nz
gtform = maketform('projective',xform2');
transform = imtransform(img, gtform,'linear',... 
                        'UData',[coord(1) coord(end)],...
                        'VData', [coord(1) coord(end)],...
                        'XData',[coord(1) coord(end)],...
                        'YData', [coord(1) coord(end)],...
                        'size', size(img));     
                    size(transform)
[xm,ym] = tformfwd(gtform, [A(1,1) A(2,1)], [A(1,2) A(2,2)])
if ~isempty(c_t)
    if c_t == 'r'
        for k = 1:nz
            tmp = squeeze(transform(:,:,k));
            transform(:,:,k) = flipud(tmp)'; 
        end
    end
end         

end