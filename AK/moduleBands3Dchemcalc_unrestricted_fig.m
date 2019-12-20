




function [bandmat,bandmata,bandmatb]=moduleBands3Dchemcalc_unrestricted_fig(kx,ky,kz,nband,t1)

%persistent  c2x c2y cx cy cz delta func hk iband ii imu info inu ix iy lwork n nb  ng oner rwork s2x s2y sx sy sz u2trafo utrafo w work ; 

%bands3d;

% Siggi's 3D 5band model for the 122 system(fit to Cao's LDA)
%=============================================================

%use types
%use mpi


%#ifdef USE_MPI
%    include 'mpif.h'
%#endif

%type(modelpara),intent(in)           :: model
% k=zeros(1,3);
% ek=zeros(1,5);
% ev=zeros(5,5);
% if isempty(n), n=81; end;
% if isempty(ng), ng=5; end;
% if isempty(nb), nb=n; end;
% %if isempty(nband), nband=10 ; end;
% 
% 
  bandmat=zeros(10,10,'like',1i); 
   bandmata=zeros(5,5,'like',1i);
     bandmatb=zeros(5,5,'like',1i);
% 
% 
% if isempty(func), func=0; end;
% 
% 
% if isempty(cx), cx=0; end;
% if isempty(cy), cy=0; end;
% if isempty(cz), cz=0; end;
% if isempty(c2x), c2x=0; end;
% if isempty(c2y), c2y=0; end;
% if isempty(sx), sx=0; end;
% if isempty(sy), sy=0; end;
% if isempty(sz), sz=0; end;
% if isempty(s2x), s2x=0; end;
% if isempty(s2y), s2y=0; end;
% 
% if isempty(oner), oner=1.0; end;
% if isempty(ii), ii = complex(0.0,oner); end;
% 
% if isempty(imu), imu=0; end;
% if isempty(inu), inu=0; end;
% if isempty(ix), ix=0; end;
% if isempty(iy), iy=0; end;
% if isempty(iband), iband=0; end;
% if isempty(hk), hk=zeros(5,5); end;
% if isempty(w), w=zeros(1,5); end;
% if isempty(rwork), rwork=zeros(1,13); end;
% if isempty(delta), delta=0; end;
% if isempty(utrafo), utrafo=zeros(5,5); end;
% if isempty(u2trafo), u2trafo=zeros(5,5); end;
% if isempty(work), work=zeros(1,5.*64); end;
% if isempty(lwork), lwork=64.*5; end;
% %if isempty(info), info=0; end;


%      DEFINE CONSTANTS

%pi = acos(-1.0d0);

if (nband==10)
k1=kx;
k2=ky;
 kx=0.5*(k1-k2);
    ky=0.5*(k1+k2);
end;

k1=kx+ky;
k2=ky-kx;

%fl1=1.0d0;

re=1.0d0./6.0d0;
fact=2.0d0./3.0d0;

if nargin < 5
    load('t1.mat');
% %end;
% param.deltas=-0.012;
% param.deltad=0.012;
% param.deltadtw=0.025.*0;
% 
% param.chempot=-0.002;
% 
% %with - band goes up
% param.gshift=0.025 -0.002+0.003              -0.015;
% %with- moves up
% param.zshift=0.022-0.001+0.004-0.003 +0.002  -0.015;
% 
% %with + moves down
% param.mshift=-0.0027+0.0002+0.0062-0.0031;
% %with + moves up
% param.ashift=0.03-0.0002-0.005+0.003;
% 
% %with - band goes up
% param.xyshift=0.008-0.002-0.013-0.0052+0.005+0.0016;
% %with- goes down
% param.zxyshift=0.014+0.011+0.0025+0.015 -0.006 -0.002;
end


