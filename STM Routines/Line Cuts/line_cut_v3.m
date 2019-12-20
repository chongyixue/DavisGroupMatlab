%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION:
%
% ALGORITHM:
%
%INPUT: pos1 = [x1 y1], pos2 = [x2 y2], where the linecut goes from pos1 to
%       pos2.
%
% CODE HISTORY
%
% 080631 MHH Created
% 130418 MHH Modified to properly take arbitrary cuts
%
function l_cut = line_cut_v3(data,pos1,pos2,avg_px)
%avg_px = 2;
lcut = [];
if isstruct(data)
    img = data.map;
else
    img = data;
end

[nr nc nz] = size(img);

% A = [x1   x2
%      y1   y2]

A = [pos1(1) pos2(1)
    pos1(2) pos2(2)];

dx = A(1,2) - A(1,1);
dy = A(2,2) - A(2,1);
lay = round(nz/2+1);
img_plot2(img(:,:,lay));
% img_plot2(img(:,:,1),Cmap.Defect1,'bla');
% hold on;  plot([pos1(1) pos2(1)],[pos1(2) pos2(2)],'k');
hold on;  plot([pos1(1) pos2(1)],[pos1(2) pos2(2)],'y');
% text(pos1(1),pos1(2),['[',num2str(pos1(1)),',',num2str(pos1(2)),']'],...
%     'Units','normalized','Fontsize',10,'Color',[1 0.6 0]);
text(0.3,0.1,['[',num2str(pos1(1)),',',num2str(pos1(2)),'] to [',num2str(pos2(1)),',',num2str(pos2(2)),']',' avg px: ',num2str(avg_px)],...
    'Units','normalized','Fontsize',10,'Color',[1 0.6 0]);
% coordinate systems has x increase towards right and y increase going down
% So quadrants I - bottom right, II - bottom left, III - top left, IV - top
% right
if dx == 0
    xstep = 0;
    ystep = 1*sign(dy);
    step_n = abs(dy);
elseif dy == 0
    xstep = 1*sign(dx);
    ystep = 0;
    step_n = abs(dx);
else
    m = dy/dx;
    if abs(m) <= 1 && m > 0 % first of third quadrant, angle < than 45
        xstep = 1*sign(dx);
        ystep = dy/dx*sign(dx);
        step_n = abs(dx);
    elseif abs(m) > 1 && m > 0 %first and third quadrant, angle > than 45
        ystep = 1*sign(dy);
        xstep = dx/dy*sign(dy);
        step_n = abs(dy);
    elseif abs(m) <=1 && m < 0 %second and forth quadrant, angle < than 45
        xstep = 1*sign(dx);
        ystep = dy/dx*sign(dx);
        step_n = abs(dx);
    elseif abs(m) >1 && m < 0 % second a forth quadrant, angle > than 45
        ystep = 1*sign(dy);
        xstep = dx/dy*sign(dy);
        step_n = abs(dy);
    end
end
cut = zeros(step_n,nz);
for i=1:step_n
    pos = A(:,1) + (i-1)*[xstep;ystep];
    d1 = shortest_dist(A(:,1),A(:,2),floor(pos));
    d2 = shortest_dist(A(:,1),A(:,2),ceil(pos));
    %calculate weight for the average
    if (d1 == d2)
        w1 = 0.5;
        w2 = 0.5;
    else
        w1 = 1 - d1/(d1+d2);
        w2 = 1 - d2/(d1+d2);
    end
    cut(i,:) =  w1*img(floor(pos(2)),floor(pos(1)),:) + w2*img(ceil(pos(2)),ceil(pos(1)),:);
    % produce a table of coordinates for used in the trasverse averaging
    for k=1:(avg_px)
        avg_pts1(:,k) = pos + k*[-ystep;xstep] ; % above the linecut
        avg_pts2(:,k) = pos + (-k)*[-ystep;xstep]; % below the linecut
        %hold on; plot([avg_pts1(1,k) avg_pts2(1,k)],[avg_pts1(2,k) avg_pts2(2,k)],'.');
    end
    % start transverse averaging using interpolation function
    % pixel_val_interp
    for j = 1:nz
        tmp_img = img(:,:,j);
        for k = 1:avg_px
            cut(i,j) = cut(i,j) + pixel_val_interp(tmp_img,avg_pts1(1,k),avg_pts1(2,k)) +...
                pixel_val_interp(tmp_img,avg_pts2(1,k),avg_pts2(2,k));
        end
        cut(i,j) = cut(i,j)/(2*avg_px + 1);
    end
    clear avg_pts1 avg_pts2;
