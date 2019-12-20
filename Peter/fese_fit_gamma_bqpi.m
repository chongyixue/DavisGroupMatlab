

en = obj_60222a00_G_FT_sym_avg3.e * 1000;

rawmap = obj_60222a00_G_FT_bcp.map;

%%

% cut_q3a = line_cut_v4(obj_60222a00_G_FT_sym_avg3,[68, 64],[100, 64],0);
% cut_q3b = line_cut_v4(obj_60222a00_G_FT_sym_avg3,[68, 65],[100, 65],0);
% cut_q3c = line_cut_v4(obj_60222a00_G_FT_sym_avg3,[68, 63],[100, 63],0);
% cut_q3d = line_cut_v4(obj_60222a00_G_FT_sym_avg3,[68, 66],[100, 66],0);
% cut_q3e = line_cut_v4(obj_60222a00_G_FT_sym_avg3,[68, 62],[100, 62],0);
% cut_q3f = line_cut_v4(obj_60222a00_G_FT_sym_avg3,[68, 67],[100, 67],0);

cut_q3a = line_cut_v4(obj_60222a00_BGS,[68, 64],[100, 64],0);
cut_q3b = line_cut_v4(obj_60222a00_BGS,[68, 65],[100, 65],0);
cut_q3c = line_cut_v4(obj_60222a00_BGS,[68, 63],[100, 63],0);
cut_q3d = line_cut_v4(obj_60222a00_BGS,[68, 66],[100, 66],0);
% cut_q3e = line_cut_v4(obj_60222a00_BGS,[65, 62],[100, 62],0);
% cut_q3f = line_cut_v4(obj_60222a00_BGS,[65, 67],[100, 67],0);

cut_q3 = cut_q3a;

cut_q3.cut = (cut_q3a.cut + cut_q3b.cut + cut_q3c.cut + cut_q3d.cut) / 4;
% figure, plot(cut_q3a.r,cut_q3a.cut(:,6),'k-o');
% figure, plot(cut_q3.r,cut_q3.cut(:,6),'k-o');

cut_q3 = line_cut_v4(obj_60222a00_G_FT_sym_avg3_bcp,[68, 65],[95, 65],8);

figure, hold on
for i=2:13
%     cut_q3.cut(:,i) = sgolayfilt(cut_q3.cut(:,i), 5, 17);
    plot(cut_q3.r,cut_q3.cut(:,i)/mean(cut_q3.cut(:,i))+(i-1)*0.5,'b.-', 'LineWidth', 2);
%     figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     title([num2str(en(i)) ' meV']);
end
hold off

cut_q3 = line_cut_v4(obj_60222a00_BGS,[68, 65],[95, 65],8);

figure, hold on
for i=2:13
%     cut_q3.cut(:,i) = sgolayfilt(cut_q3.cut(:,i), 5, 17);
    plot(cut_q3.r,cut_q3.cut(:,i)/mean(cut_q3.cut(:,i))+(i-1)*0.5,'b.-', 'LineWidth', 2);
%     figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     title([num2str(en(i)) ' meV']);
end
hold off

%% q3 -2.4 meV
i = 1;
ql = cut_q3.cut(10:end,i);
q = cut_q3.r(10:end);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof,ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);


q3_lorpar = [p.d, p.e, p.f, 2.4, p.e/2];
q3_lorpar2 = [p.d, p.e, p.f, 2.4, p.e/2];
q3_lorparcomb(1,1:5) = [p.d, p.e, p.f, 2.4, p.e/2];

%% q3 -2.3 meV
i = 2;
ql = cut_q3.cut(9:end,i);
q = cut_q3.r(9:end);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);


q3_lorpar(2,1:5) = [p.d, p.e, p.f, 2.3, p.e/2];
q3_lorpar2(2,1:5) = [p.d, p.e, p.f, 2.3, p.e/2];
q3_lorparcomb(2,1:5) = [p.d, p.e, p.f, 2.3, p.e/2];

%% q3 -2.2 meV
i = 3;
ql = cut_q3.cut(7:end,i);
q = cut_q3.r(7:end);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);


