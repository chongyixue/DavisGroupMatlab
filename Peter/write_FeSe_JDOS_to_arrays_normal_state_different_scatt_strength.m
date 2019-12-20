q = linspace(0, 1/2*pi/2.66, 201);
qc = cat(2, -fliplr(q(2:end)), q);

%% both gamma and X
for i=1:2
    
    if i==1
        sn = '40';
    else
        sn = '70';
    end
    
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g-0.1_f_222_', sn, 'conv.mat');
    s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g-0.1_f_222_', sn, 'conv.mat');
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
    allsim(1:nx,1:ny,i) = abs(dum3(:, :));
    qall = qc;
end


obj_allsim_JDOS_m0_1 = obj_60721a00_G;
ev = [-0.02, 0.01];


obj_allsim_JDOS_m0_1.e = ev;
obj_allsim_JDOS_m0_1.r = qall;
obj_allsim_JDOS_m0_1.map = allsim;
obj_allsim_JDOS_m0_1.var = '-0.1 V potential';
%%
%% both gamma and X
for i=1:2
    
    if i==1
        sn = '40';
    else
        sn = '70';
    end
    
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g-0.25_f_222_', sn, 'conv.mat');
    s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g-0.25_f_222_', sn, 'conv.mat');
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
    allsim(1:nx,1:ny,i) = abs(dum3(:, :));
    qall = qc;
end


obj_allsim_JDOS_m0_25 = obj_60721a00_G;
ev = [-0.02, 0.01];


obj_allsim_JDOS_m0_25.e = ev;
obj_allsim_JDOS_m0_25.r = qall;
obj_allsim_JDOS_m0_25.map = allsim;
obj_allsim_JDOS_m0_25.var = '-0.25 V potential';
%% both gamma and X
for i=1:2
    
    if i==1
        sn = '40';
    else
        sn = '70';
    end
    
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g0.25_f_222_', sn, 'conv.mat');
    s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g0.25_f_222_', sn, 'conv.mat');
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
    allsim(1:nx,1:ny,i) = abs(dum3(:, :));
    qall = qc;
end


obj_allsim_JDOS_p0_25 = obj_60721a00_G;
ev = [-0.02, 0.01];


obj_allsim_JDOS_p0_25.e = ev;
obj_allsim_JDOS_p0_25.r = qall;
obj_allsim_JDOS_p0_25.map = allsim;
obj_allsim_JDOS_p0_25.var = '0.25 V potential';
%% both gamma and X
for i=1:2
    
    if i==1
        sn = '40';
    else
        sn = '70';
    end
    
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g-0.5_f_222_', sn, 'conv.mat');
    s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g-0.5_f_222_', sn, 'conv.mat');
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
    allsim(1:nx,1:ny,i) = abs(dum3(:, :));
    qall = qc;
end


obj_allsim_JDOS_m0_5 = obj_60721a00_G;
ev = [-0.02, 0.01];

obj_allsim_JDOS_m0_5.e = ev;
obj_allsim_JDOS_m0_5.r = qall;
obj_allsim_JDOS_m0_5.map = allsim;
obj_allsim_JDOS_m0_5.var = '-0.5 V potential';

%% both gamma and X
for i=1:2
    
    if i==1
        sn = '40';
    else
        sn = '70';
    end
    
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g0.5_f_222_', sn, 'conv.mat');
    s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g0.5_f_222_', sn, 'conv.mat');
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
    allsim(1:nx,1:ny,i) = abs(dum3(:, :));
    qall = qc;
end


obj_allsim_JDOS_p0_5 = obj_60721a00_G;
ev = [-0.02, 0.01];

obj_allsim_JDOS_p0_5.e = ev;
obj_allsim_JDOS_p0_5.r = qall;
obj_allsim_JDOS_p0_5.map = allsim;
obj_allsim_JDOS_p0_5.var = '0.5 V potential';

%% both gamma and X
for i=1:2
    
    if i==1
        sn = '40';
    else
        sn = '70';
    end
    
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g1.0_f_222_', sn, 'conv.mat');
    s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g1.0_f_222_', sn, 'conv.mat');
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
    allsim(1:nx,1:ny,i) = abs(dum3(:, :));
    qall = qc;
end


obj_allsim_JDOS_p1 = obj_60721a00_G;
ev = [-0.02, 0.01];


obj_allsim_JDOS_p1.e = ev;
obj_allsim_JDOS_p1.r = qall;
obj_allsim_JDOS_p1.map = allsim;
obj_allsim_JDOS_p1.var = '1 V potential';
%% both gamma and X
for i=1:2
    
    if i==1
        sn = '40';
    else
        sn = '70';
    end
    
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g-5_f_222_', sn, 'conv.mat');
    s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g-5_f_222_', sn, 'conv.mat');
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
    allsim(1:nx,1:ny,i) = abs(dum3(:, :));
    qall = qc;
end


obj_allsim_JDOS_m5 = obj_60721a00_G;
ev = [-0.02, 0.01];


obj_allsim_JDOS_m5.e = ev;
obj_allsim_JDOS_m5.r = qall;
obj_allsim_JDOS_m5.map = allsim;
obj_allsim_JDOS_m5.var = '-5 V potential';
%% both gamma and X
for i=1:2
    
    if i==1
        sn = '40';
    else
        sn = '70';
    end
    
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g5_f_222_', sn, 'conv.mat');
    s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g5_f_222_', sn, 'conv.mat');
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
    allsim(1:nx,1:ny,i) = abs(dum3(:, :));
    qall = qc;
end


obj_allsim_JDOS_p5 = obj_60721a00_G;
ev = [-0.02, 0.01];


obj_allsim_JDOS_p5.e = ev;
obj_allsim_JDOS_p5.r = qall;
obj_allsim_JDOS_p5.map = allsim;
obj_allsim_JDOS_p5.var = '5 V potential';
%% both gamma and X
for i=1:2
    
    if i==1
        sn = '40';
    else
        sn = '70';
    end
    
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g-25_f_222_', sn, 'conv.mat');
    s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g-25_f_222_', sn, 'conv.mat');
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
    allsim(1:nx,1:ny,i) = abs(dum3(:, :));
    qall = qc;
end


obj_allsim_JDOS_m25 = obj_60721a00_G;
ev = [-0.02, 0.01];


obj_allsim_JDOS_m25.e = ev;
obj_allsim_JDOS_m25.r = qall;
obj_allsim_JDOS_m25.map = allsim;
obj_allsim_JDOS_m25.var = '-25 V potential';
%% both gamma and X
for i=1:2
    
    if i==1
        sn = '40';
    else
        sn = '70';
    end
    
%     s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g25_f_222_', sn, 'conv.mat');
    s = strcat('C:\Users\Peter\OneDrive\VOSM\QPI layers\12122016_different impurity potential strengths\','JDOS_g25_f_222_', sn, 'conv.mat');
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
    allsim(1:nx,1:ny,i) = abs(dum3(:, :));
    qall = qc;
end


obj_allsim_JDOS_p25 = obj_60721a00_G;
ev = [-0.02, 0.01];


obj_allsim_JDOS_p25.e = ev;
obj_allsim_JDOS_p25.r = qall;
obj_allsim_JDOS_p25.map = allsim;
obj_allsim_JDOS_p25.var = '25 V potential';