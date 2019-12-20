gammamap = obj_60222a00_G_FT_sym_avg3.map(:,:,2:48);
qgamma = obj_60222a00_G_FT_sym_avg3.r;


% -2.0, -1.6 or -1.5 (9 or 10), -1.0 meV
[nx, ny, nz] = size(gammamap(11:118,11:118,5));
gmc = gammamap(11:118,11:118,:);
qgammac = qgamma(11:118);

obj_60222a00_G_FT_sym_avg3_markers = obj_60222a00_G_FT_sym_avg3;
obj_60222a00_G_FT_sym_avg3_markers.e = obj_60222a00_G_FT_sym_avg3_markers.e(2:48);

obj_60222a00_G_FT_sym_avg3_markers.map = gmc;
obj_60222a00_G_FT_sym_avg3_markers.r = qgammac;


obj_60222a00_G_FT_sym_avg3_markers = rm_center(obj_60222a00_G_FT_sym_avg3_markers);

% energy layers actually run from -2.3 to +2.3, pad with imaginary numbers
% where you don't want to display anything
eg_peter = -2.3 : 0.1 : 2.3;
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
xgqd = 0.2898*ones(1, le);
ygqd = 0.2898*ones(1, le);
% insert q2 values into the imaginary numbers so that actual spots /
% markers will be displayed there
xg_peter = [0.122,0.10948,0.10304,0.10304,0.10304,0.0966,0.10304,0.0966,0.09016,0.08372,0.07728,0.07084,0.0644,0.0644];
yg_peter = abs([-0.077,-0.10304,-0.10948,-0.11592,-0.12236,-0.1288,-0.14168,-0.15456,-0.15456,-0.161,-0.161,-0.16744,-0.16744,-0.17388]);

xg2(3:16) = xg_peter;
yg2(3:16) = yg_peter;
% flip the order of the q-vectors for the positive side
xg2(32:45) = fliplr(xg_peter);
yg2(32:45) = fliplr(yg_peter);

%% 

%%

for i=1 : 12
    dummy = q1_lorparcomb(i,1:5);
    xg3(2+i) = 0;
    yg3(2+i) = dummy(3);
    
    xg3(46-i) = 0;
    yg3(46-i) = dummy(3);
end    
    
for i=1 : 12
    dummy = q3_lorparcomb(i,1:5);
    
%     if i==1
%        xg1(1) = dummy(3);
%        yg1(1) = 0;
%        
%        xg1(end) = dummy(3);
%        yg1(end) = 0;
%     elseif i >= 4
        xg1(i) = dummy(3);
        yg1(i) = 0;
    
        xg1(48-i) = dummy(3);
        yg1(48-i) = 0; 
    
%     end
end  




%% add the position of the markers to the newly created structure
obj_60222a00_G_FT_sym_avg3_markers.x = xg1;
obj_60222a00_G_FT_sym_avg3_markers.y = yg1;

obj_60222a00_G_FT_sym_avg3_markers.x2 = xg2;
obj_60222a00_G_FT_sym_avg3_markers.y2 = yg2;

obj_60222a00_G_FT_sym_avg3_markers.x3 = xg3;
obj_60222a00_G_FT_sym_avg3_markers.y3 = yg3;

obj_60222a00_G_FT_sym_avg3_markers.x4 = xg4;
obj_60222a00_G_FT_sym_avg3_markers.y4 = yg4;

obj_60222a00_G_FT_sym_avg3_markers.x5 = xg5;
obj_60222a00_G_FT_sym_avg3_markers.y5 = yg5;

obj_60222a00_G_FT_sym_avg3_markers.x6 = xg6;
obj_60222a00_G_FT_sym_avg3_markers.y6 = yg6;

obj_60222a00_G_FT_sym_avg3_markers.xqd = xgqd;
obj_60222a00_G_FT_sym_avg3_markers.yqd = ygqd;

%% put imaginary markers in the real space structure for movie exporting

% energy layers actually run from -2.3 to +2.3, pad with imaginary numbers
% where you don't want to display anything
eg_peter = -2.3 : 0.1 : 2.3;
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
xgqd = 1i*ones(1, le);
ygqd = 1i*ones(1, le);

obj_60222a00_G_markers = obj_60222a00_G;
obj_60222a00_G_markers.e = obj_60222a00_G_markers.e(27:73);
obj_60222a00_G_markers.map = obj_60222a00_G_markers.map(:,:,27:73);

obj_60222a00_G_markers.x = xg1;
obj_60222a00_G_markers.y = yg1;

obj_60222a00_G_markers.x2 = xg2;
obj_60222a00_G_markers.y2 = yg2;

obj_60222a00_G_markers.x3 = xg3;
obj_60222a00_G_markers.y3 = yg3;

obj_60222a00_G_markers.x4 = xg4;
obj_60222a00_G_markers.y4 = yg4;

obj_60222a00_G_markers.x5 = xg5;
obj_60222a00_G_markers.y5 = yg5;

obj_60222a00_G_markers.x6 = xg6;
obj_60222a00_G_markers.y6 = yg6;

obj_60222a00_G_markers.xqd = xgqd;
obj_60222a00_G_markers.yqd = ygqd;