mmap = obj_605047A00.map;
qm = obj_605047A00.r;


% -2.0, -1.6 or -1.5 (9 or 10), -1.0 meV
[nx, ny, nz] = size(mmap(140:261,140:261,5));
mmc = mmap(140:261,140:261,:);
qmc = qm(140:261);

obj_605047A00_markers = obj_605047A00;

obj_605047A00_markers.map = mmc;
obj_605047A00_markers.r = qmc;


obj_605047A00_markers = rm_center(obj_605047A00_markers);

% energy layers actually run from -1.1, -0.9, -0.8, -0.7, -0.6, -0.5, pad with imaginary numbers
% where you don't want to display anything
eg_peter = obj_605047A00_markers.e;
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
xgqd = 0.2920*ones(1, le);
ygqd = 0.2920*ones(1, le);

% insert q2 values into the imaginary numbers so that actual spots /
% markers will be displayed there
xm_peter = [0.23219, 0.26964,0.28462,0.31458,0.33705,0.34454];
ym_peter = abs([-0.08239, -0.08239,-0.0749,-0.06741,-0.05992,-0.05243]);


xg4 = xm_peter;
yg4 = ym_peter;

%% 

%%

for i=1 : 6
    dummy = q1m_lorparcomb(i,1:5);
    xg5(i) = 0;
    yg5(i) = dummy(3);
    
end    
    
for i=1 : 6
    dummy = q3m_lorparcomb(i,1:5);
    xg6(i) = dummy(3);
    yg6(i) = 0;
    
end  




%% add the position of the markers to the newly created structure
obj_605047A00_markers.x = xg1;
obj_605047A00_markers.y = yg1;

obj_605047A00_markers.x2 = xg2;
obj_605047A00_markers.y2 = yg2;

obj_605047A00_markers.x3 = xg3;
obj_605047A00_markers.y3 = yg3;

obj_605047A00_markers.x4 = xg4;
obj_605047A00_markers.y4 = yg4;

obj_605047A00_markers.x5 = xg5;
obj_605047A00_markers.y5 = yg5;

obj_605047A00_markers.x6 = xg6;
obj_605047A00_markers.y6 = yg6;

obj_605047A00_markers.xqd = xgqd;
obj_605047A00_markers.yqd = ygqd;
