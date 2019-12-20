

en = obj_60222a00_G_FT_sym_avg3.e * 1000;
map1 = obj_60222a00_G_FT_sym_avg3.map;
q = obj_60222a00_G_FT_sym_avg3.r;

map2 = obj_60222a00_G_FT.map;



[X,Y]=meshgrid(1:1:max(size(map1(:,:,1),2)),1:1:max(size(map1(:,:,1),1)));

xdata(:,:,1)=X;
xdata(:,:,2)=Y;

ffmap = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)) );
bsmap = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)) );


for i=1:25
    %     [x1,resnorm,residual]=complete_fit_2d_gaussian_FeSe_BQPI(map1(52:79, 37:57 ,i));
%     [x2,resnorm,residual]=complete_fit_2d_gaussian_FeSe_BQPI(map1(52:79, 72:92 ,i));
%     [x1,resnorm,residual]=complete_fit_2d_gaussian_FeSe_BQPI(map1(52:77, 24:55 ,i));
    [x2,resnorm,residual]=complete_fit_2d_gaussian_FeSe_BQPI(map1(52:77, 74:105 ,i));
%     [x3,resnorm,residual]=complete_fit_2d_gaussian_FeSe_BQPI(map1(47:82, 55:74 ,i));
    [x3,resnorm,residual]=complete_fit_2d_gaussian_FeSe_BQPI(map1(50:79, 55:74 ,i));
%     x1(2) = x1(2)+37-1;
%     x1(4) = x1(4)+52-1;
%     x2(2) = x2(2)+72-1;
%     x2(4) = x2(4)+52-1;
    x1 = x2;
    x1(2) = -x1(2)+55+1;
    x1(4) = x1(4)+52-1;
    
    x2(2) = x2(2)+74-1;
    x2(4) = x2(4)+52-1;    
    
    x3(2) = x3(2)+55-1;
%     x3(4) = x3(4)+47-1;
    x3(4) = x3(4)+50-1;
    finalfit1=twodgauss_xy_rigid(x1,xdata);
    finalfit2=twodgauss_xy_rigid(x2,xdata);
    finalfit3=twodgauss_xy_rigid(x3,xdata);
%     ffmap(:,:,i) = finalfit1 + finalfit2 + finalfit3;
    ffmap(:,:,i) = finalfit3;
    bsmap(:,:,i) = map1(:,:,i) - ffmap(:,:,i);
    bsmap(:,:,i) = bsmap(:,:,i) + abs( min( min( bsmap(:,:,i) ) ) );
    close all;
end

% -0.1 and 0 meV no BQPI, fits produce nans which conflict with the color
% scale
ffmap(:,:,24) = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)) );
ffmap(:,:,25) = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)) );

bsmap(:,:,24) = obj_60222a00_G_FT_sym_avg3.map(:,:,24);
bsmap(:,:,25) = obj_60222a00_G_FT_sym_avg3.map(:,:,25);

obj_60222a00_BGF = obj_60222a00_G_FT_sym_avg3;
obj_60222a00_BGF.map = ffmap;
obj_60222a00_BGF.e = obj_60222a00_G_FT_sym_avg3.e(1:25);
obj_60222a00_BGS = obj_60222a00_G_FT_sym_avg3;
obj_60222a00_BGS.map = bsmap;
obj_60222a00_BGS.e = obj_60222a00_G_FT_sym_avg3.e(1:25);

obj_60222a00_G_FT_sym_avg3_bcp = obj_60222a00_G_FT_sym_avg3;
obj_60222a00_G_FT_sym_avg3_bcp.e = obj_60222a00_G_FT_sym_avg3.e(1:25);
obj_60222a00_G_FT_sym_avg3_bcp.map = obj_60222a00_G_FT_sym_avg3_bcp.map(:,:,1:25);

obj_60222a00_G_FT_bcp = obj_60222a00_G_FT;
obj_60222a00_G_FT_bcp.e = obj_60222a00_G_FT.e(1:25);
obj_60222a00_G_FT_bcp.map = obj_60222a00_G_FT.map(:,:,1:25);

