function [c MN xedges yedges]=hist2d_maps(a,b,varargin)

opt.nr=100;
opt.limsa=[5 5];
opt.limsb=[5 5];
opt.nra=40;
opt.nrb=40;
opt.cut_off='on';

opt=je_parse_pv_pairs(opt,varargin);

[mia,maa]=...
   get_colormap_limits(a,...
   opt.limsa(1)/1000,opt.limsa(2)/1000,'h');
[mib,mab]=...
   get_colormap_limits(b,...
   opt.limsb(1)/1000,opt.limsb(2)/1000,'h');   

[sy,sx]=size(a);
av=a(:);
bv=b(:);
ind=find(isnan(av));
av(ind)=[];
bv(ind)=[];
ind=find(isnan(bv));
av(ind)=[];
bv(ind)=[];

if strcmp(opt.cut_off,'on')
    ind=find(av<mia | av > maa);
    av(ind)=[];
    bv(ind)=[];
    ind=find(bv<mib | bv > mab);
    av(ind)=[];
    bv(ind)=[];
end

[MN, xedges, yedges] = ...
    hist2d(av, bv,...
    linspace(mia,maa,opt.nra) , ...
    linspace(mib,mab,opt.nrb));

%figure; pcolor(xedges,yedges,MN/length(av)); shading flat;
figure; imagesc(xedges(1,:),yedges(:,1),flipud(MN)/length(av)); shading flat;
%figure; mesh(xedges,yedges,MN/length(av)); shading flat;
colormap hot
MN = MN/length(av);
%sty_dos
xlabel('Determined phase')
ylabel('CT gap(mV)')

c=corrcoef(av,bv);
c=c(2,1);

%title([ 'correlation = ' num2str(c) '. ' ] , 'fontsize', 20) 