q3_lorpar(3,1:5) = [p.d, p.e, p.f, 2.2, p.e/2];
q3_lorpar2(3,1:5) = [p.d, p.e, p.f, 2.2, p.e/2];
q3_lorparcomb(3,1:5) = [p.d, p.e, p.f, 2.2, p.e/2];


%% q3 -2.1 meV
i = 4;
ql = cut_q3.cut(5:end,i);
q = cut_q3.r(5:end);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);



q3_lorpar(4,1:5) = [p.d, p.e, p.f, 2.1, p.e/2];
q3_lorpar2(4,1:5) = [p.d, p.e, p.f, 2.1, p.e/2];
q3_lorparcomb(4,1:5) = [p.d, p.e, p.f, 2.1, p.e/2];


%% q3 -2.0 meV
i = 5;
ql = cut_q3.cut(5:end,i);
q = cut_q3.r(5:end);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

q3_lorpar(5,1:5) = [p.d, p.e, p.f, 2.0, p.e/2];
q3_lorpar2(5,1:5) = [p.d, p.e, p.f, 2.0, p.e/2];
q3_lorparcomb(5,1:5) = [p.d, p.e, p.f, 2.0, p.e/2];

%% q3 -1.9 meV
i = 6;
ql = cut_q3.cut(5:end,i);
q = cut_q3.r(5:end);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.1257, max(ql)-mean(ql), ws, 0.1523];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

q3_lorpar(6,1:5) = [p.d, p.e, p.f, 1.9, p.e/2];
q3_lorpar2(6,1:5) = [p.d, p.e, p.f, 1.9, p.e/2];
q3_lorparcomb(6,1:5) = [p.d, p.e, p.f, 1.9, p.e/2];

%% q3 -1.8 meV
i = 7;
ql = cut_q3.cut(5:end,i);
q = cut_q3.r(5:end);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.1257, max(ql)-mean(ql), ws, 0.1523];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

q3_lorpar(7,1:5) = [p.d, p.e, p.f, 1.8, p.e/2];
q3_lorpar2(7,1:5) = [p.d, p.e, p.f, 1.8, p.e/2];
q3_lorparcomb(7,1:5) = [p.d, p.e, p.f, 1.8, p.e/2];


%% q3 -1.7 meV
i = 8;
ql = cut_q3.cut(4:end,i);
q = cut_q3.r(4:end);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.1257, max(ql)-mean(ql), ws, 0.1523];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

q3_lorpar(8,1:5) = [p.d, p.e, p.f, 1.7, p.e/2];
q3_lorpar2(8,1:5) = [p.d, p.e, p.f, 1.7, p.e/2];
q3_lorparcomb(8,1:5) = [p.d, p.e, p.f, 1.7, p.e/2];
%% q3 -1.6 meV
i = 9;
ql = cut_q3.cut(5:end,i);
q = cut_q3.r(5:end);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.1257, max(ql)-mean(ql), ws, 0.1523];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

q3_lorpar(9,1:5) = [p.d, p.e, p.f, 1.6, p.e/2];
q3_lorpar2(9,1:5) = [p.d, p.e, p.f, 1.6, p.e/2];
q3_lorparcomb(9,1:5) = [p.d, p.e, p.f, 1.6, p.e/2];
%% q3 -1.5 meV
i = 10;
ql = cut_q3.cut(4:end,i);
q = cut_q3.r(4:end);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.08, max(ql)-mean(ql), ws, 0.12];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

q3_lorpar(10,1:5) = [p.d, p.e, p.f, 1.5, p.e/2];
q3_lorpar2(10,1:5) = [p.d, p.e, p.f, 1.5, p.e/2];
q3_lorparcomb(10,1:5) = [p.d, p.e, p.f, 1.5, p.e/2];

%% q3 -1.4 meV
i = 11;
ql = cut_q3.cut(4:end-3,i);
q = cut_q3.r(4:end-3);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.08, max(ql)-mean(ql), ws, 0.12];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

