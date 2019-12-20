% 2019-10-4 YXC


E_meV = linspace(-1,1,1001);
T = linspace(0,3,101);

Tlist = linspace(0,3,13);
figure,

for i = 1:length(Tlist)
    R = i/(length(Tlist)+1);
    B = 1-R;
	plot(E_meV,Fermi_Dirac_deriv(E_meV,Tlist(i)),'Color',[R,0,B])
    hold on
end
xlabel('E(meV)')
ylabel('$\left( \frac{\partial{f}}{\partial{E}} \right)$ ','Interpreter','latex')
legend(num2str(Tlist'))
title('$\frac{\partial f}{\partial E}$ at different T','Interpreter','latex' )

figure,plot(T,Fermi_Dirac_deriv_FWHM(T))
hold on
title('FWHM(meV) of $\frac{\partial f}{\partial E}$ at different $T$','Interpreter','latex')
xlabel('T(K)')
ylabel('E(meV)')