t33z=t1(1);
t33xz=t1(2);
t33yz=t1(3);
t33xxz=t1(4);
t33yyz=t1(5);
t33xxyz=t1(6);
t33xyyz=t1(7);
t33x=t1(8);
t33y=t1(9);
t33xx=t1(10);
t33yy=t1(11);
t33xy=t1(12);
t33xxy=t1(13);
t33xyy=t1(14);
t33xxyy=t1(15);
t22x=t1(16);
t22xy=t1(17);
t11z=t1(18);
t11xz=t1(19);
t11xxz=t1(20);
t11xyz=t1(21);
t11xxyz=t1(22);
t11x=t1(23);
t11xx=t1(24);
t11xy=t1(25);
t11xxy=t1(26);
t34xz=t1(27);
t34xy=t1(28);
t23x=t1(29);
t23xy=t1(30);
t13xz=t1(31);
t13yz=t1(32);
t13xxyz=t1(33);
t13yyz=t1(34);
t13x=t1(35);
t13xy=t1(36);
t35x=t1(37);
t35xy=t1(38);
t25x=t1(39);
t15xy=t1(40);
% #49 is chemical potential (additional fit parameter)
eps10=t1(41)-t1(49)./re;
eps20=t1(42)-t1(49)./(re.*fact);
eps30=t1(43)+t1(46)./re-t1(49)./re;
%keep the on-site energy the same, splitting from t(46)
eps40=t1(43)-t1(46)./re-t1(49)./re;
eps50=t1(45)-t1(49)/(re.*fact);
if numel(t1)>49
    tsoc=t1(50)./re;
else
    tsoc=0;
end
% t1(46)=-0.012;
% t1(47)=0.012;
% t1(48)=0.025.*0;

%param.deltas=t1(46);
param.deltad=t1(47);
param.deltadtw=t1(48);


if(nband==5)
for sa=1:-2:-1


%sa=-1.0d0;
saz=sa;%-1.0d0;
sh=1.0d0;
od=0.0d0;
es=1.0;
%        re=1.0d0/6.0d0
sw=1.0d0;
swold=0.0d0;
%        fact=2.0/3.0

%      convert to real xz/yz orbitals.
z=complex(0.0d0,-1.0d0);

t23x=z.*t23x;
t23xy=z.*t23xy;
t13xz=z.*t13xz;
t13yz=z.*t13yz;
t13xxyz=z.*t13xxyz;
t13yyz=z.*t13yyz;
t13x=z.*t13x;
t13xy=z.*t13xy;
t35x=-z.*t35x;
t35xy=-z.*t35xy;

% cx=cos(kx);
% cy=cos(ky);
% cz=cos(kz);
% sx=sin(kx);
% sy=sin(ky);
% sz=sin(kz);
% c2x=cos(2.0d0.*kx);
% c2y=cos(2.0d0.*ky);

epsilon33=(4.0d0.*t33xy.*cos(kx).*cos(ky) +2.0d0.*t33xx.*cos(2.0d0.*kx) +2.0d0.*t33yy.*cos(2.0d0.*ky) +4.0d0.*t33xxyy.*cos(2.0d0.*kx).*cos(2.0d0.*ky) +2.0d0.*t33z.*cos(kz).*sh+4.0d0.*t33xxz.*cos(2.0d0.*kx).*cos(kz).*sh+4.0d0.*t33yyz.*cos(2.0d0.*ky).*cos(kz).*sh+eps30) +2.0d0.*(t33x-param.deltadtw./2.0d0.*1.0d0./re-param.deltad./2.0d0.*1.0d0./re).*cos(kx).*sa +2.0d0.*(t33y-param.deltad./2.0d0.*1.0d0./re).*cos(ky).*sa +4.0d0.*t33xxy.*cos(2.0d0.*kx).*cos(ky).*sa +4.0d0.*t33xyy.*cos(2.0d0.*ky).*cos(kx).*sa +4.0d0.*t33xz.*cos(kx).*cos(kz).*saz+4.0d0.*t33yz.*cos(ky).*cos(kz).*saz+(2.0d0.*t33xxyz.*(cos(k1+kx)+cos(k2-kx)).*cos(kz).*saz+2.0d0.*t33xyyz.*(cos(k1+ky)+cos(k2+ky)).*cos(kz).*saz)+saz.*complex(0.0d0,1.0d0).*od.*(2.0d0.*t33xxyz.*(cos(k1+kx)-cos(k2-kx)).*sin(kz)+2.0d0.*t33xyyz.*(cos(k1+ky)-cos(k2+ky)).*sin(kz));


