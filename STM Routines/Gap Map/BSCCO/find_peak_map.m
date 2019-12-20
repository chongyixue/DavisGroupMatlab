function gm=...
    find_peak_map(obj,varargin)


opt.erange=[-10 -2];
opt.range=2;
opt.crit_p1=90;
opt.crit_p2=0;
opt.order='abssmall';
opt.neg='on';
if nargin~=0
    opt=je_parse_pv_pairs(opt,varargin);
end

if strcmp(opt.neg,'on')
    obj.map=-obj.map;
end

obj=crop_map_energy(obj,opt.erange);
p=nan(obj.sy,obj.sx,5);
for j=1:obj.sy   
    for k=1:obj.sx
        %[j,k]
        imax=...
            find_peak_spectra(...
            obj.e,squeeze(obj.map(j,k,:))...
            ,opt.range,opt.crit_p2, ...
            opt.crit_p1, opt.order,0);
        p(j,k,:)=[imax(2),imax(3), imax(4),imax(6),imax(7)];
    end
end


% addidtional crit:
% exact value should not be too far from on exact

nrnan_orig=length(find(isnan(p(:,:,1))));
ind_c1=find(...
    .5*abs(p(:,:,1)-p(:,:,2))>...
    opt.range*abs(obj.e(2)-obj.e(1))...
    );
figure
nrnan_c1=length(ind_c1(:));
po=p;
p=po(:,:,2);
p(ind_c1)=nan;

ind_c1=[ind_c1',1];
assignin('base','tmpe',obj.e);
[tmp2,tmp1]=ind2sub([obj.sy,obj.sy],ind_c1(1))
assignin('base','tmps',squeeze(obj.map(tmp2,tmp1,:)));

nrnan_tot=length(find(isnan(p(:))));

str=['(orig nan, add nan, tot nan) [%]: (' ...
    num2str(100*nrnan_orig/obj.sx/obj.sy,'%2.0f') ...
    ', ' ...
    num2str(100*nrnan_c1/obj.sx/obj.sy,'%2.0f') ...
    ', ' ...
    num2str(100*nrnan_tot/obj.sx/obj.sy,'%2.0f') ...
    ')'];
disp(str);
pcolor(p); shading flat; colorbar
title(str)
gm.p=p;
gm.p2=po(:,:,4);
gm.p1=po(:,:,5);
gm.pvalue=po(:,:,3);
if strcmp('on',opt.neg)
    gm.pvalue=-gm.pvalue;
end
gm.opt=opt;
gm.nr_nan=[nrnan_orig,nrnan_c1,nrnan_tot];
gm.str_nan={'original nan','add crit','total'};
gm.strtitle=str;

