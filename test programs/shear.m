function transform = transform_map(map,coord,A1,B1,A0,B0)

M = [A1(1) A1(2)   0     0
        0      0   A1(1) A1(2) 
        B1(1) B1(2)   0     0
        0      0   B1(1) B1(2)]; 

b = [A0(1); A0(2); B0(1); B0(2)];

x = inv(M)*x;

xform = [x(1)   x(2)   0
         x(3)   x(4)   0
           0     0     1];
  
xform = xform2;
     
shearing = maketform('affine',xform2);
%[G xdata ydata]= imtransform(G4KMap(:,:,11),shearing);
transform = imtransform(G4KMap, shearing,... 
                        'UData',[coord(1) coord(end)],...
                        'VData', [coord(1) coord(end)],...
                        'XData',[coord(1) coord(end)],...
                        'YData', [coord(1) coord(end)]);
end
%pcolor(G); shading interp;
%G = G(1:256,1:256);