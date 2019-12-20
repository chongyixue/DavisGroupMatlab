
%% File 51107A01

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_51107A01_T,612,511,518,423,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_51107A01_T_LF,612,511,518,423,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_51107A01_T_shearcor_LF,607,513,513,419,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_51107A01_T,419,425,617,421,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_51107A01_T_LF,419,425,617,421,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_51107A01_T_shearcor_LF,419,419,607,419,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 53;
sy = 53;
ex = 979;
ey = 979;

obj_51107A01_T.map = obj_51107A01_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_51107A01_T.map);
obj_51107A01_T.r = obj_51107A01_T.r(1:nx);
img_obj_viewer2(obj_51107A01_T);

obj_51107A01_T_LF.map = obj_51107A01_T_LF.map(sx:ex, sy:ey, :);
obj_51107A01_T_LF.r = obj_51107A01_T_LF.r(1:nx);
img_obj_viewer2(obj_51107A01_T_LF);

obj_51107A01_T_shearcor_LF.map = obj_51107A01_T_shearcor_LF.map(sx:ex, sy:ey, :);
obj_51107A01_T_shearcor_LF.r = obj_51107A01_T_shearcor_LF.r(1:nx);
img_obj_viewer2(obj_51107A01_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx:ex, sy:ey, :);
self.r = self.r(1:nx);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx:ex, sy:ey, :);
sesclf.r = sesclf.r(1:nx);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx:ex, sy:ey, :);
felf.r = felf.r(1:nx);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx:ex, sy:ey, :);
fesclf.r = fesclf.r(1:nx);
img_obj_viewer2(fesclf);
%% File 51116A01

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_51116A01_T,612,511,518,423,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_51116A01_T_LF,612,511,518,423,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_51116A01_T_shearcor_LF,607,513,513,419,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_51116A01_T,419,425,617,421,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_51116A01_T_LF,419,425,617,421,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_51116A01_T_shearcor_LF,419,419,607,419,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 53;
sy = 53;
ex = 979;
ey = 979;

obj_51116A01_T.map = obj_51116A01_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_51116A01_T.map);
obj_51116A01_T.r = obj_51116A01_T.r(1:nx);
img_obj_viewer2(obj_51116A01_T);

obj_51116A01_T_LF.map = obj_51116A01_T_LF.map(sx:ex, sy:ey, :);
obj_51116A01_T_LF.r = obj_51116A01_T_LF.r(1:nx);
img_obj_viewer2(obj_51116A01_T_LF);

obj_51116A01_T_shearcor_LF.map = obj_51116A01_T_shearcor_LF.map(sx:ex, sy:ey, :);
obj_51116A01_T_shearcor_LF.r = obj_51116A01_T_shearcor_LF.r(1:nx);
img_obj_viewer2(obj_51116A01_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx:ex, sy:ey, :);
self.r = self.r(1:nx);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx:ex, sy:ey, :);
sesclf.r = sesclf.r(1:nx);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx:ex, sy:ey, :);
felf.r = felf.r(1:nx);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx:ex, sy:ey, :);
fesclf.r = fesclf.r(1:nx);
img_obj_viewer2(fesclf);
%% File 51116A02

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_51116A02_T,612,511,518,423,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_51116A02_T_LF,612,511,518,423,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_51116A02_T_shearcor_LF,607,513,513,419,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_51116A02_T,419,425,617,421,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_51116A02_T_LF,419,425,617,421,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_51116A02_T_shearcor_LF,419,419,607,419,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 53;
sy = 53;
ex = 979;
ey = 979;

obj_51116A02_T.map = obj_51116A02_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_51116A02_T.map);
obj_51116A02_T.r = obj_51116A02_T.r(1:nx);
img_obj_viewer2(obj_51116A02_T);

obj_51116A02_T_LF.map = obj_51116A02_T_LF.map(sx:ex, sy:ey, :);
obj_51116A02_T_LF.r = obj_51116A02_T_LF.r(1:nx);
img_obj_viewer2(obj_51116A02_T_LF);