epsilon44=( 4.0d0.*t33xy.*cos(kx).*cos(ky) +2.0d0.*t33yy.*cos(2.0d0.*kx) +2.0d0.*t33xx.*cos(2.0d0.*ky) +4.0d0.*t33xxyy.*cos(2.0d0.*kx).*cos(2.0d0.*ky) +2.0d0.*t33z.*cos(kz).*sh+4.0d0.*t33yyz.*cos(2.0d0.*kx).*cos(kz).*sh+4.0d0.*t33xxz.*cos(2.0d0.*ky).*cos(kz).*sh+eps40)+2.0d0.*(t33y+param.deltadtw./2.0d0.*1.0d0./re+param.deltad./2.0d0.*1.0d0./re).*cos(kx).*sa +2.0d0.*(t33x+param.deltad./2.0d0.*1.0d0./re).*cos(ky).*sa +4.0d0.*t33xyy.*cos(2.0d0.*kx).*cos(ky).*sa +4.0d0.*t33xxy.*cos(2.0d0.*ky).*cos(kx).*sa+4.0d0.*t33yz.*cos(kx).*cos(kz).*saz+4.0d0.*t33xz.*cos(ky).*cos(kz).*saz+(2.0d0.*t33xyyz.*(cos(k1+kx)+cos(k2-kx)).*cos(kz).*saz+2.0d0.*t33xxyz.*(cos(k1+ky)+cos(k2+ky)).*cos(kz).*saz)+saz.*complex(0.0d0,1.0d0).*od.*(2.0d0.*t33xyyz.*(cos(k1+kx)-cos(k2-kx)).*sin(kz)+2.0d0.*t33xxyz.*(cos(k1+ky)-cos(k2+ky)).*sin(kz));


epsilon22=(2.0d0.*t22x.*(cos(kx) + cos(ky)).*sa +4.0d0.*t22xy.*cos(kx).*cos(ky)+eps20);


epsilon11=( 4.0d0.*t11xy.*cos(kx).*cos(ky) +2.0d0.*t11xx.*(cos(2.0d0.*kx)+cos(2.0d0.*ky)) +2.0d0.*t11z.*cos(kz).*sh+8.0d0.*t11xyz.*cos(kx).*cos(ky).*cos(kz).*sh+4.0d0.*t11xxz.*(cos(2.0d0.*kx)+cos(2.0d0.*ky)).*cos(kz).*sh+eps10)+2.0d0.*t11x.*(cos(kx) + cos(ky)).*sa +4.0d0.*t11xxy.*(cos(2.0d0.*kx).*cos(ky)+cos(2.0d0.*ky).*cos(kx)).*sa+4.0d0.*t11xz.*(cos(kx)+cos(ky)).*cos(kz).*saz+2.0d0.*t11xxyz.*( cos(k1+ky)+cos(k1+kx)+cos(k2+ky)+cos(k2-kx)  ).*cos(kz).*saz+saz.*complex(0.0d0,1.0d0).*od.*2.0d0.*t11xxyz.*( cos(k1+ky) + cos(k1+kx) -cos(k2+ky) - cos(k2-kx)  ).*sin(kz);

epsilon55= eps50;

epsilon34= -4.0d0.*t34xy.*sin(kx).*sin(ky)+od.*saz.*4.0d0.*t34xz.*(cos(kx)+cos(ky)).*sin(kz).*complex(0.0d0,1.0d0)+2.0d0.*complex(0.0d0,1.0d0).*tsoc;

epsilon23=complex(0.0d0,1.0d0).*(-2.0d0.*t23x.*sin(ky).*sa +4.0d0.*t23xy.*sin(ky).*cos(kx) );

epsilon13=complex(0.0d0,1.0d0).*4.0d0.*t13xy.*cos(ky).*sin(kx)-4.0d0.*t13yyz.*sin(2.0d0.*ky).*sin(kz).*sh+complex(0.0d0,1.0d0).*2.0d0.*t13x.*sin(kx).*sa+((-4.0d0.*t13xz.*sin(kx).*sin(kz)-4.0d0.*t13yz.*sin(ky).*sin(kz)-2.0d0.*t13xxyz.*(sin(k1+ky)+sin(k2+ky)).*sin(kz))+2.0d0.*t13xxyz.*(sin(k1+ky)-sin(k2+ky)).*cos(kz).*complex(0.0d0,1.0d0)).*saz.*od;

epsilon35=complex(0.0d0,1.0d0).*(2.0d0.*t35x.*sin(ky).*sa+4.0d0.*t35xy.*sin(ky).*cos(kx));

epsilon24=complex(0.0d0,1.0d0).*(2.0d0.*t23x.*sin(kx).*sa -4.0d0.*t23xy.*sin(kx).*cos(ky));

epsilon14=  complex(0.0d0,1.0d0).*4.0d0.*t13xy.*cos(kx).*sin(ky)-4.0d0.*t13yyz.*sin(2.0d0.*kx).*sin(kz).*sh+2.0d0.*t13x.*sin(ky).*sa.*complex(0.0d0,1.0d0)+( -4.0d0.*t13xz.*sin(ky).*sin(kz)-4.0d0.*t13yz.*sin(kx).*sin(kz)-2.0d0.*t13xxyz.*(sin(k1+kx)-sin(k2-kx)).*sin(kz)+2.0d0.*t13xxyz.*(sin(k1+kx)+sin(k2-kx)).*cos(kz).*complex(0.0d0,1.0d0)).*saz.*od;

