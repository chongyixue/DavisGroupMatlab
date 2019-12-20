function m=myColormap_get(name, nr)
% gets the values
which=[' /Applications/MATLAB74/work/mycolormap/myColormap_'...
    name '.dat'];
mt=load(which);
m=nan(nr,3);
m(:,1)=interp1(linspace(0,1,100),mt(:,1),...
    linspace(0,1,nr));
m(:,2)=interp1(linspace(0,1,100),mt(:,2),...
    linspace(0,1,nr));
m(:,3)=interp1(linspace(0,1,100),mt(:,3),...
    linspace(0,1,nr));








