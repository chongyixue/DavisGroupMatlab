% returns the running average to smooth out spectrum
% 2018-9-13
% Nsmooth is the number of number of neighbors left(or right)


function y_smooth = running_average(map,px,py,Nsmooth,plot_ornot)

% px =79;py=1;
shiftup = 0;

y=squeeze(map.map(py,px,:));
% smooth out the spectrum, Nsmooth is number of neighbor to the left(and
% right, symmetrically to use for smoothening
running_sum = 0;
eend = size(y,1);
for p=1:eend
    if p<=Nsmooth
        onewing = p-1;
        running_sum = sum(y(p-onewing:p+onewing));     
        y_smooth(p) = running_sum/(2*onewing+1);
        running_sum = sum(y(1:p+Nsmooth));  
    elseif size(y)-Nsmooth<p
        onewing = eend-p;
        running_sum = sum(y(p-onewing:p+onewing));
        y_smooth(p) = running_sum/(2*onewing+1);
    else
        running_sum = running_sum + y(p+Nsmooth);
        y_smooth(p) = running_sum/(2*Nsmooth+1);
        running_sum = running_sum - y(p-Nsmooth);
    end
end


% FIX THIS PART
if plot_ornot==1
    figure,plot(map.e*1000,y_smooth+shiftup,'-k','LineWidth',0.1)
    hold on
    plot(map.e*1000,y,'-b','LineWidth',0.1)
    %*1000 to make it mV, -line, k black
    xlabel('bias (mV)');
    ylabel('dI/dV (nS)');
    str = strcat('spectrum at (',int2str(px),',',int2str(py),')');
    title(str);
end
