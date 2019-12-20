function vh_brute_force(data,field,width,length,vspec,lec,hec,rod,dmap)

load_color;
rawmap = data.map;

if strcmp(rod,'dmap')==1
    data.map = dmap;
end

gs = 5;
sig =1;
 

new_data = gauss_blur_image(data,gs,sig);

rawmapb = gauss_blur_image(rawmap,gs,sig);

vn = vortexnumber(field,width,length);

vn = round(vn);

cohlen = 80 / ( data.r(2)-data.r(1) );
cohlen = round(cohlen);
[nx, ny, le] = size(data.map);

for j = 1:le
    if data.e(j) == 0
        zlayer = j;
    end
    if data.e(j) == lec;
        leclay = j;
    end
    if data.e(j) == hec;
        heclay = j;
    end
end

x = zeros(vn,1);
y = zeros(vn,1);
xb = zeros(vn,1);
yb = zeros(vn,1);

xmin = zeros(vn,1);
ymin = zeros(vn,1);
xbmin = zeros(vn,1);
ybmin = zeros(vn,1);

spm = zeros(vn,1);
spmb = zeros(vn,1);
spmmin = zeros(vn,1);
spmbmin = zeros(vn,1);

tic


vspecip = interp1(vspec(:,1),vspec(:,2),data.e(leclay:heclay),'spline');
figure, plot(vspec(:,1),vspec(:,2),'r',data.e(leclay:heclay),vspecip,'bo','LineWidth',2,...
    'MarkerSize',10)
vspecip = vspecip / max(vspecip);
nel = size(vspecip,2);

avespec = zeros(nel,1);
avespecb = zeros(nel,1);
avespecmin = zeros(nel,1);
avespecminb = zeros(nel,1);

for i=1:vn
    [mvy, mvindy] = max(data.map(:,:,zlayer));
    [mvx, mvindx] = max(max(data.map(:,:,zlayer)));
    y(i) = mvindy(mvindx);
    x(i) = mvindx;
    [mvby, mvbindy] = max(new_data.map(:,:,zlayer));
    [mvbx, mvbindx] = max(max(new_data.map(:,:,zlayer)));
    yb(i) = mvbindy(mvbindx);
    xb(i) = mvbindx;
    
