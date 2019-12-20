
function [coy,cox]=tmp_order(co,ssy,ssx,chardist)
%make anstand
abst=zeros(ssx*ssy);
for j=1:ssx*ssy-1
    for m=j+1:ssy*ssx
        abst(j,m)=sqrt( (co(j,1)-co(m,1))^2 + ...
            (co(j,2)-co(m,2))^2) ;
    end
end
abst=abst+abst';

%rest
richtnr=0; %(1=up
richt=1;
k=1;
nrpoints=1;
nropintstaken=1;
newco=co;
tri = delaunay(co(:,2),co(:,1));

plot(co(:,2),co(:,1),'bo')
hold on


while nrpoints<=(ssx-1)*(ssy)

    plot(co(k,2),co(k,1),'r.')
    
    % if we re not        
    if co(k,3)==0
        
        currp=[co(k,1),co(k,2)];
        
        [tmp,isort]=sort(abst(:,k),1);
        
        %pick first four;
        sortco=co(isort,:);
        neighs=sortco(2:5,1:2);
        
        testit=[0 0];
        for m=1:4
             testit=testit+(neighs(m,:)-currp);
        end
        testit=testit*testit';
        
        if testit>chardist^2
             [xi,yi,but] = ginput(1);
             kn=dsearch(co(:,2),co(:,1),tri,xi,yi);
        else
        
            % get fucking angeles 
            angl=zeros(4,1);        
            currp2=currp(2)*i+currp(1);   
            for m=1:4
       
                neighs2=i*neighs(:,2)+neighs(:,1);
                angl(m)=...
                    angle(currp2-neighs2(m,:))/pi*180;
            end
        
            %pick the next point
            % look first which direction we are going
            % 1:up, 2: right, 3: down
            if richt==1
                kn=find(angl>135 | angl<-135);
            elseif richt==2
                kn=find(angl>-90-45 & angl<-90+45);
            elseif richt==3
                kn=find(angl>-45 & angl<45);
            end
            % from kn (index of neigh) to kn (index of co)
            kn=isort(kn+1);
        end
        
        
        %conclude
        nrpoints=nrpoints+1;
        
       
nrpoints
        
           %if end up at the border
        if co(kn,3)~=0 || richt==2
            %change richtung
           
            % 1:up, 2: right, 3: down
           richtnr=mod(richtnr+1,4);
           if richtnr==0
               richt=1;
           elseif richtnr==1
               richt=2;
           elseif richtnr==2
               richt=3;
          elseif richtnr==3
               richt=2;
           end
           
           %go back 
           % do not change k (but nrpoints was changed

        end
        
        %borderpoint?
        if co(kn,3)==0
             nropintstaken=nropintstaken+1;
             newco(nropintstaken,:)=co(kn,:);
            %change k
            k=kn;
        end
        
        
        
        
    end
    
end 
 

newco=newco(1:(ssx-2)*(ssy-2),:);


cox=zeros(ssy-2,ssx-2);
coy=cox;
for j=1:ssx-2
    if isodd(j)
        cox(:,j)=newco((ssy-2)*(j-1)+1:(ssy-2)*j,2);
        coy(:,j)=newco((ssy-2)*(j-1)+1:(ssy-2)*j,1);
    else
        cox(:,j)=flipud(newco((ssy-2)*(j-1)+1:(ssy-2)*j,2));
        coy(:,j)=flipud(newco((ssy-2)*(j-1)+1:(ssy-2)*j,1));
    
    end
end
            
        


        