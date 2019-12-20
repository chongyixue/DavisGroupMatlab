color_map_path = 'C:\Users\pspra\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
% color_map_path = 'C:\Users\Peter\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map = struct2cell(load([color_map_path 'Jet.mat']));
color_map = color_map{1};

% marker size
p = 14;

gpmmap = obj_6060469A00_8cr.map;
qgpm = obj_6060469A00_8cr.r;

jdosmap = obj_alphaeps_JDOS.map;
qjdos = obj_alphaeps_JDOS.r;



% -1.4, -1.1, -0.8, -0.5, -0.3, 0.3, 0.5, 0.5, 1.1, 1.4 meV
[nx, ny, nz] = size(gpmmap(:,:,4));
gpmm1 = gpmmap(:,:,2);
gpmm2 = gpmmap(:,:,5);
gpmm3 = gpmmap(:,:,8);
gpmm4 = gpmmap(:,:,11);
gpmm5 = gpmmap(:,:,13);
gpmm6 = gpmmap(:,:,19);
gpmm7 = gpmmap(:,:,21);
gpmm8 = gpmmap(:,:,24);
gpmm9 = gpmmap(:,:,27);
gpmm10 = gpmmap(:,:,30);

% -1.4 meV
for i=1:nx
    for j=1:ny
        if gpmm1(i,j,1) > 713
            gpmm1(i,j,1) = 713;
        end
    end
end

% -1.1 meV
for i=1:nx
    for j=1:ny
        if gpmm2(i,j,1) > 698
            gpmm2(i,j,1) = 698;
        end
    end
end

% -0.8 meV
for i=1:nx
    for j=1:ny
        if gpmm3(i,j,1) > 436
            gpmm3(i,j,1) = 436;
        end
    end
end

% -0.5 meV
for i=1:nx
    for j=1:ny
        if gpmm4(i,j,1) > 280
            gpmm4(i,j,1) = 280;
        end
    end
end

% -0.3 meV
for i=1:nx
    for j=1:ny
        if gpmm5(i,j,1) > 102
            gpmm5(i,j,1) = 102;
        end
    end
end

% 0.3 meV
for i=1:nx
    for j=1:ny
        if gpmm6(i,j,1) > 150
            gpmm6(i,j,1) = 150;
        end
    end
end

% 0.5 meV
for i=1:nx
    for j=1:ny
        if gpmm7(i,j,1) > 280
            gpmm7(i,j,1) = 280;
        end
    end
end

% 0.8 meV
for i=1:nx
    for j=1:ny
        if gpmm8(i,j,1) > 450
            gpmm8(i,j,1) = 450;
        end
    end
end

% 1.1 meV
for i=1:nx
    for j=1:ny
        if gpmm9(i,j,1) > 702
            gpmm9(i,j,1) = 702;
        end
    end
end

% 1.4 meV
for i=1:nx
    for j=1:ny
        if gpmm10(i,j,1) > 800
            gpmm10(i,j,1) = 800;
        end
    end
end

% markers
x1 = 121 - 104;
y1 = 121 - 104;
x2 = 180 - 104;
y2 = 180 - 104;

%
xg_peter = [0.0966,0.07728,0.0644, 0.1, 0.1, 0.1, 0.1, 0.0644, 0.07728, 0.0966];
yg_peter = [-0.15456,-0.161,-0.17388, 0.1, 0.1, 0.1, 0.1, -0.17388, -0.161,-0.15456];

%
xm_peter = [0.2, 0.23219, 0.28462,0.34454, 0.36963, 0.36963, 0.34454, 0.28462, 0.23219, 0.2];
ym_peter = [0.2, -0.08239,-0.0749,-0.05243, 0, 0, -0.05243, -0.0749, -0.08239, 0.2];

qgpm = qgpm(:);

zerop1 = length(qgpm)/2;
zerop2 = length(qgpm)/2+1;

aqm = abs(qgpm(2)-qgpm(1));

%%
xg1(1) = zerop2 + xg_peter(1)/aqm;
yg1(1) = zerop1 + yg_peter(1)/aqm;

xg1(2) = zerop2 + xg_peter(2)/aqm;
yg1(2) = zerop1 + yg_peter(2)/aqm;

xg1(3) = zerop2 + xg_peter(3)/aqm;
yg1(3) = zerop1 + yg_peter(3)/aqm;

xg1(4) = zerop2 + xg_peter(4)/aqm;
yg1(4) = zerop1 + yg_peter(4)/aqm;

xg1(5) = zerop2 + xg_peter(5)/aqm;
yg1(5) = zerop1 + yg_peter(5)/aqm;

xg1(6) = zerop2 + xg_peter(6)/aqm;
yg1(6) = zerop1 + yg_peter(6)/aqm;

xg1(7) = zerop2 + xg_peter(7)/aqm;
yg1(7) = zerop1 + yg_peter(7)/aqm;

