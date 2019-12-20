function meanspec=local_average_average(data,topo,radius,xyvect)

n=max(size(xyvect));
avespec_grad=zeros(n,length(data.e));


for i=1:n


avespec_grad(i,:)=local_average_spectra(data,topo,radius,xyvect(1,i),xyvect(2,i));

end
meanspec=mean(avespec_grad,1);
maxspec=max(avespec_grad,[],1);
minspec=min(avespec_grad,[],1);
% figure;
% plot(data.e,minspec,'r-o',data.e,meanspec,'k-o',data.e,maxspec,'b-o','linewidth',2)
% legend('min. value','average','max. value')

lower=meanspec-minspec;
upper=maxspec-meanspec;
figure;
errorbar(data.e,meanspec,lower,upper,'b.-','linewidth',2);
hold on
plot(data.e,meanspec,'b.-','linewidth',3)
plot(data.e,minspec,'b-.',data.e,maxspec,'b-.','linewidth',2)
legend('average')
title('Average Spectrum of all vortex centers','fontsize',20,'fontweight','b')
xlabel('V [V]','fontsize',12,'fontweight','b')
ylabel('dI/dV [arb. u.]','fontsize',12,'fontweight','b')
axis([min(data.e) max(data.e) min(minspec)-1 max(maxspec)+1])
% legend('average','min. value','max. value')
hold off
a=1;


end