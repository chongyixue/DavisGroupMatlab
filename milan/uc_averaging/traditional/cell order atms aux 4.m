%%
ucn=ucr;
for j=1:51
    ucn(:,:,j)=ucr(:,:,j)/sum(sum(ucr(:,:,j)));
end

%%
cc=filtered2;
%%
cc=g;

%% find peaks
siz=[256,256];
abst=3;

pcolor(cc); shading interp; colormap gray;
hold on;
[ncy,ncx]=get_exact_maxima(cc, siz, abst);
plot(ncx,ncy,'rx');
hold off

%%
uc=average_cell(dMap,ncy,ncx,20);
%%
ncy2=ncy;
ncx2=ncx;

%%
plot(ncx,ncy,'rx'); hold on
plot(ncx2,ncy2,'b+'); hold off

%% sorting stuff
charDist=10;
unschaerfe=1/10;

m=[ncx ncy];
m2=round_my(m,charDist*unschaerfe);
[B,ix] = sort(m2(:,2),1);
m2=m2(ix,:);

[B,ix] = sort(m2(:,1),1);
m2=m2(ix,:);

plot(m2(:,1),m2(:,2),'bx');

ssx=19;
ssy=16;

mx=reshape(m(:,1),ssy,ssx);
my=reshape(m(:,2),ssy,ssx);

dx=diff(my');
pcolor(dx); colorbar
%{
 hold on
for j=1:length(m2(:,2))
    plot(m2(j,2),m2(j,1),'ro')
end
hold off
%}
%plot(mx,my,'ro')  

%% find grid points and plot
ssx=18;
ssy=16;
dx=-4;
dy=3;
charDist=15.8;
[yt,xt]=ndgrid(linspace(charDist,charDist*ssy,ssy)+dy,...
    linspace(charDist,charDist*ssy,ssy)+dx);
%plot(xt,yt,'ro')
[sy,sx]=size(xt);
xt=xt+rand(sy,sx)*charDist/300;
tri = delaunay(xt,yt);
%triplot(tri,xt,yt); hold on
kk=dsearch(xt,yt,tri,ncx,ncy);
plot(ncx,ncy,'rx'); hold on
plot(xt,yt,'b+');
for j=1:length(kk)
    plot([xt(kk(j)),ncx(j)],[yt(kk(j)),ncy(j)],'k-')
end

hold off

%% mak grid
[yt,xt]=ndgrid(linspace(charDist,charDist*ssy,ssy),...
    linspace(charDist,charDist*ssy,ssy));
plot(xt,yt,'ro')

%%
hold on
j=300
plot(m2(j,2),m2(j,1),'ro')

%%
pcolor(double(isnan(uc(:,:,9))))
colorbar