obj_51116A02_T_shearcor_LF.map = obj_51116A02_T_shearcor_LF.map(sx:ex, sy:ey, :);
obj_51116A02_T_shearcor_LF.r = obj_51116A02_T_shearcor_LF.r(1:nx);
img_obj_viewer2(obj_51116A02_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx:ex, sy:ey, :);
self.r = self.r(1:nx);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx:ex, sy:ey, :);
sesclf.r = sesclf.r(1:nx);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx:ex, sy:ey, :);
felf.r = felf.r(1:nx);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx:ex, sy:ey, :);
fesclf.r = fesclf.r(1:nx);
img_obj_viewer2(fesclf);
%% File 60422A05

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_60422a05_T,573,512,514,448,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_60422a05_T_LF,573,512,514,448,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_60422a05_T_shearcor_LF,575,513,513,451,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_60422a05_T,454,450,574,447,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_60422a05_T_LF,454,449,574,447,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_60422a05_T_shearcor_LF,451,451,575,451,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 53;
sy = 53;
ex = 999;
ey = 999;

obj_60422a05_T.map = obj_60422a05_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_60422a05_T.map);
obj_60422a05_T.r = obj_60422a05_T.r(1:nx);
img_obj_viewer2(obj_60422a05_T);

obj_60422a05_T_LF.map = obj_60422a05_T_LF.map(sx:ex, sy:ey, :);
obj_60422a05_T_LF.r = obj_60422a05_T_LF.r(1:nx);
img_obj_viewer2(obj_60422a05_T_LF);

obj_60422a05_T_shearcor_LF.map = obj_60422a05_T_shearcor_LF.map(sx:ex, sy:ey, :);
obj_60422a05_T_shearcor_LF.r = obj_60422a05_T_shearcor_LF.r(1:nx);
img_obj_viewer2(obj_60422a05_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx:ex, sy:ey, :);
self.r = self.r(1:nx);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx:ex, sy:ey, :);
sesclf.r = sesclf.r(1:nx);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx:ex, sy:ey, :);
felf.r = felf.r(1:nx);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx:ex, sy:ey, :);
fesclf.r = fesclf.r(1:nx);
img_obj_viewer2(fesclf);
%% File 60425A00

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_60425a00_T,633,510,515,384,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_60425a00_T_LF,633,510,515,384,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_60425a00_T_shearcor_LF,637,513,513,389,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_60425a00_T,396,387,635,381,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_60425a00_T_LF,395,387,635,381,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_60425a00_T_shearcor_LF,389,389,637,389,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 53;
sy = 53;
ex = 979;
ey = 979;

obj_60425a00_T.map = obj_60425a00_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_60425a00_T.map);
obj_60425a00_T.r = obj_60425a00_T.r(1:nx);
img_obj_viewer2(obj_60425a00_T);

obj_60425a00_T_LF.map = obj_60425a00_T_LF.map(sx:ex, sy:ey, :);
obj_60425a00_T_LF.r = obj_60425a00_T_LF.r(1:nx);
img_obj_viewer2(obj_60425a00_T_LF);

obj_60425a00_T_shearcor_LF.map = obj_60425a00_T_shearcor_LF.map(sx:ex, sy:ey, :);
obj_60425a00_T_shearcor_LF.r = obj_60425a00_T_shearcor_LF.r(1:nx);
img_obj_viewer2(obj_60425a00_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx:ex, sy:ey, :);
self.r = self.r(1:nx);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx:ex, sy:ey, :);
sesclf.r = sesclf.r(1:nx);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx:ex, sy:ey, :);
felf.r = felf.r(1:nx);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx:ex, sy:ey, :);
fesclf.r = fesclf.r(1:nx);
img_obj_viewer2(fesclf);

