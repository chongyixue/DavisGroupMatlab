%put data into x and y (spectrum of a point in space)

function [x,y] = spectrumdata(obj_70228A00_G,pxlxx,pxlyy)

y=squeeze(obj_70228A00_G.map(pxlyy,pxlxx,:));
x=obj_70228A00_G.e*1000;

%figure,plot(x,y,'.','LineWidth',4)
%*1000 to make it mV, -line, k black
%xlabel('bias (mV)');
%ylabel('dI/dV (nS)');

end