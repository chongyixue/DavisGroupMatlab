function A = fese_fs_plot(eigeps, orbcha)

tic

[nx, ny, lambdaz] = size(eigeps);
% define number of pixels used for first Brioullin zone and the kx, ky
n =nx-1;
kx = linspace(-pi, pi, n+1);
ky = linspace(-pi, pi, n+1);

% Fe-Fe distance
afe = 2.687;
% scaled kx and ky
kxs = kx/afe;
kys = ky/afe;

% Create meshgrid for the tight binding band structure
[X,Y]=meshgrid(kx,ky);

%% calculate the spectral function A(k,w) [w is energy] as a function of 
%% energy, and the corresponding joint density of states (jdos (q, w)) using 
%% xcorr2; jdos is autocorrelation of spectral function. q is scattering 
%% space.

% define lifetime factor g for spectral function A(k)
g = 0.002;
cc =1;

%% plot orbital coded Fermi surface
kx = linspace(-pi, pi, n+1);
ky = linspace(-pi, pi, n+1);

figure, hold on




    % energy en
    en(cc) = 0 * 0.01;
    
    for l = 1:lambdaz
    % spectral function A(k)
        A(:,:,l) = 1/pi*g ./ ( (en(cc) - eigeps(:,:,l)).^2 + g^2 );
        
        
        [row, col] = find( abs(A(:,:,l)) > 25);
        
        for p = 1:length(row)
            
            plot(kx( row(p) ),ky(col (p) ) ,'Color',orbcha{row(p), col(p), l},'Marker','.')
            
        end
        test = 1;
%         figure, imagesc(A(:,:,l))
    end
xlim([-pi, pi]);
ylim([-pi, pi]);
axis square;

hold off
toc
end