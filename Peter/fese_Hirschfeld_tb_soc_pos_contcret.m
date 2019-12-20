function eigeps2D = fese_Hirschfeld_tb_soc_pos_contcret(pixelnum, kz)

tic


% define lattice constants a1 and a2
a1 = 1;
a2 = 1;

% define number of pixels used for first Brioullin zone and the kx, ky
n = pixelnum;

% kx = linspace(-pi, pi, n+1);
% ky = linspace(-pi, pi, n+1);


kx = linspace(-0.2*pi, 0.2*pi, n+1);
ky = linspace(pi-0.2*pi, pi+0.2*pi, n+1);

k1 = kx+ky;
k2 = -kx+ky;


% kx = linspace(-pi/a1*3/sqrt(3), pi/a1*3/sqrt(3), n+1);
% ky = linspace(-pi/a2*3/sqrt(3), pi/a2*3/sqrt(3), n+1);

% % define q-space
% qx = linspace(-3*pi/a1, 3*pi/a1, 3*n+1);
% qy = linspace(-3*pi/a2, 3*pi/a2, 3*n+1);

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

%% define all offsets, hopping integrals, kz, renormalization value z

kz = kz;


%%
xind = (1:1:n+1);
yind = (1:1:n+1);

[Mx,My]=meshgrid(xind,yind);

M = Mx + My;

H = zeros(20,20,(n+1)^2);
Vcell = cell(n+1, n+1);
Dcell = cell(n+1, n+1);

% Hcell = cell(n+1, n+1);
%%
m=1;
for k=1:n+1
    for l=1:n+1
        px = kx(k);
        py = ky(l);
        p1 = px + py;
        p2 = -px + py;

        H1 = Hirschfeld_tb_hamiltonian_soc_pos(px, py, p1, p2, kz);
        H(:,:,m) = H1(:,:,1);
        
        [V, D] = eig(H(:,:,m));
        Vcell{k,l} = V;
        Dcell{k,l} = diag(D);
%         Hcell{k,l} = H1(:,:,1);
        m=m+1;
    end
end
toc
% [Vseq,Dseq] = eigenshuffle2D(H, n+1 );

eigeps2D = zeros(n+1, n+1, 20);

for k=1:n+1
    for l=1:n+1
        Dseq = real(Dcell{k, l});
        for i=1:20
            eigeps2D(k,l,i) = Dseq(i);
        end
    end
end





toc
end