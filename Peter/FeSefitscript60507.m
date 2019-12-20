
en1 = obj_60507A00_G_FT_sym_avg3.e * 1000;
map1 = obj_60507A00_G_FT_sym_avg3.map;
q1 = obj_60507A00_G_FT_sym_avg3.r;

% correct offset
en1a = (obj_60504A00_G_FT_sym_avg3.e - 0.0001) * 1000;
map1a = obj_60504A00_G_FT_sym_avg3.map;

mapc = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)), 6 );
mapc(:,:,1) = map1a(:,:,4);
mapc(:,:,2:6) = map1(:,:,1:5);
enc = [en1a(4), en1];

[X,Y]=meshgrid(1:1:max(size(map1(:,:,1),2)),1:1:max(size(map1(:,:,1),1)));

xdata(:,:,1)=X;
xdata(:,:,2)=Y;

ffmap = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)) );
bsmap = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)) );

for i=1:6
    [x3,resnorm,residual]=complete_fit_2d_gaussian_FeSe_BQPI(mapc(188:213, 192:209 ,i));

    x3(2) = x3(2)+192-1;
    x3(4) = x3(4)+188-1;

    finalfit3=twodgauss_xy_rigid(x3,xdata);
    ffmap(:,:,i) = finalfit3;
    bsmap(:,:,i) = mapc(:,:,i) - ffmap(:,:,i);
    bsmap(:,:,i) = bsmap(:,:,i) + abs( min( min( bsmap(:,:,i) ) ) );
    close all;
end

obj_605047A00 = obj_60507A00_G_FT_sym_avg3;
obj_605047A00.map = mapc;
obj_605047A00.e = enc/1000;

obj_605047A00_BGF = obj_60507A00_G_FT_sym_avg3;
obj_605047A00_BGF.map = ffmap;
obj_605047A00_BGF.e = enc/1000;

obj_605047A00_BGS = obj_60507A00_G_FT_sym_avg3;
obj_605047A00_BGS.map = bsmap;
obj_605047A00_BGS.e = enc/1000;

mapcr = mapc;
mapcr(:,:,1) = obj_60504A00_G_FT.map(:,:,4);
mapcr(:,:,2:6) = obj_60507A00_G_FT.map(:,:,1:5);
obj_605047A00_raw = obj_60507A00_G_FT;
obj_605047A00_raw.e = enc/1000;
obj_605047A00_raw.map = mapcr;

%%

cut_q3a = line_cut_v4(obj_605047A00_BGS,[217, 200],[262, 200],0);
cut_q3b = line_cut_v4(obj_605047A00_BGS,[217, 201],[262, 201],0);
cut_q3c = line_cut_v4(obj_605047A00_BGS,[217, 199],[262, 199],0);
cut_q3d = line_cut_v4(obj_605047A00_BGS,[217, 202],[262, 202],0);


cut_q3 = cut_q3a;

cut_q3.cut = (cut_q3a.cut + cut_q3b.cut + cut_q3c.cut + cut_q3d.cut) / 4;

figure, hold on
for i=1:1:6
    plot(cut_q3.r,cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.25,'.-', 'LineWidth', 2);
end
hold off

cut_q3M = cut_q3;
%%

%% q1 -1.1 meV
i = 1;
ql = cut_q3.cut(1:end-18,i);
q = cut_q3.r(1:end-18);

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
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.2117];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.2117, max(ql)-mean(ql), ws, 0.2423];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q3_lorpar(1,1:5) = [p.d, p.e, p.f, 1.1, peb1];
q3_lorpar2(1,1:5) = [p.g, p.h, p.k, 1.1, peb2];
q3_lorparcomb(1,1:5) = [mean([p.d, p.g]), mean([p.e, p.h]), mean([p.f, p.k]), 1.1, abs(p.f - p.k)];

%% -0.9 meV
i = 2;
ql = cut_q3.cut(1:end-10,i);
q = cut_q3.r(1:end-10);

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
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.2117];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.2117, max(ql)-mean(ql), ws, 0.2423,max(ql)-mean(ql), ws, 0.28];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));
peb3 = abs(ci(1,12) - ci(2,12));

q3_lorpar(2,1:5) = [p.g, p.h, p.k, 0.9, peb2];
q3_lorpar2(2,1:5) = [p.l, p.m, p.n, 0.9, peb3];
q3_lorparcomb(2,1:5) = [mean([p.g, p.l]), mean([p.h, p.m]), mean([p.k, p.n]), 0.9, abs(p.f - p.k)];

%% -0.8 meV
i = 3;
ql = cut_q3.cut(1:end-13,i);
q = cut_q3.r(1:end-13);

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
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.2117];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.2117, max(ql)-mean(ql), ws, 0.2423,max(ql)-mean(ql), ws, 0.28];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));
peb3 = abs(ci(1,12) - ci(2,12));

q3_lorpar(3,1:5) = [p.g, p.h, p.k, 0.8, peb2];
q3_lorpar2(3,1:5) = [p.l, p.m, p.n, 0.8, peb3];
q3_lorparcomb(3,1:5) = [p.l, p.m, p.n, 0.8, peb3];


%% -0.7 meV
i = 4;
ql = cut_q3.cut(1:end-10,i);
q = cut_q3.r(1:end-10);

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
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.2117];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.2117, max(ql)-mean(ql), ws, 0.2423,max(ql)-mean(ql), ws, 0.28];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));
peb3 = abs(ci(1,12) - ci(2,12));