q3_lorpar(11,1:5) = [p.d, p.e, p.f, 1.4, p.e/2];
q3_lorpar2(11,1:5) = [p.d, p.e, p.f, 1.4, p.e/2];
q3_lorparcomb(11,1:5) = [p.d, p.e, p.f, 1.4, p.e/2];

%% q3 -1.3 meV
i = 12;
ql = cut_q3.cut(1:end-3,i);
q = cut_q3.r(1:end-3);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.08, max(ql)-mean(ql), ws, 0.12];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

q3_lorpar(12,1:5) = [p.d, p.e, p.f, 1.3, p.e/2];
q3_lorpar2(12,1:5) = [p.d, p.e, p.f, 1.3, p.e/2];
q3_lorparcomb(12,1:5) = [p.d, p.e, p.f, 1.3, p.e/2];

%% q3 -1.2 meV
i = 13;
ql = cut_q3.cut(1:end-4,i);
q = cut_q3.r(1:end-4);
% ql = sgolayfilt(ql,3,13);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.08, max(ql)-mean(ql), ws, 0.12];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

q3_lorpar(13,1:5) = [p.d, p.e, p.f, 1.2, p.e/2];
q3_lorpar2(13,1:5) = [p.d, p.e, p.f, 1.2, p.e/2];
q3_lorparcomb(13,1:5) = [p.d, p.e, p.f, 1.2, p.e/2];

close all;
%%

cut_q1a = line_cut_v4(obj_60222a00_BGS,[64, 54],[64, 33],0);
cut_q1b = line_cut_v4(obj_60222a00_BGS,[65, 54],[65, 33],0);
cut_q1c = line_cut_v4(obj_60222a00_BGS,[63, 54],[63, 33],0);
cut_q1d = line_cut_v4(obj_60222a00_BGS,[66, 54],[66, 33],0);
cut_q1e = line_cut_v4(obj_60222a00_BGS,[62, 54],[62, 33],0);
cut_q1f = line_cut_v4(obj_60222a00_BGS,[67, 54],[67, 33],0);



% cut_q1a = line_cut_v4(obj_60222a00_G_FT_sym_avg3_bcp_8cr,[64, 54],[64, 33],0);
% cut_q1b = line_cut_v4(obj_60222a00_G_FT_sym_avg3_bcp_8cr,[65, 54],[65, 33],0);
% cut_q1c = line_cut_v4(obj_60222a00_G_FT_sym_avg3_bcp_8cr,[63, 54],[63, 33],0);
% cut_q1d = line_cut_v4(obj_60222a00_G_FT_sym_avg3_bcp_8cr,[66, 54],[66, 33],0);
% % 
% cut_q1a = line_cut_v4(obj_60222a00_G_FT_sym_avg3_bcp,[64, 54],[64, 33],0);
% cut_q1b = line_cut_v4(obj_60222a00_G_FT_sym_avg3_bcp,[65, 54],[65, 33],0);
% cut_q1c = line_cut_v4(obj_60222a00_G_FT_sym_avg3_bcp,[63, 54],[63, 33],0);
% cut_q1d = line_cut_v4(obj_60222a00_G_FT_sym_avg3_bcp,[66, 54],[66, 33],0);

cut_q1 = cut_q1a;
cut_q1.cut = (cut_q1a.cut + cut_q1b.cut + cut_q1c.cut + cut_q1d.cut) / 4;
% cut_q1.cut = (cut_q1a.cut + cut_q1b.cut + cut_q1c.cut + cut_q1d.cut + cut_q1e.cut + cut_q1f.cut) / 6;

% close all

cut_q1_dif = cut_q1;
cut_q1_dif.cut = cut_q1_dif.cut(:,2:end) - cut_q1_dif.cut(:,1:end-1);
% cut_q1 = line_cut_v4(obj_60222a00_BGS,[65, 54],[65, 27],5);

figure, hold on
% for i=5:1:15
for i=4:1:17
    plot(cut_q1.r,cut_q1.cut(:,i)/mean(cut_q1.cut(:,i))+(i-1)*0.75,'b.-', 'LineWidth', 2);
