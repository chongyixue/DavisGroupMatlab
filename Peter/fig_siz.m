function fig_siz(siz)

set(gcf,'units','centimeters')
pos=get(gcf,'position');
pos=pos(:);
% pos(3:4)=siz(:);
posold = pos(3:4);
pos(3:4)=siz(:);
posdiff = posold - pos(3:4);
pos(1:2) = pos(1:2) + posdiff;
set(gcf,'position',pos)
prepprint

