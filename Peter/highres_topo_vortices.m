function [] = highres_topo_vortices(hrestopo,fperimeter)
% 


% possible colors
% Mac
% color_map_path = '/Users/petersprau/Documents/MATLAB/STM/MATLAB/STM View/Color Maps/';
% Windows
% color_map_path = 'C:\Users\Oliver\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map_path = 'C:\Users\Peter\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';

% ev = data.e;
% ev2 = data2.e;
% nel2 = length(ev2);
% [nx, ny, nel] = size(nomagmap);

% ibmap = imresize(bmap,[1024, 1024],'Cubic');

% [ox, oy, oz] = size(hrestopo);
% 
% hrestopo = imresize(hrestopo,[ox/200*1024, oy/200*1024],'Cubic');


% fperimeter = bwboundaries(ibmap);


[nx, ny, nz] = size(hrestopo);

vorpert = fperimeter;

change_color_of_STM_maps(hrestopo,'noinvert');

hold on


for i=1:length(fperimeter)

    dum1 = vorpert{i};
    xxx = mean(dum1(:,2));
    yyy = mean(dum1(:,1));
    plot(xxx,yyy,'-o','Color','r','LineWidth',1,'MarkerSize',4);
    % line is needed to close the region
%     line([xxx(end),xxx(1)],[yyy(end),yyy(1)],'Color','c','LineStyle','-','LineWidth',2,'MarkerSymbol','o','MarkerSize',10);
    

end

hold off