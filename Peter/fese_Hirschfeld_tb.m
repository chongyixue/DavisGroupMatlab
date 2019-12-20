function [eigeps2D, orbcha] = fese_Hirschfeld_tb

tic


% define lattice constants a1 and a2
a1 = 1;
a2 = 1;

% define number of pixels used for first Brioullin zone and the kx, ky
n =500;

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

H = zeros(10,10,(n+1)^2);
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

        H1 = Hirschfeld_tb_hamiltonian(px, py, p1, p2, kz);
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

eigeps2D = zeros(n+1, n+1, 10);

m=1;
for k=1:n+1
    for l=1:n+1
        Dseq = real(Dcell{k, l});
        Vseq = abs(Vcell{k, l});
        for i=1:10
        dxy(i) = round(10*(Vseq(1,i)^2+Vseq(2,i)^2+Vseq(5,i)^2+Vseq(6,i)^2+...
            Vseq(7,i)^2+Vseq(10,i)^2))/10;
        dxz(i) = round(10*(Vseq(3,i)^2+Vseq(8,i)^2))/10;
        dyz(i) = round(10*(Vseq(4,i)^2+Vseq(9,i)^2))/10;
%         all(i) = dxy(i)+dxz(i)+dyz(i);
        end
        eigeps2D(k,l,1) = Dseq(1);
        orbcha{k,l,1} = [dxz(1), dxy(1), dyz(1)];
        eigeps2D(k,l,2) = Dseq(2);
        orbcha{k,l,2} = [dxz(2), dxy(2), dyz(2)];
        eigeps2D(k,l,3) = Dseq(3);
        orbcha{k,l,3} = [dxz(3), dxy(3), dyz(3)];
        eigeps2D(k,l,4) = Dseq(4);
        orbcha{k,l,4} = [dxz(4), dxy(4), dyz(4)];
        eigeps2D(k,l,5) = Dseq(5);
        orbcha{k,l,5} = [dxz(5), dxy(5), dyz(5)];
        eigeps2D(k,l,6) = Dseq(6);
        orbcha{k,l,6} = [dxz(6), dxy(6), dyz(6)];
        eigeps2D(k,l,7) = Dseq(7);
        orbcha{k,l,7} = [dxz(7), dxy(7), dyz(7)];
        eigeps2D(k,l,8) = Dseq(8);
        orbcha{k,l,8} = [dxz(8), dxy(8), dyz(8)];
        eigeps2D(k,l,9) = Dseq(9);
        orbcha{k,l,9} = [dxz(9), dxy(9), dyz(9)];
        eigeps2D(k,l,10) = Dseq(10);
        orbcha{k,l,10} = [dxz(10), dxy(10), dyz(10)];
        m=m+1;
    end
end

% 
% figure, surf(eigeps2D(:,:,1))
% figure, surf(eigeps2D(:,:,2))
% figure, surf(eigeps2D(:,:,3))
% figure, surf(eigeps2D(:,:,4))
% figure, surf(eigeps2D(:,:,5))
% figure, surf(eigeps2D(:,:,6))
% figure, surf(eigeps2D(:,:,7))
% figure, surf(eigeps2D(:,:,8))
% figure, surf(eigeps2D(:,:,9))
% figure, surf(eigeps2D(:,:,10))

xc = n/2+1;
% xc = 1;

c1 = eigeps2D(:,xc,1);
c2 = eigeps2D(:,xc,2);
c3 = eigeps2D(:,xc,3);
c4 = eigeps2D(:,xc,4);
c5 = eigeps2D(:,xc,5);
c6 = eigeps2D(:,xc,6);
c7 = eigeps2D(:,xc,7);
c8 = eigeps2D(:,xc,8);
c9 = eigeps2D(:,xc,9);
c10 = eigeps2D(:,xc,10);

figure, plot(kx,c1,'k',kx,c2,'k',kx,c3,'k',kx,c4,'k',kx,c5,'k',kx,c6,'k',kx,c7,'k',kx,c8,'k',kx,c9,'k',kx,c10,'k','LineWidth',2)