rawmap = obj_60222a00_G_FT_bcp.map;
% figure, img_plot4(finalfit1)
% figure, img_plot4(finalfit2)
% figure, img_plot4(finalfit3)
% figure, img_plot4(finalfit1 + finalfit2 + finalfit3);
% 
% bsmap = map1(:,:,5) - (finalfit1 + finalfit2 + finalfit3);
% bsmap = bsmap + abs( min( min( bsmap) ) );
% figure, img_plot4(bsmap)


% [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

% wq2{1} = [48, 82];
% wq2{2} = [45, 81];
% wq2{3} = [45, 81];
% wq2{4} = [45, 81];
% wq2{5} = [45, 81];
% wq2{6} = [41, 80];
% wq2{7} = [40, 79];
% wq2{8} = [40, 79];
% wq2{9} = [39, 78];
% wq2{10} = [39, 77];
% wq2{11} = [39, 76];
% wq2{12} = [38, 76];
% wq2{13} = [38, 76];
% wq2{14} = [36, 77];
% wq2{15} = [36, 75];
% wq2{16} = [35, 75];

% pn = [3, 3, 4, 5, 5, 6, 7, 5, 5, 5, 5, 5, 5, 5, 5, 5];
% pn = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4];
% pn = pn-2;
% 
% for i=5:17
%     
%     cropco = wq2{i-5+1};
%     xs = cropco(1) - pn(i-5+1);
%     xe = cropco(1) + pn(i-5+1);
%     ys = cropco(2) - pn(i-5+1);
%     ye = cropco(2) + pn(i-5+1);
%     
%     xsr1 = cropco(1) - pn(i-5+1)+1;
%     xer1 = cropco(1) + pn(i-5+1)-1;
%     ysr1 = cropco(2) - pn(i-5+1)+1;
%     yer1 = cropco(2) + pn(i-5+1)-1;
%     
%     xsr2 = xsr1;
%     xer2 = xer1;
%     ysr2 = 64- (yer1-65);
%     yer2 = 64- (ysr1-65);
%     
%     
%     h = fspecial('average',[3,3]);
%     rawmap(:,:,i-5+1) = imfilter(rawmap(:,:,i-5+1),h,'replicate');
% 
%     [xproc,resnormproc,residualproc]=complete_fit_2d_gaussian_FeSe_BQPI(obj_60222a00_G_FT_sym_avg3_bcp.map(xs:xe, ys:ye ,i-5+1));
% 
% %     [x,resnorm,residual]=complete_fit_2d_gaussian(map1(xs:xe, ys:ye ,i));
% 
%     [xrawr,resnormrawr,residualrawr]=complete_fit_2d_gaussian_FeSe_BQPI(rawmap(xsr1:xer1, ysr1:yer1 ,i-5+1));
%     
%     [xrawl,resnormrawl,residualrawl]=complete_fit_2d_gaussian_FeSe_BQPI(rawmap(xsr2:xer2, ysr2:yer2 ,i-5+1));
% %     [x,resnorm,residual]=complete_fit_2d_gaussian(map2(xs:xe, ys:ye ,i));
% 
%     test =1;
%     close all;
% end







%%

% cut_q3a = line_cut_v4(obj_60222a00_G_FT_sym_avg3,[68, 64],[100, 64],0);
% cut_q3b = line_cut_v4(obj_60222a00_G_FT_sym_avg3,[68, 65],[100, 65],0);
% cut_q3c = line_cut_v4(obj_60222a00_G_FT_sym_avg3,[68, 63],[100, 63],0);
% cut_q3d = line_cut_v4(obj_60222a00_G_FT_sym_avg3,[68, 66],[100, 66],0);

