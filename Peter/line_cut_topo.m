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
function l_cut = line_cut_topo(data,topo,pos1,pos2,avg_px)
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
%% Plot layer of map you want to see
% img_plot2(img(:,:,1));
figure, img_plot4(img(:,:,1));
hold on;  plot([pos1(1) pos2(1)],[pos1(2) pos2(2)],'r','Linewidth',2);
% coordinate systems has x increase towards right and y increase going down
% So quadrants I - bottom right, II - bottom left, III - top left, IV - top
% right
if dx == 0
    xstep = 0;
    ystep = 1*sign(dy); 
    % sign gives 1 for dy>0, 0 for dy=0, and -1 for dy<0
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
       % hold on; plot([avg_pts1(1,k) avg_pts2(1,k)],[avg_pts1(2,k) avg_pts2(2,k)],'.');        
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

cut = flip(cut,1);

if isstruct(data)
    x = data.r;
    x1 = sqrt(x(pos1(1))^2 + x(pos1(2))^2);
    x2 = sqrt(x(pos2(1))^2 + x(pos2(2))^2);
    n = size(cut,1);
    r = linspace(x1,x2,n);
    l_cut.cut = cut;
    l_cut.r = r';
    l_cut.e = data.e;
else
    l_cut = cut;
end

%% 06_05_2013 P. Sprau plot the actual line cut

if isstruct(topo)
    figure, img_plot5(topo.map);
else
    figure, img_plot5(topo);
end

% img_plot2(topo.map);
hold on;  plot([pos1(1) pos2(1)],[pos1(2) pos2(2)],'r','linewidth',2);
% plot([pos1(1) pos2(1)],[pos1(2) pos2(2)],'g');
% plot([pos1(1) pos2(1)],[pos1(2) pos2(2)],'g');
hold off

if isstruct(data)
        figure; plot(data.e',cut(1,:)+1);
        xlabel('V [V]','fontsize',12,'fontweight','b')
        ylabel('dI/dV [arb. u.]','fontsize',12,'fontweight','b')
        title('Linecut','fontsize',20,'fontweight','b')
        hold on
        for i=1:length(r)
            plot(data.e',cut(i,:)+i*0.1,'LineWidth',2)
        end
        hold off

        figure; surf(data.e,r,cut)
        xlabel('V [V]','fontsize',12,'fontweight','b')
        ylabel('Pos. [Angstroem]','fontsize',12,'fontweight','b')
        zlabel('dI/dV [arb. u.]','fontsize',12,'fontweight','b')
        title('Linecut','fontsize',20,'fontweight','b')
        % figure; imagesc(cut)
        figure; contourf(data.e,r,cut)
        xlabel('V [V]','fontsize',12,'fontweight','b')
        ylabel('Pos. [Angstroem]','fontsize',12,'fontweight','b')
        zlabel('dI/dV [arb. u.]','fontsize',12,'fontweight','b')
        title('Linecut','fontsize',20,'fontweight','b')
        % figure; surf(cut)
        % view([0 30 5])

        %img_plot2(data.map(:,:,1));
        %Shold on; plot([pos1(1) pos2(1)],[pos1(2),pos2(2)],'r');
else
    figure, plot((1:1:length(cut)),cut,'.')
    
end
end