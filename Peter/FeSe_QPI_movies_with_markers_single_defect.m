
obj_60721a00_F_FT_pub_markers = obj_60721a00_F_FT_pub;

le = length(obj_60721a00_F_FT_pub.e);

% obj_60721a00_F_FT_pub_markers = rm_center(obj_60721a00_F_FT_pub);

% energy layers actually run from -2.3 to +2.3, pad with imaginary numbers
% where you don't want to display anything

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


%% add the position of the markers to the newly created structure
obj_60721a00_F_FT_pub_markers.x = xg1;
obj_60721a00_F_FT_pub_markers.y = yg1;

obj_60721a00_F_FT_pub_markers.x2 = xg2;
obj_60721a00_F_FT_pub_markers.y2 = yg2;

obj_60721a00_F_FT_pub_markers.x3 = xg3;
obj_60721a00_F_FT_pub_markers.y3 = yg3;

obj_60721a00_F_FT_pub_markers.x4 = xg4;
obj_60721a00_F_FT_pub_markers.y4 = yg4;

obj_60721a00_F_FT_pub_markers.x5 = xg5;
obj_60721a00_F_FT_pub_markers.y5 = yg5;

obj_60721a00_F_FT_pub_markers.x6 = xg6;
obj_60721a00_F_FT_pub_markers.y6 = yg6;

obj_60721a00_F_FT_pub_markers.xqd = xgqd;
obj_60721a00_F_FT_pub_markers.yqd = ygqd;

%% open in img_obj_viewer with hotspots

img_obj_viewer_hotspots(obj_60721a00_F_FT_pub_markers);

%%
JDOS_qspace_pub_markers = JDOS_qspace_pub;

le = length(JDOS_qspace_pub.e);


% energy layers actually run from -2.3 to +2.3, pad with imaginary numbers
% where you don't want to display anything

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


%% add the position of the markers to the newly created structure
JDOS_qspace_pub_markers.x = xg1;
JDOS_qspace_pub_markers.y = yg1;

JDOS_qspace_pub_markers.x2 = xg2;
JDOS_qspace_pub_markers.y2 = yg2;

JDOS_qspace_pub_markers.x3 = xg3;
JDOS_qspace_pub_markers.y3 = yg3;

JDOS_qspace_pub_markers.x4 = xg4;
JDOS_qspace_pub_markers.y4 = yg4;

JDOS_qspace_pub_markers.x5 = xg5;
JDOS_qspace_pub_markers.y5 = yg5;

JDOS_qspace_pub_markers.x6 = xg6;
JDOS_qspace_pub_markers.y6 = yg6;

JDOS_qspace_pub_markers.xqd = xgqd;
JDOS_qspace_pub_markers.yqd = ygqd;

%% open in img_obj_viewer with hotspots

img_obj_viewer_hotspots(JDOS_qspace_pub_markers);

%%
JDOS_qspace_os_pub_markers = JDOS_qspace_os_pub;

le = length(JDOS_qspace_os_pub.e);


% energy layers actually run from -2.3 to +2.3, pad with imaginary numbers
% where you don't want to display anything

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


%% add the position of the markers to the newly created structure
JDOS_qspace_os_pub_markers.x = xg1;
JDOS_qspace_os_pub_markers.y = yg1;

JDOS_qspace_os_pub_markers.x2 = xg2;
JDOS_qspace_os_pub_markers.y2 = yg2;

JDOS_qspace_os_pub_markers.x3 = xg3;
JDOS_qspace_os_pub_markers.y3 = yg3;

JDOS_qspace_os_pub_markers.x4 = xg4;
JDOS_qspace_os_pub_markers.y4 = yg4;

JDOS_qspace_os_pub_markers.x5 = xg5;
JDOS_qspace_os_pub_markers.y5 = yg5;

JDOS_qspace_os_pub_markers.x6 = xg6;
JDOS_qspace_os_pub_markers.y6 = yg6;

JDOS_qspace_os_pub_markers.xqd = xgqd;
JDOS_qspace_os_pub_markers.yqd = ygqd;

%% open in img_obj_viewer with hotspots

img_obj_viewer_hotspots(JDOS_qspace_os_pub_markers);

%% real space
JDOS_rspace_pub_markers = JDOS_rspace_pub;

le = length(JDOS_rspace_pub.e);