cut_q3a = line_cut_v4(obj_60222a00_BGS,[68, 64],[100, 64],0);
cut_q3b = line_cut_v4(obj_60222a00_BGS,[68, 65],[100, 65],0);
cut_q3c = line_cut_v4(obj_60222a00_BGS,[68, 63],[100, 63],0);
cut_q3d = line_cut_v4(obj_60222a00_BGS,[68, 66],[100, 66],0);
cut_q3e = line_cut_v4(obj_60222a00_BGS,[68, 62],[100, 62],0);
cut_q3f = line_cut_v4(obj_60222a00_BGS,[68, 67],[100, 67],0);

% cut_q3a = line_cut_v4(obj_60222a00_G_FT_12cr,[68, 64],[100, 64],0);
% cut_q3b = line_cut_v4(obj_60222a00_G_FT_12cr,[68, 65],[100, 65],0);
% cut_q3c = line_cut_v4(obj_60222a00_G_FT_12cr,[68, 63],[100, 63],0);
% cut_q3d = line_cut_v4(obj_60222a00_G_FT_12cr,[68, 66],[100, 66],0);

cut_q3 = cut_q3a;

cut_q3.cut = (cut_q3a.cut + cut_q3b.cut + cut_q3c.cut + cut_q3d.cut + cut_q3e.cut + cut_q3f.cut) / 4;
% figure, plot(cut_q3a.r,cut_q3a.cut(:,6),'k-o');
% figure, plot(cut_q3.r,cut_q3.cut(:,6),'k-o');



figure, hold on
for i=1:1:15
    plot(cut_q3.r,cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     title([num2str(en(i)) ' meV']);
end
hold off

%% q3 -2.4 meV
i = 1;
ql = cut_q3.cut(10:end,i);
q = cut_q3.r(10:end);
ql = sgolayfilt(ql,3,19);

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

peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar = [p.d, p.e, p.f, 2.4, peb1];


%% q3 -2.3 meV
i = 2;
ql = cut_q3.cut(10:end,i);
q = cut_q3.r(10:end);
ql = sgolayfilt(ql,3,19);

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



peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(2,1:5) = [p.d, p.e, p.f, 2.3, peb1];


%% q3 -2.2 meV
i = 3;
ql = cut_q3.cut(10:end,i);
q = cut_q3.r(10:end);
ql = sgolayfilt(ql,3,19);

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

peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(3,1:5) = [p.d, p.e, p.f, 2.2, peb1];


%% q3 -2.1 meV
i = 4;
ql = cut_q3.cut(9:end,i);
q = cut_q3.r(9:end);
ql = sgolayfilt(ql,3,19);

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

peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(4,1:5) = [p.d, p.e, p.f, 2.1, peb1];


%% q3 -2.0 meV
i = 5;
ql = cut_q3.cut(8:end,i);
q = cut_q3.r(8:end);
ql = sgolayfilt(ql,3,19);

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

peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(5,1:5) = [p.d, p.e, p.f, 2.0, peb1];


%% q3 -1.9 meV
i = 6;
ql = cut_q3.cut(5:end-8,i);
q = cut_q3.r(5:end-8);
ql = sgolayfilt(ql,3,19);

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

peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(6,1:5) = [p.d, p.e, p.f, 1.9, peb1];


%% q3 -1.8 meV
i = 7;
ql = cut_q3.cut(6:end-8,i);
q = cut_q3.r(6:end-8);
ql = sgolayfilt(ql,3,19);

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
wup = 20* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(7,1:5) = [p.d, p.e, p.f, 1.8, peb1];


%% q3 -1.7 meV
i = 8;
ql = cut_q3.cut(6:end-8,i);
q = cut_q3.r(6:end-8);
ql = sgolayfilt(ql,3,19);

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
wup = 20* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.1];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(8,1:5) = [p.d, p.e, p.f, 1.7, peb1];

%% q3 -1.6 meV
i = 9;
ql = cut_q3.cut(3:end-10,i);
q = cut_q3.r(3:end-10);
ql = sgolayfilt(ql,3,19);

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
wup = 20* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);


peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(9,1:5) = [p.d, p.e, p.f, 1.6, peb1];

%% q3 -1.5 meV
i = 10;
ql = cut_q3.cut(3:end-10,i);
q = cut_q3.r(3:end-10);
ql = sgolayfilt(ql,3,19);

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
wup = 20* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.1];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(10,1:5) = [p.d, p.e, p.f, 1.5, peb1];

%% q3 -1.4 meV
i = 11;
ql = cut_q3.cut(1:end-10,i);
q = cut_q3.r(1:end-10);
ql = sgolayfilt(ql,3,19);

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
wup = 20* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.1];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(11,1:5) = [p.d, p.e, p.f, 1.4, peb1];

%% q3 -1.3 meV
i = 12;
ql = cut_q3.cut(1:end-10,i);
q = cut_q3.r(1:end-10);
ql = sgolayfilt(ql,3,19);

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
wup = 20* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.1];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(12,1:5) = [p.d, p.e, p.f, 1.3, peb1];


%% q3 -1.2 meV
i = 13;
ql = cut_q3.cut(2:end-10,i);
q = cut_q3.r(2:end-10);
ql = sgolayfilt(ql,3,19);

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
wup = 20* ws;

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.1];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));

q3_lorpar(13,1:5) = [p.d, p.e, p.f, 1.2, peb1];


%% q3 -1.1 meV
i = 14;
ql = cut_q3.cut(1:end,i);
q = cut_q3.r(1:end);
ql = sgolayfilt(ql,3,13);

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
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.06585, max(ql)-mean(ql), ws, 0.099,];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0.06585-0.1, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.06585+0.1, max(ql), wup, 0.139*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q3_lorpar(14,1:5) = [p.d, p.e, p.f, 1.1, peb1];
q3_lorpar2(14,1:5) = [p.g, p.h, p.k, 1.1, peb2];
% q3_lorparcomb(14,1:5) = [p.d, p.e, p.f, 1.1, peb1];
q3_lorparcomb(14,1:5) = [mean([p.d, p.g]), mean([p.e, p.h]), mean([p.f, p.k]), 1.1, abs(p.f - p.k)];

