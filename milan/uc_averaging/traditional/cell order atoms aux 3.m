%%

ssx=10;
ssy=10;
%% mak grid


[yt,xt]=ndgrid(linspace(charDist,charDist*ssy,ssy),...
    linspace(charDist,charDist*ssx,ssx));
plot(xt,yt,'ro')

%%


xh=reshape(xt,ssx*ssy,1);
yh=reshape(yt,ssx*ssy,1);
co=[yh, xh, yh*0];


%%
%get distance matrix
abst=zeros(ssx*ssy);
for j=1:ssx*ssy-1
    for m=j+1:ssy*ssx
        abst(j,m)=sqrt( (co(j,1)-co(m,1))^2 + ...
            (co(j,2)-co(m,2))^2) ;
    end
end
abst=abst+abst';

%% order those fuckers
richtnr=1; %(1=up)
k=1;
nrpoints=1;
newco=co;

while nrpoints<=(ssx-2)*(ssy-2)

    
    
    % if we re not        
    if co(k,3)==0
        
        currp=[co(k,2),co(k,1)];
        
        [tmp,isort]=sort(abst(:,k),1);
        
        %pick first four;
        sortco=co(isort,:);
        neighs=sortco(2:5,:);
        
        % get fucking angeles 
        angl=zeros(4,1);
        for m=1:4
            currp(1)=currp(1)*i;
            neighs2=neighs(:,2)*i+neighs(:,1);
            angl(m)=angle(currp-neighs2(m,:))/pi*180;
        end
        
        %pick the next point
        % look first which direction we are going
        if richt==1
            kn=find(angl>45 && angl<45+90);
        elseif richt==2
            kn=find(angl>-45-90 && angl<-45);
        elseif richt==3
            kn=find(angl>-45 && angl<45);
        end
        
        %conclude
        nrpoints=nrpoints+1;
        newco(nrpoints,:)=co(kn,:);
        
            %if end up at the border
        if co(kn,3)~=0
            %change richtung
            
            % 1:up, 2: right, 3: down
           richtnr=richtnr+1;
           if isodd(richtnr+1)
               richt=3;
           elseif isodd(floor(richt/2))
               richt=1;
           elseif isodd(floor(richt/2)+1)
               richt=1;
           end
           
           %go back 
           % do not change k (but nrpoints was changed
        else
            %change k
            k=kn
        end
        
        
        
    end
    
 end 
            
            
        
        
        tmpco=co;
        tmpco(k,:)=[];
        
        neighs=nan(4,2);
        % search for 1st neighbour
        tri = delaunay(tmpx,tmpy);
        kk=dsearch(nx,ny,tri,xt,yt);
        
    
