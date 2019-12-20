function int_val = int_circ(mat,i0,j0,ic,jc,thresh)
%function to integrate a marix around a circle
%Input: mat is the matrix
%       i0 and j0 are indices of center. 
%       ic,jc are are indices of a point on circumference
%       thresh is threshold above/below (set in code) which pixels should be added

r = floor(sqrt((ic-i0)^2+(jc-j0)^2))
int_val = 0;
for i = i0-r:i0+r
    for j=j0-r:j0+r
        if sqrt((i-i0)^2+(j-j0)^2)<r && i<size(mat,1) && j<size(mat,2) && i > 0 && j > 0
            if mat(i,j)>thresh
                int_val = int_val + mat(i,j);
            end
        end
    end
end

end