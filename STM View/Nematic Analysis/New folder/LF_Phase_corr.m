 function [phaseA, phaseB, topo_final] = LF_Phase_corr(data,Qax,Qay,Qbx,Qby,x0,y0,std)

% updated on Aug 01, 2012
% Sourin Mukhopadhyay

% close all
 
% input data is topo
% Q1(Qax,Qay) and Q2(Qbx,Qby) are the bragg-peak positions
% (x0,y0) is the center of fft
% std: pixel width for Gaussian filter

phaseA = [];
phaseB = [];
topo_final = [];

%==========================================================================

% read data sets
[nx ny ne] = size(data.map);

kx = 2*pi./nx;
ky = 2*pi./ny;

fft_Topo=fftshift(fft2(data.map));

figure(1);pcolor(data.map);shading flat; colormap('jet'); colorbar;title('Topo original');
figure(2);pcolor(abs(fft_Topo));shading flat; colormap('jet'); colorbar;title('FFT Topo original');caxis([1 50]);zoom(2);

%==========================================================================

aX = zeros(nx,ny);
bX = zeros(nx,ny);

Cos_a = zeros(nx,ny);
Sin_a = zeros(nx,ny);
Cos_b = zeros(nx,ny);
Sin_b = zeros(nx,ny);

Xa1 = zeros(nx,ny);
Xb1 = zeros(nx,ny);
Ya1 = zeros(nx,ny);
Yb1 = zeros(nx,ny);

Xa2 = zeros(nx,ny);
Xb2 = zeros(nx,ny);
Ya2 = zeros(nx,ny);
Yb2 = zeros(nx,ny);

Xa = zeros(nx,ny);
Xb = zeros(nx,ny);
Ya = zeros(nx,ny);
Yb = zeros(nx,ny);

G = zeros(nx,ny);

Amp_a = zeros(nx,ny);
Amp_b = zeros(nx,ny);

theta_a = zeros(nx,ny);
theta_b = zeros(nx,ny);

phase_a = zeros(nx,ny);
phase_b = zeros(nx,ny);

phase_a_corr = zeros(nx,ny);
phase_b_corr = zeros(nx,ny);

phase_a_store = zeros(nx,ny,1);
phase_b_store = zeros(nx,ny,1);

phi_a = zeros(nx,ny);
phi_b = zeros(nx,ny);
Topo = zeros(nx,ny);

ux_corr = zeros(nx,ny);
uy_corr = zeros(nx,ny);

topo_f_x = zeros(nx,ny);
topo_f_y = zeros(nx,ny);

Topo_final_1 = zeros(nx,ny);
Topo_final = zeros(nx,ny);
fft_Topo_final = zeros(nx,ny);


%=========================================================================
% determine bragg peak positions w.r.t. fourier center

qax = kx*(Qax - x0);
qay = ky*(Qay - y0);
qbx = kx*(Qbx - x0);
qby = ky*(Qby - y0);

% disp (qax);
% disp (qay);
% disp (qbx);
% disp (qby);

%==========================================================================

% Construct cosine and sine functions and apply on Topo-data

[X, Y] = meshgrid(1:nx, 1:ny);

aX = qax.*X + qay.*Y;
bX = qbx.*X + qby.*Y;

Cos_a = cos(aX);
Sin_a = sin(aX);
Cos_b = cos(bX);
Sin_b = sin(bX);



        Xa1 = data.map.* Cos_a;
        Ya1 = data.map.* Sin_a;

        Xb1 = data.map.* Cos_b;
        Yb1 = data.map.* Sin_b;
        
% figure(3);pcolor(Xa1);shading flat; colormap('jet'); colorbar;title('T(r) Cos Qa');
% figure(4);pcolor(Xb1);shading flat; colormap('jet'); colorbar;title('T(r) Sin Qa');
% figure(5);pcolor(Ya1);shading flat; colormap('jet'); colorbar;title('T(r) Cos Qb');
% figure(6);pcolor(Yb1);shading flat; colormap('jet'); colorbar;title('T(r) Sin Qb');

%==========================================================================

% Apply Low-Pass filter with the gaussian width = sigma (=3*std, input)
% define theta_a, theta_b

lambda = std;
scale = 2*pi./nx;
sigma = scale.*lambda;

G =((sigma.^2./(2*pi)).*exp(-sigma.^2.*((X-x0).^2 + (Y-y0).^2)./2));


