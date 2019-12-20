%%
tol = 0.2;
new_gap = zeros(200,200);
for i=1:200
    for j= 1:200
        new_gap(i,j) = gap1(i,j);
        if (abs(gap1(i,j) - gap2(i,j))/gap1(i,j)) > tol
            new_gap(i,j) = gap2(i,j);
        end
            
    end
end
clear i j tol
        