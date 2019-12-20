function [Akstruct, jdosstruct] = jdossim


% define lattice constants a1 and a2
a1 = 1;
a2 = 1;

% define number of pixels used for first Brioullin zone and the kx, ky
n =128;
kx = linspace(-pi/a1*3/sqrt(3), pi/a1*3/sqrt(3), n+1);
ky = linspace(-pi/a2*3/sqrt(3), pi/a2*3/sqrt(3), n+1);

% define q-space
qx = linspace(-3*pi/a1, 3*pi/a1, 3*n+1);
qy = linspace(-3*pi/a2, 3*pi/a2, 3*n+1);

% Create meshgrid for the tight binding band structure
[X,Y]=meshgrid(kx,ky);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE HOW TO USE MESHGRID - START
% [X,Y] = meshgrid(-2:.2:2, -2:.2:2);                                
% Z = X .* exp(-X.^2 - Y.^2);  
% figure;
% surf(X,Y,Z)
% EXAMPLE - END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xdata(:,:,1)=X;
xdata(:,:,2)=Y;


% f = 10 - 10*cos(0.5*X)-10*cos(Y)+0*cos(2*X)+0*cos(2*Y)+0*cos(3*X)+0*cos(3*Y);
% f1 = -30 + 10*cos(X) + 10* cos(0.5*Y);
% 
% figure, surf(f)
% hold on 
% surf(f1)
% hold off
% 
% figure, plot(kx,1- cos(0.5*kx), kx, -1 + cos(kx))

%% test eigenvalues of a matrix

H = zeros(2,2,(n+1)^2);
m = 1;

for k=0:n
    for l=1:n+1
        
        px = kx(k+1);
        py = ky( (n+2)*mod(k-2,2) - l * (-1)^(k+1));
        
        H(1,2,m) = -1 * (1 + exp(-1i*px*a1) + exp(-1i* (px*1/2+py*sqrt(3)/2))) ;
        H(2,1,m) = -1 * (1 + exp(1i*px*a1) + exp(1i* (px*1/2+py*sqrt(3)/2))) ;
        m = m+1;
    end
end

m=1;
[Vseq,Dseq] = eigenshuffle(H);

eigeps = zeros(n+1, n+1);
eigeps1 = zeros(n+1, n+1);

for k=0:n
    for l=1:n+1
        
        eigeps((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1) = Dseq(1,m);
        eigeps1((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1) = Dseq(2,m);
        m = m+1;
    end
end


figure, surf(eigeps)
hold on 
surf(eigeps1)
hold off

%% calculate E(k)=eps, bandstructure using the function tbbandstructure
% x = [2, 0.5, 1, a1, a2];

x = [1, 1, 0, 1/2, sqrt(3)/2];
x1 = [-1, 1, 0, 1/2, sqrt(3)/2];

eps = tbbandstructure(x,xdata);

eps1 = tbbandstructure(x1,xdata);

figure, surf(eps)
hold on 
surf(eps1)
hold off

%% calculate the spectral function A(k,w) [w is energy] as a function of 
%% energy, and the corresponding joint density of states (jdos (q, w)) using 
%% xcorr2; jdos is autocorrelation of spectral function. q is scattering 
%% space.

% define lifetime factor g for spectral function A(k)
g = 0.05;

for i=1 : 10
    
    % energy en
    en(i) = i * 1;
    
    % spectral function A(k)
    A = g ./ ( (en(i) - eps).^2 + g^2 );
    A1 = g ./ ( (en(i) - eps1).^2 + g^2 );

    
    Ak(:,:,i) = A;
    figure, imagesc(A)
    figure, imagesc(A1)
    % replicate A(k) before calculating convolution (A(k+q)A(k) <=>
    % autocorrelation of A(k)
    A = repmat(A,3);
%     figure, imagesc(A)
    
% calculate jdos and cut q-space to -3 pi/a to 3 pi/a rectangle
    JD = xcorr2(A);
    [nx, ny, nz] = size(JD);
    JDC(:,:,i) = JD(floor(nx/2)+1-floor(3/2*n) : floor(nx/2)+1 + floor(3/2*n),...
        floor(ny/2)+1 - floor(3/2*n) : floor(ny/2)+1 + floor(3/2*n),1);
    
%     figure, imagesc(JD);
%     figure, imagesc(JDC(:,:,i));
    test =1;
end

Akstruct.map = Ak;
Akstruct.type = 0;
Akstruct.ave = [];
Akstruct.name = 'spectral function';
Akstruct.r = kx;
Akstruct.coord_type = 'r';
Akstruct.e = en;
Akstruct.var = 'A(k,E)';

jdosstruct.map = JDC;
jdosstruct.type = 0;
jdosstruct.ave = [];
jdosstruct.name = 'Joint density of states';
jdosstruct.r = qx;
jdosstruct.coord_type = 'r';
jdosstruct.e = en;
jdosstruct.var = 'JDOS (q,E)';

test=1;
end