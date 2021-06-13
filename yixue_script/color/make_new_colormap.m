% 2020-6-9 YXC
% make 'Body'

% Body = zeros(256,3);
% 
% x = linspace(1,256,6);
% r = [0,126,191,225,255,255];
% g = [0,77,72,144,218,255];
% b = [0,35,30,123,154,255];
% 
% Body(:,1) = interp1(x,r,linspace(1,256,256));
% Body(:,2) = interp1(x,g,linspace(1,256,256));
% Body(:,3) = interp1(x,b,linspace(1,256,256));
% 
% Body = Body/256;

%% 2020-12-20 make jet2

% % import jet from color map 
x = linspace(1,256,256);
x = x.*ones(4,size(x,2));
f = figure;
imagesc(x);
setcolor(f,'Jetblack');
% 
% figure,plot(Jet(:,1),'r');
% hold on
% plot(Jet(:,2),'g');
% plot(Jet(:,3),'b');

% db = Jet(2,3)-Jet(1,3);
% extrab = flip(Jet(1,3):-db:0);
% extrab = extrab';
% extrab = extrab(1:end-1);
% extrar = zeros(size(extrab));
% extrag = extrar;
% 
% newR = [extrar',Jet(:,1)']';
% newG = [extrag',Jet(:,2)']';
% newB = [extrab',Jet(:,3)']';
% x = linspace(1,256,256)';
% newx = linspace(1,256,length(newR))';
% newR = interp1(newx,newR,x);
% newG = interp1(newx,newG,x);
% newB = interp1(newx,newB,x);
% 
% figure,plot(newB)
% def(:,1) = newR;
% def(:,2) = newG;
% def(:,3) = newB;


%% function


function setcolor(ax,col,varargin)
invert = 0;
if nargin>2
    skipover = 0;
    for i=1:length(varargin)
        if skipover ~=0
            skipover = skipover-1;
        else
            switch varargin{i}
                case 'invert'
                    skipover = 0;
                    invert = 1;
                otherwise
                    st = num2str(varargin{i});
                    fprintf(strcat('"',st,'" is not recognized as a property'));
            end

        end
    end
end

    
% color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map_path = fullfile(fileparts(mfilename('fullpath')),'..','..','\STM View\Color Maps\');

color_map = struct2cell(load([color_map_path col]));
color_map = color_map{1};
if invert == 1
   color_map = flipud(color_map); 
end
colormap(ax,color_map);
end

