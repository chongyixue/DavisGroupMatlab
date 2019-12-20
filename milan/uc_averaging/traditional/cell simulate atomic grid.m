%%
tot=200;
dx=linspace(0,200,tot);
[y,x]=ndgrid(dx,dx);
g=x*0;
t=0;
om=5;
d=10;
k=tot/d;
am=1;

for j=1:3*k
    l1=j-k;
    for m=1:3*k
        l2=m-k;
        %distort=[0 l2^2*d/100];
        pos=[l1*d,l2*d]+rand(1,2)*t;%+distort;
        
            
        g=g+gauss2d(x,y,pos,am,om);
        
    end
end
%g=g-gauss2d(x,y,[100,100],am,om);
pcolor(g); shading flat; colorbar
        