d1 = eigeps2D(xc, :,1);
d2 = eigeps2D(xc, :,2);
d3 = eigeps2D(xc, :,3);
d4 = eigeps2D(xc, :,4);
d5 = eigeps2D(xc, :,5);
d6 = eigeps2D(xc, :,6);
d7 = eigeps2D(xc, :,7);
d8 = eigeps2D(xc, :,8);
d9 = eigeps2D(xc, :,9);
d10 = eigeps2D(xc, :,10);

figure, plot(kx,d1,'k',kx,d2,'k',kx,d3,'k',kx,d4,'k',kx,d5,'k',kx,d6,'k',kx,d7,'k',kx,d8,'k',kx,d9,'k',kx,d10,'k','LineWidth',2)


figure, plot(kx(1),eigeps2D(xc, 1, 1),'Color',orbcha{xc,1,1},'Marker','.')
hold on
for k=1:n+1
    plot(kx(k),eigeps2D(xc, k, 1),'Color',orbcha{xc,k,1},'Marker','.')
    plot(kx(k),eigeps2D(xc, k, 2),'Color',orbcha{xc,k,2},'Marker','.')
    plot(kx(k),eigeps2D(xc, k, 3),'Color',orbcha{xc,k,3},'Marker','.')
    plot(kx(k),eigeps2D(xc, k, 4),'Color',orbcha{xc,k,4},'Marker','.')
    plot(kx(k),eigeps2D(xc, k, 5),'Color',orbcha{xc,k,5},'Marker','.')
    plot(kx(k),eigeps2D(xc, k, 6),'Color',orbcha{xc,k,6},'Marker','.')
    plot(kx(k),eigeps2D(xc, k, 7),'Color',orbcha{xc,k,7},'Marker','.')
    plot(kx(k),eigeps2D(xc, k, 8),'Color',orbcha{xc,k,8},'Marker','.')
    plot(kx(k),eigeps2D(xc, k, 9),'Color',orbcha{xc,k,9},'Marker','.')
    plot(kx(k),eigeps2D(xc, k, 10),'Color',orbcha{xc,k,10},'Marker','.')
end
hold off

figure, plot(kx(1),eigeps2D(1, xc, 1),'Color',orbcha{1,xc,1},'Marker','.')
hold on
for k=1:n+1
    plot(kx(k),eigeps2D(k, xc, 1),'Color',orbcha{k, xc,1},'Marker','.')
    plot(kx(k),eigeps2D(k, xc, 2),'Color',orbcha{k, xc,2},'Marker','.')
    plot(kx(k),eigeps2D(k, xc, 3),'Color',orbcha{k, xc,3},'Marker','.')
    plot(kx(k),eigeps2D(k, xc, 4),'Color',orbcha{k, xc,4},'Marker','.')
    plot(kx(k),eigeps2D(k, xc, 5),'Color',orbcha{k, xc,5},'Marker','.')
    plot(kx(k),eigeps2D(k, xc, 6),'Color',orbcha{k, xc,6},'Marker','.')
    plot(kx(k),eigeps2D(k, xc, 7),'Color',orbcha{k, xc,7},'Marker','.')
    plot(kx(k),eigeps2D(k, xc, 8),'Color',orbcha{k, xc,8},'Marker','.')
    plot(kx(k),eigeps2D(k, xc, 9),'Color',orbcha{k, xc,9},'Marker','.')
    plot(kx(k),eigeps2D(k, xc, 10),'Color',orbcha{k, xc,10},'Marker','.')
end
hold off

