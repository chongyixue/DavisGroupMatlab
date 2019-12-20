%%
FeSe_LQPI_60721A00_to_60804A00
%%

cut_q3a = line_cut_v4(obj_60724A00_K_FT_sym,[52, 52],[52, 104],0);
cut_q3b = line_cut_v4(obj_60724A00_K_FT_sym,[53, 52],[53, 104],0);
cut_q3c = line_cut_v4(obj_60724A00_K_FT_sym,[51, 52],[51, 104],0);
cut_q3d = line_cut_v4(obj_60724A00_K_FT_sym,[54, 52],[54, 104],0);
cut_q3e = line_cut_v4(obj_60724A00_K_FT_sym,[50, 52],[50, 104],0);
cut_q3f = line_cut_v4(obj_60724A00_K_FT_sym,[55, 52],[55, 104],0);
cut_q3g = line_cut_v4(obj_60724A00_K_FT_sym,[49, 52],[49, 104],0);
cut_q3h = line_cut_v4(obj_60724A00_K_FT_sym,[56, 52],[56, 104],0);
cut_q3i = line_cut_v4(obj_60724A00_K_FT_sym,[48, 52],[48, 104],0);
cut_q3j = line_cut_v4(obj_60724A00_K_FT_sym,[57, 52],[57, 104],0);


% cut_q3a = line_cut_v4(obj_60724A00_K_GS,[52, 52],[52, 104],0);
% cut_q3b = line_cut_v4(obj_60724A00_K_GS,[53, 52],[53, 104],0);
% cut_q3c = line_cut_v4(obj_60724A00_K_GS,[51, 52],[51, 104],0);
% cut_q3d = line_cut_v4(obj_60724A00_K_GS,[54, 52],[54, 104],0);
% cut_q3e = line_cut_v4(obj_60724A00_K_GS,[50, 52],[50, 104],0);
% cut_q3f = line_cut_v4(obj_60724A00_K_GS,[55, 52],[55, 104],0);
% cut_q3g = line_cut_v4(obj_60724A00_K_GS,[49, 52],[49, 104],0);
% cut_q3h = line_cut_v4(obj_60724A00_K_GS,[56, 52],[56, 104],0);
% cut_q3i = line_cut_v4(obj_60724A00_K_GS,[48, 52],[48, 104],0);
% cut_q3j = line_cut_v4(obj_60724A00_K_GS,[57, 52],[57, 104],0);

% cut_q3a = line_cut_v4(obj_60724A00_K_FT_sym,[52, 52],[104, 52],0);
% cut_q3b = line_cut_v4(obj_60724A00_K_FT_sym,[52, 53],[104, 53],0);
% cut_q3c = line_cut_v4(obj_60724A00_K_FT_sym,[52, 51],[104, 51],0);
% cut_q3d = line_cut_v4(obj_60724A00_K_FT_sym,[52, 54],[104, 54],0);
% cut_q3e = line_cut_v4(obj_60724A00_K_FT_sym,[52, 50],[104, 50],0);
% cut_q3f = line_cut_v4(obj_60724A00_K_FT_sym,[52, 55],[104, 55],0);
% cut_q3g = line_cut_v4(obj_60724A00_K_FT_sym,[52, 49],[104, 49],0);
% cut_q3h = line_cut_v4(obj_60724A00_K_FT_sym,[52, 56],[104, 56],0);
% cut_q3i = line_cut_v4(obj_60724A00_K_FT_sym,[52, 48],[104, 48],0);
% cut_q3j = line_cut_v4(obj_60724A00_K_FT_sym,[52, 57],[104, 57],0);


cut_q3 = cut_q3a;

cut_q3.cut = (cut_q3a.cut + cut_q3b.cut + cut_q3c.cut + cut_q3d.cut +...
    cut_q3e.cut + cut_q3f.cut + cut_q3g.cut + cut_q3h.cut) / 10;