%% File 60425A01

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_60425a01_T,543,512,514,481,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_60425a01_T_LF,543,512,514,481,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_60425a01_T_shearcor_LF,544,513,513,482,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_60425a01_T,484,482,544,480,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_60425a01_T_LF,484,482,544,480,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_60425a01_T_shearcor_LF,482,482,544,482,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 90;
sy = 90;
ex = 970;
ey = 970;

obj_60425a01_T.map = obj_60425a01_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_60425a01_T.map);
obj_60425a01_T.r = obj_60425a01_T.r(1:nx);
img_obj_viewer2(obj_60425a01_T);

obj_60425a01_T_LF.map = obj_60425a01_T_LF.map(sx:ex, sy:ey, :);
obj_60425a01_T_LF.r = obj_60425a01_T_LF.r(1:nx);
img_obj_viewer2(obj_60425a01_T_LF);

obj_60425a01_T_shearcor_LF.map = obj_60425a01_T_shearcor_LF.map(sx:ex, sy:ey, :);
obj_60425a01_T_shearcor_LF.r = obj_60425a01_T_shearcor_LF.r(1:nx);
img_obj_viewer2(obj_60425a01_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx:ex, sy:ey, :);
self.r = self.r(1:nx);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx:ex, sy:ey, :);
sesclf.r = sesclf.r(1:nx);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx:ex, sy:ey, :);
felf.r = felf.r(1:nx);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx:ex, sy:ey, :);
fesclf.r = fesclf.r(1:nx);
img_obj_viewer2(fesclf);

%% File 60425A02

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_60425a02_T,543,513,513,481,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_60425a02_T_LF,543,513,513,481,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_60425a02_T_shearcor_LF,544,513,513,482,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_60425a02_T,484,481,543,481,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_60425a02_T_LF,483,481,543,481,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_60425a02_T_shearcor_LF,482,482,544,482,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 90;
sy = 90;
ex = 970;
ey = 970;

obj_60425a02_T.map = obj_60425a02_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_60425a02_T.map);
obj_60425a02_T.r = obj_60425a02_T.r(1:nx);
img_obj_viewer2(obj_60425a02_T);

obj_60425a02_T_LF.map = obj_60425a02_T_LF.map(sx:ex, sy:ey, :);
obj_60425a02_T_LF.r = obj_60425a02_T_LF.r(1:nx);
img_obj_viewer2(obj_60425a02_T_LF);

obj_60425a02_T_shearcor_LF.map = obj_60425a02_T_shearcor_LF.map(sx:ex, sy:ey, :);
obj_60425a02_T_shearcor_LF.r = obj_60425a02_T_shearcor_LF.r(1:nx);
img_obj_viewer2(obj_60425a02_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx:ex, sy:ey, :);
self.r = self.r(1:nx);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx:ex, sy:ey, :);
sesclf.r = sesclf.r(1:nx);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx:ex, sy:ey, :);
felf.r = felf.r(1:nx);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx:ex, sy:ey, :);
fesclf.r = fesclf.r(1:nx);
img_obj_viewer2(fesclf);

%% File 60426A00

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_60426a00_T,664,510,515,345,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_60426a00_T_LF,664,510,515,345,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_60426a00_T_shearcor_LF,672,513,513,354,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_60426a00_T,365,348,667,342,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_60426a00_T_LF,364,348,666,342,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_60426a00_T_shearcor_LF,354,354,672,354,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 53;
sy = 53;
ex = 1004;
ey = 1004;

obj_60426a00_T.map = obj_60426a00_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_60426a00_T.map);
obj_60426a00_T.r = obj_60426a00_T.r(1:nx);
img_obj_viewer2(obj_60426a00_T);

obj_60426a00_T_LF.map = obj_60426a00_T_LF.map(sx:ex, sy:ey, :);
obj_60426a00_T_LF.r = obj_60426a00_T_LF.r(1:nx);
img_obj_viewer2(obj_60426a00_T_LF);

