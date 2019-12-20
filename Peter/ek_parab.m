function ek=ek_parab(kf,vf,c,k)

[ky,kx]=ndgrid(k,k');


a=vf/2/kf;
b=a*kf^2;

ang=angle(kx+i*ky);
ek=a*(kx.^2+ky.^2)-b;
ek=ek+c*cos(4*ang);

% contour(k,k,ek,zz,'k')
% hold on
% contour(k,k,ek,[0 0],'r')
% hold off
% grid on
% axis equal