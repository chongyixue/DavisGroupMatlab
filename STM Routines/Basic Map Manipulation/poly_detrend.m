%%%%%%%
% CODE DESCRIPTION: Polydetrend is used to calculate the multinomial of
% best of specified degree and return a new map with this trend subtracted
%   
% CODE HISTORY
%
% 080120 MHH  Written with 0 and (0,1) order polynomial subtraction
%
%
%%%%%%%

function[new_spectmap] = poly_detrend(map,distx,disty,order)

[sy,sx,sz] = size(map);

    if order == 0
        avg_map = squeeze(squeeze(mean(mean(map))));
        for i = 1:sz
            new_spectmap(:,:,i) = map(:,:,i)  - avg_map(i);            
        end
        return;
    end 
    if order == 1
        % do linear least squares fit
        % for (xi,yi,zi) assume  z = a + bxi + cyi
        % minimize residual R = \sum{(z - zi)^2} w.r.t. a,b,c
        % leads to linear equations in a,b,c,

        %set up matrix elements which don't change with energy layers of
        %map -> (y,x) coordinates
        N = sx*sy;
        sum_x = sum(distx)*sy;
        sum_y = sum(disty)*sx;
        sum_xy = sum(sum((distx'*disty)));
        sum_x2 = sum(distx.^2)*sy;
        sum_y2 = sum(disty.^2)*sx;
        
        %set up coefficient matrix A for parameters of linear
        %least-squares fit using AX = B
        A = [N       sum_x    sum_y;...
             sum_x   sum_x2   sum_xy;...
             sum_y   sum_xy   sum_y2];
 
        for k=1:sz
            %set up matrix elements dependent on layer coordinate of map
            sum_z = sum(sum(map(:,:,k)));
            sum_zx = sum((repmat(distx',1,sy)).*reshape(map(:,:,k)',1,sx*sy));
            sum_zy = sum((repmat(disty',1,sx)).*reshape(map(:,:,k),1,sx*sy));                
            
            %set up vector B in AX = B
            B = [sum_z sum_zx sum_zy];
            
            %Solve for X = [const term, x term, y term]
            X = inv(A)*B';
            % generate plane
            for i=1:sy
                plane_fit(i,:,k) = X(1) + X(2)*distx(i) + X(3)*disty;
            end  

            %subtract off plane of best fit
            %NOTE: take transpose of plane_fit since map matrix has x and y
            %coordinates switched
            new_spectmap(:,:,k) = map(:,:,k) - plane_fit(:,:,k)';
        end
    end    
end
    