%% q3 -1.0 meV
i = 15;
ql = cut_q3.cut(1:end,i);
q = cut_q3.r(1:end);
ql = sgolayfilt(ql,3,13);

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
% 
% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
% guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.09244, max(ql)-mean(ql), ws, 0.1257];
% low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
% [y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);
% 
% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
% guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.06585, max(ql)-mean(ql), ws, 0.099,max(ql)-mean(ql), ws, 0.12];
% low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
% [y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)+o*(p/2)^2/((x-r)^2+(p/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.06585, max(ql)-mean(ql), ws, 0.099,max(ql)-mean(ql), ws, 0.12, max(ql)-mean(ql), ws, 0.18];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian4(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q3_lorpar(15,1:5) = [p.d, p.e, p.f, 1.0, peb1];
q3_lorpar2(15,1:5) = [p.g, p.h, p.k, 1.0, peb2];
% q3_lorparcomb(15,1:5) = [p.d, p.e, p.f, 1.0, peb1];
q3_lorparcomb(15,1:5) = [mean([p.d, p.g]), mean([p.e, p.h]), mean([p.f, p.k]), 1.0, abs(p.f - p.k)];


%% q3 -0.9 meV
i = 16;
ql = cut_q3.cut(1:end,i);
q = cut_q3.r(1:end);
ql = sgolayfilt(ql,3,13);

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
% 
% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
% guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.09244, max(ql)-mean(ql), ws, 0.1257];
% low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
% [y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);
% 
% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
% guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.06585, max(ql)-mean(ql), ws, 0.099,max(ql)-mean(ql), ws, 0.12];
% low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
% [y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)+o*(p/2)^2/((x-r)^2+(p/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.06585, max(ql)-mean(ql), ws, 0.099,max(ql)-mean(ql), ws, 0.12, max(ql)-mean(ql), ws, 0.18];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian4(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q3_lorpar(16,1:5) = [p.d, p.e, p.f, 0.9, peb1];
q3_lorpar2(16,1:5) = [p.g, p.h, p.k, 0.9, peb2];
% q3_lorparcomb(16,1:5) = [p.d, p.e, p.f, 0.9, peb1];
q3_lorparcomb(16,1:5) = [mean([p.d, p.g]), mean([p.e, p.h]), mean([p.f, p.k]), 0.9, abs(p.f - p.k)];


%% q3 -0.8 meV
i = 17;
ql = cut_q3.cut(1:end,i);
q = cut_q3.r(1:end);
ql = sgolayfilt(ql,3,13);

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
% 
% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
% guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.09244, max(ql)-mean(ql), ws, 0.1257];
% low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
% [y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);
% 
% % exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
% guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.06585, max(ql)-mean(ql), ws, 0.099,max(ql)-mean(ql), ws, 0.12];
% low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
% upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
% [y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)+o*(p/2)^2/((x-r)^2+(p/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.06585, max(ql)-mean(ql), ws, 0.099,max(ql)-mean(ql), ws, 0.12, max(ql)-mean(ql), ws, 0.18];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian4(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q3_lorpar(17,1:5) = [p.d, p.e, p.f, 0.8, peb1];
q3_lorpar2(17,1:5) = [p.g, p.h, p.k, 0.8, peb2];
% q3_lorparcomb(17,1:5) = [p.d, p.e, p.f, 0.8, peb1];
q3_lorparcomb(17,1:5) = [mean([p.d, p.g]), mean([p.e, p.h]), mean([p.f, p.k]), 0.8, abs(p.f - p.k)];

close all;
%%

cut_q1a = line_cut_v4(obj_60222a00_BGS,[64, 54],[64, 27],0);
cut_q1b = line_cut_v4(obj_60222a00_BGS,[65, 54],[65, 27],0);
cut_q1c = line_cut_v4(obj_60222a00_BGS,[63, 54],[63, 27],0);
cut_q1d = line_cut_v4(obj_60222a00_BGS,[66, 54],[66, 27],0);

% cut_q1a = line_cut_v4(obj_60222a00_G_FT_12cr,[64, 54],[64, 27],0);
% cut_q1b = line_cut_v4(obj_60222a00_G_FT_12cr,[65, 54],[65, 27],0);
% cut_q1c = line_cut_v4(obj_60222a00_G_FT_12cr,[63, 54],[63, 27],0);
% cut_q1d = line_cut_v4(obj_60222a00_G_FT_12cr,[66, 54],[66, 27],0);

% cut_q1a = line_cut_v4(obj_60222a00_G_FT,[64, 54],[64, 27],0);
% cut_q1b = line_cut_v4(obj_60222a00_G_FT,[65, 54],[65, 27],0);
% cut_q1c = line_cut_v4(obj_60222a00_G_FT,[63, 54],[63, 27],0);
% cut_q1d = line_cut_v4(obj_60222a00_G_FT,[66, 54],[66, 27],0);

cut_q1 = cut_q1a;
cut_q1.cut = (cut_q1a.cut + cut_q1b.cut + cut_q1c.cut + cut_q1d.cut) / 4;

figure, hold on
% for i=5:1:15
for i=5:1:15
    plot(cut_q1.r,cut_q1.cut(:,i)/max(cut_q1.cut(:,i))+(i-1)*0.5,'b.-', 'LineWidth', 2);
%      figure, plot(cut_q1.cut(:,i)/max(cut_q1.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     title([num2str(en(i)) ' meV']);
end
hold off

%% q1 -2.1 meV
i = 4;
ql = cut_q1.cut(1:end-7,i);
q = cut_q1.r(1:end-7);

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
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09115, max(ql)-mean(ql), ws, 0.1246,max(ql)-mean(ql), ws, 0.1781];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(1,1:5) = [p.d, p.e, p.f, 2.1, peb1];
q1_lorpar2(1,1:5) = [p.g, p.h, p.k, 2.1, peb2];
q1_lorparcomb(1,1:5) = [p.d, p.e, p.f, 2.1, peb1];

%% q1 -2.0 meV
i = 5;
ql = cut_q1.cut(1:end-7,i);
q = cut_q1.r(1:end-7);

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
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09115, max(ql)-mean(ql), ws, 0.1246,max(ql)-mean(ql), ws, 0.1781];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(2,1:5) = [p.d, p.e, p.f, 2.0, peb1];
q1_lorpar2(2,1:5) = [p.g, p.h, p.k, 2.0, peb2];
q1_lorparcomb(2,1:5) = [p.d, p.e, p.f, 2.0, peb1];
%% q1 -1.9 meV
i = 6;
ql = cut_q1.cut(1:end-7,i);
q = cut_q1.r(1:end-7);

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
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09115, max(ql)-mean(ql), ws, 0.1246,max(ql)-mean(ql), ws, 0.1781];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(3,1:5) = [p.d, p.e, p.f, 1.9, peb1];
q1_lorpar2(3,1:5) = [p.g, p.h, p.k, 1.9, peb2];
q1_lorparcomb(3,1:5) = [p.d, p.e, p.f, 1.9, peb1];
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
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09115, max(ql)-mean(ql), ws, 0.1246,max(ql)-mean(ql), ws, 0.1781];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(4,1:5) = [p.d, p.e, p.f, 1.8, peb1];
q1_lorpar2(4,1:5) = [p.g, p.h, p.k, 1.8, peb2];
q1_lorparcomb(4,1:5) = [p.d, p.e, p.f, 1.8, peb1];
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
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.139];
low = [min(ql), bgsldn, -inf,  0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.139*2];