epsilon45= complex(0.0d0,1.0d0).*(2.0d0.*t35x.*sin(kx).*sa +4.0d0.*t35xy.*sin(kx).*cos(ky));
% add spin orbit coupling also here!
epsilon12=-4.0d0.*complex(0.0d0,1.0d0).*tsoc;

epsilon25= 2.0d0.*t25x.*(cos(kx) - cos(ky)).*sa;


epsilon15= -4.0d0.*t15xy.*sin(kx).*sin(ky);




bandmata(1,1) = epsilon11;
bandmata(1,2) = epsilon12;
bandmata(1,3) = epsilon13;
bandmata(1,4) = epsilon14;
bandmata(1,5) = epsilon15;
bandmata(2,1) = conj(epsilon12);
bandmata(2,2) = epsilon22.*fact;
bandmata(2,3) = epsilon23;
bandmata(2,4) = epsilon24;
bandmata(2,5) = epsilon25.*fact;
bandmata(3,1) = conj(epsilon13);
bandmata(3,2) = conj(epsilon23);
bandmata(3,3) = epsilon33; %added above  + param.deltas./re;
bandmata(3,4) = epsilon34;
bandmata(3,5) = epsilon35;
bandmata(4,1) = conj(epsilon14);
bandmata(4,2) = conj(epsilon24);
bandmata(4,3) = conj(epsilon34);
bandmata(4,4) = epsilon44;% added above  - param.deltas./re;
bandmata(4,5) = epsilon45;
bandmata(5,1) = conj(epsilon15);
bandmata(5,2) = conj(epsilon25).*fact;
bandmata(5,3) = conj(epsilon35);
bandmata(5,4) = conj(epsilon45);
bandmata(5,5) = epsilon55.*fact;


for iz=1:5;
for jz=1:5;
bandmata(iz,jz)=bandmata(iz,jz).*re;
end;
end;
if saz==1
    bandmatb=bandmata;
end;

end
end;




%****************************************************************
if(nband==10)
 kx=0.5*(k1-k2);
    ky=0.5*(k1+k2);
k1=kx+ky;
k2=ky-kx;

sa=1.0d0;
saz=1.0d0;
sh=1.0d0;
od=1.0d0;
es=1.0;
%        re=1.0d0/6.0d0
sw=1.0d0;
swold=0.0d0;
%        fact=2.0/3.0


epsilon33=(4.0d0.*t33xy.*cos(kx).*cos(ky) +2.0d0.*t33xx.*cos(2.0d0.*kx) +2.0d0.*t33yy.*cos(2.0d0.*ky) +4.0d0.*t33xxyy.*cos(2.0d0.*kx).*cos(2.0d0.*ky) +2.0d0.*t33z.*cos(kz)+4.0d0.*t33xxz.*cos(2.0d0.*kx).*cos(kz)+4.0d0.*t33yyz.*cos(2.0d0.*ky).*cos(kz)+eps30);

epsilon38=2.0d0.*(t33x-param.deltadtw./2.0d0.*1.0d0./re-param.deltad./2.0d0.*1.0d0./re).*cos(kx).*sa +2.0d0.*(t33y-param.deltad./2.0d0.*1.0d0./re).*cos(ky).*sa +4.0d0.*t33xxy.*cos(2.0d0.*kx).*cos(ky).*sa +4.0d0.*t33xyy.*cos(2.0d0.*ky).*cos(kx).*sa +4.0d0.*t33xz.*cos(kx).*cos(kz).*saz+4.0d0.*t33yz.*cos(ky).*cos(kz).*saz+2.0d0.*t33xxyz.*(cos(k1+kx)+cos(k2-kx)).*cos(kz).*saz+2.0d0.*t33xyyz.*(cos(k1+ky)+cos(k2+ky)).*cos(kz).*saz+saz.* complex(0.0d0,1.0d0).*(2.0d0.*t33xxyz.*(cos(k1+kx)-cos(k2-kx)).*sin(kz)+2.0d0.*t33xyyz.*(cos(k1+ky)-cos(k2+ky)).*sin(kz));