obj_60426a00_T_shearcor_LF.map = obj_60426a00_T_shearcor_LF.map(sx:ex, sy:ey, :);
obj_60426a00_T_shearcor_LF.r = obj_60426a00_T_shearcor_LF.r(1:nx);
img_obj_viewer2(obj_60426a00_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx:ex, sy:ey, :);
self.r = self.r(1:nx);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx:ex, sy:ey, :);
sesclf.r = sesclf.r(1:nx);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx:ex, sy:ey, :);
felf.r = felf.r(1:nx);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx:ex, sy:ey, :);
fesclf.r = fesclf.r(1:nx);
img_obj_viewer2(fesclf);

%% File 60426A01

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_60426a01_T,528,513,513,497,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_60426a01_T_LF,528,513,513,497,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_60426a01_T_shearcor_LF,528,513,513,498,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_60426a01_T,498,497,528,497,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_60426a01_T_LF,498,497,528,497,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_60426a01_T_shearcor_LF,498,498,528,498,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 185;
sy = 130;
ex = 915;
ey = 860;

sx2 = 160;
sy2 = 190;
ex2 = 870;
ey2 = 900;

sx3 = 180;
sy3 = 180;
ex3 = 915;
ey3 = 915;

obj_60426a01_T.map = obj_60426a01_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_60426a01_T.map);
obj_60426a01_T.r = obj_60426a01_T.r(1:nx);
img_obj_viewer2(obj_60426a01_T);

obj_60426a01_T_LF.map = obj_60426a01_T_LF.map(sx2:ex2, sy2:ey2, :);
[nx2, ny2, nz2] = size(obj_60426a01_T_LF.map);
obj_60426a01_T_LF.r = obj_60426a01_T_LF.r(1:nx2);
img_obj_viewer2(obj_60426a01_T_LF);

obj_60426a01_T_shearcor_LF.map = obj_60426a01_T_shearcor_LF.map(sx3:ex3, sy3:ey3, :);
[nx3, ny3, nz3] = size(obj_60426a01_T_shearcor_LF.map);
obj_60426a01_T_shearcor_LF.r = obj_60426a01_T_shearcor_LF.r(1:nx3);
img_obj_viewer2(obj_60426a01_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx2:ex2, sy2:ey2, :);
self.r = self.r(1:nx2);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx3:ex3, sy3:ey3, :);
sesclf.r = sesclf.r(1:nx3);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx2:ex2, sy2:ey2, :);
felf.r = felf.r(1:nx2);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx3:ex3, sy3:ey3, :);
fesclf.r = fesclf.r(1:nx3);
img_obj_viewer2(fesclf);
%% File 60426A02

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_60426a02_T,528,513,513,497,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_60426a02_T_LF,528,513,513,497,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_60426a02_T_shearcor_LF,528,513,513,498,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_60426a02_T,498,497,528,497,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_60426a02_T_LF,498,497,528,497,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_60426a02_T_shearcor_LF,498,498,528,498,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 195;
sy = 115;
ex = 920;
ey = 840;

sx2 = 160;
sy2 = 125;
ex2 = 870;
ey2 = 835;

sx3 = 180;
sy3 = 180;
ex3 = 915;
ey3 = 915;

obj_60426a02_T.map = obj_60426a02_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_60426a02_T.map);
obj_60426a02_T.r = obj_60426a02_T.r(1:nx);
img_obj_viewer2(obj_60426a02_T);

obj_60426a02_T_LF.map = obj_60426a02_T_LF.map(sx2:ex2, sy2:ey2, :);
[nx2, ny2, nz2] = size(obj_60426a02_T_LF.map);
obj_60426a02_T_LF.r = obj_60426a02_T_LF.r(1:nx2);
img_obj_viewer2(obj_60426a02_T_LF);

