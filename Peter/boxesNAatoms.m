function [xcor,ycor,xcor2,ycor2,Cocounter,schab]=boxesNAatoms(topo,topon)

% momentum coordinates UL,UM,UR
ftu1=[1.54 -0.91];
ftu2=[-0.98 -1.54];
ftu3=[-1.54 0.91];
ftu4=[0.98 1.54];

% momentum coordinates LL,LR
ftl1=[1.52 -0.89];
ftl2=[-0.97 -1.56];
ftl3=[-1.52 0.89];
ftl4=[0.97 1.56];

% real space coordinates UL, UR, UM
rsu1=[-1.54 +0.98];
rsu2=[0.91 1.54];
nu=2*pi/(-1.54*1.54+0.98*(-0.91));
rsu1=rsu1*nu*512/750;
rsu2=rsu2*nu*512/750;

% real space coordinates LL, LR
rsl1=[-1.56 0.97];
rsl2=[0.89 1.52];
nl=2*pi/(-1.56*1.52+0.97*(-0.89));
rsl1=rsl1*nl*512/750;
rsl2=rsl2*nl*512/750;


% Command to mark a dot
% line(204,249,'Color','r','Marker','.','MarkerSize',5);

x=204;
y=249;

x=142;
y=164;

% Lattice vectors for Fe/Co atoms
rsl3=(rsl1+rsl2)/2;
rsl4=(rsl1-rsl2)/2;

% topon=boxestoones(topo);

% figure, imagesc(topon), colormap(gray)
% line(204,249,'Color','r','Marker','.','MarkerSize',5)

k=1;
Cocounter=0;
for i=-312:312
    for j=-312:312
        newx1=(x+i*rsl1(1)+j*rsl2(1)); 
        newy1=(y+i*rsl1(2)+j*rsl2(2));
        if newx1 <= 312 && newx1 >= 1 && newy1 <= 312 && newy1 >= 1
%             line(newx1,newy1,'Color','r','Marker','.','MarkerSize',2);
        end
        
        % Fe / Co atom positions
        newx2=(x+i*rsl3(1)+j*rsl4(1)+0.5*rsl1(1)); 
        newy2=(y+i*rsl3(2)+j*rsl4(2)+0.5*rsl1(2));
        if newx2 <= 312 && newx2 >= 1 && newy2 <= 312 && newy2 >= 1
            tbt=(topon(ceil(newy2),ceil(newx2))+topon(floor(newy2),floor(newx2)))/2;
            if tbt > 0
                xcor(k)=newx2;
                ycor(k)=newy2;
                k=k+1;
            end
%             line(newx2,newy2,'Color','b','Marker','.','MarkerSize',2);
            Cocounter=Cocounter+1;
        end
        
        % Fe / Co atom positions
%         newx2=round(x+i*rsl3(1)+j*rsl4(1)+0.5*rsl1(1)); 
%         newy2=round(y+i*rsl3(2)+j*rsl4(2)+0.5*rsl1(2));
%         if newx2 <= 312 && newx2 >= 1 && newy2 <= 312 && newy2 >= 1
%         line(newx2,newy2,'Color','g','Marker','.','MarkerSize',2);
%         end
        
        
        
    end
end


figure, imagesc(topo), colormap(gray)
for i=1:length(xcor)
    line(xcor(i),ycor(i),'Color','r','Marker','.','MarkerSize',2);
end

% q=1;
% for i=1:length(xcor3)
%     clear dis disfur;
%     for j=1:length(xcor3)
%         dis(j)=((xcor3(i)-xcor3(j))^2+(ycor3(i)-ycor3(j))^2)^0.5;
%     end
%         disfur=dis;
%         [mini, minind1]=min(dis);
%         dis(minind1)=max(dis);
%         [mini, minind2]=min(dis);
%         dis(minind2)=max(dis);
%         [mini, minind3]=min(dis);
%         dis(minind3)=max(dis);
%         [mini, minind4]=min(dis);
%         
%         [maxi, maxind]=max([topo(round(ycor(i)),round(xcor(i))) topo(round(ycor(minind1)),round(xcor(minind1)))...
%             topo(round(ycor(minind2)),round(xcor(minind2))) topo(round(ycor(minind3)),round(xcor(minind3))) ...
%             topo(round(ycor(minind4)),round(xcor(minind4)))]);
%         if maxind == 1
%             xcor2(q)= xcor(i);
%             ycor2(q)= ycor(i);
%         elseif maxind ==2
%             xcor2(q)= xcor(minind1);
%             ycor2(q)= ycor(minind1);
%         elseif maxind ==3
%             xcor2(q)= xcor(minind2);
%             ycor2(q)= ycor(minind2);
%         elseif maxind ==4
%             xcor2(q)= xcor(minind3);
%             ycor2(q)= ycor(minind3);
%         elseif maxind ==5
%             xcor2(q)= xcor(minind4);
%             ycor2(q)= ycor(minind4);
%         end
%         q=q+1;
% end
% 
% 
% figure, imagesc(topo), colormap(gray)
% for i=1:length(xcor2)
%     line(xcor2(i),ycor2(i),'Color','r','Marker','.','MarkerSize',2);
% end

