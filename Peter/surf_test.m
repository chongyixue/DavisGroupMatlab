%clear all
%close all
%toy model

tx = 1;
ty = 1;
res = 600+1;
%cell dimensions
a = 2.7;
b = 2.7;
k_x = linspace(-pi/8/a,pi/8/a,res);
k_y = linspace(-pi/8/b,pi/8/b,res);
q = linspace(-2*pi/a,2*pi/a,2*res-1);


[Kx, Ky] = meshgrid(k_x,k_y);

%energy extrema
E_h = 15;
x_0 = 0.156/2;

%g=60*a;
m_hx = x_0^2/(2*E_h);
m_hy = m_hx*2;

%band
E = E_h - Kx.^2./(2*m_hx)-Ky.^2./(2*m_hy);

%define gap
%g = 10;
%gap = g*(cos(Kx)-cos(Ky))/2;
g1=1.4;
g2=1.1;
gap2 = g1+g2*(2*Kx.^2./(Kx.^2+Ky.^2)-1);
% fix the origin
gap2((res-1)/2+1,(res-1)/2+1)=g1+g2;
gap = 0;
%gap = 0;
%gap = 0.1;


%define 1/lifetime
delta = 2e0;

w = 0;

% spectrum = zeros(1,N);

%A(:,:,i) = 1/pi*delta./((E-w(i)).^2+delta.^2);
%A(:,:,i) = imag(S(:,:,i))./((w(i)-E-real(S(:,:,i))).^2+imag(S(:,:,i)).^2);
A = delta*(1+(gap.^2)./((w+E).^2+delta^2))./...
  ((w-E-((gap.^2).*(w+E)./((w+E).^2+delta^2))).^2+delta^2*(1+(gap.^2)./...
  ((w+E).^2+delta^2)).^2);
A = A/(max(A(:)));
H = A.*gap2;
H(H<0.1)=0;
figure(200), surf(k_x,k_y,H);
shading interp
axis('off');


% G.map = gap;
% G.name = 'gap';
% G.r = linspace(-pi/a,pi/a,res);
% G.e = 1;
% G.var = 'gap';
% img_obj_viewer2(G);
