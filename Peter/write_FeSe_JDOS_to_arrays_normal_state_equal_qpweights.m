q = linspace(0, 1/2*pi/2.66, 201);
qc = cat(2, -fliplr(q(2:end)), q);

%% both gamma and X
for i=0:120
    s = strcat('C:\Users\pspra\OneDrive\VOSM\QPI layers\12022016_Andreas_Tmatrix_no_quasiparticleweight\matlab\','JDOS_g-0.1_f_0_', num2str(i), 'conv.mat');
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12022016_Andreas_Tmatrix_no_quasiparticleweight\matlab\','JDOS_g-0.1_f_0_', num2str(i), 'conv.mat');
    dummy = load(s);
    quartmap = dummy.rjd0;
    qmlr = fliplr(quartmap);
    qmud = flipud(quartmap);
    qmlrud = flipud(qmlr);
    
    dum1 = cat(2, qmlrud, qmud(1:end, 2:end));
    dum2 = cat(2, qmlr(2:end, 1:end), quartmap(2:end, 2:end));
    dum3 = cat(1, dum1, dum2);
%     figure, imagesc(dum3)
    [nx, ny, nz] = size(dum3);
    allsim(1:nx,1:ny,i+1) = abs(dum3(:, :));
    qall = qc;
end

% %% only gamma
% for i=0:120
%     
% %     s = strcat('C:\Users\pspra\Dropbox\QPI layers\11032016Andreas_Tmatrix_matlab\','JDOS_g-0.1_f_222_G_', num2str(i), 'conv.mat');
%     s = strcat('C:\Users\Peter\Dropbox\QPI layers\11032016Andreas_Tmatrix_matlab\','JDOS_g-0.1_f_222_G_', num2str(i), 'conv.mat');
%     dummy = load(s);
%     quartmap = dummy.rjd0;
%     qmlr = fliplr(quartmap);
%     qmud = flipud(quartmap);
%     qmlrud = flipud(qmlr);
%     
%     dum1 = cat(2, qmlrud, qmud(1:end, 2:end));
%     dum2 = cat(2, qmlr(2:end, 1:end), quartmap(2:end, 2:end));
%     dum3 = cat(1, dum1, dum2);
% %     figure, imagesc(dum3)
%     [nx, ny, nz] = size(dum3);
%     gammasim(1:nx,1:ny,i+1) = abs(dum3(:, :));
%     qgam = qc;
% end
% 
% %% only X
% for i=0:120
%     
% %     s = strcat('C:\Users\pspra\Dropbox\QPI layers\11032016Andreas_Tmatrix_matlab\','JDOS_g-0.1_f_222_X_', num2str(i), 'conv.mat');
%     s = strcat('C:\Users\Peter\Dropbox\QPI layers\11032016Andreas_Tmatrix_matlab\','JDOS_g-0.1_f_222_X_', num2str(i), 'conv.mat');
%     dummy = load(s);
%     quartmap = dummy.rjd0;
%     qmlr = fliplr(quartmap);
%     qmud = flipud(quartmap);
%     qmlrud = flipud(qmlr);
%     
%     dum1 = cat(2, qmlrud, qmud(1:end, 2:end));
%     dum2 = cat(2, qmlr(2:end, 1:end), quartmap(2:end, 2:end));
%     dum3 = cat(1, dum1, dum2);
% %     figure, imagesc(dum3)
%     [nx, ny, nz] = size(dum3);
%     epsilonsim(1:nx,1:ny,i+1) = abs(dum3(:, :));
%     qeps = qc;
% end
%%


% obj_gammasim_JDOS = obj_60721a00_G;
% obj_epsilonsim_JDOS = obj_60721a00_G;
obj_allsim_JDOS = obj_60721a00_G;
ev = linspace(-0.06, 0.06,121);

% obj_alphaeps_JDOS = obj_60721a00_G;

% obj_gammasim_JDOS.e = ev;
% obj_gammasim_JDOS.r = qgam;
% obj_gammasim_JDOS.map = gammasim;
% obj_epsilonsim_JDOS.e = ev;
% obj_epsilonsim_JDOS.r = qeps;
% obj_epsilonsim_JDOS.map = epsilonsim;
obj_allsim_JDOS.e = ev;
obj_allsim_JDOS.r = qall;
obj_allsim_JDOS.map = allsim;

% obj_alphaeps_JDOS.e = ev(16:46);
% obj_alphaeps_JDOS.r = qeps;
% obj_alphaeps_JDOS.map = Gammasimbig(:,:,16:46)+Epsilonsim(:,:,16:46);
%%
% 
% le = length(ev(8:54));
% xg1 = 1i*ones(1, le);
% yg1 = 1i*ones(1, le);
% xg2 = 1i*ones(1, le);
% yg2 = 1i*ones(1, le);
% xg3 = 1i*ones(1, le);
% yg3 = 1i*ones(1, le);
% 
% xg4 = 1i*ones(1, le);
% yg4 = 1i*ones(1, le);
% xg5 = 1i*ones(1, le);
% yg5 = 1i*ones(1, le);
% xg6 = 1i*ones(1, le);
% yg6 = 1i*ones(1, le);
% 
% % markers fro size of q-space area
% xgqd = 0.29*ones(1, le);
% ygqd = 0.29*ones(1, le);
% 
% % Gamma
% obj_gammasim_JDOS.x = xg1;
% obj_gammasim_JDOS.y = yg1;
% 
% obj_gammasim_JDOS.x2 = xg2;
% obj_gammasim_JDOS.y2 = yg2;
% 
% obj_gammasim_JDOS.x3 = xg3;
% obj_gammasim_JDOS.y3 = yg3;
% 
% obj_gammasim_JDOS.x4 = xg4;
% obj_gammasim_JDOS.y4 = yg4;
% 
% obj_gammasim_JDOS.x5 = xg5;
% obj_gammasim_JDOS.y5 = yg5;
% 
% obj_gammasim_JDOS.x6 = xg6;
% obj_gammasim_JDOS.y6 = yg6;
% 
% obj_gammasim_JDOS.xqd = xgqd;
% obj_gammasim_JDOS.yqd = ygqd;
% 
% le = length([ev(20),ev(22:26)]);
% xg1 = 1i*ones(1, le);
% yg1 = 1i*ones(1, le);
% xg2 = 1i*ones(1, le);
% yg2 = 1i*ones(1, le);
% xg3 = 1i*ones(1, le);
% yg3 = 1i*ones(1, le);
% 
% xg4 = 1i*ones(1, le);
% yg4 = 1i*ones(1, le);
% xg5 = 1i*ones(1, le);
% yg5 = 1i*ones(1, le);
% xg6 = 1i*ones(1, le);
% yg6 = 1i*ones(1, le);
% 
% % markers fro size of q-space area
% xgqd = 0.29*ones(1, le);
% ygqd = 0.29*ones(1, le);
% % Epsilon
% obj_epsilonsim_JDOS.x = xg1;
% obj_epsilonsim_JDOS.y = yg1;
% 
% obj_epsilonsim_JDOS.x2 = xg2;
% obj_epsilonsim_JDOS.y2 = yg2;
% 
% obj_epsilonsim_JDOS.x3 = xg3;
% obj_epsilonsim_JDOS.y3 = yg3;
% 
% obj_epsilonsim_JDOS.x4 = xg4;
% obj_epsilonsim_JDOS.y4 = yg4;
% 
% obj_epsilonsim_JDOS.x5 = xg5;
% obj_epsilonsim_JDOS.y5 = yg5;
% 
% obj_epsilonsim_JDOS.x6 = xg6;
% obj_epsilonsim_JDOS.y6 = yg6;
% 
% obj_epsilonsim_JDOS.xqd = xgqd;
% obj_epsilonsim_JDOS.yqd = ygqd;
% 
% le = length(ev);
% xg1 = 1i*ones(1, le);
% yg1 = 1i*ones(1, le);
% xg2 = 1i*ones(1, le);
% yg2 = 1i*ones(1, le);
% xg3 = 1i*ones(1, le);
% yg3 = 1i*ones(1, le);
% 
% xg4 = 1i*ones(1, le);
% yg4 = 1i*ones(1, le);
% xg5 = 1i*ones(1, le);
% yg5 = 1i*ones(1, le);
% xg6 = 1i*ones(1, le);
% yg6 = 1i*ones(1, le);
% 
% % markers fro size of q-space area
% xgqd = 0.29*ones(1, le);
% ygqd = 0.29*ones(1, le);
% % All pockets
% obj_allsim_JDOS.x = xg1;
% obj_allsim_JDOS.y = yg1;
% 
% obj_allsim_JDOS.x2 = xg2;
% obj_allsim_JDOS.y2 = yg2;
% 
% obj_allsim_JDOS.x3 = xg3;
% obj_allsim_JDOS.y3 = yg3;
% 
% obj_allsim_JDOS.x4 = xg4;
% obj_allsim_JDOS.y4 = yg4;
% 
% obj_allsim_JDOS.x5 = xg5;
% obj_allsim_JDOS.y5 = yg5;
% 
% obj_allsim_JDOS.x6 = xg6;
% obj_allsim_JDOS.y6 = yg6;
% 
% obj_allsim_JDOS.xqd = xgqd;
% obj_allsim_JDOS.yqd = ygqd;
% 
% le = length(ev(16:46));
% xg1 = 1i*ones(1, le);
% yg1 = 1i*ones(1, le);
% xg2 = 1i*ones(1, le);
% yg2 = 1i*ones(1, le);
% xg3 = 1i*ones(1, le);
% yg3 = 1i*ones(1, le);
% 
% xg4 = 1i*ones(1, le);
% yg4 = 1i*ones(1, le);
% xg5 = 1i*ones(1, le);
% yg5 = 1i*ones(1, le);
% xg6 = 1i*ones(1, le);
% yg6 = 1i*ones(1, le);
% 
% % markers fro size of q-space area
% xgqd = 0.29*ones(1, le);
% ygqd = 0.29*ones(1, le);
% % Both gamma and epsilon
% obj_alphaeps_JDOS.x = xg1;
% obj_alphaeps_JDOS.y = yg1;
% 
% obj_alphaeps_JDOS.x2 = xg2;
% obj_alphaeps_JDOS.y2 = yg2;
% 
% obj_alphaeps_JDOS.x3 = xg3;
% obj_alphaeps_JDOS.y3 = yg3;
% 
% obj_alphaeps_JDOS.x4 = xg4;
% obj_alphaeps_JDOS.y4 = yg4;
% 
% obj_alphaeps_JDOS.x5 = xg5;
% obj_alphaeps_JDOS.y5 = yg5;
% 
% obj_alphaeps_JDOS.x6 = xg6;
% obj_alphaeps_JDOS.y6 = yg6;
% 
% obj_alphaeps_JDOS.xqd = xgqd;
% obj_alphaeps_JDOS.yqd = ygqd;
% %% all movies are in principle from -3 to +3, cut to energies so that the
% %% match the experimental movies
% 
% 
% 
% 
% 