[y_new, p,gof, ci]=FeSe_lorentzian1(ql,q,guess,low,upp);
figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.09115, max(ql)-mean(ql), ws, 0.1246,max(ql)-mean(ql), ws, 0.1781];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(5,1:5) = [p.d, p.e, p.f, 1.7, peb1];
q1_lorpar2(5,1:5) = [p.g, p.h, p.k, 1.7, peb2];
q1_lorparcomb(5,1:5) = [mean([p.d, p.g]), mean([p.e, p.h]), mean([p.f, p.k]), 1.7, abs(p.f - p.k)];
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

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)';
guess = [mean(ql), bgsl, min(q), max(ql)-mean(ql), ws, 0.1179, max(ql)-mean(ql), ws, 0.1781];
low = [min(ql), bgsldn, -inf,   0,  wdn,  0, 0, wdn, 0];
upp = [max(ql), bgslup, inf, max(ql), wup, 0.1257*2, max(ql), wup, 0.1523*2];
[y_new, p,gof, ci]=FeSe_lorentzian2(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(6,1:5) = [p.d, p.e, p.f, 1.6, peb1];
q1_lorpar2(6,1:5) = [p.d, p.e, p.f, 1.6, peb2];
q1_lorparcomb(6,1:5) = [p.d, p.e, p.f, 1.6, peb1];

%% q1 -1.5 meV
i = 10;
ql = cut_q1.cut(4:end-5,i);
q = cut_q1.r(4:end-5);

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
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.1179, max(ql)-mean(ql), ws, 0.1513,max(ql)-mean(ql), ws, 0.1781];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(7,1:5) = [p.d, p.e, p.f, 1.5, peb1];
q1_lorpar2(7,1:5) = [p.g, p.h, p.k, 1.5, peb2];
q1_lorparcomb(7,1:5) = [mean([p.d, p.g]), mean([p.e, p.h]), mean([p.f, p.k]), 1.5, abs(p.f - p.k)];