boxcar=importdata('C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\June_2013\06_06_13\xcor11ycor11.mat');
xcor11=boxcar.xcor11;
ycor11=boxcar.ycor11;

xcor2=xcor11;
ycor2=ycor11;

for i=1:length(xcor11)
    if round(xcor11(i))-1 >= 5
        xmin=round(xcor11(i))-5;
    else
        xmin=1;
    end
    if 312-round(xcor11(i)) >=5
        xmax=round(xcor11(i))+5;
    else
        xmax=312;
    end
    if round(ycor11(i))-1 >= 5
        ymin=round(ycor11(i))-5;
    else
        ymin=1;
    end
    if 312-round(ycor11(i)) >=5
        ymax=round(ycor11(i))+5;
    else
        ymax=312;
    end
    % change the layer of the map so the zero bias level is used
    data=topo(ymin:ymax,xmin:xmax,1)+1;
    [X,Y]=meshgrid(1:1:max(size(data(:,:,1),2)),1:1:max(size(data(:,:,1),1)));
    %% Starting guess for the following fit function
    % calculate the center of intensity / mass com coordinates
    comx(i)=sum(sum(data.*X))/sum(sum(data))-1+xmin;
    comy(i)=sum(sum(data.*Y))/sum(sum(data))-1+ymin;
    
    
end
    

figure, imagesc(topo), colormap(gray)
for i=1:length(comx)
    line(comx(i),comy(i),'Color','y','Marker','.','MarkerSize',5);
end



schablone=zeros(312,312,length(comx));
for i=1:length(xcor11)
    if round(xcor11(i))-1 >= 3
        xmin=round(xcor11(i))-3;
    else
        xmin=1;
    end
    if 312-round(xcor11(i)) >=3
        xmax=round(xcor11(i))+3;
    else
        xmax=312;
    end
    if round(ycor11(i))-1 >= 3
        ymin=round(ycor11(i))-3;
    else
        ymin=1;
    end
    if 312-round(ycor11(i)) >=3
        ymax=round(ycor11(i))+3;
    else
        ymax=312;
    end
    % change the layer of the map so the zero bias level is used
    topo1=topo(ymin:ymax,xmin:xmax,1);
    [nx ny nz]=size(topo1);
        for k=1:nx
            for l=1:ny
                if topo1(k,l)<= mean(mean(topo1))+0.2*(max(max(topo1))-mean(mean(topo1)))
                    topo2(k,l)=0;
                else
                    topo2(k,l)=1;
                end
            end
        end
%         figure, imagesc(topo1), colormap(gray)
%         figure, imagesc(topo2), colormap(gray)
        schablone(ymin:ymax,xmin:xmax,i)=topo2;
        clear topo1 topo2;
    
end

schab=sum(schablone,3);
for i=1:312
    for j=1:312
        if schab(i,j) > 0
            schab(i,j)=1;
        end
    end
end


% figure, imagesc(topo), colormap(gray)
% figure, imagesc(schab), colormap(gray)


% figure, imagesc(topo), colormap(gray)
% for i=1:312
%     for j=1:312
%         if schab(i,j)==1
%            line(j,i,'Color','r','Marker','.','MarkerSize',2);
%         end
%     end
% end

end



q=1;
for i=1:length(xcor3)
    clear dis disfur;
    for j=1:length(xcor3)
        dis(j)=((xcor3(i)-xcor3(j))^2+(ycor3(i)-ycor3(j))^2)^0.5;
    end
        disfur=dis;
        [mini, minind1]=min(dis);
        dis(minind1)=max(dis);
        [mini, minind2]=min(dis);
        dis(minind2)=max(dis);
        
        [maxi, maxind]=max([topo(round(ycor3(i)),round(xcor3(i))) topo(round(ycor3(minind1)),round(xcor3(minind1)))...
            topo(round(ycor3(minind2)),round(xcor3(minind2)))]);
        if maxind ==1;
            xcor4(q)= xcor3(i);
            ycor4(q)= ycor3(i);
        elseif maxind ==2
            xcor4(q)= xcor3(minind1);
            ycor4(q)= ycor3(minind1);
        elseif maxind ==3
            xcor4(q)= xcor3(minind2);
            ycor4(q)= ycor3(minind2);
        end
        q=q+1;
