

% color_map_path = 'C:\Users\pspra\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map_path = 'C:\Users\Peter\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map = struct2cell(load([color_map_path 'Jet.mat']));
color_map = color_map{1};

% marker size
p = 14;

% big domain
gammamap = obj_60226a01_T_FT.map;
qgamma = obj_60226a01_T_FT.r;

% small rotated domain
mmap = obj_60609a01_T_FT.map;
qm = obj_60609a01_T_FT.r;



% -2.0, -1.6 or -1.5 (9 or 10), -1.3 meV
[nx, ny, nz] = size(gammamap(135:379,135:379,1));
gm1 = gammamap(135:379,135:379,1);



for i=1:nx
    for j=1:ny
        if gm1(i,j,1) > 5 
            gm1(i,j,1) = 5;
        end
    end
end



% markers
x1 = 232 - 134;
y1 = 232 - 134;
x2 = 282 - 134;
y2 = 282 - 134;




figureset_img_plot(gm1);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
hold off

%%

% -2.0, -1.6, -1.3 meV
[nx, ny, nz] = size(mmap(372:654,372:654,1));
mm1 = mmap(372:654, 372:654,1);



for i=1:nx
    for j=1:ny
        if mm1(i,j,1) > 10
            mm1(i,j,1) = 10;
        end
    end
end


% markers
x1 = 484 - 371;
y1 = 484 - 371;
x2 = 542 - 371;
y2 = 542 - 371;


%%



figureset_img_plot(mm1);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
hold off