%      figure, plot(cut_q1.cut(:,i)/max(cut_q1.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     title([num2str(en(i)) ' meV']);
end
hold off

% for i=4:1:17
%     figure
%     plot(cut_q1_dif.r,cut_q1_dif.cut(:,i)/mean(cut_q1_dif.cut(:,i))+(i-1)*0.75,'b.-', 'LineWidth', 2);
% %      figure, plot(cut_q1.cut(:,i)/max(cut_q1.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
% %     title([num2str(en(i)) ' meV']);
% end

%% q1 -2.1 meV
i = 4;
ql = cut_q1.cut(1:end,i);
q = cut_q1.r(1:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09, max(ql)-mean(ql), ws, 0.13,max(ql)-mean(ql), ws, 0.175];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0.16];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.19];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

q1_lorpar(1,1:5) = [p.d, p.e, p.f, 2.1, p.e/2];
q1_lorpar2(1,1:5) = [p.d, p.e, p.f, 2.1, p.e/2];
q1_lorparcomb(1,1:5) = [p.d, p.e, p.f, 2.1, p.e/2];

% introduce stationary peaks that stay in the same location
sp1p = p.k;
sp1w = p.h;

sp2p = p.n;
sp2w = p.m;

guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09, max(ql)-mean(ql), sp1w, sp1p,max(ql)-mean(ql), sp2w, sp2p];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, sp1w - 0.01*ws, sp1p - 0.01*ws, 0, sp2w - 0.01*ws, sp2p - 0.01*ws];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), sp1w + 0.01*ws, sp1p + 0.01*ws, max(ql), sp2w + 0.01*ws, sp2p + 0.01*ws];


%% q1 -2.0 meV
i = 5;
ql = cut_q1.cut(1:end,i);
q = cut_q1.r(1:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
% guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09, max(ql)-mean(ql), ws, 0.13,max(ql)-mean(ql), ws, 0.175];
% low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0.16];
% upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.19];

guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09, max(ql)-mean(ql), sp1w, sp1p,max(ql)-mean(ql), sp2w, sp2p];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, sp1w - 0.01*ws, sp1p - 0.01*ws, 0, sp2w - 0.01*ws, sp2p - 0.01*ws];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), sp1w + 0.01*ws, sp1p + 0.01*ws, max(ql), sp2w + 0.01*ws, sp2p + 0.01*ws];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

q1_lorpar(2,1:5) = [p.d, p.e, p.f, 2.0, p.e/2];
q1_lorpar2(2,1:5) = [p.d, p.e, p.f, 2.0, p.e/2];
q1_lorparcomb(2,1:5) = [p.d, p.e, p.f, 2.0, p.e/2];

%% q1 -1.9 meV
i = 6;
ql = cut_q1.cut(1:end,i);
q = cut_q1.r(1:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';

% guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09, max(ql)-mean(ql), ws, 0.13,max(ql)-mean(ql), ws, 0.175];
% low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0.16];
% upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.19];

guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09, max(ql)-mean(ql), sp1w, sp1p,max(ql)-mean(ql), sp2w, sp2p];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, sp1w - 0.01*ws, sp1p - 0.01*ws, 0, sp2w - 0.01*ws, sp2p - 0.01*ws];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), sp1w + 0.01*ws, sp1p + 0.01*ws, max(ql), sp2w + 0.01*ws, sp2p + 0.01*ws];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

q1_lorpar(3,1:5) = [p.d, p.e, p.f, 1.9, p.e/2];
q1_lorpar2(3,1:5) = [p.d, p.e, p.f, 1.9, p.e/2];
q1_lorparcomb(3,1:5) = [p.d, p.e, p.f, 1.9, p.e/2];

%% q1 -1.8 meV
i = 7;
ql = cut_q1.cut(1:end,i);
q = cut_q1.r(1:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';

% guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09, max(ql)-mean(ql), ws, 0.13,max(ql)-mean(ql), ws, 0.175];
% low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0.16];
% upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.19];

guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09, max(ql)-mean(ql), sp1w, sp1p,max(ql)-mean(ql), sp2w, sp2p];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, sp1w - 0.01*ws, sp1p - 0.01*ws, 0, sp2w - 0.01*ws, sp2p - 0.01*ws];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), sp1w + 0.01*ws, sp1p + 0.01*ws, max(ql), sp2w + 0.01*ws, sp2p + 0.01*ws];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

q1_lorpar(4,1:5) = [p.d, p.e, p.f, 1.8, p.e/2];
q1_lorpar2(4,1:5) = [p.d, p.e, p.f, 1.8, p.e/2];
q1_lorparcomb(4,1:5) = [p.d, p.e, p.f, 1.8, p.e/2];

%% q1 -1.7 meV
i = 8;
ql = cut_q1.cut(1:end,i);
q = cut_q1.r(1:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.12];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.11, max(ql)-mean(ql), sp1w, sp1p,max(ql)-mean(ql), sp2w, sp2p];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, sp1w - 0.01*ws, sp1p - 0.01*ws, 0, sp2w - 0.01*ws, sp2p - 0.01*ws];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), sp1w + 0.01*ws, sp1p + 0.01*ws, max(ql), sp2w + 0.01*ws, sp2p + 0.01*ws];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);


q1_lorpar(5,1:5) = [p.d, p.e, p.f, 1.7, p.e/2];
q1_lorpar2(5,1:5) = [p.d, p.e, p.f, 1.7, p.e/2];
q1_lorparcomb(5,1:5) = [p.d, p.e, p.f, 1.7, p.e/2];
%% q1 -1.6 meV
i = 9;
ql = cut_q1.cut(1:end,i);
q = cut_q1.r(1:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.1179];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.11, max(ql)-mean(ql), sp1w, sp1p,max(ql)-mean(ql), sp2w, sp2p];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, sp1w - 0.01*ws, sp1p - 0.01*ws, 0, sp2w - 0.01*ws, sp2p - 0.01*ws];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), sp1w + 0.01*ws, sp1p + 0.01*ws, max(ql), sp2w + 0.01*ws, sp2p + 0.01*ws];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);



q1_lorpar(6,1:5) = [p.d, p.e, p.f, 1.6, p.e/2];
q1_lorpar2(6,1:5) = [p.d, p.e, p.f, 1.6, p.e/2];
q1_lorparcomb(6,1:5) = [p.d, p.e, p.f, 1.6, p.e/2];

%% q1 -1.5 meV
i = 10;
ql = cut_q1.cut(4:end,i);
q = cut_q1.r(4:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.12, max(ql)-mean(ql), ws, 0.14,max(ql)-mean(ql), ws, 0.1781];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0.16];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.19];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.12, max(ql)-mean(ql), sp1w, sp1p,max(ql)-mean(ql), sp2w, sp2p];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, sp1w - 0.01*ws, sp1p - 0.01*ws, 0, sp2w - 0.01*ws, sp2p - 0.01*ws];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), sp1w + 0.01*ws, sp1p + 0.01*ws, max(ql), sp2w + 0.01*ws, sp2p + 0.01*ws];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);



q1_lorpar(7,1:5) = 1i*[p.d, p.e, p.f, 1.5, p.e/2];
q1_lorpar2(7,1:5) = 1i*[p.d, p.e, p.f, 1.5, p.e/2];
q1_lorparcomb(7,1:5) = 1i*[p.d, p.e, p.f, 1.5, p.e/2];

% q1_lorpar(7,1:5) = [p.g, p.h, p.k, 1.5, p.h/2];
% q1_lorpar2(7,1:5) = [p.g, p.h, p.k, 1.5, p.h/2];
% q1_lorparcomb(7,1:5) = [p.g, p.h, p.k, 1.5, p.h/2];

%% q1 -1.4 meV
i = 11;
ql = cut_q1.cut(4:end,i);
q = cut_q1.r(4:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.12, max(ql)-mean(ql), ws, 0.14,max(ql)-mean(ql), ws, 0.1781];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0.16];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.19];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.15, max(ql)-mean(ql), sp1w, sp1p,max(ql)-mean(ql), sp2w, sp2p];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, sp1w - 0.01*ws, sp1p - 0.01*ws, 0, sp2w - 0.01*ws, sp2p - 0.01*ws];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), sp1w + 0.01*ws, sp1p + 0.01*ws, max(ql), sp2w + 0.01*ws, sp2p + 0.01*ws];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);