%%
% figure, plot(kx(1),eigeps2D(xc, 1, 1),'Color',orbcha{xc,1,1}(1)*[1,1,1],'Marker','.')
% hold on
% for k=1:n+1
%     plot(kx(k),eigeps2D(xc, k, 1),'Color',orbcha{xc,k,1}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 2),'Color',orbcha{xc,k,2}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 3),'Color',orbcha{xc,k,3}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 4),'Color',orbcha{xc,k,4}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 5),'Color',orbcha{xc,k,5}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 6),'Color',orbcha{xc,k,6}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 7),'Color',orbcha{xc,k,7}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 8),'Color',orbcha{xc,k,8}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 9),'Color',orbcha{xc,k,9}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 10),'Color',orbcha{xc,k,10}(1)*[1,1,1],'Marker','.')
% end
% hold off
% 
% figure, plot(kx(1),eigeps2D(1, xc, 1),'Color',orbcha{1,xc,1}(1)*[1,1,1],'Marker','.')
% hold on
% for k=1:n+1
%     plot(kx(k),eigeps2D(k, xc, 1),'Color',orbcha{k, xc,1}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 2),'Color',orbcha{k, xc,2}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 3),'Color',orbcha{k, xc,3}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 4),'Color',orbcha{k, xc,4}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 5),'Color',orbcha{k, xc,5}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 6),'Color',orbcha{k, xc,6}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 7),'Color',orbcha{k, xc,7}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 8),'Color',orbcha{k, xc,8}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 9),'Color',orbcha{k, xc,9}(1)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 10),'Color',orbcha{k, xc,10}(1)*[1,1,1],'Marker','.')
% end
% hold off
% %%
% figure, plot(kx(1),eigeps2D(xc, 1, 1),'Color',orbcha{xc,1,1}(2)*[1,1,1],'Marker','.')
% hold on
% for k=1:n+1
%     plot(kx(k),eigeps2D(xc, k, 1),'Color',orbcha{xc,k,1}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 2),'Color',orbcha{xc,k,2}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 3),'Color',orbcha{xc,k,3}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 4),'Color',orbcha{xc,k,4}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 5),'Color',orbcha{xc,k,5}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 6),'Color',orbcha{xc,k,6}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 7),'Color',orbcha{xc,k,7}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 8),'Color',orbcha{xc,k,8}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 9),'Color',orbcha{xc,k,9}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 10),'Color',orbcha{xc,k,10}(2)*[1,1,1],'Marker','.')
% end
% hold off
% 
% figure, plot(kx(1),eigeps2D(1, xc, 1),'Color',orbcha{1,xc,1}(2)*[1,1,1],'Marker','.')
% hold on
% for k=1:n+1
%     plot(kx(k),eigeps2D(k, xc, 1),'Color',orbcha{k, xc,1}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 2),'Color',orbcha{k, xc,2}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 3),'Color',orbcha{k, xc,3}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 4),'Color',orbcha{k, xc,4}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 5),'Color',orbcha{k, xc,5}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 6),'Color',orbcha{k, xc,6}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 7),'Color',orbcha{k, xc,7}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 8),'Color',orbcha{k, xc,8}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 9),'Color',orbcha{k, xc,9}(2)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 10),'Color',orbcha{k, xc,10}(2)*[1,1,1],'Marker','.')
% end
% hold off
% %%
% figure, plot(kx(1),eigeps2D(xc, 1, 1),'Color',orbcha{xc,1,1}(3)*[1,1,1],'Marker','.')
% hold on
% for k=1:n+1
%     plot(kx(k),eigeps2D(xc, k, 1),'Color',orbcha{xc,k,1}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 2),'Color',orbcha{xc,k,2}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 3),'Color',orbcha{xc,k,3}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 4),'Color',orbcha{xc,k,4}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 5),'Color',orbcha{xc,k,5}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 6),'Color',orbcha{xc,k,6}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 7),'Color',orbcha{xc,k,7}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 8),'Color',orbcha{xc,k,8}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 9),'Color',orbcha{xc,k,9}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(xc, k, 10),'Color',orbcha{xc,k,10}(3)*[1,1,1],'Marker','.')
% end
% hold off
% 
% figure, plot(kx(1),eigeps2D(1, xc, 1),'Color',orbcha{1,xc,1}(3)*[1,1,1],'Marker','.')
% hold on
% for k=1:n+1
%     plot(kx(k),eigeps2D(k, xc, 1),'Color',orbcha{k, xc,1}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 2),'Color',orbcha{k, xc,2}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 3),'Color',orbcha{k, xc,3}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 4),'Color',orbcha{k, xc,4}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 5),'Color',orbcha{k, xc,5}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 6),'Color',orbcha{k, xc,6}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 7),'Color',orbcha{k, xc,7}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 8),'Color',orbcha{k, xc,8}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 9),'Color',orbcha{k, xc,9}(3)*[1,1,1],'Marker','.')
%     plot(kx(k),eigeps2D(k, xc, 10),'Color',orbcha{k, xc,10}(3)*[1,1,1],'Marker','.')
% end
% hold off
% figure, plot3(kx(1),ky(1),eigeps2D(1, 1, 1),'Color',orbcha{xc,1,1},'Marker','.')
% hold on
% for k=1:n+1
%     for l=1:n+1
%         plot3(kx(k), ky(l),eigeps2D(k, l, 1),'Color',orbcha{k,l,1},'Marker','.')
%         plot3(kx(k), ky(l),eigeps2D(k, l, 2),'Color',orbcha{k,l,2},'Marker','.')
%         plot3(kx(k), ky(l),eigeps2D(k, l, 3),'Color',orbcha{k,l,3},'Marker','.')
%         plot3(kx(k), ky(l),eigeps2D(k, l, 4),'Color',orbcha{k,l,4},'Marker','.')
%         plot3(kx(k), ky(l),eigeps2D(k, l, 5),'Color',orbcha{k,l,5},'Marker','.')
%         plot3(kx(k), ky(l),eigeps2D(k, l, 6),'Color',orbcha{k,l,6},'Marker','.')
%         plot3(kx(k), ky(l),eigeps2D(k, l, 7),'Color',orbcha{k,l,7},'Marker','.')
%         plot3(kx(k), ky(l),eigeps2D(k, l, 8),'Color',orbcha{k,l,8},'Marker','.')
%         plot3(kx(k), ky(l),eigeps2D(k, l, 9),'Color',orbcha{k,l,9},'Marker','.')
%         plot3(kx(k), ky(l),eigeps2D(k, l, 10),'Color',orbcha{k,l,10},'Marker','.')
%     end
% end
% hold off
%
m = 1;

