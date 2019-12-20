function [eigeps2D, orbcha] = fese_Hirschfeld_tb_soc

tic


% define lattice constants a1 and a2
a1 = 1;
a2 = 1;

% define number of pixels used for first Brioullin zone and the kx, ky
n =200;

kx = linspace(-pi, pi, n+1);
ky = linspace(-pi, pi, n+1);
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

kz = 0;


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

        H1 = Hirschfeld_tb_hamiltonian_soc(px, py, p1, p2, kz);
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
        Vseq = abs(Vcell{k, l});
        for i=1:20
        dxy(i) = round(10*( Vseq(1,i)^2+Vseq(2,i)^2+Vseq(3,i)^2+Vseq(4,i)^2+...
            Vseq(9,i)^2+Vseq(10,i)^2+Vseq(11,i)^2+Vseq(12,i)^2+...
            Vseq(13,i)^2+Vseq(14,i)^2+Vseq(19,i)^2+Vseq(20,i)^2 ) )/10;
        dxz(i) = round(10*( Vseq(5,i)^2+Vseq(6,i)^2+Vseq(15,i)^2+Vseq(16,i)^2 ) )/10;
        dyz(i) = round(10*( Vseq(7,i)^2+Vseq(8,i)^2+Vseq(17,i)^2+Vseq(18,i)^2 ) )/10;
%         all(i) = dxy(i)+dxz(i)+dyz(i);
        end
        
        for i=1:20
            eigeps2D(k,l,i) = Dseq(i);
            orbcha{k,l,i} = [dxz(i), dxy(i), dyz(i)];
        end
        
        
    end
end



xc = n/2+1;
% xc = 1;

for i=1:20
    c{i} = squeeze(eigeps2D(:,xc,i));
end

figure, plot(kx,c{1},'.k')
hold on
for i=2:20
    plot(kx,c{i},'.k')
end
hold off


for i=1:20
    d{i} = squeeze(eigeps2D(xc,:,i));
end

figure, plot(kx,d{1},'.k')
hold on
for i=2:20
    plot(kx,d{i},'.k')
end
hold off
% 
% 
% figure, plot(kx(1),eigeps2D(xc, 1, 1),'Color',orbcha{xc,1,1},'Marker','.')
% hold on
% for k=1:n+1
%     for i=1:20
%         plot(kx(k),eigeps2D(xc, k, i),'Color',orbcha{xc,k,i},'Marker','.')
%     end
% end
% title('M to \Gamma to M')
% hold off
% 
% figure, plot(ky(1),eigeps2D(1, xc, 1),'Color',orbcha{1,xc,1},'Marker','.')
% hold on
% for k=1:n+1
%     for i=1:20
%         plot(ky(k),eigeps2D(k, xc, i),'Color',orbcha{k, xc,i},'Marker','.')
%     end
% end
% title('M'' to \Gamma to M''')
% hold off
% 
% 
% figure, plot(kx(1)+ky(1),eigeps2D(1, 1, 1),'Color',orbcha{1,1,1},'Marker','.')
% hold on
% for k=1:n+1
%     for i=1:20
%         plot(kx(k)+ky(k),eigeps2D(k, k, i),'Color',orbcha{k, k,i},'Marker','.')
%     end
% end
% title('\Gamma'' to X to \Gamma to X to \Gamma''')
% hold off
% 
% figure, plot(-kx(n+1)+ky(1),eigeps2D(n+1, 1, 1),'Color',orbcha{n+1,1,1},'Marker','.')
% hold on
% for k=1:n+1
%     for i=1:20
%         plot(-kx(n+2-k)+ky(k),eigeps2D(n+2-k, k, i),'Color',orbcha{n+2-k, k,i},'Marker','.')
%     end
% end
% title('\Gamma'' to X'' to \Gamma to X'' to \Gamma''')
% hold off
% 
% 
% figure, plot(kx(n/2+1)+ky(1),eigeps2D(n/2+1, 1, 1),'Color',orbcha{n/2+1,1,1},'Marker','.')
% hold on
% for k=0:n/2
%     for i=1:20
%         plot(kx(n/2+1+k)+ky(1+k),eigeps2D(n/2+1+k, 1+k, i),'Color',orbcha{n/2+1+k, 1+k,i},'Marker','.')
%     end
% end
% title('M to X'' to M''')
% hold off
% 
% figure, plot(-kx(n+1)+ky(n/2+1),eigeps2D(n+1, n/2+1, 1),'Color',orbcha{n+1,n/2+1,1},'Marker','.')
% hold on
% for k=0:n/2
%     for i=1:20
%         plot(-kx(n+1-k)+ky(n/2+1+k),eigeps2D(n+1-k, n/2+1+k, i),'Color',orbcha{n+1-k, n/2+1+k,i},'Marker','.')
%     end
% end
% title('M'' to X to M')
% hold off
%%
figure, plot(-1*(-kx(n/2+1)+ky(n/2+1)),eigeps2D(n/2+1, n/2+1, 1),'Color',...
    orbcha{n/2+1,n/2+1,1},'Marker','.','LineWidth',2,'MarkerSize',12)