xg1(8) = zerop2 + xg_peter(8)/aqm;
yg1(8) = zerop1 + yg_peter(8)/aqm;

xg1(9) = zerop2 + xg_peter(9)/aqm;
yg1(9) = zerop1 + yg_peter(9)/aqm;

xg1(10) = zerop2 + xg_peter(10)/aqm;
yg1(10) = zerop1 + yg_peter(10)/aqm;

%%
xm1(1) = zerop2 + xm_peter(1)/aqm;
ym1(1) = zerop1 + ym_peter(1)/aqm;

xm1(2) = zerop2 + xm_peter(2)/aqm;
ym1(2) = zerop1 + ym_peter(2)/aqm;

xm1(3) = zerop2 + xm_peter(3)/aqm;
ym1(3) = zerop1 + ym_peter(3)/aqm;

xm1(4) = zerop2 + xm_peter(4)/aqm;
ym1(4) = zerop1 + ym_peter(4)/aqm;

xm1(5) = zerop2 + xm_peter(5)/aqm;
ym1(5) = zerop1 + ym_peter(5)/aqm;

xm1(6) = zerop2 + xm_peter(6)/aqm;
ym1(6) = zerop1 + ym_peter(6)/aqm;

xm1(7) = zerop2 + xm_peter(7)/aqm;
ym1(7) = zerop1 + ym_peter(7)/aqm;

xm1(8) = zerop2 + xm_peter(8)/aqm;
ym1(8) = zerop1 + ym_peter(8)/aqm;

xm1(9) = zerop2 + xm_peter(9)/aqm;
ym1(9) = zerop1 + ym_peter(9)/aqm;

xm1(10) = zerop2 + xm_peter(10)/aqm;
ym1(10) = zerop1 + ym_peter(10)/aqm;


cp = floor( linspace(1, 256, 6) );

%%

