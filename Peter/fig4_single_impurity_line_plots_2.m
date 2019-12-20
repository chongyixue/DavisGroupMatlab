%plot single impurity results
%currently figure 4 panels F
%% load stuff
% load('/Users/andreykostin/Documents/MATLAB/Analysis Code/MATLAB/FeSe figs/rho_minus_compare_hr.mat');
% load('C:\Users\Peter\Dropbox\Splusminus_analysis\rho_minus_compare_hr.mat');
load('C:\Users\pspra\Dropbox\Splusminus_analysis\rho_minus_compare_hr.mat');

scalar = max(rhom_pm(:));
energy = energy * 1000;
rhom_pm = rhom_pm/scalar;
rhom_pp = rhom_pp/scalar;
figure(1), clf
plot(energy,rhom_pm,'-.k','MarkerSize',25);
hold on
plot(energy,rhom_pp,'-.r','MarkerSize',25);
hold off

axes2 = gca;
axes2.XTick = linspace(0,5,6);
% axes2.YTick = linspace(-0.6,1,5);
axes2.YTick = linspace(-1.4,1,7);

% axis([0 4.5 -0.7 1.1]);
axis([0 4.5 -1.5 1.1]);

figw