%     toc
    if strcmp(rod,'dmap')==1
        
        cm = circlematrix(nx,cohlen,y(i),x(i));
        cm = double(cm);
        rm = ringmatrix(nx,cohlen,y(i),x(i),cohlen*sqrt(2));
        rm = double(rm);
    end
    
    spec = squeeze(rawmap(y(i), x(i),leclay :heclay));
    spec = spec/max(spec);
    avespec = avespec + spec;
    specb = squeeze(rawmapb(yb(i), xb(i),leclay :heclay));
    specb = specb/max(specb);
    avespecb = avespecb + specb;
     
    spm(i) = sum ( abs ( vspecip - spec'))/nel;
    spmb(i) = sum ( abs ( vspecip - specb'))/nel;
    
%     figure, plot(data.e(leclay:heclay),spec,'LineWidth',2); 
    
%     toc
    
    cm = circlematrix(nx,cohlen,y(i),x(i));
    cm = double(cm);
    cmo = ones(nx, ny) - cm;
    cmb = circlematrix(nx,cohlen,yb(i),xb(i));
    cmb = double(cmb);
    cmbo = ones(nx, ny) - cmb;
    
%     toc
    
%     figure, imagesc(cm)
%     axis image
%     figure, imagesc(cmo)
%     axis image
%     figure, imagesc(cmb)
%     axis image
%     figure, imagesc(cmbo)
%     axis image
    
%     img_plot2(new_data.map(:,:,zlayer),Cmap.Blue2);
    
    data.map(:,:,zlayer) = data.map(:,:,zlayer) .* cmo;
    new_data.map(:,:,zlayer) = new_data.map(:,:,zlayer) .* cmbo;
    
%     img_plot2(new_data.map(:,:,zlayer),Cmap.Blue2);
    if i==1
        rawmap2 = rawmap;
        rawmapb2 = rawmapb;
    end
    
%     
%     figure, imagesc(rawmap(:,:,zlayer))
%     figure, imagesc(rawmap2(:,:,zlayer))
%     figure, imagesc(rawmapb(:,:,zlayer))
%     figure, imagesc(rawmapb2(:,:,zlayer))
    
    
    t = 1;
    for k=leclay:heclay
        rrawmap(:,:,t) = rawmap2(:,:,k) .* cm;
        rrawmapb(:,:,t) = rawmapb2(:,:,k) .* cmb;
        vormat(:,:,t) = vspecip(t) * cm;
        vormatb(:,:,t) = vspecip(t) * cmb;
        t = t+1;
    end
    
    if i==2
        cmom = repmat(cmo,1,1,le);
        rawmap2 = rawmap2 .* cmom;
        cmbom = repmat(cmbo,1,1,le);
        rawmapb2 = rawmapb2 .* cmbom;
    end
    
    maxrr=max(rrawmap,[],3);
    maxrrr = repmat(maxrr,1,1,nel);
    rrawmap = rrawmap ./ maxrrr;
    
    maxrrb=max(rrawmapb,[],3);
    maxrrrb = repmat(maxrrb,1,1,nel);
    rrawmapb = rrawmapb ./ maxrrrb;
    
    minr = sum(abs(vormat - rrawmap),3)/nel;
    minrb = sum(abs(vormatb - rrawmapb),3)/nel;
    
    [mvymin, mvindymin] = min(minr);
    [mvxmin, mvindxmin] = min(min(minr));
    ymin(i) = mvindymin(mvindxmin);
    xmin(i) = mvindxmin;
    [mvbymin, mvbindymin] = min(minrb);
    [mvbxmin, mvbindxmin] = min(min(minrb));
    ybmin(i) = mvbindymin(mvbindxmin);
    xbmin(i) = mvbindxmin;
    
    spmmin(i) = minr(ymin(i),xmin(i));
    spmbmin(i) = minrb(ybmin(i),xbmin(i));
    
    specmin = squeeze(rawmap(ymin(i), xmin(i),leclay :heclay));
    specmin = specmin/max(specmin);
    avespecmin = avespecmin + specmin;
    specbmin = squeeze(rawmapb(ybmin(i), xbmin(i),leclay :heclay));
    specbmin = specbmin/max(specbmin);
    avespecminb = avespecminb + specbmin;
    
%     test=1;
%     toc
    
end

    img_plot2(new_data.map(:,:,zlayer),Cmap.Blue2);


toc

avespec = avespec/vn;
avespecb = avespecb/vn;
avespecmin = avespecmin/vn;
avespecminb = avespecminb/vn;
ev = data.e(leclay:heclay);
figure, plot(ev,vspecip,'b',ev,avespec,'r',ev,avespecmin,'k','LineWidth',2);
figure, plot(ev,vspecip,'b',ev,avespecb,'r',ev,avespecminb,'k','LineWidth',2);




img_plot2(rawmap(:,:,zlayer),Cmap.Blue2);
hold on

for i=1:vn
    
    if spm(i) <= 0.15
        line([x(i),x(i)],[y(i)-1,y(i)+1],'Linewidth',2,'Color','c');
        line([x(i)-1,x(i)+1],[y(i),y(i)],'Linewidth',2, 'Color','c');
    elseif spm(i) <= 0.25 && spm(i) > 0.15
        line([x(i),x(i)],[y(i)-1,y(i)+1],'Linewidth',2,'Color','y');
        line([x(i)-1,x(i)+1],[y(i),y(i)],'Linewidth',2, 'Color','y');
    elseif spm(i) <= 0.35 && spm(i) > 0.25
        line([x(i),x(i)],[y(i)-1,y(i)+1],'Linewidth',2,'Color','r');
        line([x(i)-1,x(i)+1],[y(i),y(i)],'Linewidth',2, 'Color','r');
    elseif spm(i) > 0.35
        line([x(i),x(i)],[y(i)-1,y(i)+1],'Linewidth',2,'Color','m');
        line([x(i)-1,x(i)+1],[y(i),y(i)],'Linewidth',2, 'Color','m');
    end
    
%     line([xmin(i),xmin(i)],[ymin(i)-1,ymin(i)+1],'Linewidth',2,'Color','r');
%     line([xmin(i)-1,xmin(i)+1],[ymin(i),ymin(i)],'Linewidth',2, 'Color','r');
    
    
    
end

hold off

img_plot2(rawmap(:,:,zlayer),Cmap.Blue2);
hold on

for i=1:vn
    
    if spm(i) <= 0.15
        line([xmin(i),xmin(i)],[ymin(i)-1,ymin(i)+1],'Linewidth',2,'Color','c');
        line([xmin(i)-1,xmin(i)+1],[ymin(i),ymin(i)],'Linewidth',2, 'Color','c');
    elseif spm(i) <= 0.25 && spm(i) > 0.15
        line([xmin(i),xmin(i)],[ymin(i)-1,ymin(i)+1],'Linewidth',2,'Color','y');
        line([xmin(i)-1,xmin(i)+1],[ymin(i),ymin(i)],'Linewidth',2, 'Color','y');
    elseif spm(i) <= 0.35 && spm(i) > 0.25
        line([xmin(i),xmin(i)],[ymin(i)-1,ymin(i)+1],'Linewidth',2,'Color','r');
        line([xmin(i)-1,xmin(i)+1],[ymin(i),ymin(i)],'Linewidth',2, 'Color','r');
    elseif spm(i) > 0.35
        line([xmin(i),xmin(i)],[ymin(i)-1,ymin(i)+1],'Linewidth',2,'Color','m');
        line([xmin(i)-1,xmin(i)+1],[ymin(i),ymin(i)],'Linewidth',2, 'Color','m');
    end
    
%     line([xmin(i),xmin(i)],[ymin(i)-1,ymin(i)+1],'Linewidth',2,'Color','r');
%     line([xmin(i)-1,xmin(i)+1],[ymin(i),ymin(i)],'Linewidth',2, 'Color','r');
    
    
    
end

hold off

toc 

img_plot2(rawmapb(:,:,zlayer),Cmap.Blue2);
hold on

for i=1:vn
    
    if spm(i) <= 0.15
        line([xb(i),xb(i)],[yb(i)-1,yb(i)+1],'Linewidth',2,'Color','c');
        line([xb(i)-1,xb(i)+1],[yb(i),yb(i)],'Linewidth',2, 'Color','c');
    elseif spm(i) <= 0.25 && spm(i) > 0.15
        line([xb(i),xb(i)],[yb(i)-1,yb(i)+1],'Linewidth',2,'Color','y');
        line([xb(i)-1,xb(i)+1],[yb(i),yb(i)],'Linewidth',2, 'Color','y');
    elseif spm(i) <= 0.35 && spm(i) > 0.25
        line([xb(i),xb(i)],[yb(i)-1,yb(i)+1],'Linewidth',2,'Color','r');
        line([xb(i)-1,xb(i)+1],[yb(i),yb(i)],'Linewidth',2, 'Color','r');
    elseif spm(i) > 0.35
        line([xb(i),xb(i)],[yb(i)-1,yb(i)+1],'Linewidth',2,'Color','m');
        line([xb(i)-1,xb(i)+1],[yb(i),yb(i)],'Linewidth',2, 'Color','m');
    end
    
%     line([xbmin(i),xbmin(i)],[ybmin(i)-1,ybmin(i)+1],'Linewidth',2,'Color','r');
%     line([xbmin(i)-1,xbmin(i)+1],[ybmin(i),ybmin(i)],'Linewidth',2, 'Color','r');
    
    
end

hold off


img_plot2(rawmapb(:,:,zlayer),Cmap.Blue2);
hold on

for i=1:vn
    
    if spm(i) <= 0.15
        line([xbmin(i),xbmin(i)],[ybmin(i)-1,ybmin(i)+1],'Linewidth',2,'Color','c');
        line([xbmin(i)-1,xbmin(i)+1],[ybmin(i),ybmin(i)],'Linewidth',2, 'Color','c');
    elseif spm(i) <= 0.25 && spm(i) > 0.15
        line([xbmin(i),xbmin(i)],[ybmin(i)-1,ybmin(i)+1],'Linewidth',2,'Color','y');
        line([xbmin(i)-1,xbmin(i)+1],[ybmin(i),ybmin(i)],'Linewidth',2, 'Color','y');
    elseif spm(i) <= 0.35 && spm(i) > 0.25
        line([xbmin(i),xbmin(i)],[ybmin(i)-1,ybmin(i)+1],'Linewidth',2,'Color','r');
        line([xbmin(i)-1,xbmin(i)+1],[ybmin(i),ybmin(i)],'Linewidth',2, 'Color','r');
    elseif spm(i) > 0.35
        line([xbmin(i),xbmin(i)],[ybmin(i)-1,ybmin(i)+1],'Linewidth',2,'Color','m');
        line([xbmin(i)-1,xbmin(i)+1],[ybmin(i),ybmin(i)],'Linewidth',2, 'Color','m');
    end
    
%     line([xbmin(i),xbmin(i)],[ybmin(i)-1,ybmin(i)+1],'Linewidth',2,'Color','r');
%     line([xbmin(i)-1,xbmin(i)+1],[ybmin(i),ybmin(i)],'Linewidth',2, 'Color','r');
    
    
end

hold off

toc
test = 1;
    


end