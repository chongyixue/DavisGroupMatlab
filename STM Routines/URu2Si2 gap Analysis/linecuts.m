%% Linecut Analysis of URu2Si2 gap map

strleft.map = (F_left_edge_gfilt_tr_sym);
strleft.r = F_G.r;
strright.map = (F_right_edge_gfilt_tr_sym);
strright.r = F_G.r;
%%
strleft = blur_map(strleft,5,5);
strright = blur_map(strright,5,5);
img_plot2(strleft.map,Cmap.Defect1,'Left Edge Blur');
img_plot2(strright.map,Cmap.Defect1,'Right Edge Blur');
%%
l_px_avg = 2; r_px_avg = 4;
start = floor(length(strleft.r)/2) + 1; fin = length(strleft.r) -4;
cut_left = linecut3(strleft,[start start],[fin fin],l_px_avg);
cut_right = linecut3(strright,[start start],[start fin],r_px_avg);

n1 = length(cut_left); n2 = length(cut_right);
curve_plot(sqrt(2*(strleft.r(start:fin-1).^2)),cut_left,'bx',['Left Edge Cut Diagonal - avg px ' num2str(l_px_avg)]);
curve_plot(strright.r(start:fin-1),cut_right,'rx',['Right Edge Cut Horizontal - avg px ' num2str(r_px_avg)]);
%%
x=0:.01:2*pi;
y=sin(x);figure;
h=plot(x,y);
hc=uicontextmenu;
hm=uimenu('parent',hc);
set(h,'uicontextmenu',hc);
set(gcf,'windowbuttondownfcn', ...
'pt=get(gca,''currentpoint'');set(hm,''label'',[num2str(pt(1,1)) '', '' num2str(pt(1,2))])')