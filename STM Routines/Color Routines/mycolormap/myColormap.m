function myColormap(name)
which=[' /Applications/MATLAB74/work/mycolormap/myColormap_'...
    name '.dat'];
thiscmaphere=load(which);
colormap(thiscmaphere)
clear thiscmaphere






