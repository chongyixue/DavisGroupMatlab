k = linspace(-pi,pi,100);
w = linspace(0,10,100);
[ki,wi] = meshgrid(k,w);

Q = ki;

E = ki.^2;
G = 1./(wi+1i*0.1-E);

% figure, plot(k,k.^2)
% 
% mat2STM_Viewer(real(G),0,0,0)
% mat2STM_Viewer(imag(G),0,0,0)


figure(2),surf(ki,wi,real(G),'FaceColor','interp','LineStyle', 'none')
view(2)
set(2,'Name','Real');
ylabel('\omega')
xlabel('k')
figure(3),surf(ki,wi,imag(G),'FaceColor','interp','LineStyle', 'none')
view(2)
set(3,'Name','Imaginary');
ylabel('\omega')
xlabel('k')


%indexing-wise it is G(w,k)
figure(4),
plot(w,real(G(:,70)),'Color' ,[0,0,1])
hold on
plot(w,real(G(:,100)),'Color',[1,0,0])

kk = 3.14;
figure(5),
plot(w,real(1./(w+1i*0.1-kk^2)))



% surfplot example
% [num,txt,raw] = xlsread('DATA.xlsx') ;
% X = num(:,1) ;
% Y = num(:,2) ;
% Z = num(:,3) ;
% N = 100 ;
% x = linspace(min(X),max(X),N) ;
% y = linspace(min(Y),max(Y),N) ;
% [Xi,Yi] = meshgrid(x,y) ;
% Zi = griddata(X,Y,Z,Xi,Yi) ;
% surf(Xi,Yi,Zi)