%% q1 -1.4 meV
i = 11;
ql = cut_q1.cut(4:end-5,i);
q = cut_q1.r(4:end-5);

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
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.1179, max(ql)-mean(ql), ws, 0.1513,max(ql)-mean(ql), ws, 0.1781];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(8,1:5) = [p.d, p.e, p.f, 1.4, peb1];
q1_lorpar2(8,1:5) = [p.g, p.h, p.k, 1.4, peb2];
q1_lorparcomb(8,1:5) = [p.g, p.h, p.k, 1.4, peb2];

%% q1 -1.3 meV
i = 12;
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

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)+o*(p/2)^2/((x-r)^2+(p/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.1179, max(ql)-mean(ql), ws, 0.1513,max(ql)-mean(ql), ws, 0.1781, max(ql)-mean(ql), ws, 0.2182];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian4(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(9,1:5) = [p.d, p.e, p.f, 1.3, peb1];
q1_lorpar2(9,1:5) = [p.g, p.h, p.k, 1.3, peb2];
q1_lorparcomb(9,1:5) = [p.g, p.h, p.k, 1.3, peb2];

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

% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.1246, max(ql)-mean(ql), ws, 0.158,max(ql)-mean(ql), ws, 0.2182];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(10,1:5) = [p.d, p.e, p.f, 1.2, peb1];
q1_lorpar2(10,1:5) = [p.g, p.h, p.k, 1.2, peb2];
q1_lorparcomb(10,1:5) = [p.g, p.h, p.k, 1.2, peb2];

%% q1 -1.1 meV
i = 14;
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


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.1246, max(ql)-mean(ql), ws, 0.158,max(ql)-mean(ql), ws, 0.2182];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(11,1:5) = [p.d, p.e, p.f, 1.1, peb1];
q1_lorpar2(11,1:5) = [p.g, p.h, p.k, 1.1, peb2];
q1_lorparcomb(11,1:5) = [p.g, p.h, p.k, 1.1, peb2];

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


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.1246, max(ql)-mean(ql), ws, 0.158,max(ql)-mean(ql), ws, 0.2182];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(12,1:5) = [p.g, p.h, p.k, 1.0, peb2];
q1_lorpar2(12,1:5) = [p.g, p.h, p.k, 1.0, peb2];
q1_lorparcomb(12,1:5) = [p.g, p.h, p.k, 1.0, peb2];

%% q1 -0.9 meV
i = 16;
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


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.1246, max(ql)-mean(ql), ws, 0.158,max(ql)-mean(ql), ws, 0.2182];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(13,1:5) = [p.g, p.h, p.k, 0.9, peb1];
q1_lorpar2(13,1:5) = [p.g, p.h, p.k, 0.9, peb2];
q1_lorparcomb(13,1:5) = [p.g, p.h, p.k, 0.9, peb2];

%% q1 -0.8 meV
i = 17;
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


% exp_lrntz = 'a+ b*(x-c) + d*(e/2)^2/((x-f)^2+(e/2)^2)+g*(h/2)^2/((x-k)^2+(h/2)^2)+l*(m/2)^2/((x-n)^2+(m/2)^2)';
guess = [mean(ql), bgsl, min(q) , max(ql)-mean(ql), ws, 0.1246, max(ql)-mean(ql), ws, 0.1848,max(ql)-mean(ql), ws, 0.2182];
low = [min(ql), bgsldn, -inf,  0,    wdn,  0, 0, wdn, 0, 0, wdn, 0];
upp = [max(ql), bgslup, inf,  max(ql), wup, 0.139*2, max(ql), wup, 0.139*2, max(ql), wup, 0.18*2];
[y_new, p,gof, ci]=FeSe_lorentzian3(ql,q,guess,low,upp);

peb1 = abs(ci(1,6) - ci(2,6));
peb2 = abs(ci(1,9) - ci(2,9));

q1_lorpar(14,1:5) = [p.g, p.h, p.k, 0.8, peb1];
q1_lorpar2(14,1:5) = [p.g, p.h, p.k, 0.8, peb2];
q1_lorparcomb(14,1:5) = [p.g, p.h, p.k, 0.8, peb2];

close all;