%  figure(7);surfc(abs(fftshift(fft2(G))));daspect('auto');axis vis3d;colormap('jet');
%  figure(8);surfc(G);daspect('auto');axis vis3d;colormap('jet');

%==========================================================================

% FFT & IFFT

Xa2 =fftshift((fft2(complex(Xa1,0))).*(fft2(complex(G,G))));
Xa3 = real(ifftshift(ifft2(ifftshift(Xa2))));

Ya2 =fftshift((fft2(complex(Ya1,0))).*(fft2(complex(G,G))));
Ya3 = real(ifftshift(ifft2(ifftshift(Ya2))));

Xb2 =fftshift((fft2(complex(Xb1,0))).*(fft2(complex(G,G))));
Xb3 = real(ifftshift(ifft2(ifftshift(Xb2))));

Yb2 =fftshift((fft2(complex(Yb1,0))).*(fft2(complex(G,G))));
Yb3 = real(ifftshift(ifft2(ifftshift(Yb2))));

 
figure(9);pcolor(abs(fftshift((fft2(complex(Xa1,0))))));shading flat; colormap('jet'); colorbar; title('FFT[T(r)Cos(qx.x)]');
figure(10);pcolor(abs(fftshift((fft2(complex(Ya1,0))))));shading flat; colormap('jet'); colorbar; title('FFT[T(r)Sin(qx.x)]');
figure(11);pcolor(abs(fftshift((fft2(complex(Xb1,0))))));shading flat; colormap('jet'); colorbar; title('FFT[T(r)Cos(qy.y)]');
figure(12);pcolor(abs(fftshift((fft2(complex(Yb1,0))))));shading flat; colormap('jet'); colorbar; title('FFT[T(r)Sin(qy.y)]');

figure(80);pcolor(abs(Xa2));shading flat; colormap('jet'); colorbar; title('FFT[T(r)Cos(qx.x)]');
% caxis([1 200]);
 zoom(15);

figure(90);pcolor(abs(Ya2));shading flat; colormap('jet'); colorbar; title('FFT[T(r)Sin(qx.x)]');
% caxis([1 200]);
 zoom(15);
figure(100);pcolor(abs(Xb2));shading flat; colormap('jet'); colorbar; title('FFT[T(r)Cos(qy.y)]');
% caxis([1 200]);
 zoom(15);
figure(110);pcolor(abs(Yb2));shading flat; colormap('jet'); colorbar; title('FFT[T(r)Sin(qy.y)]');
% caxis([1 200]);
  zoom(15);

%==========================================================================

%  Apply padnorm to enhance S/N ratio

Padnorm = zeros(nx, ny);

Padnorm(:,:) = 1.0;

Padnorm1 =fftshift(fft2(complex(Padnorm,0),2*nx,2*ny)).*fftshift(fft2(complex(G,G),2*nx,2*ny));
Padnorm2 = real(ifft2(ifftshift(Padnorm1)));

PadnormFinal = zeros(nx,ny);

for x = 1:nx
    for y = 1:ny
               
        PadnormFinal(x,y) = Padnorm2(x+floor(nx/2), y+floor(ny/2));
        
    end
end




Xa = Xa3./PadnormFinal;
Ya = Ya3./PadnormFinal;
Xb = Xb3./PadnormFinal;
Yb = Yb3./PadnormFinal;

%==========================================================================

% Determine amplitudes

Amp_a = abs(sqrt((Xa.^2 + Ya.^2)));
Amp_b = abs(sqrt((Xb.^2 + Yb.^2)));

%==========================================================================


% Determine the phase

phase_a = atan2(real(Ya),real(Xa));
phase_b = atan2(real(Yb),real(Xb));

phase_a_store(:,:,1) = phase_a(:,:);
phase_b_store(:,:,1) = phase_b(:,:);

phi_a = mod(qax.*X + qay.*Y - theta_a + pi, 2*pi);
phi_b = mod(qbx.*X + qby.*Y - theta_b + pi, 2*pi);

Topo = Amp_a.* cos(phi_a) + Amp_b.*cos(phi_b);


figure(13);pcolor(phase_a);shading flat; colormap('jet'); colorbar; title('Initial phase_a');
figure(14);pcolor(phase_b);shading flat; colormap('jet'); colorbar; title('Initial phase_b');

