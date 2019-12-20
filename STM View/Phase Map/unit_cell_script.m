% 2008-06-11 
% celled script unit cell averaging and related analysis
%%
[dx dy] = size(z);
n = dx;
[k f] = fourier_block(z,dx,'sine');
%f = fft2(z);
fshift = fftshift(f);
k0 = 2*pi/n;
k = linspace(-k0*(n/2+1),k0*(n/2-1),n);
clear n k0 f dx dy;
%%
figure; surf(k,k,real(fshift)); shading flat;
%%
figure; pcolor(k,k,abs(fshift)); shading flat;
%% find values of dominant wavevectors
%m - extracted portion of f1 containing peak (needs to be done for x and y
%direction
[cx,cy,sx,sy,PeakOD] = Gaussian2D(m,tol);

%% Plot fshift
figure; pcolor(k,k,abs(fshift)); shading flat; colormap(Defect1); 
axis off; axis equal;

%% Use mouse to select the main unique peak representing lattice in FT
% q1(:,1) is right most point
% q1(:,2) is top most point
q=0;s=0;
count = 0;
while ~isempty(q)
    if count == 2
        break;
    end
   [x1,y1]=ginput(1)
   count = count + 1;
   q1(1,count) = x1; q1(2,count) = y1;  
   hold on
   q=x1;s=y1;
end
clear q s x1 y1 count;
%% make reference functions
% need to define q1 and q2 based on results of wavevector finding
[nr nc] = size(z);
[X Y] = meshgrid(1:nr,1:nc);

% q1 and q2 reference functions
A1= sin(q1(1,1)*X + q1(2,1)*Y); B1 = cos(q1(1,1)*X + q1(2,1)*Y);
A2= sin(q1(1,2)*X + q1(2,2)*Y); B2 = cos(q1(1,2)*X + q1(2,2)*Y);
clear X Y nr nc;
%%  Plot fshift
figure; pcolor(abs(fshift)); shading flat; colormap(Defect1); 
axis off; axis equal;
%% Use mouse to find peak position for filter
% start with right most point -> left most->top most->bottom most

q=0;s=0;
count = 0;
while ~isempty(q)
    if count == 4
        break;
    end
   [col,row]=ginput(1);
   count = count + 1;
   q2(1,count) = row; q2(2,count) = col;  
   hold on
   q=row;s=col;
end
clear q s row col count;
%% taking peak positions to generate filter

%xcoord given as [rnumber, cnumber]
xright = q2(:,1); xleft = q2(:,2);
yup = q2(:,3); ydown = q2(:,4);
% xright = [60 87]; xleft = [72 45];
% yup = [86 71]; ydown = [46 60];
[nr nc] = size(z);
filtx = zeros(nr,nc);
filty = zeros(nr,nc);

filtx = filtx +  Gaussian(1:nr,1:nc,1.5,xright,1) + Gaussian(1:nr,1:nc,1.5,xleft,1);
filty = filty +  Gaussian(1:nr,1:nc,1.5,yup,1) + Gaussian(1:nr,1:nc,1.5,ydown,1);

clear nr nc xright xleft yup ydown;
%% filtered z

% first define a mask to get only keep dominant wavevectors in fshift,
% filtx,filty (may need to use sx, sy values from gaussian fitto pick proper mask around
% wavevector peaks

f1 = filtx.*fshift;
f2 = filty.*fshift;
z1 = ifft2(ifftshift(f1));
z2 = ifft2(ifftshift(f2));
figure; pcolor(abs(f1)); shading flat
clear f1 f2;
%clear filtx filty;
%% reference signal * filtered signal
Az1 = A1.*z1; Bz1 = B1.*z1;
Az2 = A2.*z2; Bz2 = B2.*z2;

fAz1 = fft2(Az1); fAz1shift = fftshift(fAz1);
fBz1 = fft2(Bz1); fBz1shift = fftshift(fBz1);

fAz2 = fft2(Az2); fAz2shift = fftshift(fAz2);
fBz2 = fft2(Bz2); fBz2shift = fftshift(fBz2);

%clear A1 A2 B1 B2 Az1 Bz1 Az2 Bz2 fAz1 fBz1 fAz2 fBz2 z1 z2;
%% create filter to remove 2*k atmoic
%Note the std of the gaussian to creat this filter determines how well the
%imperfection of the lattice are represetned.  A small std can recreate a
%perfect lattice as it ignore dislocations and vacancies.  
[nr nc] = size(z);
filt1x = Gaussian(1:nr,1:nc,0.5,[nr/2+1 nc/2+1],1);
filt2y = filt1x;
clear nc nr;
%figure; pcolor(filt1x);
%% filtered FT to remove 2*k atomic peaks (low pass filtering)
% first, make filters to remove wavevectors with twice the frequency of the
% atomic corrugation (there should only be ~dc component that remains after this)

% filt1x,filt1y, filt2x, filt2y are needed (probably only two are
% sufficient)
%filt1x = filt; filt1y = filt'; filt2x = filt1x; filt2y = filt1y;

fAz1filt = fAz1shift.*filt1x; fBz1filt = fBz1shift.*filt1x;
fAz2filt = fAz2shift.*filt2y; fBz2filt = fBz2shift.*filt2y;

X1 = ifft2(ifftshift(fAz1filt)); Y1 = ifft2(ifftshift(fBz1filt));
X2 = ifft2(ifftshift(fAz2filt)); Y2 = ifft2(ifftshift(fBz2filt));

%clear filt1x filt2y fAz1filt fBz1filt fAz2filt fBz2filt;
%clear fAz1shift fAz2shift fBz1shift fBz2shift;

%% calculate theta and phi

%should look at the amount of imaginary component.  Needs to be low if taking
%only the real parts of Y and X to form theta

[nr nc] = size(z);
[X Y] = meshgrid(1:nr,1:nc);

%%%%%%%%%%%%%%%%%%% Theta 1 calculation
%theta1 = atan(real(Y1)./real(X1)); 
theta1 = real(atan((Y1)./(X1))); 
%theta in [-pi/2 pi/2] so convert everthing to [0 2pi]

% check if coordinate in 3rd quadrant
tmp1 = (theta1 > 0 & real(Y1) < 0) ;
theta1(tmp1) = pi + theta1(tmp1);

% check if coordinate in 2nd quadrant
tmp1 = (theta1 < 0 & real(Y1) > 0);
theta1(tmp1) = pi - abs(theta1(tmp1));

% check if coordinate in 4th quadrant
tmp1 = (theta1 < 0 & real(Y1) < 0);
theta1(tmp1) = 2*pi + theta1(tmp1);

clear tmp1
% %%%%%%%%%%%%%%%%%%% THETA 2 calculation
%theta2 = atan(real(Y2)./real(X2)); %theta in [-pi/2 pi/2]
theta2 = real(atan((Y2)./(X2))); 
% check if coordinate in 3rd quadrant
tmp1 = (theta2 > 0 & real(Y2) < 0) ;
theta2(tmp1) = pi + theta2(tmp1);

% check if coordinate in 2nd quadrant
tmp1 = (theta2 < 0 & real(Y2) > 0);
theta2(tmp1) = pi - abs(theta2(tmp1));

% check if coordinate in 4th quadrant
tmp1 = (theta2 < 0 & real(Y2) < 0);
theta2(tmp1) = 2*pi + theta2(tmp1);


phi1 = q1(1,1)*X + q1(2,1)*Y + real(theta1);
phi1a = mod(phi1,2*pi);

phi2 = q1(1,2)*X + q1(2,2)*Y + real(theta2);
phi2a = mod(phi2,2*pi);


clear X Y X1 X2 Y1 Y2 nr nc phi1 phi2 tmp1 theta1 theta2;
%% sin of phi1a and phi2a with topograph to check how well phases match
figure; pcolor(real(z)); shading flat; colormap(bone);
figure; pcolor(sin(phi1a)); shading flat; colormap(bone);
figure; pcolor(sin(phi2a)); shading flat; colormap(bone);
%%  unit cell average check I
%count = 0;
%chk = [];
[nr nc] = size(z);
tol = 0.2;
for i = 1:nr
    for j=1:nc
        ph1 = phi1a(i,j);
        ph2 = phi2a(i,j);
        tmp = ((phi1a >= ph1 -tol & phi1a <= ph1 + tol)&...
                (phi2a >= ph2 -tol & phi2a <= ph2 + tol));
        uc_avg(i,j) = mean(z(tmp));
    end
end

clear i j nr nc ph1 ph2 tmp;
%% unit cell average
clear uc_avg
%pick a reference unit cell in topo 
%ref_map = z(50:70,15:35);
%A = z(1:35,30:64);
%phi1a = phi1a(16:48,32:64); 
%phi2a = phi2a(16:48,32:64);

%A = fano_g(140:230,38:119);
%A = A(1:82,1:82);
%A = z;

A = fano.e;
ref_map = A(1:50,1:50);
ref_map = A;
[nr nc] = size(ref_map);
tol = 0.25;
%then use the corresponding pixels in the phase maps to determine phase
%values to look for when averaging
uc_avg = zeros(nr,nc);
for i=1:nr
    for j=1:nc        
        ph1 = phi1a(i,j);
        ph2 = phi2a(i,j);
        tmp = ((phi1a >= ph1 - tol & phi1a <= ph1 + tol)&...
                (phi2a >= ph2 - tol & phi2a <= ph2 + tol));
        uc_avg(i,j) = mean(A(tmp));
        clear tmp;
    end
end
figure;
subplot(1,2,1); pcolor(uc_avg); shading flat; colormap(Defect1); axis off; axis equal;
subplot(1,2,2); pcolor(ref_map); shading flat; colormap(Defect1); axis off; axis equal;

clear i j ph1 ph2 nc nr tol ref_map A;
%% peak finder
%phx = phi1a(47,15); % 70619A02 phase for atomic peak
%phy = phi2a(47,15);
phx = phi1a(46,29);
phy = phi2a(46,29);
format long
tol2x = 0.18;
tol2y = 0.18;
[px py] = find((phi1a >= phx-tol2x & phi1a <= phx+tol2x) & (phi2a >= phy-tol2y & phi2a <=phy+tol2y));
figure;
subplot(1,2,1)
pcolor(uc_avg) ;colormap(bone); 
hold on; plot(py,px,'ro','MarkerEdgeColor','k',...
                'MarkerFaceColor','r',...
                'MarkerSize',5); 
shading interp; axis off; %axis equal;
subplot(1,2,2)
A = z;
pcolor(A) ;colormap(bone); 
hold on; plot(py,px,'ro','MarkerEdgeColor','k',...
                'MarkerFaceColor','r',...
                'MarkerSize',5); 
shading interp; axis off; %axis equal;
clear tol2x tol2y phx phy px py;
%% Unit Cell Plot
%tmpx tmpy are points to plot of interest e.g. atomic peaks (see above)
figure; pcolor(uc_avg2); colormap(bone); 
hold on; plot(tmpy,tmpx,'ro','MarkerEdgeColor','k',...
                'MarkerFaceColor','r',...
                'MarkerSize',20); 
shading flat; axis off; axis equal;
axis([48 62 30 44])
%% dI/dV map unit cell average
%clear uc_avg2
%pick a reference unit cell in topo 
%ref_map = z(50:70,15:35);
%ref_map = A; % choose A
A = G1subt.map;
[dx2 dy2 dz2] = size(A);
tol = 0.3;
%then use the corresponding pixels in the phase maps to determine phase
%values to look for when averaging
avg_map = zeros(35,35, dz2);
for k = 1:dz2
    for i=1:35
        for j=1:35        
            ph1 = phi1a(i,j);
            ph2 = phi2a(i,j);
            tmp4 = ((phi1a >= ph1 - tol & phi1a <= ph1 + tol)&...
                    (phi2a >= ph2 - tol & phi2a <= ph2 + tol));
            ref_map = A(:,:,k);   
            avg_map(i,j,k) = mean(ref_map(tmp4));
            clear tmp4;
        end
    end
end
G1subt_avg = G;
G1subt_avg.map = avg_map;
G1subt_avg.r = Gavg.r(1:35);

%% fano map map unit cell average
%clear uc_avg2
%pick a reference unit cell in topo 
%ref_map = z(50:70,15:35);
%ref_map = A; % choose A
A = fano.q;
%A = z;
[dx3 dy3] = size(A);
tol = 0.3;
%then use the corresponding pixels in the phase maps to determine phase
%values to look for when averaging
avg_map = zeros(35,35);
for i=1:35
    for j=1:35        
        ph1 = phi1a(i,j);
        ph2 = phi2a(i,j);
        tmp4 = ((phi1a >= ph1 - tol & phi1a <= ph1 + tol)&...
                (phi2a >= ph2 - tol & phi2a <= ph2 + tol));
        ref_map = A(:,:);   
        avg_map(i,j) = mean(ref_map(tmp4));
        clear tmp4;
    end
end
figure; pcolor(avg_map); shading flat; axis off; axis equal; colormap(Defect1)
%% NOTES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 70619
% unit cell average were done in using the following part of the
% topograph t (I think a04)

%  A = t(140:230,38:119);
%  A = A(1:82,1:82);

% the following phases were use to find the peaks in this FOV

%phx = phi1a(47,15); 
%phy = phi2a(47,15);

% a06 was used for the conductance map and the phase of the atomic peaks
% from a04 were adjusted slightly to find atomic peaks on a06 ((worked
% fairly well)

% phx = phi1a(49,15);
% phy = phi2a(49,13);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 70928A16
% the simultaneous topo for this map is very garbled so first fourier
% filter it to get rid of hf noise.

% then run the lock-in algorithm.  However, there are discotinuous jumps in
% the phase phi so only a part of the phase info was used.  The following part
% yields a relatively good average and finds most of atomic peaks
%  -> t(16:48,32:64) is the used porition of topo and the respective
%  porition of phi was used in the unit cell averaging.

%In this FOV the following phase values were used to find atomic peaks
%phx = phi1a(6,17);
%phy = phi2a(6,17);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 70928A16
% did this unit cell average again but used the conductance map to extract
% the topo - layers 63 has good image that coincides with atomic peaks 

% gives a very smooth phase diagram

%In this FOV the following phase values were used to find atomic peaks
%phx = phi1a(8,35);
%phy = phi2a(8,35);