obj_60426a02_T_shearcor_LF.map = obj_60426a02_T_shearcor_LF.map(sx3:ex3, sy3:ey3, :);
[nx3, ny3, nz3] = size(obj_60426a02_T_shearcor_LF.map);
obj_60426a02_T_shearcor_LF.r = obj_60426a02_T_shearcor_LF.r(1:nx3);
img_obj_viewer2(obj_60426a02_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx2:ex2, sy2:ey2, :);
self.r = self.r(1:nx2);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx3:ex3, sy3:ey3, :);
sesclf.r = sesclf.r(1:nx3);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx2:ex2, sy2:ey2, :);
felf.r = felf.r(1:nx2);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx3:ex3, sy3:ey3, :);
fesclf.r = fesclf.r(1:nx3);
img_obj_viewer2(fesclf);
%% File 60426A03

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_60426a03_T,528,513,513,497,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_60426a03_T_LF,528,513,513,497,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_60426a03_T_shearcor_LF,528,513,513,498,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_60426a03_T,498,497,528,497,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_60426a03_T_LF,498,497,528,497,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_60426a03_T_shearcor_LF,498,498,528,498,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 200;
sy = 110;
ex = 925;
ey = 835;

sx2 = 150;
sy2 = 120;
ex2 = 870;
ey2 = 840;

sx3 = 180;
sy3 = 180;
ex3 = 915;
ey3 = 915;

obj_60426a03_T.map = obj_60426a03_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_60426a03_T.map);
obj_60426a03_T.r = obj_60426a03_T.r(1:nx);
img_obj_viewer2(obj_60426a03_T);

obj_60426a03_T_LF.map = obj_60426a03_T_LF.map(sx2:ex2, sy2:ey2, :);
[nx2, ny2, nz2] = size(obj_60426a03_T_LF.map);
obj_60426a03_T_LF.r = obj_60426a03_T_LF.r(1:nx2);
img_obj_viewer2(obj_60426a03_T_LF);

obj_60426a03_T_shearcor_LF.map = obj_60426a03_T_shearcor_LF.map(sx3:ex3, sy3:ey3, :);
[nx3, ny3, nz3] = size(obj_60426a03_T_shearcor_LF.map);
obj_60426a03_T_shearcor_LF.r = obj_60426a03_T_shearcor_LF.r(1:nx3);
img_obj_viewer2(obj_60426a03_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx2:ex2, sy2:ey2, :);
self.r = self.r(1:nx2);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx3:ex3, sy3:ey3, :);
sesclf.r = sesclf.r(1:nx3);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx2:ex2, sy2:ey2, :);
felf.r = felf.r(1:nx2);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx3:ex3, sy3:ey3, :);
fesclf.r = fesclf.r(1:nx3);
img_obj_viewer2(fesclf);
%% File 60426A04

% Se-x and Se-y
[seraw, seraw1, seraw2, serawampl, serawpha, serawreal] = find_envelopes(obj_60426a04_T,528,513,513,497,5);
[self, self1, self2, selfampl, selfpha, selfreal] = find_envelopes(obj_60426a04_T_LF,528,513,513,497,5);
[sesclf, sesclf1, sesclf2, sesclfampl, sesclfpha, sesclfreal] = find_envelopes(obj_60426a04_T_shearcor_LF,528,513,513,498,5);

% Fe-x and Fe-y
[feraw, feraw1, feraw2, ferawampl, ferawpha, ferawreal] = find_envelopes(obj_60426a04_T,498,497,528,497,5);
[felf, felf1, felf2, felfampl, felfpha, felfreal] = find_envelopes(obj_60426a04_T_LF,498,497,528,497,5);
[fesclf, fesclf1, fesclf2, fesclfampl, fesclfpha, fesclfreal] = find_envelopes(obj_60426a04_T_shearcor_LF,498,498,528,498,5);

% crop data and N(r)and open its structure with img_obj_viewer2
sx = 155;
sy = 175;
ex = 885;
ey = 905;

