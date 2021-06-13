% 2020-4-9 YXC
% scale map2 to match map1 given two coordinates each

% points are in (xpix,ypix) form
function newmap2 = scale_rotate_match(map1,pa1,pa2,pa3,map2,pb1,pb2,pb3)

    fun = @(x) simsix(pa1,pa2,pa3,pb1,pb2,pb3,x);
    x0 = [1,0,0,1,1,1];
    x = fsolve(fun,x0);

    a = x(1);
    b = x(2);
    c = x(3);
    d = x(4);
    e = x(5);
    f = x(6);
    
    M = [a b 0; c d 0; e f 1];
    
    assignin('base','M',M);
    assignin('base','pa1',[pa1,1]');
    assignin('base','pa2',[pa2,1]');
    assignin('base','pa3',[pa3,1]');
    assignin('base','pb1',[pb1,1]');
    assignin('base','pb2',[pb2,1]');
    assignin('base','pb3',[pb3,1]');

    
    
    tform = affine2d(M);
    centerOutput = affineOutputView(size(map1.map),tform,'BoundsStyle','SameAsInput');
    newmap2 = map2;
    newmap2.r = map1.r;
    
    
    [newmap2.map,~] = imwarp(newmap2.map,tform,'OutputView' ,centerOutput);
    

    function F = simfour(pa1,pa2,pb1,pb2,x)
        a = x(1);
        d = x(2);
        e = x(3);
        f = x(4);
        F(1) = a*pb1(1)+e-pa1(1);
        F(2) = a*pb2(1)+e-pa2(1);
        F(3) = d*pb1(2)+f-pa1(2);
        F(4) = d*pb2(2)+f-pa2(2);
    end


    function F = simsix(pa1,pa2,pa3,pb1,pb2,pb3,x)
        a = x(1);
        b = x(2);
        c = x(3);
        d = x(4);
        e = x(5);
        f = x(6);
        F(1) = a*pb1(1)+c*pb1(2)+e-pa1(1);
        F(2) = a*pb2(1)+c*pb2(2)+e-pa2(1);
        F(3) = a*pb3(1)+c*pb3(2)+e-pa3(1);
        F(4) = b*pb1(1)+d*pb1(2)+f-pa1(2);
        F(5) = b*pb2(1)+d*pb2(2)+f-pa2(2);
        F(6) = b*pb3(1)+d*pb3(2)+f-pa3(2);        
    end


% %% find the scaling such that for a point in map2, point*scale+move=map1point
% d1 = pb1-pa1;
% d2 = pb2-pa2;
% dp = d1-d2;
% 
% dx = pb2(1)-pb1(1);
% dy = pb2(2)-pb1(2);
% 
% % scale, then move
% sx = 1+(dp(1)/dx);
% sy = 1+(dp(2)/dy);
% 
% x0 = sx*pb1(1);% coordinate after scaling
% y0 = sy*pb1(2);
% xtarg = pa1(1);% target coordinate
% ytarg = pa1(2);
% xmove = xtarg-x0;%for every point, you scale, then move xmove/ymove pixels
% ymove = ytarg-y0;
% 
% 
% %% use scaling and translation found to interpolate everypoint
% [nx,~,~] = size(map1.map);
% [nx2,~,~] = size(map2.map);
% X = linspace(1,nx,nx);
% Y = X;
% 
% X = (X-xmove)/sx;
% Y = (Y-ymove)/sy;
% % X = X*sx+xmove;
% % Y = Y*sy+ymove;
% 
% assignin('base','X',X)
% 
% newmap2 = map1;
% newmap2.name = map2.name;
% newmap2.ops = map2.ops;
% newmap2.ops{end+1} = 'scale';
% newmap2.type = map2.type;
% newmap2.var = map2.var;
% 
% for i = 1:nx
%     for j=1:nx
%         x = X(i);y=Y(j);
%         if x>=1 && y>=1 && x<=nx2 && y<=nx2
%             newmap2.map(j,i) = pixel_val_interp(map2.map,x,y);
%         else
%             newmap2.map(j,i)=0;
%         end
%     end
% end



end