q1_lorpar(8,1:5) = 1i*[p.d, p.e, p.f, 1.4, p.e/2];
q1_lorpar2(8,1:5) = 1i*[p.d, p.e, p.f, 1.4, p.e/2];
q1_lorparcomb(8,1:5) = 1i*[p.d, p.e, p.f, 1.4, p.e/2];

% q1_lorpar(8,1:5) = [p.g, p.h, p.k, 1.4, p.h/2];
% q1_lorpar2(8,1:5) = [p.g, p.h, p.k, 1.4, p.h/2];
% q1_lorparcomb(8,1:5) = [p.g, p.h, p.k, 1.4, p.h/2];

%% q1 -1.3 meV
i = 12;
ql = cut_q1.cut(5:end,i);
q = cut_q1.r(5:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.12, max(ql)-mean(ql), ws, 0.14];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.12, max(ql)-mean(ql), ws, 0.14,max(ql)-mean(ql), ws, 0.1781];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0.16];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.19];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

q1_lorpar(9,1:5) = [p.g, p.h, p.k, 1.3, p.h/2];
q1_lorpar2(9,1:5) = [p.g, p.h, p.k, 1.3, p.h/2];
q1_lorparcomb(9,1:5) = [p.g, p.h, p.k, 1.3, p.h/2];

%% q1 -1.2 meV
i = 13;
ql = cut_q1.cut(5:end,i);
q = cut_q1.r(5:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.12, max(ql)-mean(ql), ws, 0.14];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);


q1_lorpar(10,1:5) = [p.g, p.h, p.k, 1.2, p.h/2];
q1_lorpar2(10,1:5) = [p.g, p.h, p.k, 1.2, p.h/2];
q1_lorparcomb(10,1:5) = [p.g, p.h, p.k, 1.2, p.h/2];

%% q1 -1.1 meV
i = 14;
ql = cut_q1.cut(8:end,i);
q = cut_q1.r(8:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.16, max(ql)-mean(ql), ws, 0.22];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

q1_lorpar(11,1:5) = [p.d, p.e, p.f, 1.1, p.e/2];
q1_lorpar2(11,1:5) = [p.d, p.e, p.f, 1.1, p.e/2];
q1_lorparcomb(11,1:5) = [p.d, p.e, p.f, 1.1, p.e/2];

%% q1 -1.0 meV
i = 15;
ql = cut_q1.cut(7:end,i);
q = cut_q1.r(7:end);

bgsl = (ql(end) - ql(1)) / (q(end) - q(1));
if bgsl > 0
   bgslup = 1.5 * bgsl;
   bgsldn = 0.5 * bgsl;
else
   bgslup = 0.5 * bgsl;
   bgsldn = 1.5 * bgsl;
end

ws = q(2) - q(1);
wdn = 0;
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
% guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.158, max(ql)-mean(ql), ws, 0.2115];
% low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
% [y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);



% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)+o*(p/2)^2/((x-r)^2+(p/2)^2)';
% guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.1179, max(ql)-mean(ql), ws, 0.1513,max(ql)-mean(ql), ws, 0.1781, max(ql)-mean(ql), ws, 0.2182];
% low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2, max(ql), wup, 0.18*2];
% [y_new, p,gof, ci]=FeSe_lorentzian4(ql,q,guess,low,upp);


% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
% guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.16, max(ql)-mean(ql), ws, 0.12];
% low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2];
% [y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

q1_lorpar(12,1:5) = [p.d, p.e, p.f, 1.0, p.e/2];
q1_lorpar2(12,1:5) = [p.d, p.e, p.f, 1.0, p.e/2];
q1_lorparcomb(12,1:5) = [p.d, p.e, p.f, 1.0, p.e/2];


close all;