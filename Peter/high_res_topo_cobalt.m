
%% load high res topo
load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\June_2013\06_06_13\30606A03_T.mat


T=obj_30606A03_T;

t=T.map;
%%

tres=imresize(t,'scale',0.194667,'method','nearest');
T.map=tres;
img_obj_viewer2(T)