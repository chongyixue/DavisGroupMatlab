qmmap1 = obj_60604A00_G_FT_sym_avg3.map;
qmq = obj_60604A00_G_FT_sym_avg3.r;
e1 = obj_60604A00_G_FT_sym_avg3.e;

qmmap3 = obj_60606a00_G_FT_sym_avg3.map;
e3 = obj_60606a00_G_FT_sym_avg3.e;

qmmap2 = obj_60609a00_G_FT_sym_avg3.map;
e2 = obj_60609a00_G_FT_sym_avg3.e;


eall = cat(2, e1, e2(2:end), e3(2:end));
qmmapall = cat(3, qmmap1, qmmap2(:,:,2:end), qmmap3(:,:,2:end));
% -2.0, -1.6 or -1.5 (9 or 10), -1.0 meV
[nx, ny, nz] = size(qmmapall(105:196,105:196,:));
qmmapc = qmmapall(105:196,105:196,:);
qmmc = qmq(105:196);

obj_6060469A00_markers = obj_60604A00_G_FT_sym_avg3;

obj_6060469A00_markers.map = qmmapc;
obj_6060469A00_markers.r = qmmc;
obj_6060469A00_markers.e = eall;

obj_6060469A00_markers = rm_center(obj_6060469A00_markers);

% energy layers actually run from -1.1, -0.9, -0.8, -0.7, -0.6, -0.5, pad with imaginary numbers
% where you don't want to display anything
eg_peter = eall;
le = length(eg_peter);
xg1 = 1i*ones(1, le);
yg1 = 1i*ones(1, le);
xg2 = 1i*ones(1, le);
yg2 = 1i*ones(1, le);
xg3 = 1i*ones(1, le);
yg3 = 1i*ones(1, le);

xg4 = 1i*ones(1, le);
yg4 = 1i*ones(1, le);
xg5 = 1i*ones(1, le);
yg5 = 1i*ones(1, le);
xg6 = 1i*ones(1, le);
yg6 = 1i*ones(1, le);

% markers fro size of q-space area
xgqd = 0.290*ones(1, le);
ygqd = 0.290*ones(1, le);

% insert q2 values into the imaginary numbers so that actual spots /
% markers will be displayed there
xm_peter = [0.23219, 0.26964,0.28462,0.31458,0.33705,0.34454, 0.36963];
ym_peter = abs([-0.08239, -0.08239,-0.0749,-0.06741,-0.05992,-0.05243, 0]);

% M point
xg4(5) = xm_peter(1);
yg4(5) = ym_peter(1);

xg4(7:11) = xm_peter(2:6);
yg4(7:11) = ym_peter(2:6);

xg4(13) = xm_peter(7);
yg4(13) = ym_peter(7);

xg4(19) = xm_peter(7);
yg4(19) = ym_peter(7);

xg4(21:25) = fliplr(xm_peter(2:6));
yg4(21:25) = fliplr(ym_peter(2:6));

xg4(27) = xm_peter(1);
yg4(27) = ym_peter(1);

% Gamma point 
xg_peter = [0.10304,0.0966,0.09016,0.08372,0.07728,0.07084,0.0644,0.0644];
yg_peter = abs([-0.14168,-0.15456,-0.15456,-0.161,-0.161,-0.16744,-0.16744,-0.17388]);

xg2(1:8) = xg_peter;
yg2(1:8) = yg_peter;
% flip the order of the q-vectors for the positive side
xg2(24:31) = fliplr(xg_peter);
yg2(24:31) = fliplr(yg_peter);
%% Gamma
cc = 1;
cc2 = 31;
for i=7 : 14
    dummy = q1_lorparcomb(i,1:5);
    xg3(cc) = 0;
    yg3(cc) = dummy(3);
    cc = cc+1;
    
    xg3(cc2) = 0;
    yg3(cc2) = dummy(3);
    cc2 = cc2-1;
end    
cc = 1;
cc2 = 31;
for i=10 : 17
    dummy = q3_lorparcomb(i,1:5);
    
        xg1(cc) = dummy(3);
        yg1(cc) = 0;
        cc = cc + 1;
        xg1(cc2) = dummy(3);
        yg1(cc2) = 0; 
        cc2 = cc2 - 1;
end  
%% M

cc = 7;
cc2 = 25;

for i=1 : 6
    dummy = q1m_lorparcomb(i,1:5);
    if i ==1
        xg5(5) = 0;
        yg5(5) = dummy(3);
        
        xg5(27) = 0;
        yg5(27) = dummy(3);
    elseif i > 1 && i <= 6
        xg5(cc) = 0;
        yg5(cc) = dummy(3);
        cc = cc +1;
        xg5(cc2) = 0;
        yg5(cc2) = dummy(3);
        cc2 = cc2 - 1;
    end
    
end    
    
cc = 7;
cc2 = 25;

for i=1 : 6
    dummy = q3m_lorparcomb(i,1:5);
    
    if i ==1
        xg6(5) = dummy(3);
        yg6(5) = 0;
        
        xg6(27) = dummy(3);
        yg6(27) = 0;
    elseif i > 1 && i <= 6
        xg6(cc) = dummy(3);
        yg6(cc) = 0;
        cc = cc +1;
        xg6(cc2) = dummy(3);
        yg6(cc2) = 0;
        cc2 = cc2 - 1;
    end
end  




%% add the position of the markers to the newly created structure
obj_6060469A00_markers.x = xg1;
obj_6060469A00_markers.y = yg1;

obj_6060469A00_markers.x2 = xg2;
obj_6060469A00_markers.y2 = yg2;

obj_6060469A00_markers.x3 = xg3;
obj_6060469A00_markers.y3 = yg3;

obj_6060469A00_markers.x4 = xg4;
obj_6060469A00_markers.y4 = yg4;

obj_6060469A00_markers.x5 = xg5;
obj_6060469A00_markers.y5 = yg5;

obj_6060469A00_markers.x6 = xg6;
obj_6060469A00_markers.y6 = yg6;

obj_6060469A00_markers.xqd = xgqd;
obj_6060469A00_markers.yqd = ygqd;