figure, hold on
for i=5:1:41
    plot(cut_q3.r,cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
end

plot(cut_q3.r(7:18),cut_q3.cut(7:18,5)/max(cut_q3.cut(:,5))+(5-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(7:18),cut_q3.cut(7:18,6)/max(cut_q3.cut(:,6))+(6-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(7:20),cut_q3.cut(7:20,7)/max(cut_q3.cut(:,7))+(7-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(8:21),cut_q3.cut(8:21,8)/max(cut_q3.cut(:,8))+(8-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:24),cut_q3.cut(9:24,9)/max(cut_q3.cut(:,9))+(9-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:25),cut_q3.cut(9:25,10)/max(cut_q3.cut(:,10))+(10-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:26),cut_q3.cut(9:26,11)/max(cut_q3.cut(:,11))+(11-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:27),cut_q3.cut(9:27,12)/max(cut_q3.cut(:,12))+(12-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:28),cut_q3.cut(9:28,13)/max(cut_q3.cut(:,13))+(13-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,14)/max(cut_q3.cut(:,14))+(14-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,15)/max(cut_q3.cut(:,15))+(15-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,16)/max(cut_q3.cut(:,16))+(16-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,17)/max(cut_q3.cut(:,17))+(17-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,18)/max(cut_q3.cut(:,18))+(18-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,19)/max(cut_q3.cut(:,19))+(19-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(10:29),cut_q3.cut(10:29,20)/max(cut_q3.cut(:,20))+(20-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(10:29),cut_q3.cut(10:29,21)/max(cut_q3.cut(:,21))+(21-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(10:30),cut_q3.cut(10:30,22)/max(cut_q3.cut(:,22))+(22-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(10:31),cut_q3.cut(10:31,23)/max(cut_q3.cut(:,23))+(23-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(12:31),cut_q3.cut(12:31,24)/max(cut_q3.cut(:,24))+(24-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(12:32),cut_q3.cut(12:32,25)/max(cut_q3.cut(:,25))+(25-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(12:33),cut_q3.cut(12:33,26)/max(cut_q3.cut(:,26))+(26-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(14:34),cut_q3.cut(14:34,27)/max(cut_q3.cut(:,27))+(27-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(14:34),cut_q3.cut(14:34,28)/max(cut_q3.cut(:,28))+(28-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(15:34),cut_q3.cut(15:34,29)/max(cut_q3.cut(:,29))+(29-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(15:35),cut_q3.cut(15:35,30)/max(cut_q3.cut(:,30))+(30-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(15:36),cut_q3.cut(15:36,31)/max(cut_q3.cut(:,31))+(31-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(16:36),cut_q3.cut(16:36,32)/max(cut_q3.cut(:,32))+(32-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(17:36),cut_q3.cut(17:36,33)/max(cut_q3.cut(:,33))+(33-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(18:36),cut_q3.cut(18:36,34)/max(cut_q3.cut(:,34))+(34-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(19:37),cut_q3.cut(19:37,35)/max(cut_q3.cut(:,35))+(35-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(19:38),cut_q3.cut(19:38,36)/max(cut_q3.cut(:,36))+(36-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(19:39),cut_q3.cut(19:39,37)/max(cut_q3.cut(:,37))+(37-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(19:40),cut_q3.cut(19:40,38)/max(cut_q3.cut(:,38))+(38-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(20:40),cut_q3.cut(20:40,39)/max(cut_q3.cut(:,39))+(39-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(21:41),cut_q3.cut(21:41,40)/max(cut_q3.cut(:,40))+(40-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(21:42),cut_q3.cut(21:42,41)/max(cut_q3.cut(:,41))+(41-4)*0.25,'r.-', 'LineWidth', 2, 'MarkerSize', 15);

hold off


figure, hold on
plot(cut_q3.r(7:18),cut_q3.cut(7:18,5)/max(cut_q3.cut(:,5))+(5-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(7:18),cut_q3.cut(7:18,6)/max(cut_q3.cut(:,6))+(6-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(7:20),cut_q3.cut(7:20,7)/max(cut_q3.cut(:,7))+(7-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(8:21),cut_q3.cut(8:21,8)/max(cut_q3.cut(:,8))+(8-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:24),cut_q3.cut(9:24,9)/max(cut_q3.cut(:,9))+(9-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:25),cut_q3.cut(9:25,10)/max(cut_q3.cut(:,10))+(10-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:26),cut_q3.cut(9:26,11)/max(cut_q3.cut(:,11))+(11-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:27),cut_q3.cut(9:27,12)/max(cut_q3.cut(:,12))+(12-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:28),cut_q3.cut(9:28,13)/max(cut_q3.cut(:,13))+(13-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,14)/max(cut_q3.cut(:,14))+(14-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,15)/max(cut_q3.cut(:,15))+(15-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,16)/max(cut_q3.cut(:,16))+(16-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,17)/max(cut_q3.cut(:,17))+(17-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,18)/max(cut_q3.cut(:,18))+(18-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(9:29),cut_q3.cut(9:29,19)/max(cut_q3.cut(:,19))+(19-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(10:29),cut_q3.cut(10:29,20)/max(cut_q3.cut(:,20))+(20-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(10:29),cut_q3.cut(10:29,21)/max(cut_q3.cut(:,21))+(21-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(10:30),cut_q3.cut(10:30,22)/max(cut_q3.cut(:,22))+(22-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(10:31),cut_q3.cut(10:31,23)/max(cut_q3.cut(:,23))+(23-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(12:31),cut_q3.cut(12:31,24)/max(cut_q3.cut(:,24))+(24-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(12:32),cut_q3.cut(12:32,25)/max(cut_q3.cut(:,25))+(25-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(12:33),cut_q3.cut(12:33,26)/max(cut_q3.cut(:,26))+(26-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(14:34),cut_q3.cut(14:34,27)/max(cut_q3.cut(:,27))+(27-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(14:34),cut_q3.cut(14:34,28)/max(cut_q3.cut(:,28))+(28-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(15:34),cut_q3.cut(15:34,29)/max(cut_q3.cut(:,29))+(29-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(15:35),cut_q3.cut(15:35,30)/max(cut_q3.cut(:,30))+(30-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(15:36),cut_q3.cut(15:36,31)/max(cut_q3.cut(:,31))+(31-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(16:36),cut_q3.cut(16:36,32)/max(cut_q3.cut(:,32))+(32-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(17:36),cut_q3.cut(17:36,33)/max(cut_q3.cut(:,33))+(33-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(18:36),cut_q3.cut(18:36,34)/max(cut_q3.cut(:,34))+(34-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(19:37),cut_q3.cut(19:37,35)/max(cut_q3.cut(:,35))+(35-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(19:38),cut_q3.cut(19:38,36)/max(cut_q3.cut(:,36))+(36-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(19:39),cut_q3.cut(19:39,37)/max(cut_q3.cut(:,37))+(37-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(19:40),cut_q3.cut(19:40,38)/max(cut_q3.cut(:,38))+(38-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(20:40),cut_q3.cut(20:40,39)/max(cut_q3.cut(:,39))+(39-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(21:41),cut_q3.cut(21:41,40)/max(cut_q3.cut(:,40))+(40-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
plot(cut_q3.r(21:42),cut_q3.cut(21:42,41)/max(cut_q3.cut(:,41))+(41-4)*0.25,'k.-', 'LineWidth', 2, 'MarkerSize', 15);
hold off



%% try to fit with formula from Dahm and Scalapino paper, use Gaussian blur
%% 4, 2 on data first
% exp_lrntz = 'Re( a / sqrt(2*b + 1i*2*c - x) ) + d + e*x + f * exp(-g*(x-h))';

ql = cut_q3.cut(7:18,5);
q = cut_q3.r(7:18);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, 0];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, 0];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);
%%

ql = cut_q3.cut(7:18,6);
q = cut_q3.r(7:18);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%
ql = cut_q3.cut(7:20,7);
q = cut_q3.r(7:20);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%
ql = cut_q3.cut(8:21,8);
q = cut_q3.r(8:21);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(9:24,9);
q = cut_q3.r(9:24);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(9:25,10);
q = cut_q3.r(9:25);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(9:26,11);
q = cut_q3.r(9:26);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(9:27,12);
q = cut_q3.r(9:27);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(9:28,13);
q = cut_q3.r(9:28);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(9:29,14);
q = cut_q3.r(9:29);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(9:29,15);
q = cut_q3.r(9:29);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(9:29,16);
q = cut_q3.r(9:29);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(9:29,17);
q = cut_q3.r(9:29);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(9:29,18);
q = cut_q3.r(9:29);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(9:29,19);
q = cut_q3.r(9:29);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(10:29,20);
q = cut_q3.r(10:29);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(10:29,21);
q = cut_q3.r(10:29);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(10:30,22);
q = cut_q3.r(10:30);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(10:31,23);
q = cut_q3.r(10:31);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(12:31,24);
q = cut_q3.r(12:31);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(12:32,25);
q = cut_q3.r(12:32);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(12:33,26);
q = cut_q3.r(12:33);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(14:34,27);
q = cut_q3.r(14:34);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(14:34,28);
q = cut_q3.r(14:34);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(15:34,29);
q = cut_q3.r(15:34);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(15:35,30);
q = cut_q3.r(15:35);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(15:36,31);
q = cut_q3.r(15:36);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(16:36,32);
q = cut_q3.r(16:36);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(17:36,33);
q = cut_q3.r(17:36);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(18:36,34);
q = cut_q3.r(18:36);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(19:37,35);
q = cut_q3.r(19:37);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(19:38,36);
q = cut_q3.r(19:38);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(19:39,37);
q = cut_q3.r(19:39);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(19:40,38);
q = cut_q3.r(19:40);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(20:40,39);
q = cut_q3.r(20:40);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(21:41,40);
q = cut_q3.r(21:41);

guess = [mean(ql), q(7)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), inf, max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);

%%

ql = cut_q3.cut(21:42,41);
q = cut_q3.r(21:42);

guess = [mean(ql), q(9)/2, 0.005, mean(ql), (ql(end)-ql(1))/(q(end)-q(1)), 0, 1, 0];

if (ql(end)-ql(1))/(q(end)-q(1)) < 0
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, 0, 0, q(1)];
    upp = [inf, q(end), q(end)-q(1), max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, max(ql), inf, q(end)];
else
    low = [min(ql),q(1) , 0, min(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 0.5, 0, 0, q(1)];
    upp = [inf, q(end), q(end)-q(1), max(ql), (ql(end)-ql(1))/(q(end)-q(1)) * 1.5, max(ql), inf, q(end)];
end

[y_new, p,gof, ci]=FeSe_selfenergy(ql,q,guess,low,upp);