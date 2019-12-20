%plot single impurity results
%currently figure 4 panels E,F
%% load stuff
load('/Users/andreykostin/Documents/MATLAB/rhominus.mat');
load('/Users/andreykostin/Documents/MATLAB/Analysis Code/MATLAB/refwdnqpibqpimsdevelopment/rho_minus_sign_change_lowres_highres.mat');

%% calculate antisymmetric rho_-(omega)
rhom_FeSe_hr=-res_hr(46:-1:1)+res_hr(46:1:91);
rhom_FeSe_hr_abs=-res_hr_abs(46:-1:1)+res_hr_abs(46:1:91);
rhom_FeSe=-res(31:-1:1)+res(31:1:61);
rhom_FeSe_abs=-res_abs(31:-1:1)+res_abs(31:1:61);

%% make figure
figure(1), clf
rhominus = boxcar_vector(rhominus);
rhominus = rhominus/max(rhominus(:));
e = 1000*om_hr(46:1:91);
scalar = max(rhom_FeSe_hr(:));
th_1 = rhom_FeSe_hr/scalar;
th_2 = rhom_FeSe_hr_abs/scalar;

plot(rhominus_ev,rhominus,'.k','MarkerSize',25);
hold on
plot(e,th_1,'.r','MarkerSize',25);
plot(e,th_2,'.b','MarkerSize',25);
plot([0 4.5],[0 0],'--k','LineWidth',2);

axes2 = gca;
axes2.XTick = linspace(0,5,6);
axes2.YTick = linspace(-0.6,1,5);
axis([0 4.5 -0.7 1.1]);
figw




% Create figure
%figure1 = figure;
figure(2), clf

% Create axes
%axes1 = axes('Parent',figure1);
axes1 = gca;
box(axes1,'on');
hold(axes1,'all');

%% do the plotting
plot1 = plot(1000*om_hr(46:1:91),[rhom_FeSe_hr;rhom_FeSe_hr_abs],'Parent',axes1);
set(plot1(1),'Marker','o','DisplayName','\Delta_{+-}');
set(plot1(2),'Marker','square','DisplayName','\Delta_{++}');

plot2 = plot(1000*om(31:1:61),[rhom_FeSe;rhom_FeSe_abs],'Parent',axes1,'LineStyle','--');
set(plot2(1),'Marker','*','DisplayName','\Delta_{+-}');
set(plot2(2),'Marker','+','DisplayName','\Delta_{++}');

% Create xlabel
xlabel('\omega (meV)','FontSize',20);

% Create ylabel
ylabel('\rho_-^X(\omega) (1/eV)','FontSize',20);

% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.700967261904757 0.496577380952382 0.142410714285714 0.385069444444445]);

%% plot the zero line
plot(om(31:1:61),[rhom_FeSe*0],'--')