function [Akstruct, Axzkstruct,Ayzkstruct, Axykstruct] = fese_spectralfunction(eigeps, orbcha)

tic

[nx, ny, lambdaz] = size(eigeps);
% define number of pixels used for first Brioullin zone and the kx, ky
n =nx-1;
kx = linspace(-pi, pi, n+1);
ky = linspace(-pi, pi, n+1);

% Fe-Fe distance
afe = 2.687;
% scaled kx and ky
kxs = kx/afe;
kys = ky/afe;

% Create meshgrid for the tight binding band structure
[X,Y]=meshgrid(kx,ky);

A = zeros(nx, ny, lambdaz);
Axz = zeros(nx, ny, lambdaz);
Ayz = zeros(nx, ny, lambdaz);
Axy = zeros(nx, ny, lambdaz);
    
%% calculate the spectral function A(k,w) [w is energy] as a function of 
%% energy, and the corresponding joint density of states (jdos (q, w)) using 
%% xcorr2; jdos is autocorrelation of spectral function. q is scattering 
%% space.

% define lifetime factor g for spectral function A(k)
g = 0.002;
cc =1;
for i = -1.0 :0.1 : 1.0
    

    % energy en
    en(cc) = i * 0.01;
    
    for l = 1:lambdaz
    % spectral function A(k)
        A(:,:,l) = 1/pi*g ./ ( (en(cc) - eigeps(:,:,l)).^2 + g^2 );
        Axz(:,:,l) = A(:,:,l);
        Ayz(:,:,l) = A(:,:,l);
        Axy(:,:,l) = A(:,:,l);
        
        [row, col] = find( abs(A(:,:,l)) > 0);
        
        for p = 1:length(row)
            sv = orbcha{row(p), col(p), l};
            Axz(row(p), col(p), l) = A(row(p), col(p),l)*sv(1);
            Ayz(row(p), col(p), l) = A(row(p), col(p),l)*sv(3);
            Axy(row(p), col(p), l) = A(row(p), col(p),l)*sv(2);
        end
        test = 1;
%         figure, imagesc(A(:,:,l))
    end
    Awk(:,:,cc) = sum(A,3);
    Awkxz(:,:,cc) = sum(Axz,3);
    Awkyz(:,:,cc) = sum(Ayz,3);
    Awkxy(:,:,cc) = sum(Axy,3);
    
    %%
%     cm=double(circlematrix([n+1, n+1],round(n/4),n/2+1,n/2+1));
%     
% %     Awk(:,:,cc) = cm.*Awk(:,:,cc);
% %     Awkxz(:,:,cc) = cm.*Awkxz(:,:,cc);
% %     Awkyz(:,:,cc) = cm.*Awkyz(:,:,cc);
% %     Awkxy(:,:,cc) = cm.*Awkxy(:,:,cc);
%     
% 
%     cm1=double(circlematrix([n+1, n+1],round(n/4),1,1));
%     cm2=double(circlematrix([n+1, n+1],round(n/4),n+1,1));
%     cm3=double(circlematrix([n+1, n+1],round(n/4),1,n+1));
%     cm4=double(circlematrix([n+1, n+1],round(n/4),n+1,n+1));
%     icm = 1-cm;
% %     figure, imagesc(icm)
%     icm = (icm - cm1 - cm2 - cm3 - cm4);
% %     figure, imagesc(icm)
%     Awk(:,:,cc) = icm.*Awk(:,:,cc);
%     Awkxz(:,:,cc) = icm.*Awkxz(:,:,cc);
%     Awkyz(:,:,cc) = icm.*Awkyz(:,:,cc);
%     Awkxy(:,:,cc) = icm.*Awkxy(:,:,cc);
    %%
