function newllmap = filter_misfits(llmap,peakmV_array,range)

if length(range)==1
    range = zeros(length(llmap.e))+range;
end


[~,first_non0] = min(peakmV_array==0);
relevant_mV = peakmV_array(first_non0:length(llmap.e)+first_non0-1);

% [nx,ny,~] = size(llmap.map);

newllmap = llmap;
for level = 1:length(relevant_mV)
    matrix_tobefixed = llmap.map(:,:,level);
%     level
%     range(level)
    filter =  abs(matrix_tobefixed-relevant_mV(level))>range(level);
    newllmap.map(:,:,level) = removepeak(matrix_tobefixed,filter);
%     figure,imagesc(filter');
end

% test = zeros(10,10)+30;
% test(2,8) = 1;
% filter = zeros(10,10); filter(2,8) = 1;
% newllmap = removepeak(test,filter);

end
function newmatrix = removepeak(matrix,filter)
[nx,ny] = size(matrix);

rightfilt = zeros(nx,ny);
leftfilt = zeros(nx,ny);
upfilt = rightfilt; downfilt = upfilt;

rightfilt(2:nx,:) = filter(1:nx-1,:);
leftfilt(1:nx-1,:) = filter(2:nx,:);
downfilt(:,1:ny-1) = filter(:,2:ny);
upfilt(:,2:ny)=filter(:,1:ny-1);

left = leftfilt.*matrix;
right = rightfilt.*matrix;
up = upfilt.*matrix;
down = downfilt.*matrix;

leftreturn = zeros(nx,ny);rightreturn = leftreturn;
downreturn = leftreturn; upreturn = leftreturn;

leftreturn(2:nx,:) = left(1:nx-1,:);
downreturn(:,2:ny) = down(:,1:ny-1);
upreturn(:,1:ny-1) = up(:,2:ny);
rightreturn(1:nx-1,:) = right(2:nx,:);

div_matrix = zeros(nx,ny)+3;
div_matrix(1,1) = 2;
div_matrix(nx,1) = 2;
div_matrix(1,ny) = 2;
div_matrix(nx,ny) = 2;
div_matrix(2:nx-1,2:ny-1)= 4;

newmatrix = ((downreturn+leftreturn+upreturn+rightreturn)./div_matrix).*filter + (1-filter).*matrix;
end
function newmatrix = add_zero_border(matrix)
    [nx,ny] = size(matrix);
    newmatrix = zeros(nx+2,ny+2);
    newmatrix(2:nx+1,2:ny+1) = matrix;
end

function [xlist,ylist] = neighbor(x,y,nx,ny,pixels)
[xrange,yrange] = neighborrange(x,y,nx,ny,pixels);
xlength = xrange(end)-xrange(1)+1;
ylength = yrange(end)-yrange(1)+1;

xstart = xrange(1); ystart = yrange(1);

squares = xlength*ylength;
xlist = zeros(squares,1);
ylist = xlist;

for i = 1:squares
    xlist(i) = fix((i-1)/ylength)+xstart;
    ylist(i) = rem(i-1,ylength)+ystart;
    if xlist(i) == x && ylist(i) == y
        remove_i = i;
    end
end
xlist(remove_i) = [];
ylist(remove_i) = [];

end

function [xrange,yrange] = neighborrange(x,y,nx,ny,pixels)
xrange = [max(x-pixels,1),min((x+pixels),nx)];
yrange = [max(y-pixels,1),min((y+pixels),ny)];
end

% function number = modd(num,div)
% number = rem(num,div);
% if number == 0
%     number = div;
% end
% end
