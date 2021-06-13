% 2019-9-24 YXC
% if we have the coordinates ready, put in varargin, else will prompt

% 2020-4-28 YXC
% opposite of Gaussian's coordinate is not correct. Key: centerpx =
% ceil((nx+1)/2);

function newdata = keep_peak_coord(data,varargin)

if isstruct(data)
    [~,nr, nz] = size(data.map);
else
    [~,nr, nz] = size(data);
end


addtoshiftopposite = 2-mod(nr,2);

center = (nr+1)/2;

if nargin>1
    xx = varargin{1};
    yy = varargin{2};
    gw = varargin{3};
    
    if nargin>4 
        maskchoice = varargin{4};
    else
        maskchoice = 'Gauss';
    end
    mask = zeros(nr,nr,1);
    for i = 1:length(xx)
        x = xx(i); y = yy(i);
        if strcmp(maskchoice,'Gauss')
            mask = mask + Gaussian_v2(1:nr,1:nr,gw,gw,0,[x,y],1);
            mask = mask + Gaussian_v2(1:nr,1:nr,gw,gw,0,[nr-x+addtoshiftopposite,nr-y+addtoshiftopposite],1);
        elseif strcmp(maskchoice,'Circle')
            mask = mask + circle_mask(nr,x,y,gw);
            mask = mask + circle_mask(nr,nr-x+addtoshiftopposite,nr-y+addtoshiftopposite,gw);
        end
%                  figure,imagesc(mask)
    end
else
    
    prompt = {'x','y','Gauss width'};
    dlg_title = 'Coordinates of unique q peaks';
    num_lines = 1;
    default_answer = {num2str(round(center)),num2str(round(center)),num2str(round(center/5))};
    % confirm = 0;
    
    button2 = 'Yes';
    
    mask = zeros(nr,nr,1);
    
    while strcmp(button2,'Yes')==1
        
        button2 = questdlg('Add another region?',...
            'Choose yes or no','Yes','No','Cancel','No');
        
        if strcmp(button2,'Yes')
            answer = inputdlg(prompt,dlg_title,num_lines,default_answer);
            if isempty(answer)
                return;
            else
                x = str2double(answer{1});
                y = str2double(answer{2});
                gw = str2double(answer{3});
                
                mask = mask + Gaussian_v2(1:nr,1:nr,gw,gw,0,[x,y],1);
                mask = mask + Gaussian_v2(1:nr,1:nr,gw,gw,0,[nr-x+addtoshiftopposite,nr-y+addtoshiftopposite],1);
                figure,imagesc(mask)
            end
        end
        
    end
end
maxx = max(max(mask));
if maxx ~= 0
    mask = mask/maxx;
end

mask3D = zeros(nr,nr,nz);
for i = 1:nz
    mask3D(:,:,i) = mask;
end
% mask3D = 1-mask3D;


FTcomplex = fourier_transform2d(data,'none','complex','ft');
if isstruct(FTcomplex)
    FTcomplex.map = FTcomplex.map.*mask3D;
    FTcomplex.cpx_map = FTcomplex.cpx_map.*mask3D;
    FTcomplex.rel_map = FTcomplex.rel_map.*mask3D;
    FTcomplex.img_map = FTcomplex.img_map.*mask3D;
    FTcomplex.apl_map = FTcomplex.apl_map.*mask3D;
    FTcomplex.pha_map = FTcomplex.pha_map.*mask3D;
    
    
    
else
    FTcomplex = FTcomplex.*mask3D;
end

% to add operation log later
if nargin==1
    img_obj_viewer_test(amplitude_map(FTcomplex))
end
newdata = fourier_transform2d(FTcomplex,'none','real','ift');
newdata.ave = average_spectrum_map(newdata);

end