figure(15);pcolor(Topo);shading flat; colormap('jet'); colorbar; title('Topo Initial constructed');
figure(16);pcolor(abs(fftshift(fft2(Topo))));shading flat; colormap('jet'); colorbar; title(' FFT of Topo Initial constructed');zoom(2);

%==========================================================================
        
% Phase correction

for i = 1:6
phase_a_corr = phase_correct_3(phase_a,1,1,nx,ny);
phase_b_corr = phase_correct_3(phase_b,1,1,nx,ny);

phase_a = phase_a_corr;
phase_b = phase_b_corr;
end

figure(18);pcolor(phase_a_corr);shading flat; colormap('jet'); colorbar; title('phase_a corrected');       
figure(19);pcolor(phase_b_corr);shading flat; colormap('jet'); colorbar; title('phase_b corrected');       
 
%==========================================================================

% Determine the final corrected topo

Q_matrix = [qax, qay; qbx, qby];

Inv_Q = inv(Q_matrix);

ux_corr = Inv_Q(1,1).*phase_a_corr + Inv_Q(1,2).*phase_b_corr;
uy_corr = Inv_Q(2,1).*phase_a_corr + Inv_Q(2,2).*phase_b_corr;


topo_f_x = X + ux_corr;
topo_f_y = Y + uy_corr;


% figure(20);pcolor(ux_corr);shading flat; colormap('jet'); colorbar; title('Corrected ux');
% figure(21);pcolor(uy_corr);shading flat; colormap('jet'); colorbar; title('Corrected uy');

%==========================================================================

 Topo_final_1 = griddata(X, Y, data.map, topo_f_x, topo_f_y,'linear');

%=====================================================================
% fix NaN's in the topo

fixnan = isnan(Topo_final_1);

for x = 1:nx
    for y = 1:ny
        if fixnan(x,y) == 0.0
            Topo_final(x,y) = Topo_final_1(x,y);
        else
            Topo_final(x,y) = 0.0;
        end
    end
end
%=========================================================================
figure(22);pcolor(Topo_final);shading flat; colormap('jet'); colorbar; title('Topo final');       

%==========================================================================

% check fft of topo

 fft_Topo_final = fftshift(fft2(Topo_final));
 rc_fft_Topo = real(fft_Topo_final);
 ic_fft_Topo = imag(fft_Topo_final);


figure(23);pcolor(abs(rc_fft_Topo));shading flat; colormap('jet'); colorbar; title('Real of FFT Topo final'); zoom(2); caxis([1 70]);
figure(24);pcolor(abs(ic_fft_Topo));shading flat; colormap('jet'); colorbar; title('Imag of FFT Topo final'); zoom(2); caxis([1 70]);
% figure(25);pcolor((abs(real(fft_Topo_final)))-(abs(imag(fft_Topo_final))));shading flat; colormap('jet'); colorbar;caxis([1 50]); title('Real-Imag of FFT Topo final');zoom(2);     
figure(27);pcolor((abs((fft_Topo_final))));shading flat; colormap('jet'); colorbar; title('FFT Topo final'); zoom(2); caxis([1 70]);   

%==========================================================================

% store data in structure

phaseA = make_struct;
phaseA.map = phase_a_store;
phaseA.type = data.type;
phaseA.ave = phase_a_store;
phaseA.name = data.name;
phaseA.r = data.r;
phaseA.e = 1.0;
phaseA.info = data.info;
phaseA.ops = data.ops;
phaseA.var = 'perfect_phase_a_LF';

assignin('base','perfect_phase_a_LF',phaseA);

phaseB = make_struct;
phaseB.map = phase_b_store;
phaseB.type = data.type;
phaseB.ave = phase_b_store;
phaseB.name = data.name;
phaseB.r = data.r;
phaseB.e = 1.0;
phaseB.info = data.info;
phaseB.ops = data.ops;
phaseB.var = 'perfect_phase_b_LF';

assignin('base','perfect_phase_b_LF',phaseB);

topo_final = make_struct;
topo_final.map = Topo_final;
topo_final.type = data.type;
topo_final.ave = Topo_final;
topo_final.name = data.name;
topo_final.r = data.r;
topo_final.e = data.e;
topo_final.info = data.info;
topo_final.ops = data.ops;
topo_final.var = 'topo_61114A03_final_LF1_a';

assignin('base','topo_61114A03_final_LF1_a',topo_final);


%==========================================================================



end