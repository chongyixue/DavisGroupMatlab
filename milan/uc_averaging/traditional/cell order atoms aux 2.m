%% reshape coords
oldimage=p;
xto=xt;
yto=yt;
nxmo=nxm;
nymo=nym;

nym=reshape(nym,ssy,ssx);
nxm=reshape(nxm,ssy,ssx);
yt=reshape(yt,ssy,ssx);
xt=reshape(xt,ssy,ssx);

%%
%get square
newx=[];
newy=[];

newImage=oldimage;
[sy,sx]=size(oldimage);
xtr=floor(xt);
ytr=floor(yt);

for j=1:ssy-1
    for k=1:ssx-1
        squaredrift=[nxm(j,k) nym(j,k); ...
            nxm(j+1,k) nym(j+1,k); ...
            nxm(j+1,k+1) nym(j+1,k+1); ...
            nxm(j,k+1) nym(j,k+1)];
        
        squaretext=[xt(j,k) yt(j,k); ...
            xt(j+1,k) yt(j+1,k); ...
            xt(j+1,k+1) yt(j+1,k+1); ...
            xt(j,k+1) yt(j,k+1)];
        
        tform = maketform('projective',squaredrift,squaretext);
        
       % im_square=imtransform(oldimage,tform);
       [im_square,xdata,ydata] = imtransform(oldimage, tform, 'bicubic' ...
                              ,'size', size(oldimage));
                   % 'udata', [0 1],...
                              %'vdata', [1 0],...
                              %...
        %put square in new image.
        st=squaretext;
        sd=squaredrift;
        str=floor(st);
        ep= st;% find the points where the quare is in im_square
        %[ep(:,1), ep(:,2)]=tformfwd(tform,sd(:,1),sd(:,2));
        xx=linspace(xdata(1),xdata(2),sx);
        yy=linspace(ydata(1),ydata(2),sy)';
         %{
pcolor(xx,yy,im_square); shading interp
         hold on
        plot(ep(:,1),ep(:,2),'ro')
        hold off
%}        
        epx=linspace(ep(1,1),ep(3,1),str(3,1)-str(1,1)+1);
        epy=linspace(ep(1,2),ep(3,2),str(3,2)-str(1,2)+1)';
        %plot(str(1,1),str(1,2),'ko'); hold on
        conewx=str(1,1):str(3,1);
        newx=[newx; str(1,1)];
        newy=[newy; str(1,2)];
        conewy=str(1,2):str(3,2);
        k
        size(epx)
        size(conewx)
        newimage(conewy,conewx)=...
            interp2(xx,yy,...
            im_square, ...
            epx,epy);
    end
end

pcolor(newimage); shading flat;

        
        
        
            