end

if isstruct(data)
    %this block of code determines the coordinate for the cutline.
    x = data.r;
    %     x1 = sqrt(x(pos1(1))^2 + x(pos1(2))^2);
    %     x2 = sqrt(x(pos2(1))^2 + x(pos2(2))^2);
    %     if min(x) >= 0
    % %         p='min(x)>=0 branch'
    %     elseif x(pos1(1)) < 0 || x(pos1(2)) < 0
    %         x1 = -x1;
    % %         p='x(pos1(1)) < 0 || x(pos1(2)) < 0'
    %     elseif x(pos2(1)) < 0 || x(pos2(2)) < 0
    %         x2 = -x2;
    % %         p='x(pos2(1)) < 0 || x(pos2(2)) < 0'
    %     end
    
    %here I prefer to plot using real q distances
    x1 = 0;
    xlength = x(abs(dx)+1)-x(1);
    ylength = x(abs(dy)+1)-x(1);
    x2 = sqrt(xlength^2+ylength^2);
    dr = x(2)-x(1);
    asymx = x(pos1(1))+x(pos2(1));
    asymy = x(pos1(2))+x(pos2(2));
    asym = (asymx+asymy)*0.5/x2;
    
    %compare the gradient to see if line roughly pass the vicinity of
    %origin (within 0.1*length of line cut)
    epsilon = abs((x(2)-x(1))*0.001);
%     step_n
    k = 0.1*step_n*dr;
    m_line = (x(pos2(2))-x(pos1(2)))/(x(pos2(1))-x(pos1(1))+epsilon);
    c_line = 0.5*(x(pos1(2))+x(pos2(2))-m_line*(x(pos1(1))+x(pos2(1))));
    a = (1+m_line^2);
    b = (2*m_line*c_line);
    c = c_line^2-k;
    root = b^2-4*a*c;
    if root<0
        intercept_origin = 0;
    else
        intercept_origin = 1;
    end
        
    if asym<0.5 || intercept_origin > 0.4
        x2 = 0.5*(asym+x2);
        x1 = asym-x2;
    end
    
    n = size(cut,1);
    r = linspace(x1,x2,n);
    l_cut.cut = cut;
    l_cut.r = r';
    l_cut.e = data.e.*1000;
    
    figure, imagesc(l_cut.r,l_cut.e,l_cut.cut')
    set(gca,'YDir','normal')
    set(gca,'YDir','normal')
    set(gca, 'FontSize', 16);
    title('Linecut');
    % determine if it is real or k space
    if contains(data.var,'ft_')==1
        %xlabel('q [2\pi/a_{Fe}]','FontSize',16);
        xlabel('q [A^{-1}]','FontSize',16);
    else
        xlabel('r [A]','FontSize',16);
    end
    ylabel('E [meV]','FontSize', 16);
    
    %     cut1 = cut;
    cut2 = cut;
    
    [lx, ly] = size(cut);
    
    %     for i=1:lx
    %         dum1 = max(cut(i,:));
    %         cut1(i,:) = cut1(i,:)/dum1;
    %     end
    
    for i=1:ly
        dum1 = max(cut(:,i));
        cut2(:,i) = cut2(:,i)/dum1;
    end
    
    %     figure, imagesc(l_cut.r,l_cut.e,cut1')
    %     set(gca,'YDir','normal')
    
    figure, imagesc(l_cut.r,l_cut.e,cut2')
    set(gca,'YDir','normal')
    set(gca, 'FontSize', 16);
    title('Normalized Linecut');
    % determine if it is real or k space
    if contains(data.var,'ft_')==1
        %xlabel('q [2\pi/a_{Fe}]','FontSize',16);
        xlabel('q [A^{-1}]','FontSize',16);
    else
        xlabel('r [A]','FontSize',16);
    end
    ylabel('E [meV]','FontSize', 16);
else
    l_cut = cut;
end
%img_plot2(data.map(:,:,1));
%Shold on; plot([pos1(1) pos2(1)],[pos1(2),pos2(2)],'r');
end