epsilon44=( 4.0d0.*t33xy.*cos(kx).*cos(ky) +2.0d0.*t33yy.*cos(2.0d0.*kx) +2.0d0.*t33xx.*cos(2.0d0.*ky) +4.0d0.*t33xxyy.*cos(2.0d0.*kx).*cos(2.0d0.*ky) +2.0d0.*t33z.*cos(kz)+4.0d0.*t33yyz.*cos(2.0d0.*kx).*cos(kz)+4.0d0.*t33xxz.*cos(2.0d0.*ky).*cos(kz)+eps40);


epsilon49=2.0d0.*(t33y+param.deltadtw./2.0d0.*1.0d0./re+param.deltad./2.0d0.*1.0d0./re).*cos(kx).*sa +2.0d0.*(t33x+param.deltad./2.0d0.*1.0d0./re).*cos(ky).*sa +4.0d0.*t33xyy.*cos(2.0d0.*kx).*cos(ky).*sa +4.0d0.*t33xxy.*cos(2.0d0.*ky).*cos(kx).*sa+4.0d0.*t33yz.*cos(kx).*cos(kz).*saz+4.0d0.*t33xz.*cos(ky).*cos(kz).*saz+2.0d0.*t33xyyz.*(cos(k1+kx)+cos(k2-kx)).*cos(kz).*saz+2.0d0.*t33xxyz.*(cos(k1+ky)+cos(k2+ky)).*cos(kz).*saz+saz.*complex(0.0d0,1.0d0).*(2.0d0.*t33xyyz.*(cos(k1+kx)-cos(k2-kx)).*sin(kz)+2.0d0.*t33xxyz.*(cos(k1+ky)-cos(k2+ky)).*sin(kz));



epsilon22=( 4.0d0.*t22xy.*cos(kx).*cos(ky)+eps20).*complex(1.0d0,0.0d0);

epsilon27=(2.0d0.*t22x.*(cos(kx) + cos(ky))).*sa;


epsilon11=( 4.0d0.*t11xy.*cos(kx).*cos(ky) +2.0d0.*t11xx.*(cos(2.0d0.*kx)+cos(2.0d0.*ky)) +2.0d0.*t11z.*cos(kz)+8.0d0.*t11xyz.*cos(kx).*cos(ky).*cos(kz)+4.0d0.*t11xxz.*(cos(2.0d0.*kx)+cos(2.0d0.*ky)).*cos(kz)+eps10);


epsilon16=2.0d0.*t11x.*(cos(kx) + cos(ky)).*sa +4.0d0.*t11xxy.*(cos(2.0d0.*kx).*cos(ky)+cos(2.0d0.*ky).*cos(kx)).*sa+4.0d0.*t11xz.*(cos(kx)+cos(ky)).*cos(kz).*saz+2.0d0.*t11xxyz.*( cos(k1+ky)+cos(k1+kx)+cos(k2+ky)+cos(k2-kx)  ).*cos(kz).*saz+saz.*complex(0.0d0,1.0d0).*2.0d0.*t11xxyz.*( cos(k1+ky) + cos(k1+kx) -cos(k2+ky) - cos(k2-kx)  ).*sin(kz);


epsilon55= eps50;

epsilon510=0.0d0;

epsilon34= -4.0d0.*t34xy.*sin(kx).*sin(ky)+tsoc;

epsilon39= sa.*4.0d0.*t34xz.*(cos(kx)+cos(ky)).*sin(kz).*complex(0.0d0,1.0d0)-tsoc;

epsilon23=  complex(0.0d0,1.0d0).*4.0d0.*t23xy.*sin(ky).*cos(kx);

epsilon28= -complex(0.0d0,1.0d0).*2.0d0.*t23x.*sin(ky).*sa;

epsilon13= complex(0.0d0,1.0d0).*4.0d0.*t13xy.*cos(ky).*sin(kx)-4.0d0.*t13yyz.*sin(2.0d0.*ky).*sin(kz);

epsilon18=complex(0.0d0,1.0d0).*2.0d0.*t13x.*sin(kx).*sa+(-4.0d0.*t13xz.*sin(kx).*sin(kz)-4.0d0.*t13yz.*sin(ky).*sin(kz)-2.0d0.*t13xxyz.*(sin(k1+ky)+sin(k2+ky)).*sin(kz)+2.0d0.*t13xxyz.*(sin(k1+ky)-sin(k2+ky)).*cos(kz).*complex(0.0d0,1.0d0)).*saz;

epsilon35= complex(0.0d0,1.0d0).*4.0d0.*t35xy.*sin(ky).*cos(kx);

