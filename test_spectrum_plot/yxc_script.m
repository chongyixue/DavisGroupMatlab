

color_map_path = 'C:\Users\YiXue\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
% color_map_path = 'C:\Users\YiXue\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map = struct2cell(load([color_map_path 'Jet.mat']));
color_map = color_map{1};

% marker size
p = 14;

gammamap = obj_60222a00_G_FT_sym_avg3_bcp_8cr.map;
qgamma = obj_60222a00_FT_12cr.r;


% -2.0, -1.6 or -1.5 (9 or 10), -1.2 meV
[nx, ny, nz] = size(gammamap(11:118,11:118,5));
gm1 = gammamap(11:118,11:118,5);
gm2 = gammamap(11:118,11:118,9);
% gm2 = gammamap(11:118,11:118,10);
gm3 = gammamap(11:118,11:118,13);


for i=1:nx
    for j=1:ny
        if gm1(i,j,1) > 388.4 
            gm1(i,j,1) = 388.4;
        end
    end
end

% -1.6 meV
for i=1:nx
    for j=1:ny
        if gm2(i,j,1) > 300
            gm2(i,j,1) = 300;
        end
    end
end

for i=1:nx
    for j=1:ny
        if gm3(i,j,1) > 130.9
            gm3(i,j,1) = 130.9;
        end
    end
end


% markers
x1 = 19 - 10;
y1 = 19 - 10;
x2 = 110 - 10;
y2 = 110 - 10;


% q2 -1.6
xg_peter = [0.10948,0.0966,0.08372];
yg_peter = ([-0.10304,-0.1288,-0.161]);

qgamma = qgamma(11:118);


zerop1 = length(qgamma)/2;
zerop2 = length(qgamma)/2+1;

aqg = abs(qgamma(2)-qgamma(1));

xg1(1) = zerop2 + xg_peter(1)/aqg;
yg1(1) = zerop1 + yg_peter(1)/aqg;

xg1(2) = zerop2 + xg_peter(2)/aqg;
yg1(2) = zerop1 + yg_peter(2)/aqg;

xg1(3) = zerop2 + xg_peter(3)/aqg;
yg1(3) = zerop1 + yg_peter(3)/aqg;

cp = floor( linspace(1, 256, 14) );


%%

figureset_img_plot(gm1);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(x2, y2,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','b','MarkerFaceColor','b', 'LineWidth', 3);
% plot(xg1(1), yg1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(2), :),'MarkerFaceColor',color_map(cp(2), :)); 
plot(xg1(1), yg1(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(1), yg1(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor',[0,255,255]/255,'MarkerFaceColor',[0,255,255]/255, 'LineWidth', 3);

hold off
figureset_img_plot(gm2);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xg1(2), yg1(2),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(7), :),'MarkerFaceColor',color_map(cp(7), :)); 
plot(xg1(2), yg1(2),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(2), yg1(2),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor',[0,255,255]/255,'MarkerFaceColor',[0,255,255]/255, 'LineWidth', 3);
hold off

figureset_img_plot(gm3);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xg1(3), yg1(3),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(12), :),'MarkerFaceColor',color_map(cp(12), :)); 
plot(xg1(3), yg1(3),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(3), yg1(3),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor',[0,255,255]/255,'MarkerFaceColor',[0,255,255]/255, 'LineWidth', 3);
hold off






