function read_map(file,name,typ)
dir='';

switch typ
    case 'didv'     %1FL
        type=0
    case 'current'  %FFL
        type=1
    case 'topo'
        type=2
end

% type:
% 0=didv
% 1 =current: he does not do the LI-factor
%2 = topo+ no factor, and he does differtn names.

% get additiaonal params
hs=read_map_extra([dir file]);


s=hs.irows;
% get data
fid=fopen([dir file],'r');
a=fread(fid,'uint16');
a=a(1057:length(a)); 
h=(length(a)-1300)/s^2
map=zeros(s,s,h);
for j=1:h;
    
    for i=1:s;
       map(:,i,j)=a( ((i-1)*s+1)+(j-1)*s^2 :i*s+(j-1)*s^2);
    end
    
end
    assignin('base','a',a);
fclose(fid);

%transpose data
[sy, sx,sz]=size(map);
for j=1:sz
    map(:,:,j)=flipud(map(:,:,j)');
end




%file to volt
% standart values: w_zero=-10; w_factor= 3.0518e-04;
map=map*hs.w_factor+hs.w_zero;


%volt to nS : fsensitivity/10 / (ddriveAmp/100)* corrfactor* gainfactro
%no factor for current
if type==0
    hs.factor=((hs.li_sens/10)/(hs.li_amp/100)*1.495*11);
    map=map*hs.factor;
elseif type==1 || type==2
    hs.factor=1;
end


[sy, sx,sz]=size(map);

if type==0 || type ==1
    dist=hs.xdist;
    assignin('base',[name 'Map' ],map);

    ave=squeeze(sum(sum(map)))/s/s;
    assignin('base',[name 'Ave' ],ave);
    
    k=2*pi/3.87*hs.irows*hs.xdist;
    k=linspace(0,k,s);
      assignin('base',[name 'K' ],k);
    
    
   
    dist=linspace(0,dist,s)';
    assignin('base',[name 'R' ],dist);
    
%    [fftt,k0]=fourier_block(map,max(dist));
 %    assignin('base',[name 'FFT' ],fftt);
     
    en=linspace(hs.s_startvolt,hs.s_endvolt,hs.ilayers);
    assignin('base',[name 'E' ],en'*1000);

    assignin('base',[ name 'Info'],hs);

elseif type == 2
    
%    dist=hs.distx;
 %   dist=linspace(0,dist,s)';
  %  assignin('base',[name 'R' ],dist);
    
    assignin('base',[name 'Topo' ],map);
    
    map=prep_topo(map);
    assignin('base',[name 'Ts' ],map);
    
    assignin('base',[ name 'Info'],hs);
end

hs


