function [eigeps2Daa] = fese_Hirschfeld_tb_5orbital_bounds_unres_mexable(pixelnum, kz, kx_limits, ky_limits ,t1)
% if nargin < 5
%     load('t1.mat','t1');
% end;
    

%tic


% define lattice constants a1 and a2
%a1 = 1;
%a2 = 1;

% define number of pixels used for first Brioullin zone and the kx, ky
n = pixelnum;

%%
kx = linspace(kx_limits(1), kx_limits(2), n+1);
ky = linspace(ky_limits(1), ky_limits(2), n+1);
%ky = linspace(pi-0.2*pi, pi+0.2*pi, n+1);

% kx = linspace(-0.15*pi, 0.15*pi, n+1);
% ky = linspace(pi-0.15*pi, pi+0.15*pi, n+1);
%%


% Create meshgrid for the tight binding band structure
%[X,Y]=meshgrid(kx,ky);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE HOW TO USE MESHGRID - START
% [X,Y] = meshgrid(-2:.2:2, -2:.2:2);                                
% Z = X .* exp(-X.^2 - Y.^2);  
% figure;
% surf(X,Y,Z)
% EXAMPLE - END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%xdata(:,:,1)=X;
%xdata(:,:,2)=Y;



%% define all offsets, hopping integrals, kz, renormalization value z

%xind = (1:1:n+1);
%yind = (1:1:n+1);

%[Mx,My]=meshgrid(xind,yind);

%M = Mx + My;

%Hss = zeros(5,5,(n+1)^2);
%Haa = zeros(5,5,(n+1)^2);

%Vsscell = cell(n+1, n+1);
%Dsscell = cell(n+1, n+1);
%Vaacell = cell(n+1, n+1);
%Daacell = cell(n+1, n+1);
eigeps2Daa = zeros(n+1, n+1, 5);

