function ab=doser(cube,e,disty,distx)

% X lets you select a core of spectra, which then are put to workspace.

%start with imprtant wariables
hs.cube=cube;
%e=flipud(e);
hs.e=e;

hs.layer=1;%ceil(length(e/2));
[sy,sx,sz] = size(hs.cube);
hs.dos=zeros(1,sz);
hs.sy=sy; hs.sx=sx; hs.sz=sz;

hs.disty=disty;
hs.distx=distx;

%create stuff
fh=figure('Color',[.9,.9,.9],'Position',[50,0,800,1200]);

radius_edit = uicontrol(fh,'Style','Edit',...
                'String','10',...
                'Position',[30 20 130 20]);
            
mini_edit = uicontrol(fh,'Style','Edit',...
                'String','0',...
                'Position',[700 80 70 20]);
            
maxi_edit = uicontrol(fh,'Style','Edit',...
                'String','0',...
                'Position',[700 60 70 20]);

main_axis = axes('Parent',fh,'Position',[.1 .1 .6 .4]);

dos_axis = axes('Parent',fh,'Position',[.1 .6 .6 .3]);

carpet_butt = uicontrol(fh,'Style','pushbutton','String','get carpet',...
                'Position',[190 20 70 40],...
                'Callback',{@button1_Callback,hs});
            
spectra_butt = uicontrol(fh,'Style','pushbutton','String','get spectra',...
                'Position',[280 20 70 40],...
                'Callback',{@button2_Callback,hs});
            
toggle_graph = uicontrol(fh,'Style','togglebutton',...
                'String','add?',...
                'Value',0,'Position',[350 20 30 40]...
                );
                        
energy_list = uicontrol(fh,'Style','listbox',...
                'String',cellstr(num2str(e)),...
                'Value',hs.layer,...
                'Position',[450 10 130 60],...
                'Callback',{@energy_list_Callback,hs});            

axes(main_axis);

%first plot
colormap gray
plot_it(hs);


%callbacks DOS spectra

function button2_Callback(hObject,eventdata,hs)
axes(dos_axis); cla;   axes(main_axis)   
but=1;

r=str2double(get(radius_edit,'String'));
adding=get(toggle_graph,'Value');

hold off;

plot_it(hs);

 m=colormap(cool(10));colormap gray;

 nr_click=0;
 
while but==1

    nr_click=nr_click+1;
    
    [xi,yi,but] = ginput(1);
    yi=yi/max(hs.disty)*hs.sy; xi=xi/max(hs.distx)*hs.sx; %dist to coord
    
    xn=floor(xi);yn=floor(yi);
    
    if r>0 
       %make abstand matrix
       [cy,cx]=ndgrid(-yi+1:hs.sy-yi,-xi+1:hs.sx-xi);
       cx=abs(cx);cy=abs(cy);
       abstand=(cx.^2+cy.^2).^0.5;
       ind=find(abstand<=r);
       n=length(ind);
       hs.dos=zeros(1,hs.sz);
       for k=1:sz
           now=hs.cube(:,:,k);
           hs.dos(k)=sum(now(abstand<=r))/n;
       end
    
       set(gca, 'NextPlot', 'add');
       N=256;
       t=(0:N)*2*pi/N;
       plot( (r*cos(t)+xn)/hs.sx*max(hs.distx),...
           (r*sin(t)+yn)/hs.sy*max(hs.disty),'b');
    else
       set(gca, 'NextPlot', 'add');
       hs.dos=squeeze(hs.cube(yn,xn,:));
       plot( (xn+.5)*max(hs.distx)/hs.sx,...
           (yn+.5)*max(hs.disty)/hs.sy,'bx');
    end
    
   
   
     axes(dos_axis);
   set(gca,'XGrid','on')
    if adding==1
        j=mod(nr_click,9)+1;
        set(gca, 'NextPlot', 'add');
        plot(hs.e,hs.dos,...
            'Color',[m(j,1) m(j,2) m(j,3)],...
            'LineWidth',2);
      
        set(gca, 'NextPlot', 'replace');
    else
        plot(hs.e,abs(hs.dos), 'Linewidth',2);
       
    end
    axes(main_axis)
    assignin('base',['d' num2str(nr_click, '%02d')],hs.dos);
end

end


%%%% DOS CARPETS
function button1_Callback(hObject,eventdata,hs)


set(gca, 'NextPlot', 'add');

count=0;
clear a b x d total_xn total_xi M abst wo ;


while count<2
    axes(gca)
    [yi,xi,but] = ginput(1);
    yi=yi/max(hs.disty)*hs.sy; xi=xi/max(hs.distx)*hs.sx;
    xn=floor(xi);yn=floor(yi);
    
    if count==0
        a=[xi;yi]
    elseif count==1
        b=[xi;yi]
    end
    
    count=count+1;
end

[sy,sx,sz]=size(hs.cube);


x=b-a;

d=sqrt(x'*x);

M=[x(1), x(2)/d; x(2) -x(1)/d]^-1;
abst=zeros(sy,sx);
wo=zeros(sy,sx);

xp=[a(2),b(2)]/sx*max(hs.distx);
yp=[a(1),b(1)]/sy*max(hs.disty);
plot(xp,yp,'r-','linewidth',3);

for k=1:sy
    for j=1:sx
        p=[k;j];
        t=M*(p-a);
        abst(k,j)=abs(t(2));
        wo(k,j)=t(1);  %wo: where the oint belongs to on the red line, t element [0,1]
    end
end

wo=wo*d;
n=round(d);



kvec=linspace(0,d,n+1);
delta=kvec(2)-kvec(1);
kvec2=linspace(delta/2,d-delta/2,n);
carp=zeros(sz,n);

ab=str2num(get(radius_edit,'String'));


for k=1:n
    
    [indy,indx]=find(abst<ab & wo > kvec(k)   &   wo <= kvec(k+1));
    for j=1:length(indy)
        carp(:,k)=carp(:,k)+squeeze(hs.cube(indy(j),indx(j),:)) /length(indy);
    end
end

totdist=sqrt( (xp(2)-xp(1))^2 + (yp(2)-yp(1))^2)
kvec2=linspace( 0,totdist,n);
figure
pcolor(kvec2,hs.e,carp);
title(['integr-abst=',num2str(ab)])
shading interp; colorbar; colormap 'jet';


assignin('base','carpet',carp);



end

function energy_list_Callback(hObject,eventdata,hs)
hs.layer=get(energy_list,'Value'); 
axis(main_axis);
cla;

plot_it(hs);
end



    function plot_it(hs)
        hs.layer=get(energy_list,'Value'); 
        axis(main_axis);
        mini=str2num(get(mini_edit,'String'));
        maxi=str2num(get(maxi_edit,'String'));
     %   [mini,maxi]=...
      %      get_colormap_limits(abs(hs.cube(:,:,hs.layer)),mini/1000,maxi/1000,'h');
        pcolor(hs.distx',hs.disty,abs(hs.cube(:,:,hs.layer)));
        shading flat; 
        colorbar; axis equal;
     %   caxis([mini,maxi]);
        hold on; plot(0,0,'*r'); hold off;
        hs.layer
    

    end



end