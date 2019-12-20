function [y_new, x_fit, p]=lorentzian_fit_v2(r,y,a,b,guess)
% range is [left right]

left_index = find(r>a,1);
right_index = find(r<b,1,'last');
x_fit = r(left_index:right_index); 
y_fit = y(left_index:right_index);



lrntz = 'a/((x-b)^2+c^2)+d';
low = [guess(1:3)*0.2 -Inf];
upp = [guess(1:3)*5 Inf];
for i=1:3
    if(low(i)>upp(i))
        temp = low(i);
        low(i) = upp(i);
        upp(i)=temp;
    end
end

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',guess,...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-6,...
    'MaxIter',10000,...
    'MaxFunEvals', 10000,...
    'Lower',low,...
    'Upper',upp);

f = fittype(lrntz,'options',s);
[p,gof] = fit(x_fit,y_fit,f);
p
% c = coeffvalues(p);
% peak1 = c(2);
y_new = feval(p,x_fit);
%figure(70), plot(x,y,'.k',x,y_new,'-r');
% figure(70), plot(x,y,'.k',x_fit,y_new,'-r');
% %figure(70), plot(x,y_test,'.k')
% hold on 
% plot([peak1 peak1],ylim,'-g');
% hold off
%figure, plot(x,cumsum(y),'.k');
%title([num2str(e) 'mV ' 'single peak']);
%pause(0.5);
end