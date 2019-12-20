function [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = fesesingleimpurity_pjh_analysis(prft_data, qc1, qc2, qr, maskshape)

% prft_data - phase resolved, complex, fourier transform for a single 
% impurity whose origin is at the center in order to give meaning to real
% and imaginary part
% qr - radius in q-space in pixel for integration around interpocket
% scattering vector
% qc1 - coordinates of first interpocket scattering vector
% qc2 - coordinates of second interpocket scattering vector

% energies of map
ev = prft_data.e;
le = length(ev);
%% check if energies start on positive or negative side of chemical potential
complexft = prft_data.map;

if ev(le) < 0
    ev = fliplr(ev);
    complexft = flip(complexft,3);
    prft_data.e = ev;
    prft_data.map = complexft;
end
%%


[nx, ny, nz] = size(complexft);

% Find the energy layer corresponding to the chemical potential if the
% number of layers is odd, or corresponding to the layer closest to the
% chemical potential in the case of an even number of layers
if mod(le, 2) == 0
    zlayer = le - le/2;
else
    for j = 1:le
        if ev(j) == 0
            zlayer = j;
        end
    end
    zlayer = zlayer - 1;
end

for i=1:zlayer
    me(i) = ev(i);
    pe(i) = ev(le+1-i);
end

%% circular or rectangular masks used for integration

if strcmp(maskshape, 'circle')==1
    cm1 = double(circlematrix([nx,ny], qr , qc1(2), qc1(1)) );

    cm2 = double(circlematrix([nx,ny], qr, qc2(2), qc2(1)) );
else
    cm1 = zeros(nx,ny);
    cm1(qc1(2)-qr : qc1(2)+qr, qc1(1)-qr : qc1(1)+qr) = 1;
    
    cm2 = zeros(nx,ny);
    cm2(qc2(2)-qr : qc2(2)+qr, qc2(1)-qr : qc2(1)+qr) = 1;
end

figure, imagesc(cm1);
figure, imagesc(cm2);

pn1 = sum(sum(cm1));
cmr1 = repmat(cm1, 1, 1, zlayer);
pn2 = sum(sum(cm2));
cmr2 = repmat(cm2, 1, 1, zlayer);

%%

complexft = prft_data.map;


realft = zeros(nx, ny, nz);
imagft = zeros(nx, ny, nz);

for i=1:nz
   realft(:,:,i) = real(complexft(:,:,i));
   imagft(:,:,i) = imag(complexft(:,:,i));
end

realft_data = prft_data;
realft_data.map = realft;

imagft_data = prft_data;
imagft_data.map = imagft;


symrealmap = zeros(nx, ny, zlayer);
asymrealmap = zeros(nx, ny, zlayer);
symimagmap = zeros(nx, ny, zlayer);
asymimagmap = zeros(nx, ny, zlayer);

for i=1:zlayer
    symrealmap(:,:,i) = realft(:,:,le+1-i) + realft(:,:,i);
    testmap(:,:,i) = (realft(:,:,le+1-i) - realft(:,:,i)).*(cm1+cm2);
    asymrealmap(:,:,i) = realft(:,:,le+1-i) - realft(:,:,i);
    symimagmap(:,:,i) = imagft(:,:,le+1-i) + imagft(:,:,i);
    asymimagmap(:,:,i) = imagft(:,:,le+1-i) - imagft(:,:,i);
end

symrealft_data = prft_data;
symrealft_data.map = symrealmap;
symrealft_data.e = pe;

symimagft_data = prft_data;
symimagft_data.map = symimagmap;
symimagft_data.e = pe;

asymrealft_data = prft_data;
asymrealft_data.map = asymrealmap;
asymrealft_data.e = pe;

asymimagft_data = prft_data;
asymimagft_data.map = asymimagmap;
asymimagft_data.e = pe;

test_data = prft_data;
test_data.map = testmap;
%% calculate the individual average intensity for the individual q-vectors
%% inside the area defined through the circular masks
arp1 = squeeze(sum ( sum ( asymrealmap .* (cmr1) ) ) / pn1);

arp2 = squeeze(sum ( sum ( asymrealmap .* (cmr2) ) ) / pn2);

aip1 = squeeze(sum ( sum ( asymimagmap .* (cmr1) ) ) / pn1);

aip2 = squeeze(sum ( sum ( asymimagmap .* (cmr2) ) ) / pn2);




pe = abs(pe)*1000;

rho.arp1 = arp1;
rho.arp2 = arp2;
rho.aip1 = aip1;
rho.aip2 = aip2;
rho.ev = pe;

figure, plot(pe, arp1,'-o','color','r', 'LineWidth', 2, 'MarkerSize', 15);
title('Anti-symmetrized real part of FT of conductance q1');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

figure, plot(pe, arp2,'-o','color','b', 'LineWidth', 2, 'MarkerSize', 15);
title('Anti-symmetrized real part of FT of conductance q2');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

figure, plot(pe, aip1,'-o','color','r', 'LineWidth', 2, 'MarkerSize', 15);
title('Anti-symmetrized imaginary part of FT of conductance q1');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on

figure, plot(pe, aip2,'-o','color','b', 'LineWidth', 2, 'MarkerSize', 15);
title('Anti-symmetrized imaginary part of FT of conductance q2');
xlim([pe(end), pe(1)])
xlabel('E [meV]');
ylabel('q-integrated intensity');
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
box on





%%  plot either a circle or a rectangle of the same color as the line 
%% plots marking the area of q-space integration

plotlayer = asymrealmap(26:76,26:76,zlayer-6);
qc1 = qc1 - 25;
qc2 = qc2 - 25;

pe(zlayer-6)

qr2 = qr-1;
qr3 = qr+1;
if strcmp(maskshape, 'circle')==1
    
    change_color_of_STM_maps(plotlayer,'ninvert')
    hold on
    rectangle('Position',[qc1(1)-qr,qc1(2)-qr,2*qr,2*qr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','k')
%     rectangle('Position',[qc1(1)-qr,qc1(2)-qr,2*qr,2*qr],'Curvature',[1,1],'Linewidth',3,'Edgecolor','k')
%     rectangle('Position',[qc1(1)-qr2,qc1(2)-qr2,2*qr2,2*qr2],'Curvature',[1,1],'Linewidth',3,'Edgecolor','k')
%     rectangle('Position',[qc1(1)-qr3,qc1(2)-qr3,2*qr3,2*qr3],'Curvature',[1,1],'Linewidth',3,'Edgecolor','k')
%     rectangle('Position',[qc2(1)-qr,qc2(2)-qr,2*qr,2*qr],'Curvature',[1,1],'Linewidth',2,'Edgecolor','b')
    hold off

else

    change_color_of_STM_maps(asymrealmap(:,:,zlayer-6),'ninvert')
    hold on
    rectangle('Position',[qc1(1)-qr,qc1(2)-qr,2*qr,2*qr],'Curvature',[0,0],'Linewidth',2,'Edgecolor','r')
    rectangle('Position',[qc2(1)-qr,qc2(2)-qr,2*qr,2*qr],'Curvature',[0,0],'Linewidth',2,'Edgecolor','b')
    hold off
end


end