end


figure, imagesc(topo), colormap(gray)
for i=1:length(xcor4)
    line(xcor4(i),ycor4(i),'Color','r','Marker','.','MarkerSize',2);
end


for i=1:length(xcor16)
for j=1:length(xcor16)
if i==j
else
if xcor16(i)==xcor16(j)
if ycor16(i)==ycor16(j)
xcor16(j)=i*1000;
ycor16(j)=i*1000;
end
end
end
end
end
q=1;
clear i
for i=1:length(xcor16)
if xcor16(i) < 1000
xcor17(q)=xcor16(i);
ycor17(q)=ycor16(i);
q=q+1;
end
end
figure, imagesc(topo), colormap(gray)
for i=1:length(xcor17)
    line(xcor17(i),ycor17(i),'Color','r','Marker','.','MarkerSize',5);
end



q=1;
for i=1:length(xcor15)
    clear dis disfur;
    for j=1:length(xcor15)
        dis(j)=((xcor15(i)-xcor15(j))^2+(ycor15(i)-ycor15(j))^2)^0.5;
    end
        disfur=dis;
        [mini, minind1]=min(dis);
        dis(minind1)=max(dis);
        [mini, minind2]=min(dis);
        if mini < 3
            dis(minind2)=max(dis);

            [maxi, maxind]=max([topo(round(ycor15(i)),round(xcor15(i))) topo(round(ycor15(minind1)),round(xcor15(minind1)))...
                topo(round(ycor15(minind2)),round(xcor15(minind2)))]);
            if maxind ==1;
                xcor16(q)= xcor15(i);
                ycor16(q)= ycor15(i);
            elseif maxind ==2
                xcor16(q)= xcor15(minind1);
                ycor16(q)= ycor15(minind1);
            elseif maxind ==3
                xcor16(q)= xcor15(minind2);
                ycor16(q)= ycor15(minind2);
            end
        else
            xcor16(q)=xcor15(i);
            ycor16(q)=ycor15(i);
        end
        
        q=q+1;
        
end


figure, imagesc(topo), colormap(gray)
for i=1:length(xcor16)
    line(xcor16(i),ycor16(i),'Color','r','Marker','.','MarkerSize',2);
end


q=1;
for i=1:length(xcor18)
    t1 = 0;
        for j=1:length(xdes2)
            if round(xcor18(i)) == xdes2(j)
                if round(ycor18(i)) == ydes2(j)
                    t1=1;
                else
                    t2=0;
                end
            else
                t2=0;
            end
        end
        if t1 == 1
        else
        xcor19(q)=xcor18(i);
        ycor19(q)=ycor18(i);
        q=q+1;
        end
end

Topores=imresize(topo,6);

a=Topores;
b=a;
for i=1:1872
    for j=1:1872
        if a(i,j)<=-0.13
            b(i,j)=-0.13;
        elseif a(i,j) >=0.15;
            b(i,j)=0.15;
        else
            b(i,j)=a(i,j);
        end
    end
end
Topo=b;


figure, imagesc(Topo), colormap(gray)
for i=1:length(xcor19)
    line(round(xcor19(i)*6),round(ycor19(i)*6),'Color','y','Marker','.','MarkerSize',5);
end


x=876;
y=963;

% Lattice vectors for Fe/Co atoms
rsl3=(rsl1+rsl2)/2;
rsl4=(rsl1-rsl2)/2;

% topon=boxestoones(topo);

% figure, imagesc(topon), colormap(gray)
% line(204,249,'Color','r','Marker','.','MarkerSize',5)

k=1;
Cocounter=0;
for i=-1872:1872
    for j=-1872:1872
        newx1=(x+i*6*rsl1(1)+j*6*rsl2(1)); 
        newy1=(y+i*6*rsl1(2)+j*6*rsl2(2));
        if newx1 <= 1872 && newx1 >= 1 && newy1 <= 1872 && newy1 >= 1
            line(newx1,newy1,'Color','r','Marker','.','MarkerSize',2);
        end        
    end
end