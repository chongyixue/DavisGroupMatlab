%make spectrum from points on map.
%2 March 2017 

function  spectrumplot(map,px,py,linewidth)
y=squeeze(map.map(py,px,:));
figure,plot(map.e*1000,y,'-k','LineWidth',linewidth)
%*1000 to make it mV, -line, k black
xlabel('bias (mV)');
ylabel('dI/dV (nS)');
str = strcat('spectrum at (',int2str(px),',',int2str(py),')');
title(str);
end 