% while m <= (n+1)^2
% 
%     for k=0:n
%         for l=1:n+1
%         
%             px = kx(k+1);
%             py = ky( (n+2)*mod(k-2,2) - l * (-1)^(k+1));
%             p1 = px + py;
%             p2 = -px + py;
% 
%             H1 = Hirschfeld_tb_hamiltonian(px, py, p1, p2, kz);
%             H(:,:,m) = H1(:,:,1);
%             m = m+1;
% %         
% % for k=1:(2*(n+1)-1)
% %     
% %     if k==1
% %         px = kx(1);
% %         py = ky(1);
% %         p1 = px + py;
% %         p2 = -px + py;
% %         H1 = Hirschfeld_tb_hamiltonian(px, py, p1, p2, kz, m, n);
% %         H(:,:,m) = H1(:,:,m);
% %         m = m+1;
% %     else
% %         [row, col] = find( M==k+1 );
% %         
% %         if abs(mod(k,2)) > 0
% %             for l=1:length(row)
% %                 px = kx(col(l));
% %                 py = ky(row(l));
% %                 p1 = px + py;
% %                 p2 = -px + py;
% %                 H1 = Hirschfeld_tb_hamiltonian(px, py, p1, p2, kz, m, n);
% %                 H(:,:,m) = H1(:,:,m);
% %                 m = m+1;
% %             end
% %         else
% %             [B,I] = sort(row,'ascend');
% %             for l=1:length(row)
% %                 px = kx( col(I(l)) );
% %                 py = ky( row(I(l)) );
% %                 p1 = px + py;
% %                 p2 = -px + py;
% %                 H1 = Hirschfeld_tb_hamiltonian(px, py, p1, p2, kz, m, n);
% %                 H(:,:,m) = H1(:,:,m);
% %                 m = m+1;
% %             end
% %         end
% %         
% %     end
% %                 
% %         
% % end 
%         
%         end
%     end
% end
% m=1;
% [Vseq,Dseq] = eigenshuffle(H);
% 
% eigeps = zeros(n+1, n+1, 10);
% 
% % for k=1:(2*(n+1)-1)
% %     
% %     if k==1
% %         
% %         eigeps(1, 1, 1) = Dseq(1,m);
% %         eigeps(1, 1, 2) = Dseq(2,m);
% %         eigeps(1, 1, 3) = Dseq(3,m);
% %         eigeps(1, 1, 4) = Dseq(4,m);
% %         eigeps(1, 1, 5) = Dseq(5,m);
% %         eigeps(1, 1, 6) = Dseq(6,m);
% %         eigeps(1, 1, 7) = Dseq(7,m);
% %         eigeps(1, 1, 8) = Dseq(8,m);
% %         eigeps(1, 1, 9) = Dseq(9,m);
% %         eigeps(1, 1, 10) = Dseq(10,m);
% %         
% %         m = m+1;
% %         
% %     else
% %         [row, col] = find( M==k+1 );
% %         
% %         if abs(mod(k,2)) > 0
% %             for l=1:length(row)
%                 
%                 
% %                 eigeps(col(l), row(l), 1) = Dseq(1,m);
% %                 eigeps(col(l), row(l), 2) = Dseq(2,m);
% %                 eigeps(col(l), row(l), 3) = Dseq(3,m);
% %                 eigeps(col(l), row(l), 4) = Dseq(4,m);
% %                 eigeps(col(l), row(l), 5) = Dseq(5,m);
% %                 eigeps(col(l), row(l), 6) = Dseq(6,m);
% %                 eigeps(col(l), row(l), 7) = Dseq(7,m);
% %                 eigeps(col(l), row(l), 8) = Dseq(8,m);
% %                 eigeps(col(l), row(l), 9) = Dseq(9,m);
% %                 eigeps(col(l), row(l), 10) = Dseq(10,m);
% %                 eigeps(row(l), col(l), 1) = Dseq(1,m);
% %                 eigeps(row(l), col(l), 2) = Dseq(2,m);
% %                 eigeps(row(l), col(l), 3) = Dseq(3,m);
% %                 eigeps(row(l), col(l), 4) = Dseq(4,m);
% %                 eigeps(row(l), col(l), 5) = Dseq(5,m);
% %                 eigeps(row(l), col(l), 6) = Dseq(6,m);
% %                 eigeps(row(l), col(l), 7) = Dseq(7,m);
% %                 eigeps(row(l), col(l), 8) = Dseq(8,m);
% %                 eigeps(row(l), col(l), 9) = Dseq(9,m);
% %                 eigeps(row(l), col(l), 10) = Dseq(10,m);
% %                 m = m+1;
% %                 
% %             end
% %         else
% %             [B,I] = sort(row,'ascend');
% %             for l=1:length(row)
%                 
%                 
% %                 eigeps(col(I(l)), row(I(l)), 1) = Dseq(1,m);
% %                 eigeps(col(I(l)), row(I(l)), 2) = Dseq(2,m);
% %                 eigeps(col(I(l)), row(I(l)), 3) = Dseq(3,m);
% %                 eigeps(col(I(l)), row(I(l)), 4) = Dseq(4,m);
% %                 eigeps(col(I(l)), row(I(l)), 5) = Dseq(5,m);
% %                 eigeps(col(I(l)), row(I(l)), 6) = Dseq(6,m);
% %                 eigeps(col(I(l)), row(I(l)), 7) = Dseq(7,m);
% %                 eigeps(col(I(l)), row(I(l)), 8) = Dseq(8,m);
% %                 eigeps(col(I(l)), row(I(l)), 9) = Dseq(9,m);
% %                 eigeps(col(I(l)), row(I(l)), 10) = Dseq(10,m);
% 
% %                 eigeps(row(I(l)), col(I(l)), 1) = Dseq(1,m);
% %                 eigeps(row(I(l)), col(I(l)), 2) = Dseq(2,m);
% %                 eigeps(row(I(l)), col(I(l)), 3) = Dseq(3,m);
% %                 eigeps(row(I(l)), col(I(l)), 4) = Dseq(4,m);
% %                 eigeps(row(I(l)), col(I(l)), 5) = Dseq(5,m);
% %                 eigeps(row(I(l)), col(I(l)), 6) = Dseq(6,m);
% %                 eigeps(row(I(l)), col(I(l)), 7) = Dseq(7,m);
% %                 eigeps(row(I(l)), col(I(l)), 8) = Dseq(8,m);
% %                 eigeps(row(I(l)), col(I(l)), 9) = Dseq(9,m);
% %                 eigeps(row(I(l)), col(I(l)), 10) = Dseq(10,m);
% %                 m = m+1;
% %             end
% %         end
% %         
% %     end
% %                 
% %         
% % end 
%         
% 
% 
% 
% 
% 
% 
% for k=0:n
%     for l=1:n+1
%         
%         eigeps((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1, 1) = Dseq(1,m);
%         eigeps((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1, 2) = Dseq(2,m);
%         eigeps((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1, 3) = Dseq(3,m);
%         eigeps((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1, 4) = Dseq(4,m);
%         eigeps((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1, 5) = Dseq(5,m);
%         eigeps((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1, 6) = Dseq(6,m);
%         eigeps((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1, 7) = Dseq(7,m);
%         eigeps((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1, 8) = Dseq(8,m);
%         eigeps((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1, 9) = Dseq(9,m);
%         eigeps((n+2)*mod(k-2,2) - l * (-1)^(k+1), k+1, 10) = Dseq(10,m);
%         
%         m = m+1;
%     end
% end
% 
% 
% figure, surf(eigeps(:,:,1))
% figure, surf(eigeps(:,:,2))
% figure, surf(eigeps(:,:,3))
% figure, surf(eigeps(:,:,4))
% figure, surf(eigeps(:,:,5))
% figure, surf(eigeps(:,:,6))
% figure, surf(eigeps(:,:,7))
% figure, surf(eigeps(:,:,8))
% figure, surf(eigeps(:,:,9))
% figure, surf(eigeps(:,:,10))
% 
% xc = 1;
% 
% c1 = eigeps(:,xc,1);
% c2 = eigeps(:,xc,2);
% c3 = eigeps(:,xc,3);
% c4 = eigeps(:,xc,4);
% c5 = eigeps(:,xc,5);
% c6 = eigeps(:,xc,6);
% c7 = eigeps(:,xc,7);
% c8 = eigeps(:,xc,8);
% c9 = eigeps(:,xc,9);
% c10 = eigeps(:,xc,10);
% 
% figure, plot(kx,c1,kx,c2,kx,c3,kx,c4,kx,c5,kx,c6,kx,c7,kx,c8,kx,c9,kx,c10)
% 
% d1 = eigeps(xc, :,1);
% d2 = eigeps(xc, :,2);
% d3 = eigeps(xc, :,3);
% d4 = eigeps(xc, :,4);
% d5 = eigeps(xc, :,5);
% d6 = eigeps(xc, :,6);
% d7 = eigeps(xc, :,7);
% d8 = eigeps(xc, :,8);
% d9 = eigeps(xc, :,9);
% d10 = eigeps(xc, :,10);
% 
% figure, plot(kx,d1,kx,d2,kx,d3,kx,d4,kx,d5,kx,d6,kx,d7,kx,d8,kx,d9,kx,d10)
% 
% 
% %%
% % eigepsc = eigeps;
% % 
% % [nx, ny, nz] = size(eigeps);
% % 
% % for i=1:nz
% %     m(i) = sum( eigeps(:,1,i));
% % end
% % 
% % [M, I] = sort(m,'ascend');
% % 
% % for j=1:nz
% %     eigepsc(:,:,j) = eigeps(:,:,I(j));
% % end
% % clear M I i j;
% % eigeps = eigepsc;
% % 
% % cc = 0;
% % 
% % figure, plot(kx, eigeps(:,1,1),'bo')
% % hold on
% % for i=2:n+1
% %     plot(kx, eigeps(:,i,1)+i*0.1,'bo')
% % end
% % hold off
% %     
% % figure, plot(kx, eigeps(1,:,1),'bo')
% % hold on
% % for i=2:n+1
% %     plot(kx, eigeps(i,:,1)+i*0.1,'bo')
% % end
% % hold off
% % 
% % 
% % 
% % for i=1:nz
% %     for j=1:nz
% %         s(i,j) = sum( abs( eigeps(:,2,j) - eigeps(:,1,i) ) );
% %         figure, plot(kx,eigeps(:,2,j),'ro',kx,eigeps(:,1,i),'ko', kx,abs (eigeps(:,2,j) - eigeps(:,1,i)),'bo' )
% %     end
% %     tt = 1;
% % end
% % 
% % [M, I] = min(s);
% % 
% % for j=1:nz
% %     eigepsc(:,2,j) = eigeps(:,2,I(j));
% % end
% % clear M I;
% % eigeps = eigepsc;
% % 
% % for k=2:nx-1
% %     for i=1:nz
% %         for j=1:nz
% %             s(i,j) = sum( abs(  ( eigeps(:,k+1,j) - eigeps(:,k,i) ) - ( eigeps(:,k,j) - eigeps(:,k-1,i) )  ) );
% %     %         figure, plot(kx,eigeps(:,2,j),'ro',kx,eigeps(:,1,i),'ko', kx,abs (eigeps(:,2,j) - eigeps(:,1,i)),'bo' )
% %         end
% %         tt = 1;
% %     end
% % 
% %     [M, I] = min(s);
% % 
% %     for j=1:nz
% %         eigepsc(:,k+1,j) = eigeps(:,k+1,I(j));
% %     end
% %     clear M I
% %     eigeps = eigepsc;
% % end
% % 
% % 
% % % for j=0:nz-1
% % %     for i=1:nz-j
% % %         s(i) =  sum( abs( eigeps(:,2,i+cc)-eigeps(:,1,cc+1) ) );
% % %     end
% % %     [M, I] = min(s);
% % % 
% % %     eigepsc(:,2,cc+1) = eigeps(:,2,I);
% % %     eigeps(:,2,I) = eigeps(:,2,cc+1);
% % %     cc = cc+1;
% % %     clear s M I;
% % % end
% % 
% % xc = 1;
% % 
% % c1 = eigepsc(:,xc,1);
% % c2 = eigepsc(:,xc,2);
% % c3 = eigepsc(:,xc,3);
% % c4 = eigepsc(:,xc,4);
% % c5 = eigepsc(:,xc,5);
% % c6 = eigepsc(:,xc,6);
% % c7 = eigepsc(:,xc,7);
% % c8 = eigepsc(:,xc,8);
% % c9 = eigepsc(:,xc,9);
% % c10 = eigepsc(:,xc,10);
% % 
% % figure, plot(kx,c1,kx,c2,kx,c3,kx,c4,kx,c5,kx,c6,kx,c7,kx,c8,kx,c9,kx,c10)
% % 
% % d1 = eigepsc(xc, :,1);
% % d2 = eigepsc(xc, :,2);
% % d3 = eigepsc(xc, :,3);
% % d4 = eigepsc(xc, :,4);
% % d5 = eigepsc(xc, :,5);
% % d6 = eigepsc(xc, :,6);
% % d7 = eigepsc(xc, :,7);
% % d8 = eigepsc(xc, :,8);
% % d9 = eigepsc(xc, :,9);
% % d10 = eigepsc(xc, :,10);
% % 
% % figure, plot(kx,d1,kx,d2,kx,d3,kx,d4,kx,d5,kx,d6,kx,d7,kx,d8,kx,d9,kx,d10)
% % 
% % figure, surf(eigepsc(:,:,1))
% % figure, surf(eigepsc(:,:,2))
% % figure, surf(eigepsc(:,:,3))
% % figure, surf(eigepsc(:,:,4))
% % figure, surf(eigepsc(:,:,5))
% % figure, surf(eigepsc(:,:,6))
% % figure, surf(eigepsc(:,:,7))
% % figure, surf(eigepsc(:,:,8))
% % figure, surf(eigepsc(:,:,9))
% % figure, surf(eigepsc(:,:,10))
% % 

toc
end