hold on
% Gamma to X'
for k=0:round(n/4)
    for i=1:20
        plot(-1*(-kx(n/2+1+k)+ky(n/2+1-k)),eigeps2D(n/2+1+k, n/2+1-k, i),...
            'Color',orbcha{n/2+1+k, n/2+1-k,i},'Marker','.','LineWidth',2,...
            'MarkerSize',12)
    end
end
% X' to M'
for k=0:round(n/4)
    for i=1:20
        plot(pi+(kx(n/2+1+round(n/4)+k)+ky(n/2+1-round(n/4)+k)),...
            eigeps2D(n/2+1+round(n/4)+k, n/2+1-round(n/4)+k, i),...
            'Color',orbcha{n/2+1+round(n/4)+k, n/2+1-round(n/4)+k,i},...
            'Marker','.','LineWidth',2, 'MarkerSize',12)
    end
end
% M' to Gamma
for k=0:n/2
    for i=1:20
        plot(3*pi+kx(1+k),eigeps2D(1+k, n/2+1, i),'Color',...
            orbcha{1+k, n/2+1,i},'Marker','.','LineWidth',2, 'MarkerSize',12)
    end
end

line([pi,pi],[-0.4,0.4],'Color','k','LineStyle','--','LineWidth',2)
line([2*pi,2*pi],[-0.4,0.4],'Color','k','LineStyle','--','LineWidth',2)


title('\Gamma to X'' to M'' to \Gamma')
hold off


%%
figure, plot((kx(n/2+1)+ky(n/2+1)),eigeps2D(n/2+1, n/2+1, 1),...
    'Color',orbcha{n/2+1,n/2+1,1},'Marker','.','LineWidth',2, 'MarkerSize',12)
hold on
% Gamma to X
for k=0:round(n/4)
    for i=1:20
        plot((kx(n/2+1+k)+ky(n/2+1+k)),eigeps2D(n/2+1+k, n/2+1+k, i),...
            'Color',orbcha{n/2+1+k, n/2+1+k,i},'Marker','.','LineWidth',2,...
            'MarkerSize',12)
    end
end
% X to M
for k=0:round(n/4)
    for i=1:20
        plot(pi+(-kx(n/2+1+round(n/4)-k)+ky(n/2+1+round(n/4)+k)),...
            eigeps2D(n/2+1+round(n/4)-k, n/2+1+round(n/4)+k, i),...
            'Color',orbcha{n/2+1+round(n/4)-k, n/2+1+round(n/4)+k,i},...
            'Marker','.','LineWidth',2, 'MarkerSize',12)
    end
end
% M to Gamma
for k=0:n/2
    for i=1:20
        plot(3*pi+ky(1+k),eigeps2D(n/2+1, 1+k, i),'Color',...
            orbcha{n/2+1, 1+k,i},'Marker','.','LineWidth',2, 'MarkerSize',12)
    end
end

line([pi,pi],[-0.4,0.4],'Color','k','LineStyle','--','LineWidth',2)
line([2*pi,2*pi],[-0.4,0.4],'Color','k','LineStyle','--','LineWidth',2)


title('\Gamma to X to M to \Gamma')
hold off

toc
end