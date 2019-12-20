%Function to correct phase jumps by 2pi by SUBTRACTING 2PI from selected
%areas

function phasefix = fixphase(phase);
%cmap = open('C:\MATLAB\ColorMap\IDL_Colormap2.mat');
cmap = open('C:\Analysis Code\MATLAB\ColorMap\IDL_Colormap3.mat');
[nr,nc] = size(phase);

tmp = zeros(nr);
tmp = phase >= pi;

a = tmp+0; %Turn from logical
figure; pcolor(phase); shading flat; colormap(cmap.Defect4); colorbar;
figure; pcolor(a); shading flat; colormap(cmap.Defect4); title('a')
%Chose rectangular area to change by 2pi
disp('Click Top Right of Area to be Conserved');[xi,yi] = ginput(1); 
disp('Click Bottom Left Area to be Conserved');[xii,yii] = ginput(1); 

% Isolate Area
for i = 1:nr
    for j = 1:nc
        if ((i < yi && i > yii && j < xi && j > xii))
            a(i,j) = a(i,j);
        else
            a(i,j) = 0;
        end
    end
end
%Show selected area
figure; pcolor(a); shading flat; colormap(cmap.Defect4); title('anew')
%If the rectangle selects unwanted area deselect them
disp('Please click top right if nesscary to deselect');[xiii,yiii] = ginput(1);
disp('Please click bottom left if nesscary to deselect');[xiv,yiv] = ginput(1);
    %Deselect chosen area
for i = 1:nr
    for j = 1:nc
        if ((i < yiii && i > yiv && j < xiii && j > xiv))
            a(i,j) = 0;
        end
    end
end
b = a*2*pi;

phasefix = phase - b;

figure; pcolor(phasefix); shading flat; colormap(cmap.Defect4); title('phasefix')

end