% energy layers actually run from -2.3 to +2.3, pad with imaginary numbers
% where you don't want to display anything

xg1 = 37.346*ones(1, le);
yg1 = 37.346*ones(1, le);
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


%% add the position of the markers to the newly created structure
JDOS_rspace_pub_markers.x = xg1;
JDOS_rspace_pub_markers.y = yg1;

JDOS_rspace_pub_markers.x2 = xg2;
JDOS_rspace_pub_markers.y2 = yg2;

JDOS_rspace_pub_markers.x3 = xg3;
JDOS_rspace_pub_markers.y3 = yg3;

JDOS_rspace_pub_markers.x4 = xg4;
JDOS_rspace_pub_markers.y4 = yg4;

JDOS_rspace_pub_markers.x5 = xg5;
JDOS_rspace_pub_markers.y5 = yg5;

JDOS_rspace_pub_markers.x6 = xg6;
JDOS_rspace_pub_markers.y6 = yg6;

JDOS_rspace_pub_markers.xqd = xgqd;
JDOS_rspace_pub_markers.yqd = ygqd;

%% open in img_obj_viewer with hotspots

img_obj_viewer_hotspots(JDOS_rspace_pub_markers);

%%
JDOS_rspace_os_pub_markers = JDOS_rspace_os_pub;

le = length(JDOS_rspace_os_pub.e);


% energy layers actually run from -2.3 to +2.3, pad with imaginary numbers
% where you don't want to display anything

xg1 = 37.346*ones(1, le);
yg1 = 37.346*ones(1, le);
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


%% add the position of the markers to the newly created structure
JDOS_rspace_os_pub_markers.x = xg1;
JDOS_rspace_os_pub_markers.y = yg1;

JDOS_rspace_os_pub_markers.x2 = xg2;
JDOS_rspace_os_pub_markers.y2 = yg2;

JDOS_rspace_os_pub_markers.x3 = xg3;
JDOS_rspace_os_pub_markers.y3 = yg3;

JDOS_rspace_os_pub_markers.x4 = xg4;
JDOS_rspace_os_pub_markers.y4 = yg4;

JDOS_rspace_os_pub_markers.x5 = xg5;
JDOS_rspace_os_pub_markers.y5 = yg5;

JDOS_rspace_os_pub_markers.x6 = xg6;
JDOS_rspace_os_pub_markers.y6 = yg6;

JDOS_rspace_os_pub_markers.xqd = xgqd;
JDOS_rspace_os_pub_markers.yqd = ygqd;

%% open in img_obj_viewer with hotspots

img_obj_viewer_hotspots(JDOS_rspace_os_pub_markers);

%%

obj_60801a00_F_filtered_pub_markers = obj_60801a00_F_filtered_pub;

le = length(obj_60801a00_F_filtered_pub.e);

% obj_60721a00_F_FT_pub_markers = rm_center(obj_60721a00_F_FT_pub);

% energy layers actually run from -2.3 to +2.3, pad with imaginary numbers
% where you don't want to display anything

xg1 = 36.354*ones(1, le);
yg1 = 36.354*ones(1, le);
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


%% add the position of the markers to the newly created structure
obj_60801a00_F_filtered_pub_markers.x = xg1;
obj_60801a00_F_filtered_pub_markers.y = yg1;

obj_60801a00_F_filtered_pub_markers.x2 = xg2;
obj_60801a00_F_filtered_pub_markers.y2 = yg2;

obj_60801a00_F_filtered_pub_markers.x3 = xg3;
obj_60801a00_F_filtered_pub_markers.y3 = yg3;

obj_60801a00_F_filtered_pub_markers.x4 = xg4;
obj_60801a00_F_filtered_pub_markers.y4 = yg4;

obj_60801a00_F_filtered_pub_markers.x5 = xg5;
obj_60801a00_F_filtered_pub_markers.y5 = yg5;

obj_60801a00_F_filtered_pub_markers.x6 = xg6;
obj_60801a00_F_filtered_pub_markers.y6 = yg6;

obj_60801a00_F_filtered_pub_markers.xqd = xgqd;
obj_60801a00_F_filtered_pub_markers.yqd = ygqd;

%% open in img_obj_viewer with hotspots

img_obj_viewer_hotspots(obj_60801a00_F_filtered_pub_markers);