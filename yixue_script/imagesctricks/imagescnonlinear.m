%% 2020-11-24 YXC
% given a nonlinear spacing (in energy) do imagesc

function linearizedcut = imagescnonlinear(maincut,varargin)

% maincut = cutoriginal; % this cut has nonlinear energy
symmetric = 1;
divisionfactor = 2;
plott=1;
tt = "linearized plot";
elim = [maincut.e(1),maincut.e(end)];
colorm = 'Jet';
xlab="E(mV)";
ylab = "";
if nargin>2
    skipover = 0;
    for i=1:length(varargin)
        if skipover ~=0
            skipover = skipover-1;
        else
            switch varargin{i}
                case 'divisionfactor' % choose smallest division, and divide by this number
                    skipover = 1;
                    divisionfactor = varargin{i+1};
                case 'noplot'
                    skipover = 0;
                    plott=0;
                case 'symmetric'
                    skipover = 1;
                    symmetric = varargin{i+1};
                case 'title'
                    skipover = 1;
                    tt = varargin{i+1};
                case 'elim'
                    skipover = 1;
                    elim = varargin{i+1};
                case 'color'
                    skipover = 1;
                    colorm = varargin{i+1};                
                case 'xlabel'
                    skipover = 1;
                    xlab = varargin{i+1};
                case 'ylabel'
                    skipover = 1;
                    ylab = varargin{i+1};
                otherwise
                    st = num2str(varargin{i});
                    fprintf(strcat('"',st,'" is not recognized as a property'));
            end

        end
    end
end



%% determine the smallest division

dE = abs(maincut.e(2:end)-maincut.e(1:end-1));
mindE = min(dE);
mindE = mindE/divisionfactor;
if symmetric == 1
    max1 = mindE*abs(round(maincut.e(1)/mindE));
    max2 = mindE*abs(round(maincut.e(end)/mindE));
    
    modifiedE = -max1:mindE:0;
    modifiedE = [modifiedE,mindE:mindE:max2];
    if maincut.e(1)>0 % descending energy
        modifiedE = -modifiedE;
    end
else
    modifiedE = maincut.e(1):mindE:maincut.e(end);
end
modifiedE = reshape(modifiedE,[],1);

%% limit energy range
[~,i1]=min(abs(modifiedE-elim(1)));
[~,i2]=min(abs(modifiedE-elim(2)));
modifiedE = modifiedE(i1:i2);

%% interpolate (nearest)
linearizedcut = maincut;
linearizedcut.e = modifiedE;
linearizedcut.cut = zeros(length(maincut.r),length(modifiedE));
for i=1:length(maincut.r)
    linearizedcut.cut(i,:)=interp1(maincut.e,maincut.cut(i,:),modifiedE,'nearest');
end   
if plott==1
    f = figure;
    imagesc(linearizedcut.e,linearizedcut.r,linearizedcut.cut);
    xlabel(xlab);
    xlabel(xlab);
    title(tt);
    setcolor(f,colorm)
end
    
    

function setcolor(ax,col)
color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map = struct2cell(load([color_map_path col]));
color_map = color_map{1};
colormap(ax,color_map);
end
    
end
    
    