figureset_img_plot(gpmm1);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(1), ym1(1),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xg1(1), yg1(1),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(gpmm2);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
plot(xm1(2), ym1(2),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xg1(2), yg1(2),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(gpmm3);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
plot(xm1(3), ym1(3),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xg1(3), yg1(3),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(gpmm4);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
plot(xm1(4), ym1(4),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(4), yg1(4),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(gpmm5);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
plot(xm1(5), ym1(5),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(5), yg1(5),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off


figureset_img_plot(gpmm6);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
plot(xm1(6), ym1(6),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(6), yg1(6),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(gpmm7);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
plot(xm1(7), ym1(7),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(7), yg1(7),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(gpmm8);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
plot(xm1(8), ym1(8),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xg1(8), yg1(8),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(gpmm9);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
plot(xm1(9), ym1(9),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xg1(9), yg1(9),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(gpmm10);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(10), ym1(10),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xg1(10), yg1(10),'Marker','o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off


%%

% -1.4, -1.1, -0.8, -0.5, -0.3, 0.3, 0.5, 0.5, 1.1, 1.4 meV
[nx, ny, nz] = size(jdosmap(:,:,4));
jdosm1 = jdosmap(:,:,2);
jdosm2 = jdosmap(:,:,5);
jdosm3 = jdosmap(:,:,8);
jdosm4 = jdosmap(:,:,11);
jdosm5 = jdosmap(:,:,13);
jdosm6 = jdosmap(:,:,19);
jdosm7 = jdosmap(:,:,21);
jdosm8 = jdosmap(:,:,24);
jdosm9 = jdosmap(:,:,27);
jdosm10 = jdosmap(:,:,30);

% -1.4 meV
for i=1:nx
    for j=1:ny
        if jdosm1(i,j,1) > 4
            jdosm1(i,j,1) = 4;
        end
    end
end

% -1.1 meV
for i=1:nx
    for j=1:ny
        if jdosm2(i,j,1) > 1.59
            jdosm2(i,j,1) = 1.59;
        end
    end
end

% -0.8 meV
for i=1:nx
    for j=1:ny
        if jdosm3(i,j,1) > 0.82
            jdosm3(i,j,1) = 0.82;
        end
    end
end

% -0.5 meV
for i=1:nx
    for j=1:ny
        if jdosm4(i,j,1) > 0.32
            jdosm4(i,j,1) = 0.32;
        end
    end
end

% -0.3 meV
for i=1:nx
    for j=1:ny
        if jdosm5(i,j,1) > 0.2
            jdosm5(i,j,1) = 0.2;
        end
    end
end

% 0.3 meV
for i=1:nx
    for j=1:ny
        if jdosm6(i,j,1) > 0.2
            jdosm6(i,j,1) = 0.2;
        end
    end
end

% 0.5 meV
for i=1:nx
    for j=1:ny
        if jdosm7(i,j,1) > 0.32
            jdosm7(i,j,1) = 0.32;
        end
    end
end

% 0.8 meV
for i=1:nx
    for j=1:ny
        if jdosm8(i,j,1) > 0.81
            jdosm8(i,j,1) = 0.81;
        end
    end
end

% 1.1 meV
for i=1:nx
    for j=1:ny
        if jdosm9(i,j,1) > 1.64
            jdosm9(i,j,1) = 1.64;
        end
    end
end

% 1.4 meV
for i=1:nx
    for j=1:ny
        if jdosm10(i,j,1) > 4.1
            jdosm10(i,j,1) = 4.1;
        end
    end
end

% markers
x1 = 56;
y1 = 56;
x2 = 256;
y2 = 256;

%
xg_peter = [0.0966,0.07728,0.0644, 0.1, 0.1, 0.1, 0.1, 0.0644, 0.07728, 0.0966];
yg_peter = [-0.15456,-0.161,-0.17388, 0.1, 0.1, 0.1, 0.1, -0.17388, -0.161,-0.15456];

%
xm_peter = [0.2, 0.23219, 0.28462,0.34454, 0.36963, 0.36963, 0.34454, 0.28462, 0.23219, 0.2];
ym_peter = [0.2, -0.08239,-0.0749,-0.05243, 0, 0, -0.05243, -0.0749, -0.08239, 0.2];

qjdos = qjdos(:);

zerop1 = length(qjdos)/2;
zerop2 = length(qjdos)/2+1;

aqm = abs(qjdos(2)-qjdos(1));

%%
xg1(1) = zerop2 + xg_peter(1)/aqm;
yg1(1) = zerop1 + yg_peter(1)/aqm;

xg1(2) = zerop2 + xg_peter(2)/aqm;
yg1(2) = zerop1 + yg_peter(2)/aqm;

xg1(3) = zerop2 + xg_peter(3)/aqm;
yg1(3) = zerop1 + yg_peter(3)/aqm;

xg1(4) = zerop2 + xg_peter(4)/aqm;
yg1(4) = zerop1 + yg_peter(4)/aqm;

xg1(5) = zerop2 + xg_peter(5)/aqm;
yg1(5) = zerop1 + yg_peter(5)/aqm;

xg1(6) = zerop2 + xg_peter(6)/aqm;
yg1(6) = zerop1 + yg_peter(6)/aqm;

xg1(7) = zerop2 + xg_peter(7)/aqm;
yg1(7) = zerop1 + yg_peter(7)/aqm;

xg1(8) = zerop2 + xg_peter(8)/aqm;
yg1(8) = zerop1 + yg_peter(8)/aqm;

xg1(9) = zerop2 + xg_peter(9)/aqm;
yg1(9) = zerop1 + yg_peter(9)/aqm;

xg1(10) = zerop2 + xg_peter(10)/aqm;
yg1(10) = zerop1 + yg_peter(10)/aqm;

%%
xm1(1) = zerop2 + xm_peter(1)/aqm;
ym1(1) = zerop1 + ym_peter(1)/aqm;

xm1(2) = zerop2 + xm_peter(2)/aqm;
ym1(2) = zerop1 + ym_peter(2)/aqm;

xm1(3) = zerop2 + xm_peter(3)/aqm;
ym1(3) = zerop1 + ym_peter(3)/aqm;

xm1(4) = zerop2 + xm_peter(4)/aqm;
ym1(4) = zerop1 + ym_peter(4)/aqm;

xm1(5) = zerop2 + xm_peter(5)/aqm;
ym1(5) = zerop1 + ym_peter(5)/aqm;

xm1(6) = zerop2 + xm_peter(6)/aqm;
ym1(6) = zerop1 + ym_peter(6)/aqm;

xm1(7) = zerop2 + xm_peter(7)/aqm;
ym1(7) = zerop1 + ym_peter(7)/aqm;

xm1(8) = zerop2 + xm_peter(8)/aqm;
ym1(8) = zerop1 + ym_peter(8)/aqm;

xm1(9) = zerop2 + xm_peter(9)/aqm;
ym1(9) = zerop1 + ym_peter(9)/aqm;

xm1(10) = zerop2 + xm_peter(10)/aqm;
ym1(10) = zerop1 + ym_peter(10)/aqm;


cp = floor( linspace(1, 256, 6) );

%%

figureset_img_plot(jdosm1);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(1), ym1(1),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(1), yg1(1),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(jdosm2);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(2), ym1(2),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(2), yg1(2),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(jdosm3);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(3), ym1(3),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(3), yg1(3),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(jdosm4);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(4), ym1(4),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(4), yg1(4),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(jdosm5);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(5), ym1(5),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(5), yg1(5),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off


figureset_img_plot(jdosm6);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(6), ym1(6),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(6), yg1(6),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(jdosm7);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(7), ym1(7),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(7), yg1(7),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(jdosm8);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(8), ym1(8),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(8), yg1(8),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(jdosm9);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(9), ym1(9),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(9), yg1(9),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

figureset_img_plot(jdosm10);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
% plot(xm1(10), ym1(10),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg1(10), yg1(10),'Marker', 'o', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','w','MarkerFaceColor','none', 'LineWidth', 2);
% plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
% plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off