%% get coords

pcolor(m);
%pcolor(k2,ec,carp); shading interp
coord=[0 0];
caxis([2 6]*1e-3)

but=1;
nr_click=0;
 
while but==1

    nr_click=nr_click+1;
    
    [xi,yi,but] = ginput(1);
    
    xn=floor(xi);yn=floor(yi);

    hold on
    plot(xi,yi,'r*');
    hold off
    
    coord=[coord; yi, xi];

    
end





coord(1,:)=[];