q3_lorpar(4,1:5) = [p.g, p.h, p.k, 0.7, peb2];
q3_lorpar2(4,1:5) = [p.l, p.m, p.n, 0.7, peb3];
q3_lorparcomb(4,1:5) = [p.l, p.m, p.n, 0.7, peb3];

%% -0.6 meV
i = 5;
ql = cut_q3.cut(1:end,i);
q = cut_q3.r(1:end);

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
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.2117];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.2117, max(ql)-mean(ql), ws, 0.2423,max(ql)-mean(ql), ws, 0.28];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));
peb3 = abs(ci(1,12) - ci(2,12));

q3_lorpar(5,1:5) = [p.g, p.h, p.k, 0.6, peb2];
q3_lorpar2(5,1:5) = [p.l, p.m, p.n, 0.6, peb3];
q3_lorparcomb(5,1:5) = [p.l, p.m, p.n, 0.6, peb3];


%% -0.5 meV
i = 6;
ql = cut_q3.cut(1:end,i);
q = cut_q3.r(1:end);

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
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.2117];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.2117, max(ql)-mean(ql), ws, 0.2423,max(ql)-mean(ql), ws, 0.28];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));
peb3 = abs(ci(1,12) - ci(2,12));

q3_lorpar(6,1:5) = [p.g, p.h, p.k, 0.5, peb2];
q3_lorpar2(6,1:5) = [p.l, p.m, p.n, 0.5, peb3];
q3_lorparcomb(6,1:5) = [p.l, p.m, p.n, 0.5, peb3];
%%
cut_q1a = line_cut_v4(obj_605047A00,[200, 201],[200, 185],0);
cut_q1b = line_cut_v4(obj_605047A00,[201, 201],[201, 185],0);
cut_q1c = line_cut_v4(obj_605047A00,[199, 201],[199, 185],0);
cut_q1d = line_cut_v4(obj_605047A00,[202, 201],[202, 185],0);

cut_q1 = cut_q1a;
cut_q1.cut = (cut_q1a.cut + cut_q1b.cut + cut_q1c.cut + cut_q1d.cut) / 4;

figure, hold on
% for i=5:1:15
for i=1:1:6
    plot(cut_q1.r,cut_q1.cut(:,i)/max(cut_q1.cut(:,i))+(i-1)*0.2,'.-', 'LineWidth', 2);
end
hold off


cut_q1M = cut_q1;


%% -1.1 meV
i = 1;
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
wdn = 0
wup = 10* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.01497, max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(1,1:5) = [p.d, p.e, p.f, 1.1, peb1];
q1_lorpar2(1,1:5) = [p.g, p.h, p.k, 1.1, peb2];
q1_lorparcomb(1,1:5) = [p.g, p.h, p.k, 1.1, peb2];


%% -0.9 meV
i = 2;
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
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
% 
% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
% guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.01497, max(ql)-mean(ql), ws, 0.06738];
% low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
% [y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.01497, max(ql)-mean(ql), ws, 0.06738,max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));
peb3 = abs(ci(1,12) - ci(2,12));

q1_lorpar(2,1:5) = [p.g, p.h, p.k, 0.9, peb1];
q1_lorpar2(2,1:5) = [p.l, p.m, p.n, 0.9, peb2];
% q1_lorparcomb(2,1:4) = [p.g, p.h, p.k, 0.9];
q1_lorparcomb(2,1:5) = [mean([p.g, p.l]), mean([p.h, p.m]), mean([p.k, p.n]), 0.9, abs(p.m - p.k)];

%% -0.8 meV
i = 3;
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
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.01497, max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(3,1:5) = [p.d, p.e, p.f, 0.8, peb1];
q1_lorpar2(3,1:5) = [p.g, p.h, p.k, 0.8, peb2];
q1_lorparcomb(3,1:5) = [p.g, p.h, p.k, 0.8, peb2];

%% -0.7 meV
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
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.01497, max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(4,1:5) = [p.d, p.e, p.f, 0.7, peb1];
q1_lorpar2(4,1:5) = [p.g, p.h, p.k, 0.7, peb2];
q1_lorparcomb(4,1:5) = [p.g, p.h, p.k, 0.7, peb2];

%% -0.6 meV
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
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.01497, max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(5,1:5) = [p.d, p.e, p.f, 0.6, peb1];
q1_lorpar2(5,1:5) = [p.g, p.h, p.k, 0.6, peb2];
q1_lorparcomb(5,1:5) = [p.g, p.h, p.k, 0.6, peb2];

%% -0.5 meV
i = 6;
ql = cut_q1.cut(1:end-5,i);
q = cut_q1.r(1:end-5);

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
wup = 5* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.01497, max(ql)-mean(ql), ws, 0.06738];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
% guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.01497, max(ql)-mean(ql), ws, 0.06738,max(ql)-mean(ql), ws, 0.06738];
% low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
% [y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);
% 
% 
% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)+o*(p/2)^2/((x-r)^2+(p/2)^2)';
% guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.01497, max(ql)-mean(ql), ws, 0.06738,max(ql)-mean(ql), ws, 0.06738, max(ql)-mean(ql), ws, 0.06738];
% low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2, max(ql), wup, 0.18*2];
% [y_new, p,gof, ci]=FeSe_lorentzian4(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(6,1:5) = [p.d, p.e, p.f, 0.5, peb1];
q1_lorpar2(6,1:5) = [p.g, p.h, p.k, 0.5, peb2];
q1_lorparcomb(6,1:5) = [p.g, p.h, p.k, 0.5, peb2];

close all;