% Hcell = cell(n+1, n+1);
%%
% m=1;
for k=1:n+1
    for l=1:n+1
       % px = kx(k);
       % py = ky(l);
       % p1 = px + py;
       % p2 = -px + py;
        
       % [~,Haa1,Hss1]=moduleBands3Dchemcalc_unrestricted_fig(kx(k),ky(l),kz,5,t1);
        [~,Haa1,~]=moduleBands3Dchemcalc_unrestricted_fig(kx(k),ky(l),kz,int32(5),t1.');
        %[Hss1, Haa1] = Hirschfeld_tb_hamiltonian_5orbital2(px, py, p1, p2, kz);
       % Hss(:,:,m) = Hss1(:,:,1);
        %Haa(:,:,m) = Haa1(:,:,1);
        
%         
%         %[Vss, Dss] = eigs(Hss(:,:,m));
%                 [~, Dss] = eig(Hss1);
%        % Vsscell{k,l} = Vss;
%         Dsscell{k,l} =sort( diag(Dss));
        
        %[Vaa, Daa] = eig(Haa(:,:,m));
                [ ~, Daa] = eig(Haa1);

      %  Vaacell{k,l} = Vaa;
        %Daacell{k,l} 
        Dseq =  sort(real(diag(Daa)));
         eigeps2Daa(k,l,:) = Dseq(:);
      %   m=m+1;
    end
end
%toc
% %%
% 
% eigeps2Dss = zeros(n+1, n+1, 5);
% 
% % m=1;
% for k=1:n+1
%     for l=1:n+1
%         Dseq = real(Dsscell{k, l});
%         %Vseq = abs(Vsscell{k, l});
%        % for i=1:5
%         %dxy(i) = round(10*( Vseq(1,i)^2+Vseq(2,i)^2+Vseq(5,i)^2 ))/10;
%         %dxz(i) = round(10*( Vseq(3,i)^2) )/10;
%         %dyz(i) = round(10*( Vseq(4,i)^2) )/10;
% %         all(i) = dxy(i)+dxz(i)+dyz(i);
%        % end
%         eigeps2Dss(k,l,1) = Dseq(1);
%         %orbchass{k,l,1} = [dxz(1), dxy(1), dyz(1)];
%         eigeps2Dss(k,l,2) = Dseq(2);
%         %orbchass{k,l,2} = [dxz(2), dxy(2), dyz(2)];
%         eigeps2Dss(k,l,3) = Dseq(3);
%         %orbchass{k,l,3} = [dxz(3), dxy(3), dyz(3)];
%         eigeps2Dss(k,l,4) = Dseq(4);
%         %orbchass{k,l,4} = [dxz(4), dxy(4), dyz(4)];
%         eigeps2Dss(k,l,5) = Dseq(5);
%         %orbchass{k,l,5} = [dxz(5), dxy(5), dyz(5)];
%         % m=m+1;
%     end
% end
% 
% %%

% 
% m=1;
% for k=1:n+1
%     for l=1:n+1
%         Dseq = real(Daacell{k, l});
%        % Vseq = abs(Vaacell{k, l});
% %         for i=1:5
% %         dxy(i) = round(10*( Vseq(1,i)^2+Vseq(2,i)^2+Vseq(5,i)^2 ))/10;
% %         dxz(i) = round(10*( Vseq(3,i)^2) )/10;
% %         dyz(i) = round(10*( Vseq(4,i)^2) )/10;
% % %         all(i) = dxy(i)+dxz(i)+dyz(i);
% %         end
%         eigeps2Daa(k,l,:) = Dseq(:);
%         %orbchaaa{k,l,1} = [dxz(1), dxy(1), dyz(1)];
% %         eigeps2Daa(k,l,2) = Dseq(2);
% %         %orbchaaa{k,l,2} = [dxz(2), dxy(2), dyz(2)];
% %         eigeps2Daa(k,l,3) = Dseq(3);
% %         %orbchaaa{k,l,3} = [dxz(3), dxy(3), dyz(3)];
% %         eigeps2Daa(k,l,4) = Dseq(4);
% %         %orbchaaa{k,l,4} = [dxz(4), dxy(4), dyz(4)];
% %         eigeps2Daa(k,l,5) = Dseq(5);
% %         %orbchaaa{k,l,5} = [dxz(5), dxy(5), dyz(5)];
%         m=m+1;
%     end
% end
% %%

% xc = n/2+1;
% 
% figure, plot(kx(1),eigeps2Dss(xc, 1, 1),'Color',orbchass{xc,1,1},'Marker','.')
% hold on
% for k=1:n+1
%     plot(kx(k),eigeps2Dss(xc, k, 1),'Color',orbchass{xc,k,1},'Marker','.')
%     plot(kx(k),eigeps2Dss(xc, k, 2),'Color',orbchass{xc,k,2},'Marker','.')
%     plot(kx(k),eigeps2Dss(xc, k, 3),'Color',orbchass{xc,k,3},'Marker','.')
%     plot(kx(k),eigeps2Dss(xc, k, 4),'Color',orbchass{xc,k,4},'Marker','.')
%     plot(kx(k),eigeps2Dss(xc, k, 5),'Color',orbchass{xc,k,5},'Marker','.')
% end
% hold off
% 
% figure, plot(kx(1),eigeps2Dss(1, xc, 1),'Color',orbchass{1,xc,1},'Marker','.')
% hold on
% for k=1:n+1
%     plot(kx(k),eigeps2Dss(k, xc, 1),'Color',orbchass{k, xc,1},'Marker','.')
%     plot(kx(k),eigeps2Dss(k, xc, 2),'Color',orbchass{k, xc,2},'Marker','.')
%     plot(kx(k),eigeps2Dss(k, xc, 3),'Color',orbchass{k, xc,3},'Marker','.')
%     plot(kx(k),eigeps2Dss(k, xc, 4),'Color',orbchass{k, xc,4},'Marker','.')
%     plot(kx(k),eigeps2Dss(k, xc, 5),'Color',orbchass{k, xc,5},'Marker','.')
% end
% hold off
% 
% %%
% 
% xc = n/2+1;
% 
% figure, plot(kx(1),eigeps2Daa(xc, 1, 1),'Color',orbchaaa{xc,1,1},'Marker','.')
% hold on
% for k=1:n+1
%     plot(kx(k),eigeps2Daa(xc, k, 1),'Color',orbchaaa{xc,k,1},'Marker','.')
%     plot(kx(k),eigeps2Daa(xc, k, 2),'Color',orbchaaa{xc,k,2},'Marker','.')
%     plot(kx(k),eigeps2Daa(xc, k, 3),'Color',orbchaaa{xc,k,3},'Marker','.')
%     plot(kx(k),eigeps2Daa(xc, k, 4),'Color',orbchaaa{xc,k,4},'Marker','.')
%     plot(kx(k),eigeps2Daa(xc, k, 5),'Color',orbchaaa{xc,k,5},'Marker','.')
% end
% hold off
% 
% figure, plot(kx(1),eigeps2Daa(1, xc, 1),'Color',orbchaaa{1,xc,1},'Marker','.')
% hold on
% for k=1:n+1
%     plot(kx(k),eigeps2Daa(k, xc, 1),'Color',orbchaaa{k, xc,1},'Marker','.')
%     plot(kx(k),eigeps2Daa(k, xc, 2),'Color',orbchaaa{k, xc,2},'Marker','.')
%     plot(kx(k),eigeps2Daa(k, xc, 3),'Color',orbchaaa{k, xc,3},'Marker','.')
%     plot(kx(k),eigeps2Daa(k, xc, 4),'Color',orbchaaa{k, xc,4},'Marker','.')
%     plot(kx(k),eigeps2Daa(k, xc, 5),'Color',orbchaaa{k, xc,5},'Marker','.')
% end
% hold off
% 

end