sx2 = 160;
sy2 = 200;
ex2 = 865;
ey2 = 905;

sx3 = 105;
sy3 = 245;
ex3 = 845;
ey3 = 985;

obj_60426a04_T.map = obj_60426a04_T.map(sx:ex, sy:ey, :);
[nx, ny, nz] = size(obj_60426a04_T.map);
obj_60426a04_T.r = obj_60426a04_T.r(1:nx);
img_obj_viewer2(obj_60426a04_T);

obj_60426a04_T_LF.map = obj_60426a04_T_LF.map(sx2:ex2, sy2:ey2, :);
[nx2, ny2, nz2] = size(obj_60426a04_T_LF.map);
obj_60426a04_T_LF.r = obj_60426a04_T_LF.r(1:nx2);
img_obj_viewer2(obj_60426a04_T_LF);

obj_60426a04_T_shearcor_LF.map = obj_60426a04_T_shearcor_LF.map(sx3:ex3, sy3:ey3, :);
[nx3, ny3, nz3] = size(obj_60426a04_T_shearcor_LF.map);
obj_60426a04_T_shearcor_LF.r = obj_60426a04_T_shearcor_LF.r(1:nx3);
img_obj_viewer2(obj_60426a04_T_shearcor_LF);

seraw.map = seraw.map(sx:ex, sy:ey, :);
seraw.r = seraw.r(1:nx);
img_obj_viewer2(seraw);

self.map = self.map(sx2:ex2, sy2:ey2, :);
self.r = self.r(1:nx2);
img_obj_viewer2(self);

sesclf.map = sesclf.map(sx3:ex3, sy3:ey3, :);
sesclf.r = sesclf.r(1:nx3);
img_obj_viewer2(sesclf);

feraw.map = feraw.map(sx:ex, sy:ey, :);
feraw.r = feraw.r(1:nx);
img_obj_viewer2(feraw);

felf.map = felf.map(sx2:ex2, sy2:ey2, :);
felf.r = felf.r(1:nx2);
img_obj_viewer2(felf);

fesclf.map = fesclf.map(sx3:ex3, sy3:ey3, :);
fesclf.r = fesclf.r(1:nx3);
img_obj_viewer2(fesclf);


%% real space analysis of the highest resolution topos

%% 60425A01

LF_60425a01=fese_nem_ord_anal_va(obj_60425a01_T_LF, 90, 90, 970, 970);

SCLF_6042501=fese_nem_ord_anal_va(obj_60425a01_T_shearcor_LF, 90, 90, 970, 970);

%% 60425A02

LF_60425a02=fese_nem_ord_anal_va(obj_60425a02_T_LF, 90, 90, 970, 970);

SCLF_6042502=fese_nem_ord_anal_va(obj_60425a02_T_shearcor_LF, 90, 90, 970, 970);

%% 60426A01

LF_60426a01=fese_nem_ord_anal_va(obj_60426a01_T_LF, 160, 190, 870, 900);

SCLF_6042601=fese_nem_ord_anal_va(obj_60426a01_T_shearcor_LF, 180, 180, 915, 915);

%% 60426A02

LF_60426a02=fese_nem_ord_anal_va(obj_60426a02_T_LF, 160, 125, 870, 835);

SCLF_6042602=fese_nem_ord_anal_va(obj_60426a02_T_shearcor_LF, 180, 180, 915, 915);

%% 60426A03

LF_60426a03=fese_nem_ord_anal_va(obj_60426a03_T_LF, 150, 120, 870, 840);

SCLF_6042603=fese_nem_ord_anal_va(obj_60426a03_T_shearcor_LF, 180, 180, 915, 915);

%% 60426A04

LF_60426a04=fese_nem_ord_anal_va(obj_60426a04_T_LF, 160, 200, 865, 905);

SCLF_6042604=fese_nem_ord_anal_va(obj_60426a04_T_shearcor_LF, 105, 245, 845, 985);