%     figure, imagesc(Awk(:,:,cc))
    
    close all;
    cc = cc+1;
    

    % replicate A(k) before calculating convolution (A(k+q)A(k) <=>
    % autocorrelation of A(k)
    Aall(:,:,cc-1) = repmat(Awk(:,:,cc-1),3);
%     [nx, ny] = size(Aall);
%     sx = floor(nx/2)+1-floor(5/4*n);
%     ex = floor(nx/2)+1 + floor(5/4*n);
%     sy = floor(ny/2)+1 - floor(5/4*n);
%     ey = floor(ny/2)+1 + floor(5/4*n);
%     
%     Aall = Aall(sx : ex, sy : ey,1);
%     figure, imagesc(Aall)
    
    Axzp(:,:,cc-1) = repmat(Awkxz(:,:,cc-1),3);
%     Axzp = Axzp(sx : ex, sy : ey,1);
%     figure, imagesc(Axzp)
    
    Ayzp(:,:,cc-1) = repmat(Awkyz(:,:,cc-1),3);
%     Ayzp = Ayzp(sx : ex, sy : ey,1);
%     figure, imagesc(Ayzp)
    
    Axyp(:,:,cc-1) = repmat(Awkxy(:,:,cc-1),3);
%     Axyp = Axyp(sx : ex, sy : ey,1);
%     figure, imagesc(Axyp)
%     
% calculate jdos and cut q-space to -3 pi/a to 3 pi/a rectangle
%     JD = xcorr2(Aall);
%     [nx, ny] = size(JD);
%     figure, imagesc(JD);
%     sx = floor(nx/2)+1-floor(5/4*n);
%     ex = floor(nx/2)+1 + floor(5/4*n);
%     sy = floor(ny/2)+1 - floor(5/4*n);
%     ey = floor(ny/2)+1 + floor(5/4*n);
%     JDC(:,:,cc-1) = JD(sx : ex, sy : ey,1);
    
%     figure, imagesc(JDC(:,:,cc-1));
    
    test =1;
end

% parpool(4)
% parfor i=1:length(en)
% for i=1:length(en)
%     
%     JD = xcorr2(Aall(:,:,i));
%     JDxz = xcorr2(Axzp(:,:,i));
%     JDyz = xcorr2(Ayzp(:,:,i));
% %     JDxy = xcorr2(Axyp(:,:,i));
%     
% %     JDxzyz = xcorr2(Axzp(:,:,i), Ayzp(:,:,i));
%     
%     [nx, ny] = size(JD);
% %     figure, imagesc(JD);
%     sx = floor(nx/2)+1-floor(5/4*n);
%     ex = floor(nx/2)+1 + floor(5/4*n);
%     sy = floor(ny/2)+1 - floor(5/4*n);
%     ey = floor(ny/2)+1 + floor(5/4*n);
%     JDC(:,:,i) = JD(sx : ex, sy : ey,1);
%     JDCxz(:,:,i) = JDxz(sx : ex, sy : ey,1);
%     JDCyz(:,:,i) = JDyz(sx : ex, sy : ey,1);
% %     JDCxy(:,:,i) = JDxy(sx : ex, sy : ey,1);
% %     JDCxzyz(:,:,i) = JDxzyz(sx : ex, sy : ey, 1);
% end

% delete(gcp);

smat = repmat(Awkyz(:,:,cc-1),3);

[lx, ly, lz] = size(smat);
kx = linspace(-3*pi, 3*pi, lx);
ky = linspace(-3*pi, 3*pi, ly);


Akstruct.map = Awk;
Akstruct.type = 0;
Akstruct.ave = [];
Akstruct.name = 'spectral function';
Akstruct.r = kxs;
Akstruct.coord_type = 'r';
Akstruct.e = en;
Akstruct.ops = '';
Akstruct.var = 'A(k,E)';

Axzkstruct = Akstruct;
Axzkstruct.map = Awkxz;
Axzkstruct.var = 'Axz(k,E)';

Ayzkstruct = Akstruct;
Ayzkstruct.map = Awkyz;
Ayzkstruct.var = 'Ayz(k,E)';

Axykstruct = Akstruct;
Axykstruct.map = Awkxy;
Axykstruct.var = 'Axy(k,E)';

% [nx, ny] = size(JDC);

% define q-space
qx = linspace(2.5*pi, 2.5*pi, nx);
qy = linspace(2.5*pi, 2.5*pi, ny);

% jdosstruct.map = JDC;
% jdosstruct.type = 0;
% jdosstruct.ave = [];
% jdosstruct.name = 'Joint density of states';
% jdosstruct.r = qx;
% jdosstruct.coord_type = 'r';
% jdosstruct.e = en;
% jdosstruct.ops = '';
% jdosstruct.var = 'JDOS (q,E)';
% 
% jdosxzstruct = jdosstruct;
% jdosxzstruct.map = JDCxz;
% jdosxzstruct.var = 'JDOS xz (q,E)';
% 
% jdosyzstruct = jdosstruct;
% jdosyzstruct.map = JDCyz;
% jdosyzstruct.var = 'JDOS yz (q,E)';

% jdosxystruct = jdosstruct;
% jdosxystruct.map = JDCxy;
% jdosxystruct.var = 'JDOS xy (q,E)';
% 
% jdosxzyzstruct = jdosstruct;
% jdosxzyzstruct.map = JDCxzyz;
% jdosxzyzstruct.var = 'JDOS xz <-> yz (q,E)';

test=1;
%% plot orbital coded Fermi surface
kx = linspace(-pi, pi, n+1);
ky = linspace(-pi, pi, n+1);

figure, hold on




    % energy en
    en(cc) = 0 * 0.01;
    
    for l = 1:lambdaz
    % spectral function A(k)
        A(:,:,l) = 1/pi*g ./ ( (en(cc) - eigeps(:,:,l)).^2 + g^2 );
        
        
        [row, col] = find( abs(A(:,:,l)) > 50);
        
        for p = 1:length(row)
            
            plot(kx( row(p) ),ky(col (p) ) ,'Color',orbcha{row(p), col(p), l},'Marker','.')
            
        end
        test = 1;
%         figure, imagesc(A(:,:,l))
    end
xlim([-pi, pi]);
ylim([-pi, pi]);
axis square;

hold off
toc
end