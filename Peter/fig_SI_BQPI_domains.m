

color_map_path = 'C:\Users\pspra\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
% color_map_path = 'C:\Users\Peter\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map = struct2cell(load([color_map_path 'Jet.mat']));
color_map = color_map{1};

% marker size
p = 14;

% big domain
gammamap = obj_60222a00_G_FT_sym_avg3_bcp_8cr.map;
qgamma = obj_60222a00_FT_12cr.r;

% small rotated domain
mmap = obj_60224a00_G_FT_sym_avg_4cr.map;
qm = obj_60224a00_G_FT_sym_avg_4cr.r;



% -2.0, -1.6 or -1.5 (9 or 10), -1.3 meV
[nx, ny, nz] = size(gammamap(11:118,11:118,5));
gm1 = gammamap(11:118,11:118,5);
gm2 = gammamap(11:118,11:118,9);
% gm2 = gammamap(11:118,11:118,10);
gm3 = gammamap(11:118,11:118,12);


for i=1:nx
    for j=1:ny
        if gm1(i,j,1) > 388.4 
            gm1(i,j,1) = 388.4;
        end
    end
end

% -1.5 meV
% for i=1:nx
%     for j=1:ny
%         if gm2(i,j,1) > 150
%             gm2(i,j,1) = 150;
%         end
%     end
% end

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
        if gm3(i,j,1) > 190
            gm3(i,j,1) = 190;
        end
    end
end


% markers
x1 = 19 - 10;
y1 = 19 - 10;
x2 = 110 - 10;
y2 = 110 - 10;


% % q2 -1.5
% xg_peter = [0.10948,0.10304,0.07084];
% yg_peter = ([-0.10304,-0.14168,-0.16744]);

% q2 -1.6
xg_peter = [0.10948,0.0966,0.09016];
yg_peter = ([-0.10304,-0.1288,-0.15456]);

qgamma = qgamma(11:118);
% [M, xg1(1)] = min( abs (xg_peter(1) - qgamma) );
% [M, yg1(1)] = min( abs (yg_peter(1) - qgamma) );
% 
% [M, xg1(2)] = min( abs (xg_peter(2) - qgamma) );
% [M, yg1(2)] = min( abs (yg_peter(2) - qgamma) );
% 
% [M, xg1(3)] = min( abs (xg_peter(3) - qgamma) );
% [M, yg1(3)] = min( abs (yg_peter(3) - qgamma) );

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
cc2 = 1;

for i=1 : 12
    dummy = q1_lorparcomb(i,1:5);
    
    if i==2 || i==6 || i==9
        xg2(cc2) = 0;
        yg2(cc2) = -dummy(3);
        cc2 = cc2 + 1;
    end
    
end 

cc3 = 1;

for i=1 : 12
    dummy = q3_lorparcomb(i,1:5);
    
    if i==5 || i==9 || i==11
       xg3(cc3) = dummy(3);
       yg3(cc3) = 0;
       cc3 = cc3 + 1;
    end
    
end  

% [M, xg2(1)] = min( abs (xg2(1) - qgamma) );
% [M, yg2(1)] = min( abs (yg2(1) - qgamma) );
% 
% [M, xg2(2)] = min( abs (xg2(2) - qgamma) );
% [M, yg2(2)] = min( abs (yg2(2) - qgamma) );
% 
% [M, xg2(3)] = min( abs (xg2(3) - qgamma) );
% [M, yg2(3)] = min( abs (yg2(3) - qgamma) );
% 
% [M, xg3(1)] = min( abs (xg3(1) - qgamma) );
% [M, yg3(1)] = min( abs (yg3(1) - qgamma) );
% 
% [M, xg3(2)] = min( abs (xg3(2) - qgamma) );
% [M, yg3(2)] = min( abs (yg3(2) - qgamma) );
% 
% [M, xg3(3)] = min( abs (xg3(3) - qgamma) );
% [M, yg3(3)] = min( abs (yg3(3) - qgamma) );


xg2(1) = zerop2 + xg2(1)/aqg;
xg2(1) = (zerop1+zerop2)/2;
yg2(1) = zerop1 + yg2(1)/aqg;

xg2(2) = zerop2 + xg2(2)/aqg;
xg2(2) = (zerop1+zerop2)/2;
yg2(2) = zerop1 + yg2(2)/aqg;

xg2(3) = zerop2 + xg2(3)/aqg;
xg2(3) = (zerop1+zerop2)/2;
yg2(3) = zerop1 + yg2(3)/aqg;

xg3(1) = zerop2 + xg3(1)/aqg;
yg3(1) = zerop1 + yg3(1)/aqg;
yg3(1) = (zerop1+zerop2)/2;

xg3(2) = zerop2 + xg3(2)/aqg;
yg3(2) = zerop1 + yg3(2)/aqg;
yg3(2) = (zerop1+zerop2)/2;


