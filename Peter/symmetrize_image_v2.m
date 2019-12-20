%%%%%%%
% CODE DESCRIPTION: Symmetrizes a map along the horizontal, vertical or
% diagonal axes.  This method typically used used in symmetrizing the 
% fourier transforms
% 
%   
% INPUT: data: standard image or STM data structure
%        varargin: can have up to 3 entries defining direction for
%        symmetrization - horizontal (h), vertical (v), diagonal(d).  At
%        least one direction must be specified.  
%
% CODE HISTORY
%
% 080304 MHH Created
% 100721 MHH Modified - add options to symmetrize along any of three high
%                       symmetry direction as chosen by the user.


function sym_data = symmetrize_image_v2(data,varargin)
if isempty(varargin)
     fprintf('Specify Symmetrization Axis: v, h, or d? \r')
     sym_data = data;
     return;
elseif size(varargin,2) > 3
    fprintf('Too many input paramters \r')
    return;
end

if isstruct(data) % check if data is a full data structure
    [nr,nc,nz]=size(data.map);
    tmp_data = data.map;
else % single data image
    [nr,nc,nz] = size(data);
    tmp_data = data;
end



if(mod(nr,2)==0)
    tmp_data2 = zeros(nr+1,nc+1,nz);
    tmp_data2(1:nr,1:nc,:)=tmp_data;
    tmp_data2(1:nr,end,:) = tmp_data(:,1,:);
    tmp_data2(end,1:nc,:) = tmp_data(1,:,:);
    tmp_data2(end,end,:) = tmp_data(1,1,:);
    tmp_data = tmp_data2;
    clear tmp_data2
    nr = nr+1;
    nc = nc+1;
    tempr = data.r;
    data.r = [tempr 2*tempr(end)-tempr(end-1)];
end

new_data = nan(nr,nc,nz);
%symmetrize along horizontal
if sum([varargin{:}] == 'h') == 1
    %if the number of rows/cols is odd
    if(mod(nr,2)==1)
        for i=1:((nr-1)/2)
            new_data(i,:,:) = (tmp_data(i,:,:) + tmp_data(nr + 1 - i,:,:))/2;
            new_data(nr + 1 -i,:,:) = new_data(i,:,:);
        end
        new_data((nr+1)/2,:,:)=tmp_data((nr+1)/2,:,:);
    %else the number of rows/cols is even
    else
        for i=1:nr/2
            new_data(i,:,:) = (tmp_data(i,:,:) + tmp_data(nr + 1 - i,:,:))/2;
            new_data(nr + 1 -i,:,:) = new_data(i,:,:);
        end
    end
    tmp_data = new_data;
end

%symmetrize along vertical
if sum([varargin{:}] == 'v') == 1
    if(mod(nc,2)==1)
        for j=1:((nc-1)/2)
            new_data(:,j,:) = (tmp_data(:,j,:) + tmp_data(:,nc + 1 - j,:))/2;
            new_data(:,nc + 1 -j,:) = new_data(:,j,:);
        end
        new_data(:,(nc+1)/2,:)=tmp_data(:,(nc+1)/2,:);
    else
        for j=1:nc/2
            new_data(:,j,:) = (tmp_data(:,j,:) + tmp_data(:,nc + 1 - j,:))/2;
            new_data(:,nc + 1 -j,:) = new_data(:,j,:);
        end
    end
     tmp_data = new_data;
end

%symmetrize along diagonal
if sum([varargin{:}] == 'd') == 1   
    display('yes');
    for k = 1:nz
      new_data(:,:,k) = (tmp_data(:,:,k) + tmp_data(:,:,k)')/2;
    end
end
if isstruct(data) % check if data is a full data structure
    sym_data = data;
    sym_data.map = new_data;   
else % single data image
    sym_data = new_data;
end
end