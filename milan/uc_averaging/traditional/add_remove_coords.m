function co=add_remove_coords(plane,co,addit)



%create stuff
fh=figure('Color',[1 1 1],'units','centimeter', ...
    'Position',[2,2,20,20]);

           
main_axis = axes('Parent',fh,'units','normalized',...
                'units','normalized',...
                'Position',[.05 .05 .9 .9]);

axes(main_axis)   

pcolor(plane); shading interp; colormap jet
hold on

if ~isempty(co)
    tri = delaunay(co(:,2),co(:,1));
    plot(co(:,2),co(:,1),'bo')  
    ind=find(co(:,3)==1);
    plot(co(ind,2),co(ind,1),'b.') 
end


 


but=1;
poitot=[];
while but==1
 
    [xi,yi,but] = ginput(1);
   

    plot(xi,yi,'rx')
    
    if addit==1
        co=[co;yi,xi,0];
    elseif addit==0
         poi=dsearch(co(:,2),co(:,1),tri,xi,yi);
         plot(co(poi,2),co(poi,1),'r.')
         poitot=[poitot; poi];
    elseif addit==2
         poi=dsearch(co(:,2),co(:,1),tri,xi,yi);
         plot(co(poi,2),co(poi,1),'r.')
         co(poi,3)=0;
    end
        

    
end
co(poitot,:)=[];