xg3(3) = zerop2 + xg3(3)/aqg;
yg3(3) = zerop1 + yg3(3)/aqg;
yg3(3) = (zerop1+zerop2)/2;



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
plot(xg2(1), yg2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xg3(1), yg3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
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
plot(xg2(2), yg2(2),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xg3(2), yg3(2),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
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
plot(xg2(3), yg2(3),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xg3(3), yg3(3),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off

% -2.0, -1.6, -1.3 meV
[nx, ny, nz] = size(mmap(7:44,7:44,30));
mm1 = mmap(7:44,7:44,30);
mm2 = mmap(7:44,7:44,34);
mm3 = mmap(7:44,7:44,37);


for i=1:nx
    for j=1:ny
        if mm1(i,j,1) > 300.6
            mm1(i,j,1) = 300.6;
        end
    end
end

for i=1:nx
    for j=1:ny
        if mm2(i,j,1) > 200.3
            mm2(i,j,1) = 200.3;
        end
        
    end
end

for i=1:nx
    for j=1:ny
        if mm3(i,j,1) > 50.1
            mm3(i,j,1) = 50.1;
        end
        
    end
end

% markers
x1 = 10 - 6;
y1 = 10 - 6;
x2 = 41 - 6;
y2 = 41 - 6;


% just rotate the values for x and y

ym_peter = [0.10948,0.0966,0.09016];
xm_peter = -([-0.10304,-0.1288,-0.15456]);

qm = qm(7:44);

% [M, xm1(1)] = min( abs (xm_peter(1) - qm) );
% [M, ym1(1)] = min( abs (ym_peter(1) - qm) );
% 
% [M, xm1(2)] = min( abs (xm_peter(2) - qm) );
% [M, ym1(2)] = min( abs (ym_peter(2) - qm) );
% 
% [M, xm1(3)] = min( abs (xm_peter(3) - qm) );
% [M, ym1(3)] = min( abs (ym_peter(3) - qm) );


zerop1 = length(qm)/2;
zerop2 = length(qm)/2+1;

aqm = abs(qm(2)-qm(1));

xm1(1) = zerop2 + xm_peter(1)/aqm;
ym1(1) = zerop1 - ym_peter(1)/aqm;

xm1(2) = zerop2 + xm_peter(2)/aqm;
ym1(2) = zerop1 - ym_peter(2)/aqm;

xm1(3) = zerop2 + xm_peter(3)/aqm;
ym1(3) = zerop1 - ym_peter(3)/aqm;


cp = floor( linspace(1, 256, 6) );

%%
cc2 = 1;

cc2 = 1;

for i=1 : 12
    dummy = q1_lorparcomb(i,1:5);
    
    if i==2 || i==6 || i==9
        ym2(cc2) = 0;
        xm2(cc2) = -dummy(3);
        cc2 = cc2 + 1;
    end
    
end 

cc3 = 1;

for i=1 : 12
    dummy = q3_lorparcomb(i,1:5);
    
    if i==5 || i==9 || i==11
       ym3(cc3) = dummy(3);
       xm3(cc3) = 0;
       cc3 = cc3 + 1;
    end
    
end  



% [M, xm2(1)] = min( abs (xm2(1) - qm) );
% [M, ym2(1)] = min( abs (ym2(1) - qm) );
% 
% [M, xm2(2)] = min( abs (xm2(2) - qm) );
% [M, ym2(2)] = min( abs (ym2(2) - qm) );
% 
% [M, xm2(3)] = min( abs (xm2(3) - qm) );
% [M, ym2(3)] = min( abs (ym2(3) - qm) );
% 
% [M, xm3(1)] = min( abs (xm3(1) - qm) );
% [M, ym3(1)] = min( abs (ym3(1) - qm) );
% 
% [M, xm3(2)] = min( abs (xm3(2) - qm) );
% [M, ym3(2)] = min( abs (ym3(2) - qm) );
% 
% [M, xm3(3)] = min( abs (xm3(3) - qm) );
% [M, ym3(3)] = min( abs (ym3(3) - qm) );


xm2(1) = zerop2 - xm2(1)/aqm;
ym2(1) = zerop1 + ym2(1)/aqm;
ym2(1) = [zerop1 + zerop2]/2;

xm2(2) = zerop2 - xm2(2)/aqm;
ym2(2) = zerop1 + ym2(2)/aqm;
ym2(2) = [zerop1 + zerop2]/2;


xm2(3) = zerop2 - xm2(3)/aqm;
ym2(3) = zerop1 + ym2(3)/aqm;
ym2(3) = [zerop1 + zerop2]/2;


xm3(1) = zerop2 + xm3(1)/aqm;
xm3(1) = [zerop1 + zerop2]/2;
ym3(1) = zerop1 - ym3(1)/aqm;

xm3(2) = zerop2 + xm3(2)/aqm;
xm3(2) = [zerop1 + zerop2]/2;
ym3(2) = zerop1 - ym3(2)/aqm;

xm3(3) = zerop2 + xm3(3)/aqm;
xm3(3) = [zerop1 + zerop2]/2;
ym3(3) = zerop1 - ym3(3)/aqm;



%%



figureset_img_plot(mm1);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(1), ym1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(1), :),'MarkerFaceColor',color_map(cp(1), :)); 
plot(xm1(1), ym1(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xm2(1), ym2(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xm3(1), ym3(1),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off
figureset_img_plot(mm2);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(2), ym1(2),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(3), :),'MarkerFaceColor',color_map(cp(3), :)); 
plot(xm1(2), ym1(2),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xm2(2), ym2(2),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xm3(2), ym3(2),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off
figureset_img_plot(mm3);
hold on
plot(x1, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y1,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x1, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
plot(x2, y2,'Marker', '+', 'MarkerSize', p-2,'MarkerEdgeColor','c','MarkerFaceColor','c', 'LineWidth', 3);
% plot(xm1(3), ym1(3),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(6), :),'MarkerFaceColor',color_map(cp(6), :)); 
plot(xm1(3), ym1(3),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xm2(3), ym2(3),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
plot(xm3(3), ym3(3),'Marker', '+', 'LineStyle', 'none', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k', 'LineWidth', 3);
hold off
