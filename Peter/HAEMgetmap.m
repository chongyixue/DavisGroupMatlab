function [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = HAEMgetmap(prft_data,comment)
%this function converts the complex FT data into symmetrized and
%antisymmetrized data.

% prft_data - phase resolved, complex, fourier transform for a single 
% impurity whose origin is at the center in order to give meaning to real
% and imaginary part

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


%%  plot antisymetrized map at a particular layer

plotlayer = asymrealmap(:,:,zlayer-9);

%     change_color_of_STM_maps(plotlayer,'ninvert')
    figureset_img_plot(plotlayer)




end