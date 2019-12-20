function plot_tesla_spec(ev,spec0T,spec05T,spec1T,spec2T,spec3T,spec4T,spec6T)



figure; 
hold on
plot(ev,spec0T,'k+-','LineWidth',2,'MarkerSize',10);
plot(ev,spec05T,'r+-','LineWidth',2,'MarkerSize',10);
plot(ev,spec1T,'b+-','LineWidth',2,'MarkerSize',10);
plot(ev,spec2T,'m+-','LineWidth',2,'MarkerSize',10);
plot(ev,spec3T,'c+-','LineWidth',2,'MarkerSize',10);
plot(ev,spec4T,'ko-','LineWidth',2,'MarkerSize',10);
plot(ev,spec6T,'bo-','LineWidth',2,'MarkerSize',10);
title('Without damage tracks and vortices');
legend('ave. spec. 0 T','ave. spec. 0.5 T',...,
    'ave. spec. 1 T','ave. spec. 2 T',...,
    'ave. spec. 3 T','ave. spec. 4 T',...,
    'ave. spec. 6 T','Location','Northwest');
% legend('ave. spec. 0.5 T',...,
%     'ave. spec. 1 T','ave. spec. 2 T',...,
%     'ave. spec. 3 T','ave. spec. 4 T',...,
%     'ave. spec. 6 T','Location','Northwest');
xlabel('Energy [meV]');
ylabel('dI/dV [arb. u.]');
xlim([min(ev), max(ev)]); 
hold off

end