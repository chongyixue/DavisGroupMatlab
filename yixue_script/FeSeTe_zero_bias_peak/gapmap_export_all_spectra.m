% 2019-7-11 YXC
% import all the spectra
% machine learning

function gapmap_export_all_spectra(map,varargin)

[nx,ny,nz] = size(map.map);

pathname = 'C:\Users\chong\Desktop\machine learning\STM\';
% filename = 'FST90708_allspec.csv';
% file = strcat(pathname,filename);

name = strcat(map.name(1:5),'_allspec.csv'); % '90708'

if nargin>1
    pair = fix(nargin-1)/2;
    for prop = 1:pair
        propname = varargin{prop*2-1};
        if strcmp(varargin{prop*2-1},'name')==1
            name = varargin{prop+1};
            name = strcat(name,'.csv');
        elseif strcmp(varargin{prop*2-1},'suffix')==1
            nam = varargin{prop+1};
            name = strcat(nam,name);
        else
            dis = strcat(['"',propname,'"',' is not a valid property']);
            disp(dis);
        end
    end
end

file = strcat(pathname,name);



remlinear = linspace(1,nx*ny,nx*ny);
[xx,yy] = one2xy(remlinear,nx); %% xx and yy - list of x and y coord respectively

% write header
head = linspace(0,nz,nz+1);
dlmwrite(file,head,'delimiter',',','-append')

for i = 1:nx*ny
    
    x = xx(i);y = yy(i);
    coord = xy2coord(x,y,nx);
    spect = squeeze(squeeze(map.map(y,x,:)))';
    spec = zeros(1,nz+1);
    spec(1,1) = coord;
    spec(1,2:end) = spect;
    
    dlmwrite(file,spec,'delimiter',',','-append')
    
end







    function coord = xy2coord(x,y,nx)
        coord = (y-1)*nx+x;
    end

    function [x,y] = one2xy(coordinate,nx)
        y = fix((coordinate-0.5)/nx)+1;
        x = coordinate - nx*(y-1);
    end



end