epsilon310=2.0d0.*t35x.*sin(ky).*sa.*complex(0.0d0,1.0d0);

epsilon24= -complex(0.0d0,1.0d0).*4.0d0.*t23xy.*sin(kx).*cos(ky);

epsilon29=2.0d0.*t23x.*sin(kx).*sa.*complex(0.0d0,1.0d0);

epsilon14= complex(0.0d0,1.0d0).*4.0d0.*t13xy.*cos(kx).*sin(ky)-4.0d0.*t13yyz.*sin(2.0d0.*kx).*sin(kz);

epsilon19=2.0d0.*t13x.*sin(ky).*sa.*complex(0.0d0,1.0d0)+(-4.0d0.*t13xz.*sin(ky).*sin(kz)-4.0d0.*t13yz.*sin(kx).*sin(kz)-2.0d0.*t13xxyz.*(sin(k1+kx)-sin(k2-kx)).*sin(kz)+2.0d0.*t13xxyz.*(sin(k1+kx)+sin(k2-kx)).*cos(kz).*complex(0.0d0,1.0d0)).*saz;

epsilon45= complex(0.0d0,1.0d0).*4.0d0.*t35xy.*sin(kx).*cos(ky);

epsilon410=2.0d0.*t35x.*sin(kx).*sa.*complex(0.0d0,1.0d0);

epsilon12=complex(0.0d0,0.0d0);

epsilon17=0.0d0;

epsilon25=0.0d0;

epsilon210= 2.0d0.*t25x.*(cos(kx) - cos(ky)).*sa;


epsilon15= -4.0d0.*t15xy.*sin(kx).*sin(ky);

epsilon110=0.0d0;




bandmat(1,1) = epsilon11;
bandmat(1,2) = epsilon12;
bandmat(1,3) = epsilon13;
bandmat(1,4) = epsilon14;
bandmat(1,5) = epsilon15;
bandmat(1,6) = epsilon16;
bandmat(1,7) = epsilon17;
bandmat(1,8) = epsilon18;
bandmat(1,9) = epsilon19;
bandmat(1,10) = epsilon110;

bandmat(2,1) = conj(epsilon12);
bandmat(2,2) = epsilon22.*fact;
bandmat(2,3) = epsilon23;
bandmat(2,4) = epsilon24;
bandmat(2,5) = epsilon25.*fact;
bandmat(2,6) = epsilon17;
bandmat(2,7) = epsilon27.*fact;
bandmat(2,8) = epsilon28;
bandmat(2,9) = epsilon29;
bandmat(2,10) = epsilon210.*fact;


bandmat(3,1) = conj(epsilon13);
bandmat(3,2) = conj(epsilon23);
bandmat(3,3) = epsilon33 ; %added above + param.deltas./re;
bandmat(3,4) = epsilon34;
bandmat(3,5) = epsilon35;
bandmat(3,6) = epsilon18;
bandmat(3,7) = epsilon28;
bandmat(3,8) = epsilon38;
bandmat(3,9) = epsilon39;
bandmat(3,10) = epsilon310;



bandmat(4,1) = conj(epsilon14);
bandmat(4,2) = conj(epsilon24);
bandmat(4,3) = conj(epsilon34);
bandmat(4,4) = epsilon44; % added above - param.deltas./re;
bandmat(4,5) = epsilon45;
bandmat(4,6) = epsilon19;
bandmat(4,7) = epsilon29;
bandmat(4,8) = epsilon39;
bandmat(4,9) = epsilon49;
bandmat(4,10) = epsilon410;

bandmat(5,1) = conj(epsilon15);
bandmat(5,2) = conj(epsilon25).*fact;
bandmat(5,3) = conj(epsilon35);
bandmat(5,4) = conj(epsilon45);
bandmat(5,5) = epsilon55.*fact;
bandmat(5,6) = epsilon110;
bandmat(5,7) = epsilon210.*fact;
bandmat(5,8) = epsilon310;
bandmat(5,9) = epsilon410;
bandmat(5,10) = epsilon510.*fact;

for ib=6:10;
for jb=1:5;
bandmat(ib,jb)=conj(bandmat(ib-5,jb+5));
end; 
end; 

for ib=6:10;
for jb=6:10;
bandmat(ib,jb)=conj(bandmat(ib-5,jb-5));
end; 
end; 

for ib=1:10;
for jb=1:10;
bandmat(ib,jb)=bandmat(ib,jb).*re;
end;
end;
end;



end %subroutine





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% extra functions as needed by the translation %%%%%%%%%%%

