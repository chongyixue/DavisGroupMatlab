q = linspace(-pi/2.7, pi/2.7, 801);

for i=0:60
    s = strcat('C:\Users\pspra\OneDrive\800 pxl simulations\JDOS matlab files\','AKSC_-3_', num2str(i), '_gJDOS.mat');
%     s = strcat('C:\Users\Peter\OneDrive\800 pxl simulations\JDOS matlab files\','AKSC_-3_', num2str(i), '_gJDOS.mat');
    dummy = load(s);
    [nx, ny, nz] = size(dummy.B(284:518, 284:518));
    Gammasim(1:nx,1:ny,i+1) = abs(dummy.B(284:518, 284:518))';
    [nxb, nyb, nzb] = size(dummy.B(246:556, 246:556));
    Gammasimbig(1:nxb,1:nyb,i+1) = abs(dummy.B(246:556, 246:556))';
    qgam = q(284:518);
end

for i=0:60
    
    s = strcat('C:\Users\pspra\OneDrive\800 pxl simulations\JDOS matlab files\','AKSC_-3_', num2str(i), '_xJDOS.mat');
%     s = strcat('C:\Users\Peter\OneDrive\800 pxl simulations\JDOS matlab files\','AKSC_-3_', num2str(i), '_xJDOS.mat');
    dummy = load(s);
    [nx, ny, nz] = size(dummy.B(246:556, 246:556));
%     [nx, ny, nz] = size(dummy.B(284:518, 284:518));
    Epsilonsim(1:nx,1:ny,i+1) = abs(dummy.B(246:556, 246:556))';
%     Epsilonsim(1:nx,1:ny,i+1) = abs(dummy.B(284:518, 284:518))';
    qeps = q(246:556);
%     qeps = q(284:518);
end

for i=0:60
    
    s = strcat('C:\Users\pspra\OneDrive\800 pxl simulations\JDOS matlab files\','AKSC_-3_', num2str(i), 'JDOS.mat');
%     s = strcat('C:\Users\Peter\OneDrive\800 pxl simulations\JDOS matlab files\','AKSC_-3_', num2str(i), 'JDOS.mat');
    dummy = load(s);
    [nx, ny, nz] = size(dummy.B(246:556, 246:556));
    allsim(1:nx,1:ny,i+1) = abs(dummy.B(246:556, 246:556))';
    qall = q(246:556);
end



obj_gammasim_JDOS = obj_60222a00_G;
obj_epsilonsim_JDOS = obj_60222a00_G;
obj_allsim_JDOS = obj_60222a00_G;
ev = linspace(-0.003, 0.003,61);

obj_alphaeps_JDOS = obj_60222a00_G;

obj_gammasim_JDOS.e = ev(8:54);
obj_gammasim_JDOS.r = qgam;
obj_gammasim_JDOS.map = Gammasim(:,:,8:54);
obj_epsilonsim_JDOS.e = [ev(20),ev(22:26)];
obj_epsilonsim_JDOS.r = qeps;
obj_epsilonsim_JDOS.map = cat(3,Epsilonsim(:,:,20), Epsilonsim(:,:,22:26));
obj_allsim_JDOS.e = ev;
obj_allsim_JDOS.r = qall;
obj_allsim_JDOS.map = allsim;

obj_alphaeps_JDOS.e = ev(16:46);
obj_alphaeps_JDOS.r = qeps;
obj_alphaeps_JDOS.map = Gammasimbig(:,:,16:46)+Epsilonsim(:,:,16:46);
%%

le = length(ev(8:54));
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
xgqd = 0.29*ones(1, le);
ygqd = 0.29*ones(1, le);

% Gamma
obj_gammasim_JDOS.x = xg1;
obj_gammasim_JDOS.y = yg1;

obj_gammasim_JDOS.x2 = xg2;
obj_gammasim_JDOS.y2 = yg2;

obj_gammasim_JDOS.x3 = xg3;
obj_gammasim_JDOS.y3 = yg3;

obj_gammasim_JDOS.x4 = xg4;
obj_gammasim_JDOS.y4 = yg4;

obj_gammasim_JDOS.x5 = xg5;
obj_gammasim_JDOS.y5 = yg5;

obj_gammasim_JDOS.x6 = xg6;
obj_gammasim_JDOS.y6 = yg6;

obj_gammasim_JDOS.xqd = xgqd;
obj_gammasim_JDOS.yqd = ygqd;

le = length([ev(20),ev(22:26)]);
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
xgqd = 0.29*ones(1, le);
ygqd = 0.29*ones(1, le);
% Epsilon
obj_epsilonsim_JDOS.x = xg1;
obj_epsilonsim_JDOS.y = yg1;

obj_epsilonsim_JDOS.x2 = xg2;
obj_epsilonsim_JDOS.y2 = yg2;

obj_epsilonsim_JDOS.x3 = xg3;
obj_epsilonsim_JDOS.y3 = yg3;

obj_epsilonsim_JDOS.x4 = xg4;
obj_epsilonsim_JDOS.y4 = yg4;

obj_epsilonsim_JDOS.x5 = xg5;
obj_epsilonsim_JDOS.y5 = yg5;

obj_epsilonsim_JDOS.x6 = xg6;
obj_epsilonsim_JDOS.y6 = yg6;

obj_epsilonsim_JDOS.xqd = xgqd;
obj_epsilonsim_JDOS.yqd = ygqd;

le = length(ev);
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
xgqd = 0.29*ones(1, le);
ygqd = 0.29*ones(1, le);
% All pockets
obj_allsim_JDOS.x = xg1;
obj_allsim_JDOS.y = yg1;

obj_allsim_JDOS.x2 = xg2;
obj_allsim_JDOS.y2 = yg2;

obj_allsim_JDOS.x3 = xg3;
obj_allsim_JDOS.y3 = yg3;

obj_allsim_JDOS.x4 = xg4;
obj_allsim_JDOS.y4 = yg4;

obj_allsim_JDOS.x5 = xg5;
obj_allsim_JDOS.y5 = yg5;

obj_allsim_JDOS.x6 = xg6;
obj_allsim_JDOS.y6 = yg6;

obj_allsim_JDOS.xqd = xgqd;
obj_allsim_JDOS.yqd = ygqd;

le = length(ev(16:46));
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
xgqd = 0.29*ones(1, le);
ygqd = 0.29*ones(1, le);
% Both gamma and epsilon
obj_alphaeps_JDOS.x = xg1;
obj_alphaeps_JDOS.y = yg1;

obj_alphaeps_JDOS.x2 = xg2;
obj_alphaeps_JDOS.y2 = yg2;

obj_alphaeps_JDOS.x3 = xg3;
obj_alphaeps_JDOS.y3 = yg3;

obj_alphaeps_JDOS.x4 = xg4;
obj_alphaeps_JDOS.y4 = yg4;

obj_alphaeps_JDOS.x5 = xg5;
obj_alphaeps_JDOS.y5 = yg5;

obj_alphaeps_JDOS.x6 = xg6;
obj_alphaeps_JDOS.y6 = yg6;

obj_alphaeps_JDOS.xqd = xgqd;
obj_alphaeps_JDOS.yqd = ygqd;
%% all movies are in principle from -3 to +3, cut to energies so that the
%% match the experimental movies





